//
// nazghul - an old-school RPG engine
// Copyright (C) 2002, 2003 Gordon McNutt
//
// This program is free software; you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation; either version 2 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, write to the Free Foundation, Inc., 59 Temple Place,
// Suite 330, Boston, MA 02111-1307 USA
//
// Gordon McNutt
// gmcnutt@users.sourceforge.net
//
#include "gob.h"
#include "object.h"
#include "session.h"
#include "place.h"
#include "character.h"
#include "map.h"
#include "sprite.h"
#include "screen.h"
#include "console.h"
#include "sound.h"
#include "player.h"
#include "terrain.h"
#include "vmask.h"
#include "Field.h"
#include "dice.h"
#include "effect.h"
#include "mmode.h"
#include "log.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/*****************************************************************************/

//
// These GIFC_CAN_* bits need to match the script:
//
#define GIFC_CAN_GET          1
#define GIFC_CAN_USE          2
#define GIFC_CAN_EXEC         4
#define GIFC_CAN_OPEN         8
#define GIFC_CAN_HANDLE       16
#define GIFC_CAN_STEP         32
#define GIFC_CAN_ATTACK       64
#define GIFC_CAN_MIX          128
#define GIFC_CAN_ENTER        256
#define GIFC_CAN_CAST         512
#define GIFC_CAN_BUMP         1024
#define GIFC_CAN_HIT_LOCATION 2048

ObjectType::ObjectType()
{
        assert(false);

        speed                  = 0;
        required_action_points = 0;
        max_hp                 = 0;
        gifc = NULL;
        gifc_cap = 0;
}

ObjectType::ObjectType(char *tag, char *name, struct sprite *sprite, 
                       enum layer layer)
        : speed(0), required_action_points(0), max_hp(0), sprite(sprite)
{
	this->tag = strdup(tag);
        assert(this->tag);

	this->name = strdup(name);
        assert(this->name);

	this->layer = layer;

        gifc = NULL;
        gifc_cap = 0;
}

ObjectType::~ObjectType()
{
	if (tag)
		free(tag);
	if (name)
		free(name);
        if (gifc)
                closure_del(gifc);

}

bool ObjectType::init(char *tag, char *name, enum layer layer,
		      struct sprite *sprite)
{
	this->tag = strdup(tag);
	this->name = strdup(name);
	this->sprite = sprite;
	this->layer = layer;
	return (this->tag != 0 && this->name != 0);
}

class Object *ObjectType::createInstance()
{
	return new Object(this);
}

void ObjectType::setSprite(struct sprite *sprite)
{
	this->sprite = sprite;        
}

void ObjectType::describe(int count)
{
	char *name = getName();
	if (count == 1) {
		if (isvowel(name[0]))
			log_continue("an ");
		else
			log_continue("a ");
		log_continue("%s", name);
	} else {
		log_continue("some %ss (%d)", name, count);
	}
}

bool ObjectType::isType(int classID) 
{
        return (classID == OBJECT_TYPE_ID);
}

int ObjectType::getType()
{
        return OBJECT_TYPE_ID;
}

char *ObjectType::getTag()
{
        return tag;
}

char *ObjectType::getName()
{
        return name;
}

struct sprite *ObjectType::getSprite()
{
        return sprite;
}

enum layer ObjectType::getLayer()
{
        return layer;
}

bool ObjectType::isVisible()
{
        return true;
}

int ObjectType::getSpeed()
{
        return speed;
}

int ObjectType::getRequiredActionPoints()
{
        return required_action_points;
}

int ObjectType::getMaxHp()
{
        return max_hp;
}

//////////////////////////////////////////////////////////////////////////////
//
// hook_list api
//
//////////////////////////////////////////////////////////////////////////////
#define hook_list_init(hl) do { list_init(&(hl)->list); (hl)->lock = 0; } while (0)
#define hook_list_add(hl,en) (list_add(&(hl)->list, (en)))
#define hook_list_lock(hl) (++(hl)->lock)
#define hook_list_unlock(hl) ((hl)->lock--)
#define hook_list_first(hl) ((hl)->list.next)
#define hook_list_end(hl) (&(hl)->list)
#define hook_list_empty(hl) (list_empty(&(hl)->list))
#define hook_list_for_each(hl,ptr) list_for_each(&(hl)->list, (ptr))
#define hook_list_locked(hl) ((hl)->lock)
#define hook_list_trylock(hl) (hook_list_locked(hl) ? 0 : hook_list_lock(hl))
#define hook_list_tryunlock(hl,lock) ((lock) ? hook_list_unlock(hl) : 0)

//////////////////////////////////////////////////////////////////////////////
//
// hook_entry api
//
//////////////////////////////////////////////////////////////////////////////

#define HEF_INVALID (1<<0)
#define HEF_DETECTED (1<<1)

#define hook_entry_invalidate(he) ((he)->flags |= HEF_INVALID)
#define hook_entry_detected(he) ((he)->flags & HEF_DETECTED)
#define hook_entry_detect(he) ((he)->flags |= HEF_DETECTED)
#define hook_entry_gob(he) ((he)->gob->p)

hook_entry_t *hook_entry_new(struct effect *effect, struct gob *gob)
{
        hook_entry_t *entry;

        entry = (hook_entry_t*)calloc(1, sizeof(*entry));
        assert(entry);
        list_init(&entry->list);
        entry->effect = effect;
        entry->gob = gob;
        gob_ref(gob);
        
        if (effect_will_expire(effect)) {
                clock_alarm_set(&entry->expiration, effect->duration);
        }

        //dbg("hook_entry_new: %p\n", entry);
        return entry;
}

void hook_entry_del(hook_entry_t *entry)
{
        //dbg("hook_entry_del: %p\n", entry);
        if (entry->gob)
                gob_unref(entry->gob);
        free(entry);
}

void hook_entry_save(hook_entry_t *entry, struct save *save)
{
        // Note: saved effects are loaded in kern.c:kern_mk_char() & attached
        // via restoreEffect().

        save->enter(save, "(list\n");
        save->write(save, "%s\n", entry->effect->tag);
        if (entry->gob)
                gob_save(entry->gob, save);
        else
                save->write(save, "nil\n");
        save->write(save, "%d\n", entry->flags);
        clock_alarm_save(entry->expiration, save);
        save->exit(save, ")\n");
}

static inline int hook_entry_is_invalid(hook_entry_t *entry)
{
        return ((entry->flags & HEF_INVALID) ||
                (effect_will_expire(entry->effect) &&
                 clock_alarm_is_expired(&entry->expiration)));
}

//////////////////////////////////////////////////////////////////////////////
//
// Object class methods
//
//////////////////////////////////////////////////////////////////////////////

void Object::init(int x, int y, struct place *place, class ObjectType * type)
{
        // fixme: obsolete?
	this->type = type;
	setX(x);
	setY(y);
	container_link.key = type->getLayer();
	setPlace(place);
}

void Object::init(class ObjectType * type)
{
	container_link.key = type->getLayer();
	this->type = type;
}

bool Object::tryToRelocateToNewPlace(struct place *newplace, 
                                     int newx, int newy,
                                     struct closure *cutscene)
{
        place_remove_object(getPlace(), this);

        if (cutscene) {
                
                mapUpdate(0);
                closure_exec(cutscene, NULL);
                
        }

        setPlace(newplace);
        setX(newx);
        setY(newy);
        place_add_object(getPlace(), this);
        changePlaceHook();
        return true;
}

void Object::relocate(struct place *newplace, int newx, int newy, bool noStep,
                      struct closure *place_switch_hook)
{
        int volume;
        int distance;
        struct place *foc_place;
        int foc_x, foc_y;

        assert(newplace);

        if (isOnMap()) {

                assert(getPlace());

                if (newplace == getPlace()) {

                        // ---------------------------------------------------
                        // Moving from one tile to another in the same place.
                        // ---------------------------------------------------

                        if (place_switch_hook) {

                                // --------------------------------------------
                                // A cut scene was specified (this happens for
                                // moongate entry, for example). Remove the
                                // object, play the cut scene, and put the
                                // object back down at the new location.
                                // --------------------------------------------

                                mapUpdate(0);
                                setOnMap(false);
                                rmView();
                                place_remove_object(getPlace(), this);

                                closure_exec(place_switch_hook, NULL);

                                setPlace(newplace);
                                setX(newx);
                                setY(newy);
                                place_add_object(newplace, this);
                                setOnMap(true);
                                addView();

                        } else {

                                place_move_object(newplace, this, newx, newy);
                                setX(newx);
                                setY(newy);
                        }

                } else {

                        // ---------------------------------------------------
                        // Place-to-place movement, where the object is on the
                        // map. This is a special case for character objects so
                        // use an overloadable method to implement it.
                        // ---------------------------------------------------

                        if (! tryToRelocateToNewPlace(newplace, newx, newy,
                                                      place_switch_hook))
                                return;

                        // ----------------------------------------------------
                        // This object may no longer be on a map as a result of
                        // the above call. If so then finish processing.
                        // ----------------------------------------------------

                        if (! isOnMap())
                                return;
                }

        } else {

                // ------------------------------------------------------------
                // Place-to-place movement, where the object is off-map in the
                // old place. I assume by default it will be on-map in the new
                // place and let changePlaceHook() fix things up if necessary.
                // ------------------------------------------------------------

                setPlace(newplace);
                setX(place_wrap_x(newplace, newx));
                setY(place_wrap_y(newplace, newy));
                place_add_object(getPlace(), this);
                setOnMap(true);
                addView();
                changePlaceHook();

        }

        mapSetDirty();

        // --------------------------------------------------------------------
        // It's possible that changePlaceHook() removed this object from the
        // map. This certainly happens when the player party moves from town to
        // wilderness, for example. In this case I probably want to skip all of
        // what follows. I ABSOLUTELY want to skip the call to updateView() at
        // the end, and in fact I changed updateView() to assert if this object
        // is not on the map.
        // --------------------------------------------------------------------

        if (! isOnMap())
                return;

        // --------------------------------------------------------------------
        // Attenuate movement sound based on distance from the camera's focal
        // point.
        // --------------------------------------------------------------------

        volume = SOUND_MAX_VOLUME;

        mapGetCameraFocus(&foc_place, &foc_x, &foc_y);
        if (foc_place == getPlace()) {
                distance = place_flying_distance(foc_place, foc_x, foc_y, 
                                                 getX(), getY());
                if (distance > 1)
                        volume /= (distance/2);
                soundPlay(get_movement_sound(), volume);
        }

        // --------------------------------------------------------------------
        // If the camera is attached to this object then update it to focus on
        // the object's new location.
        // --------------------------------------------------------------------

        if (isCameraAttached()) {
                mapCenterCamera(getX(), getY());
        }
        
        updateView();

        // --------------------------------------------------------------------
        // Send the "step" signal to any mechanisms on this tile.
        // --------------------------------------------------------------------

        if (! noStep) {
                class Object *mech;

                mech = place_get_object(place, x, y, mech_layer);
                if (mech 
                    && mech != this 
                    && mech->getObjectType()->canStep())
                        mech->getObjectType()->step(mech, this);
        }

}

void Object::setOnMap(bool val)
{
        is_on_map = val;
}

void Object::remove()
{
	if (isOnMap()) {
                setOnMap(false);
                rmView();
		place_remove_object(getPlace(), this);
	}
        endTurn();
        attachCamera(false);
}

void Object::paint(int sx, int sy)
{
	struct sprite *sprite = getSprite();
	if (sprite)
		spritePaint(sprite, 0, sx, sy);
}

void Object::describe()
{
        getObjectType()->describe(getCount());
        if (!isVisible())
                consolePrint(" (invisible)");
}

char *Object::get_movement_sound()
{
        return 0;
}

class Object *Object::clone()
{
        // gmcnutt: added support for an optional quantity field for placed
        // objects.

        class Object *obj;

        obj = getObjectType()->createInstance();
        obj->setPlace(getPlace());
        obj->setX(getX());
        obj->setY(getY());

        // FIXME: should assign the new object a unique script tag

        return obj;
}

//////////////////////////////////////////////////

bool Object::isType(int classID) 
{
        return (classID == OBJECT_ID);
}
int Object::getType() 
{
        return OBJECT_ID;
}

Object::Object()
{
        type = NULL;
        setup();
}

Object::Object(class ObjectType * type) 
{
        this->type = type;
        setup();
        container_link.key = type->getLayer();
}

void Object::setup()
{
        int i;

        list_init(&container_link.list);
        turn_list       = NULL;

        for (i = 0; i < OBJ_NUM_HOOKS; i++) {
                hook_list_init(&hooks[i]);
        }

        x               = -1;
        y               = -1;
        place           = NULL;
        selected        = false;
        destroyed       = false;
        tag             = 0;
        action_points   = 0; /* FIXME: assumes no debt */
        control_mode    = CONTROL_MODE_AUTO;
        camera_attached = false;
        hp              = 0;
        is_on_map       = false;
        conv            = NULL;
        view            = NULL;
        saved           = 0;
        handle          = 0;
        refcount        = 0;
        count           = 1;
        gob             = NULL;
        current_sprite  = NULL;
        opacity         = false;
        light           = 0;
        temporary       = false;
        forceEffect     = false;
        pclass          = PCLASS_NONE;
        
        
        if (getObjectType() && ! getObjectType()->isVisible())
                visible = 0;
        else
                visible = 1;
}

Object::~Object()
{
        assert(! refcount);

        if (handle) {
                session_rm(Session, handle);
                handle = 0;
        }
        if (tag) {
                free(tag);
                tag = 0;
        }

        if (gob)
                gob_del(gob);

}

int Object::getX()
{
        return x;
}

int Object::getY()
{
        return y;
}

struct place *Object::getPlace()
{
        return place;
}

struct sprite *Object::getSprite()
{
        if (current_sprite)
                return current_sprite;
        return type->getSprite();
}

bool Object::isSelected()
{
        return selected;
}

enum layer Object::getLayer(void)
{
        return (enum layer) container_link.key;
}

char *Object::getName(void)
{
        return type->getName();
}

class ObjectType *Object::getObjectType()
{
        return type;
}

bool Object::isDestroyed()
{
        return destroyed;
}


void Object::setX(int x)
{
        this->x = x;
}

void Object::setY(int y)
{
        this->y = y;
}

void Object::changeX(int dx)
{
        this->x += dx;
}

void Object::changeY(int dy)
{
        this->y += dy;
}

void Object::setPlace(struct place *place)
{
        this->place = place;
}

void Object::select(bool val)
{
        selected = val;

        // --------------------------------------------------------------------
        // FIXME: instead of doing this, figure out how to just repaint the
        // tile.
        // --------------------------------------------------------------------

        mapUpdateTile(getPlace(), getX(), getY());
}

void Object::destroy()
{
        destroyed = true;
        remove();
}

int Object::getLight()
{
        return light;
}

void Object::exec()
{
        startTurn();
        if (getObjectType()->canExec())
                getObjectType()->exec(this);
        endTurn();
}

void Object::synchronize()
{
}

bool Object::isVisible()
{
        //return getObjectType()->isVisible();
        return visible > 0;
}

void Object::setVisible(bool val)
{
	if (val)
		visible++;
	else
		visible--;
}

bool Object::isShaded()
{
        return false;
}

void Object::setOpacity(bool val)
{
        // If the opacity is changing then invalidate the view mask cache in
        // the surrounding area.
        if (val != opacity && isOnMap())
                vmask_invalidate(getPlace(), getX(), getY(), 1, 1);                

        opacity = val;
}

bool Object::isOpaque()
{
        return opacity;
}

bool Object::joinPlayer()
{
        return false;
}

int Object::getActivity()
{
        return 0;
}

int Object::getActionPointsPerTurn()
{
        // --------------------------------------------------------------------
        // If 'Quicken' is in effect then give player-controlled objects bonus
        // action points per turn.
        // --------------------------------------------------------------------

        if (Quicken > 0 && isPlayerControlled()) {
                return getSpeed() * 2;
        }

        // --------------------------------------------------------------------
        // If 'TimeStop' is in effect then give action points ONLY to
        // player-controlled objects.
        // --------------------------------------------------------------------

        if (TimeStop && ! isPlayerControlled()) {
                return 0;
        }

        return getSpeed();
}

void Object::applyEffect(closure_t *effect)
{
        closure_exec(effect, "p", this);
}

void Object::burn()
{
}

void Object::sleep()
{
}

void Object::damage(int amount)
{
        runHook(OBJ_HOOK_DAMAGE);
}

int Object::getActionPoints()
{
        return action_points;
}

void Object::decActionPoints(int points)
{
        action_points -= points;
}

void Object::endTurn()
{
        if (action_points > 0)
                action_points = 0;
}

void Object::startTurn()
{
        action_points += getActionPointsPerTurn();
        runHook(OBJ_HOOK_START_OF_TURN);
}

int Object::getSpeed()
{
        return getObjectType()->getSpeed();
}

int Object::getRequiredActionPoints()
{
        return getObjectType()->getRequiredActionPoints();
}

bool Object::isOnMap()
{
        return is_on_map;
}

bool Object::isDead()
{
        return false;
}

enum control_mode Object::getControlMode()
{
        return control_mode;
}

void Object::setControlMode(enum control_mode mode)
{
        control_mode = mode;
}

void Object::attachCamera(bool val)
{
        if (camera_attached == val)
                return;

        camera_attached = val;

        if (val)
                mapAttachCamera(this);
        else
                mapDetachCamera(this);
}

bool Object::isCameraAttached()
{
        return camera_attached;
}

bool Object::isTurnEnded()
{
        return (getActionPoints() <= 0 ||
                isDead() ||
                Quit);
}

bool Object::isPlayerPartyMember()
{
        return false;
}

bool Object::addToInventory(class Object *object)
{
        return false;
}

bool Object::hasInInventory(class ObjectType *object)
{
        return false;
}

void Object::heal(int amount)
{
        amount = min(amount, getMaxHp() - hp);
        hp += amount;
}

bool Object::isPlayerControlled()
{
        return false;
}

int Object::getMaxHp()
{
        return getObjectType()->getMaxHp();
}

int Object::getHp()
{
        return hp;
}

bool Object::isCompanionOf(class Object *other)
{
        return false;
}

int Object::getPclass()
{
        return pclass;
}

void Object::setPclass(int val)
{
        pclass = val;
}

int Object::getMovementCost(int pclass)
{        
        if (pclass == PCLASS_NONE)
                return 0;

        struct mmode *mmode = getMovementMode();
        if (! mmode)
                return PTABLE_IMPASSABLE;

        return ptable_get(session_ptable(), mmode->index, pclass);
}

bool Object::isPassable(int pclass)
{
        return (getMovementCost(pclass) != PTABLE_IMPASSABLE);
}

bool Object::putOnMap(struct place *new_place, int new_x, int new_y, int r,
                      int flags)
{
        // --------------------------------------------------------------------
        // Put an object on a map. If possible, put it at (new_x, new_y). If
        // that's not possible then put it at some other (x, y) such that:
        // 
        // o (x, y) is with radius r of (new_x, new_y)
        //
        // o The object can find a path from (x, y) to (new_x, new_y)
        //
        // If no such (x, y) exists then return false without placing the
        // object.
        // --------------------------------------------------------------------

        char *visited;
        char *queued;
        bool ret = false;
        int i;
        int rx;
        int ry;
        int *q_x;
        int *q_y;
        int index;
        int q_head;
        int q_tail;
        int q_size;
        int x_offsets[] = { -1, 1, 0, 0 };
        int y_offsets[] = { 0, 0, -1, 1 };
        
        printf("Putting %s near (%d %d)\n", getName(), new_x, new_y);

        // --------------------------------------------------------------------
        // Although the caller specified a radius, internally I use a bounding
        // box. Assign the upper left corner in place coordinates. I don't
        // *think* I have to worry about wrapping coordinates because all the
        // place_* methods should do that internally.
        // --------------------------------------------------------------------

        rx = new_x - (r / 2);
        ry = new_y - (r / 2);

        // --------------------------------------------------------------------
        // Initialize the 'visited' table and the coordinate search queues. The
        // queues must be large enough to hold all the tiles in the bounding
        // box, plus an extra ring around it. The extra ring is for the case
        // where we enqueue the neighbors of tiles that are right on the edge
        // of the bounding box. We won't know the neighbors are bad until we
        // pop them off the queue and check them.
        // --------------------------------------------------------------------

        q_size = r * r;

        visited = (char*)calloc(sizeof(char), q_size);
        if (NULL == visited)
                return false;
                
        q_x = (int*)calloc(sizeof(int), q_size);
        if (NULL == q_x) {
                goto free_visited;
        }

        q_y = (int*)calloc(sizeof(int), q_size);
        if (NULL == q_y) {
                goto free_q_x;
        }

        queued = (char*)calloc(sizeof(char), q_size);
        if (NULL == queued)
                goto free_q_y;

        // --------------------------------------------------------------------
        // Enqueue the preferred location to start the search.
        // --------------------------------------------------------------------

#define INDEX(x,y) (((y)-ry) * r + ((x)-rx))

        q_head        = 0;
        q_tail        = 0;
        q_x[q_tail]   = new_x;
        q_y[q_tail]   = new_y;
        index         = INDEX(new_x, new_y);
        assert(index >= 0);
        assert(index < q_size);
        queued[index] = 1;
        q_tail++;

        // --------------------------------------------------------------------
        // Run through the search queue until it is exhausted or a safe
        // position has been found.
        // --------------------------------------------------------------------

        while (q_head != q_tail) {

                // ------------------------------------------------------------
                // Dequeue the next location to check.
                // ------------------------------------------------------------

                new_x = q_x[q_head];
                new_y = q_y[q_head];
                q_head++;

                printf("Checking (%d,%d)...", new_x, new_y);

                // ------------------------------------------------------------
                // Has the location already been visited? (If not then mark it
                // as visited now).
                // ------------------------------------------------------------
                
                index = INDEX(new_x, new_y);
                assert(index >= 0);
                assert(index < q_size);

                if (0 != visited[index]) {
                        printf("already checked\n");
                        continue;
                }
                visited[index] = 1;

                // ------------------------------------------------------------
                // Is the location off the map or impassable?
                // ------------------------------------------------------------
                
                if (place_off_map(new_place, new_x, new_y) ||
                    ! place_is_passable(new_place, new_x, new_y, this, flags)){
                        continue;
                }

                // ------------------------------------------------------------
                // Is the location occupied or hazardous?
                // ------------------------------------------------------------

                if ((! (flags & PFLAG_IGNOREBEINGS) &&
                     place_is_occupied(new_place, new_x, new_y)) ||
                    (! (flags & PFLAG_IGNOREHAZARDS) &&
                     place_is_hazardous(new_place, new_x, new_y))) {

                        printf("occupied or hazardous\n");

                        // ----------------------------------------------------
                        // This place is not suitable, but its neighbors might
                        // be. Put them on the queue.
                        // ----------------------------------------------------

                        for (i = 0; i < array_sz(x_offsets); i++) {

                                int neighbor_x;
                                int neighbor_y;
                                int neighbor_index;

                                neighbor_x = new_x + x_offsets[i];
                                neighbor_y = new_y + y_offsets[i];

                                // --------------------------------------------
                                // Is the neighbor outside the search radius?
                                // --------------------------------------------

                                if (neighbor_x < rx        ||
                                    neighbor_y < ry        ||
                                    neighbor_x >= (rx + r) ||
                                    neighbor_y >= (ry + r)) {
                                        continue;
                                }
                                
                                // --------------------------------------------
                                // Has the neighbor already been queued?
                                // --------------------------------------------

                                neighbor_index = INDEX(neighbor_x, neighbor_y);
                                assert(neighbor_index >= 0);
                                assert(neighbor_index < (q_size));

                                if (queued[neighbor_index])
                                        continue;

                                // --------------------------------------------
                                // Enqueue the neighbor
                                // --------------------------------------------

                                assert(q_tail < (q_size));

                                q_x[q_tail] = neighbor_x;
                                q_y[q_tail] = neighbor_y;
                                q_tail++;
                                queued[neighbor_index] = 1;
                        }
                        
                        continue;
                }

                // ------------------------------------------------------------
                // I've found a good spot, and I know that I can pathfind back
                // to the preferred location from here because of the manner in
                // which I found it.
                //
                // Note: we don't want to activate step triggers while doing
                // this. One example of why this is bad is if we get here by
                // coming through a moongate on a town map. If the moongate is
                // in a state where it leads to itself we could end up
                // re-entering it with the relocate call below if we allowed
                // stepping.
                // ------------------------------------------------------------

                printf("OK!\n");
                relocate(new_place, new_x, new_y, true, NULL);
                ret = true;

                goto done;
        }

        // --------------------------------------------------------------------
        // Didn't find anyplace suitable. Return false. If the caller wants to
        // force placement I'll leave it to their discretion.
        // --------------------------------------------------------------------

        printf("NO PLACE FOUND!\n");

 done:
        free(queued);
 free_q_y:
        free(q_y);
 free_q_x:
        free(q_x);
 free_visited:
        free(visited);

        return ret;

}

struct mview *Object::getView()
{
        return view;
}

int Object::getVisionRadius()
{
        return 0;
}

void Object::addView()
{
        if (NULL != getView()) {
                mapAddView(getView());
                updateView();
        }
}

void Object::rmView()
{
        if (NULL != getView()) {
                mapRmView(getView());
        }
}

void Object::updateView()
{
        assert(isOnMap());

        if (NULL != getView()) {
                mapCenterView(getView(), getX(), getY());
                mapSetRadius(getView(), min(getVisionRadius(), MAX_VISION_RADIUS));
                mapSetDirty();
        }
}

void Object::setView(struct mview *new_view)
{
        view = new_view;
}

void Object::changePlaceHook()
{
}

int Object::getDx()
{
        return dx;
}

int Object::getDy()
{
        return dy;
}
bool Object::canWanderTo(int newx, int newy)
{
        return false;
}
enum MoveResult Object::move(int dx, int dy)
{
        return NotApplicable;
}

void Object::save(struct save *save)
{
        if (tag) {
                // wrap the declaration in a call to assign the tag
                save->enter(save, "(kern-tag '%s\n", tag);
        }

        if (getGob()) {
                // wrap the declaration in a call to bind the object to the
                // gob 
                save->enter(save, "(bind\n");
        }

        // Save the object constructor call
        save->write(save, "(kern-mk-obj %s %d)\n", getObjectType()->getTag(), 
                    getCount());

        if (getGob()) {

                // save the gob list
                gob_save(getGob(), save);

                // end the bind call
                save->exit(save, ") ;; bind\n");
        }

        if (tag) {
                save->exit(save, ") ;; kern-tag\n");
        }
}


#define VALID_HOOK_ID(id) ((id) >= 0 && (id) < OBJ_NUM_HOOKS)

void Object::hookForEach(int hook_id, 
                         int (*cb)(struct hook_entry *entry, void *data),
                         void *data)
{
        struct list *elem;
        struct hook_list *hl;
        int locked;

        //dbg("hookForEach entry\n");

        assert(VALID_HOOK_ID(hook_id));
        hl = &hooks[hook_id];

        // Lock the hook list to prevent any removals or entry deletions while
        // we're running it.
        locked = hook_list_trylock(hl);

        elem = hook_list_first(hl);
        while (elem != hook_list_end(hl)) {
        
                hook_entry_t *entry;

                entry = outcast(elem, hook_entry_t, list);
                elem = elem->next;

                // Check if the entry is invalid. Invalid entries are entries
                // that somebody tried to remove while we had the hook list
                // locked. Since we have the lock, we can remove/delete them
                // now.
                if (hook_entry_is_invalid(entry)) {
                        if (locked) {
                                //dbg("hookForEach: delete %p\n", entry);
                                if (entry->effect->rm)
                                        closure_exec(entry->effect->rm, "lp", 
                                                     hook_entry_gob(entry), 
                                                     this);
                                list_remove(&entry->list);
                                hook_entry_del(entry);
                        }
                        continue;
                }

                // Invoke the callback on the hook entry... this is the part
                // that does anything interesting. If it returns non-zero then
                // we skip running the rest of the hooks.
                if (cb(entry, data))
                        break;
                        
                if (isDestroyed())
                        break;
        }

        hook_list_tryunlock(hl, locked);
        //dbg("hookForEach exit\n");

}

static int object_start_effect(struct hook_entry *entry, void *data)
{
        if (entry->effect->apply)
                closure_exec(entry->effect->apply, "lp", hook_entry_gob(entry),
                             data);
        return 0;
}

void Object::start(void)
{
        int i;

        forceEffect = true;
        for (i = 0; i < OBJ_NUM_HOOKS; i++) {
                hookForEach(i, object_start_effect, this);
        }
        forceEffect = false;
}

struct add_hook_hook_data {
        struct effect *effect;
        char reject : 1;
};

int object_run_add_hook_hook(hook_entry_t *entry, void *data)
{
        struct add_hook_hook_data *context;
        context = (struct add_hook_hook_data *)data;
        if (entry->effect->exec &&
            closure_exec(entry->effect->exec, "lp", hook_entry_gob(entry),
                         context->effect))
                context->reject = 1;
        return context->reject;
}

int object_find_effect(hook_entry_t *entry, void *data)
{
        struct add_hook_hook_data *context;
        context = (struct add_hook_hook_data *)data;
        if (entry->effect == context->effect)
                context->reject = 1;
        return context->reject;
}

bool Object::addEffect(struct effect *effect, struct gob *gob)
{
        hook_entry_t *entry;
        struct add_hook_hook_data data;
        int hook_id = effect->hook_id;
        
        assert(VALID_HOOK_ID(effect->hook_id));

        // Hack: NPC's don't go through a keystroke handler. For these,
        // substitute the start-of-turn-hook for the keystroke-hook.
        if (effect->hook_id == OBJ_HOOK_KEYSTROKE &&
            ! isPlayerControlled())
                hook_id = OBJ_HOOK_START_OF_TURN;

        // Use the same data structure to search for the effect and to check
        // for countereffects.
        data.effect = effect;
        data.reject = 0;

        // For non-cumulative effects Check if the effect is already applied.
        if (! effect->cumulative) {
                hookForEach(hook_id, object_find_effect, &data);
                if (data.reject)
                        return false;
        }

        // If we're starting up the object then "force" effects to be applied,
        // without checking for immunities. This works around the
        // script-kernel-script recursion that will otherwise occur, and which
        // will make summoning creatures with native effects not work from the
        // script.
        if (! forceEffect) {

                // Run the add-hook entries to see if any of these will block
                // this new entry from being added. This is how immunities are
                // implemented, BTW.
                hookForEach(OBJ_HOOK_ADD_HOOK, object_run_add_hook_hook, 
                            &data);

                if (data.reject) {
                        return false;
                }
        }

        // Run the "apply" procedure of the effect if it has one.
        if (effect->apply)
                closure_exec(effect->apply, "lp", gob? gob->p : NULL, this);

        entry = hook_entry_new(effect, gob);

        // Roll to see if the character detects the effect (it won't show up in
        // stats if not)
        if (dice_roll("1d20") > effect->detect_dc) {
                hook_entry_detect(entry);
        }

        hook_list_add(&hooks[hook_id], &entry->list);

        statusRepaint();

        return true;
}

void Object::restoreEffect(struct effect *effect, struct gob *gob, int flags, 
                           clock_alarm_t expiration)
{
        hook_entry_t *entry;
        struct add_hook_hook_data data;

        assert(VALID_HOOK_ID(effect->hook_id));

        // Note: do NOT run the "apply" procedure of the effect here (already
        // tried this - causes script recursion while loading which as we know
        // aborts the load prematurely).

        entry = hook_entry_new(effect, gob);
        entry->flags = flags;
        entry->expiration = expiration;
        hook_list_add(&hooks[effect->hook_id], &entry->list);

}

static int object_run_hook_entry(struct hook_entry *entry, void *data)
{
        //dbg("run entry: %p\n", entry);
        if (entry->effect->exec)
                return closure_exec(entry->effect->exec, "lp", 
                                    hook_entry_gob(entry), data);
        return 0;
}

void Object::runHook(int hook_id)
{
        struct list *elem;
        struct hook_list *hl;
        int locked;

        hookForEach(hook_id, object_run_hook_entry, this);
}

int Object::nameToHookId(char *name)
{
        if (! strcmp(name, "start-of-turn-hook"))
                return OBJ_HOOK_START_OF_TURN;
        if (! strcmp(name, "add-hook-hook"))
                return OBJ_HOOK_ADD_HOOK;
        if (! strcmp(name, "on-damage-hook"))
                return OBJ_HOOK_DAMAGE;
        if (! strcmp(name, "keystroke-hook"))
                return OBJ_HOOK_KEYSTROKE;
        return -1;
}

char *Object::hookIdToName(int hook_id)
{
        switch (hook_id) {
        case OBJ_HOOK_START_OF_TURN:
                return "start-of-turn-hook";
        case OBJ_HOOK_ADD_HOOK:
                return "add-hook-hook";
        case OBJ_HOOK_DAMAGE:
                return "on-damage-hook";
        case OBJ_HOOK_KEYSTROKE:
                return "keystroke-hook";
        default:
                return NULL;
        }
}

void Object::saveHooks(struct save *save)
{
        int i;

        save->write(save, ";; hooks\n");
        save->enter(save, "(list\n");
        for (i = 0; i < OBJ_NUM_HOOKS; i++) {
                struct list *elem;
                hook_list_for_each(&hooks[i], elem) {
                        hook_entry_t *entry;
                        entry = outcast(elem, hook_entry_t, list);
                        hook_entry_save(entry, save);
                }
        }
        save->exit(save, ")\n");
}

bool Object::removeEffect(struct effect *effect)
{
        struct list *elem;
        struct hook_list *hl;
        int hook_id = effect->hook_id;

        assert(VALID_HOOK_ID(effect->hook_id));
        
        // Hack: NPC's don't go through a keystroke handler. For these,
        // substitute the start-of-turn-hook for the keystroke-hook.
        if (effect->hook_id == OBJ_HOOK_KEYSTROKE &&
            ! isPlayerControlled())
                hook_id = OBJ_HOOK_START_OF_TURN;

        hl = &hooks[hook_id];

        elem = hook_list_first(hl);
        while (elem != hook_list_end(hl)) {
                hook_entry_t *entry;

                entry = outcast(elem, hook_entry_t, list);
                elem = elem->next;

                if (hook_entry_is_invalid(entry))
                        // Already pending removal.
                        continue;

                if (effect == entry->effect) {

                        // If the hook list is locked we can't remove/delete
                        // the entry, but if we mark it invalid then the
                        // runHooks() method will eventually clean it up.
                        if (hook_list_locked(hl)) {
                                hook_entry_invalidate(entry);
                        } else {
                                if (entry->effect->rm)
                                        closure_exec(entry->effect->rm, "lp", 
                                                     hook_entry_gob(entry), 
                                                     this);
                                list_remove(&entry->list);
                                hook_entry_del(entry);
                        }

                        statusRepaint();

                        return true;
                }
        }

        return false;
}

struct object_get_condition_from_effect_data {
        char *condition;
        int maxlen;
        int index;
};

int object_get_condition_from_effect(hook_entry_t *entry, void *data)
{
        struct object_get_condition_from_effect_data *context;

        context = (struct object_get_condition_from_effect_data*)data;
        assert(context->index < context->maxlen);
        if (entry->effect->status_code) {
                context->condition[context->index++] = 
                        entry->effect->status_code;
        }
        return (context->index == context->maxlen);
}

void Object::setDefaultCondition()
{
}

char * Object::getCondition()
{
        struct object_get_condition_from_effect_data data;
        int hook;

        // Set default condition
        memset(condition, 0, sizeof(condition));
        setDefaultCondition();

        // Collect conditions from attached effects, overriding the default 'G'
        data.condition = condition;
        data.maxlen = maxstrlen(condition);
        data.index = 0;
        for (hook = 0; hook < OBJ_NUM_HOOKS; hook++) {
                hookForEach(hook, object_get_condition_from_effect, 
                            &data);
        }

        return condition;
}

int Object::getCount()
{
        return count;
}

void Object::setCount(int c)
{
        count = c;
}

bool ObjectType::isUsable()
{
        return (gifc_cap & GIFC_CAN_USE);
}

bool ObjectType::isReadyable()
{
        return isType(ARMS_TYPE_ID);
}

bool ObjectType::isMixable()
{
        return (gifc_cap & GIFC_CAN_MIX);
}

bool ObjectType::isCastable()
{
        return (gifc_cap & GIFC_CAN_CAST);
}

bool ObjectType::canExec()
{
        return (gifc_cap & GIFC_CAN_EXEC);
}

bool ObjectType::canStep()
{
        return (gifc_cap & GIFC_CAN_STEP);
}

bool ObjectType::canAttack()
{
        return (gifc_cap & GIFC_CAN_ATTACK);
}

bool ObjectType::canEnter()
{
        return (gifc_cap & GIFC_CAN_ENTER);
}

bool ObjectType::canGet()
{
        // Hack: arms types not converted over to use gifc's yet
        return (gifc_cap & GIFC_CAN_GET);
}

bool ObjectType::canOpen()
{
        return (gifc_cap & GIFC_CAN_OPEN);
}

bool ObjectType::canBump()
{
        return (gifc_cap & GIFC_CAN_BUMP);
}

void ObjectType::open(Object *obj, Object *opener)
{
        closure_exec(gifc, "ypp", "open", obj, opener);
}

void ObjectType::bump(Object *obj, Object *bumper)
{
        closure_exec(gifc, "ypp", "open", obj, bumper);
}

bool ObjectType::canHandle()
{
        return (gifc_cap & GIFC_CAN_HANDLE);
}

void ObjectType::handle(Object *obj, Object *handler)
{
        closure_exec(gifc, "ypp", "handle", obj, handler);
}

bool ObjectType::canHitLocation()
{
        return (gifc_cap & GIFC_CAN_HIT_LOCATION);
}

void ObjectType::hitLocation(Object *obj, struct place *place, int x, int y)
{
        closure_exec(gifc, "yppdd", "hit-loc", obj, place, x, y);
}

void ObjectType::step(Object *obj, Object *stepper)
{
        closure_exec(gifc, "ypp", "step", obj, stepper);
}

void ObjectType::attack(Object *obj, Object *stepper)
{
        closure_exec(gifc, "ypp", "attack", obj, stepper);
}

void ObjectType::enter(Object *obj, Object *stepper)
{
        closure_exec(gifc, "ypp", "enter", obj, stepper);
}

void ObjectType::exec(Object *obj)
{
        closure_exec(gifc, "yp", "exec", obj);
}

void ObjectType::use(Object *user)
{
        closure_exec(gifc, "ypp", "use", this, user);
}

int ObjectType::cast(Object *caster)
{
        return closure_exec(gifc, "ypp", "cast", this, caster);
}

void ObjectType::get(Object *obj, Object *getter)
{
        closure_exec(gifc, "ypp", "get", obj, getter);
}


closure_t *ObjectType::getGifc()
{
        return gifc;
}

void ObjectType::setGifc(closure_t *g, int cap)
{
        gifc = g;
        gifc_cap = cap;
}

bool Object::add(ObjectType *type, int amount)
{
        return false; // subclasses will overload
}

bool Object::takeOut(ObjectType *type, int amount)
{
        return false; // subclasses will overload
}

bool Object::addFood(int amount)
{
        return false; // subclasses will overload
}

void Object::setGob(struct gob *g)
{
        gob = g;
}

struct gob * Object::getGob()
{
        return gob;
}

void Object::setSprite(struct sprite *sprite)
{
        current_sprite = sprite;
}

void Object::step(Object *stepper)
{        
        if (! getObjectType() ||
            ! getObjectType()->canStep())
                return;

        getObjectType()->step(this, stepper);
}

void Object::attack(Object *stepper)
{        
        if (! getObjectType() ||
            ! getObjectType()->canStep())
                return;

        getObjectType()->attack(this, stepper);
}

struct closure *Object::getConversation()
{
        return conv;
}

void Object::setConversation(closure_t *val)
{
        conv = val;
}

bool Object::canEnter()
{
        return (getObjectType() && getObjectType()->canEnter());
}

void Object::enter(Object *enterer)
{
        getObjectType()->enter(this, enterer);
}

bool Object::canStep()
{
        return (getObjectType() && getObjectType()->canStep());
}

void Object::setLight(int val)
{
        light = val;
        if (light < 0)
                light = 0;
}

bool Object::isTemporary()
{
        return temporary;
}

void Object::setTemporary(bool val)
{
        temporary = val;
}

struct mmode *Object::getMovementMode()
{
        return NULL;
}

Object *Object::getSpeaker()
{
        return this;
}

void Object::resetActionPoints()
{
        action_points = 0;
}

void Object::setActionPoints(int amount)
{
        action_points = amount;
}
