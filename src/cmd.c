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

#include "cmd.h"
#include "place.h"
#include "constants.h"
#include "images.h"
#include "sprite.h"
#include "los.h"
#include "astar.h"
#include "common.h"
#include "screen.h"
#include "status.h"
#include "player.h"
#include "sky.h"
#include "map.h"
#include "wq.h"
#include "foogod.h"
#include "combat.h"
#include "cursor.h"
#include "Arms.h"
#include "event.h"
#include "wind.h"
#include "Container.h"
#include "dup_constants.h"
#include "cmdwin.h"
#include "vehicle.h"
#include "terrain.h"
#include "vmask.h"
#include "session.h"
#include "sched.h"
#include "conv.h"
#include "log.h"
#include "factions.h"
#include "result.h"
#include "dice.h"
#include "menus.h"

#define DEBUG
#include "debug.h"

#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <unistd.h>     // getpid()
#include <errno.h>

#define MAX_SPELL_NAME_LENGTH 64 /* arbitrarily chosen */
#define MIN_XAMINE_LIGHT_LEVEL 32
#define ESCAPE_CHARACTER 110

extern int DeveloperMode;

/* SAM: Using this typedef below */
typedef void (*v_funcpointer_iiv) (struct place *, int x, int y, void * v);

/* Struct used by the movecursor function and it's mouse-handling counterparts
 * for commands which prompt the player to select a target from the map. */
struct movecursor_data {

        /* Optional function called when a tile is entered by the cursor */
        v_funcpointer_iiv each_tile_func;

        /* Optional function called when the tile under the cursor is selected
         * by the player */
        v_funcpointer_iiv each_target_func;

        /* Optional list of objects to be used by the 'previous' and 'next'
         * cursor operations. */
        struct list *loc_list;

        /* Optional pointer into the objlist. */
        struct list *cur_loc;

        /* Number of tiles to "jump" the cursor on the next direction
         * keypress. */
        int jump;

        /* Flags */
        char abort : 1;   /* command was aborted     */
        char multi : 1;   /* select multiple targets */
};

/* Struct used by the terraform version of the movecursor function et al. It's
 * a superset of the standard movecursor_data and extends it with
 * some extra data. */
struct terraform_mode_keyhandler {
        /* "Inherit" from movecursor_data so we can use the same
         * mousecursor function for terraform and other targetting commands. */
        struct movecursor_data base;
        struct place           * place;  // needed?
        struct terrain_map     * map;
        struct terrain_palette * palette;
};

int dirkey(struct KeyHandler *kh, int key, int keymod)
{
	int *dir = (int *) kh->data;

	if (key >= KEY_SOUTHWEST && key <= KEY_NORTHEAST) {
		*dir = keyToDirection(key);
		return 1;
	}

	if (key == SDLK_ESCAPE) {
		*dir = key;
		return 1;
	}

	return 0;
}

int yesnokey(struct KeyHandler * kh, int key, int keymod)
{
	int *yesno = (int *) kh->data;

	switch (key) {
	case 'y':
	case 'Y':
		*yesno = 'y';
		return 1;
	case 'n':
	case 'N':
	case CANCEL:
		*yesno = 'n';
		return 1;
	default:
		return 0;
	}
}

enum get_number_state {
	GN_ALL,
	GN_ZERO,
	GN_SOME,
	GN_CANCEL
};

/* Max number getnum() will accept */
const int MAX_GETNUM = 999999999;

struct get_number_info {
	int digit;
	int state;
	char *prompt;
};

struct get_char_info {
        char *string;
        char c;
	int state;
	char *prompt;
};

struct get_spell_name_data {
	char spell_name[MAX_WORDS_IN_SPELL_NAME + 1];
        char *prompt;
	char *ptr;
	int n;
        int state;
};

int getnum(struct KeyHandler *kh, int key, int keymod)
{
	struct get_number_info *info;

	info = (struct get_number_info *) kh->data;

	switch (info->state) {
	case GN_ALL:
		if (key == CANCEL) {
                        cmdwin_pop();
			info->digit = 0;
			info->state = GN_CANCEL;
			return 1;
		}
		if (key == '\n') {
                        cmdwin_pop();
			return 1;
		}
		if (key == '0') {
                        cmdwin_pop();
			cmdwin_push("0");
			info->digit = 0;
			info->state = GN_ZERO;
			return 0;
		}
		if (isdigit(key)) {
                        cmdwin_pop();
			info->digit = info->digit * 10 + key - '0';
			cmdwin_push("%c", key);
			info->state = GN_SOME;
			return 0;
		}
		break;
	case GN_ZERO:
		if (key == CANCEL) {
			info->digit = 0;
			info->state = GN_CANCEL;
			return 1;
		}
		if (key == '\n') {
			return 1;
		}
		if (key == '\b') {
			cmdwin_pop();
			if (info->prompt)
				cmdwin_spush(info->prompt);
			info->state = GN_ALL;
			return 0;
		}
		if (key == '0')
			return 0;
		if (isdigit(key)) {
			cmdwin_pop();
			info->digit = info->digit * 10 + key - '0';
			cmdwin_push("%c", key);
			info->state = GN_SOME;
			return 0;
		}
		break;
	case GN_SOME:
		if (key == CANCEL) {
			info->digit = 0;
			info->state = GN_CANCEL;
			return 1;
		}
		if (key == '\n') {
			return 1;
		}
		if (key == '\b') {
			info->digit = info->digit - (info->digit % 10);
			info->digit /= 10;
			cmdwin_pop();
			if (info->digit == 0) {
				info->state = GN_ALL;
				if (info->prompt)
					cmdwin_spush(info->prompt);
			}
			return 0;
		}
		if (isdigit(key)) {
                        int keyval = key - '0';
                        if ((MAX_GETNUM - keyval) >= info->digit) {
                                info->digit = info->digit * 10 + keyval;
                                cmdwin_push("%c", key);
                        }
			return 0;
		}
		break;
	}

	return 0;
}

int getdigit(struct KeyHandler * kh, int key, int keymod)
{
        struct get_number_info *info;

        info = (struct get_number_info *) kh->data;
        
        if (key == CANCEL) {
                cmdwin_pop();
                info->digit = 0;
                return 1;
        }

        if (isdigit(key)) {
                cmdwin_pop();
                info->digit = key - '0';
                if (info->digit != 0)
                        cmdwin_push("%c", key);
                return 1;
        }
        
        return 0;
}

static int cmd_getchar(struct KeyHandler * kh, int key, int keymod)
{
        struct get_char_info *info;

        info = (struct get_char_info *) kh->data;
        
        if (key == CANCEL) {
                cmdwin_pop();
                info->c = 0;
                return 1;
        }

        if (strchr(info->string, key)) {
                cmdwin_pop();
                info->c = key;
                cmdwin_push("%c", key);
                return 1;
        }
        
        return 0;        
}

int anykey(struct KeyHandler * kh, int key, int keymod)
{
	return 1;
}

int scroller(struct KeyHandler * kh, int key, int keymod)
{
	struct ScrollerContext *context;
	context = (struct ScrollerContext *) kh->data;

	switch (key) {
	case KEY_NORTH:
		statusScroll(ScrollUp);
		break;
	case KEY_SOUTH:
		statusScroll(ScrollDown);
		break;
	case KEY_EAST:
		statusScroll(ScrollRight);
		break;
	case KEY_WEST:
		statusScroll(ScrollLeft);
		break;
	case SDLK_PAGEUP:
		statusScroll(ScrollPageUp);
		break;
	case SDLK_PAGEDOWN:
		statusScroll(ScrollPageDown);
		break;
	case SDLK_RETURN:
	case SDLK_SPACE:
	case '\n':
		if (context != NULL) {
			context->selection =
                                statusGetSelected(context->selector);
		}
		return 1;
	case SDLK_ESCAPE:
	case 'q':
		if (context)
			context->abort = 1;
		return 1;
	case 'm':
		if (context && context->mixing) {
			context->done = 1;
			return 1;
		}
		break;
	default:
		break;
	}

	return 0;
}

bool mouse_button_cursor(struct MouseButtonHandler *mh, SDL_MouseButtonEvent *event)
{
        struct movecursor_data * data
                = (struct movecursor_data *) mh->data;
        int mx = event->x;
        int my = event->y;

        /* Off-map? */
        if (mapScreenToPlaceCoords(&mx, &my)) {
                return false;
        }

        /* Did the crosshair move? */
        if (Session->crosshair->getX() != mx
            || Session->crosshair->getY() != my) {

                /* turn on range shading after the first move */
                Session->crosshair->shadeRange(true);

                /* Move the crosshair */
                Session->crosshair->move(mx - Session->crosshair->getX(),
                                         my - Session->crosshair->getY());
                mapSetDirty();

                /* Need to run our visitor function on each tile? */
                if (data->each_tile_func) {
                        data->each_tile_func(Session->crosshair->getPlace(),
                                             Session->crosshair->getX(),
                                             Session->crosshair->getY(),
                                             0);
                }

        }

        /* target selected? */
        if (event->button == SDL_BUTTON_LEFT) {
                if (data->each_target_func) {
                        data->each_target_func(Session->crosshair->getPlace(),
                                               Session->crosshair->getX(),
                                               Session->crosshair->getY(),
                                               data);
                }

                return ! data->multi;   /* done unless multiple targets */
        }


        return false;
}

bool mouse_motion_cursor(struct MouseMotionHandler *mh, SDL_MouseMotionEvent *event)
{
        struct movecursor_data * data
                = (struct movecursor_data *) mh->data;
        int mx = event->x;
        int my = event->y;

        /* Off-map? */
        if (mapScreenToPlaceCoords(&mx, &my)) {
                return false;
        }
        
        /* Did the crosshair NOT move? */
        if (Session->crosshair->getX() == mx
            && Session->crosshair->getY() == my) {
                return false;
        }

        /* turn on range shading after the first move */
        Session->crosshair->shadeRange(true);

        /* Move the crosshair */
        Session->crosshair->move(mx - Session->crosshair->getX(),
                                 my - Session->crosshair->getY());
        mapSetDirty();

        /* Need to run our visitor function on each tile? */
        if (data->each_tile_func) {
                data->each_tile_func(Session->crosshair->getPlace(),
                                     Session->crosshair->getX(),
                                     Session->crosshair->getY(),
                                     0);
        }

        /* Mouse dragging? */
        if (event->state & SDL_BUTTON(1)
            && data->each_target_func) {
                data->each_target_func(Session->crosshair->getPlace(),
                                       Session->crosshair->getX(),
                                       Session->crosshair->getY(),
                                       data);
                
                return ! data->multi;   /* done unless multiple targets */
        }


        return false;
}

/**
 * movecursor - move the crosshair around, possibly running a function on each
 * tile entered by the crosshair or on each tile selected
 */
int movecursor(struct KeyHandler * kh, int key, int keymod)
{
        int moved = 0;
        struct movecursor_data * data
                = (struct movecursor_data *) kh->data;
  
        /* target selected? */
        if (key == '\n' || key == SDLK_SPACE || key == SDLK_RETURN) {
                if (data->each_target_func) {
                        data->each_target_func(Session->crosshair->getPlace(),
                                               Session->crosshair->getX(),
                                               Session->crosshair->getY(),
                                               0);
                }

                return ! data->multi;   /* done unless multiple targets */

        }
  
        /* crosshairs moved? */
        if (keyIsDirection(key)) {
                int dir = keyToDirection(key);
                int dx = directionToDx(dir);
                int dy = directionToDy(dir);
                
                /* Brain-dead but simple way to clamp the jump distance to
                 * range: iteratively back-off until it's ok. */
                while (OutOfRange == Session->crosshair->move(dx * data->jump, 
                                                              dy * data->jump)
                        && data->jump > 1) {
                        data->jump--;
                }
                moved = 1;
        } else if (isdigit(key)) {
                data->jump = key - '0';
                if (! data->jump)
                        data->jump = 1; /* disallow zero */
        } else {
  
                struct list *old_loc = data->cur_loc;

                switch (key) {
                        
                case SDLK_ESCAPE:
                        /* Abort */
                        data->abort = 1;
                        return 1;   /* done */
                        
                case '+':
                case '=':
                case 'n':
                        /* Next target */
                        if (data->loc_list
                            && ! list_empty(data->loc_list)) {
                                data->cur_loc = data->cur_loc->next;
                                if (data->cur_loc == data->loc_list) {
                                        /* wrap around */
                                        data->cur_loc = 
                                                data->cur_loc->next;
                                }
                        }
                        break;
                        
                case '-':
                case 'p':
                        /* Previous target */
                        if (data->loc_list
                            && ! list_empty(data->loc_list)) {
                                data->cur_loc = data->cur_loc->prev;
                                if (data->cur_loc == data->loc_list) {
                                        /* wrap around */
                                        data->cur_loc = 
                                                data->cur_loc->prev;
                                }
                        }
                        break;
                default:
                        break;
                }

                /* Target changed? */
                if (old_loc != data->cur_loc) {
                        struct location_list *loc = 
                                (struct location_list*)data->cur_loc;
                        Session->crosshair->move(loc->x - 
                                                 Session->crosshair->getX(),
                                                 loc->y - 
                                                 Session->crosshair->getY());
                        moved = 1;
                }
        }

        /* Cursor was moved? */
        if (moved) {
                data->jump = 1;
                mapSetDirty();
                if (data->each_tile_func) {
                        data->each_tile_func(Session->crosshair->getPlace(),
                                             Session->crosshair->getX(),
                                             Session->crosshair->getY(),
                                             0);
                }

                /* turn on range shading after the first move */
                Session->crosshair->shadeRange(true);
        }

        return 0;   /* not done */
}

/*
 * emit_terraform_status - print the active terrain palette entry to the
 * console during terraform mode
 */
void emit_terraform_status (char * msg, struct terrain_palette * pp, 
                            struct terrain * tt)
{
    log_msg("[%s] %3d: %s '%s'", msg, pp->current_terrain_index, tt->tag, 
            tt->name);
}

static void cmd_terraform_fill(struct terrain *nt, struct terrain *ot, 
                               struct place *place, int x, int y)
{
        struct terrain *ct = place_get_terrain(place, x, y);

        /* base case 1: off-map */
        if (!ct)
                return;

        /* base case 2: current terrain does not match old terrain */
        if (ct != ot)
                return;

        /* recursive case - change current terrain to new terrain */
        place_set_terrain(place, x, y, nt);
        vmask_invalidate(place, x, y, 1, 1);

        /* recur on four neighbors */
        cmd_terraform_fill(nt, ot, place, x-1, y);
        cmd_terraform_fill(nt, ot, place, x+1, y);
        cmd_terraform_fill(nt, ot, place, x, y-1);
        cmd_terraform_fill(nt, ot, place, x, y+1);
}

/*
 * cmd_terraform_movecursor_and_do - key handler function for terraform mode
 */
int cmd_terraform_movecursor_and_do(struct KeyHandler * kh, int key, 
                                    int keymod)
{
        struct terraform_mode_keyhandler * data;
        struct terrain_palette * pp;
        struct terrain * tt;

        assert(kh);

        data = (struct terraform_mode_keyhandler *) kh->data;
        pp   = data->palette;
  
        if (key == '\n' || key == SDLK_SPACE || key == SDLK_RETURN ||
            key == SDLK_LCTRL || key == SDLK_RCTRL) {
                int x = Session->crosshair->getX();
                int y = Session->crosshair->getY();
                if (data->base.each_target_func)
                        data->base.each_target_func(Session->crosshair->getPlace(),
                                               x, y, data);
                return 0;  /* Keep on keyhandling */
        }

        if (keyIsDirection(key)) {
                int dir = keyToDirection(key);
                /* SAM: TODO: The Terraform cursor should not be allowed to go
                 *            past the Viewport bounds...
                 */
                Session->crosshair->move(directionToDx(dir), 
                                         directionToDy(dir));
                mapSetDirty();
                int x = Session->crosshair->getX();
                int y = Session->crosshair->getY();
                if (data->base.each_tile_func)
                        data->base.each_tile_func(Session->crosshair->getPlace(),
                                              x, y, data);

                /* If the CTRL key is held down then also run the target
                 * function to paint the tile. */
                if (keymod & KMOD_CTRL &&
                    data->base.each_target_func)
                        data->base.each_target_func(Session->crosshair->getPlace(),
                                               x, y, data);

                return 0;  /* Keep on keyhandling */
        }

        if (key == 'c') {
                /* Set the terrain beneath the cursor as the current "pen" */
                int index = -1;
                tt = place_get_terrain(Session->crosshair->getPlace(),
                                       Session->crosshair->getX(),
                                       Session->crosshair->getY());
                index = palette_get_terrain_index(pp, tt);
                if (index >= 0) {
                        palette_set_current_terrain(pp, index);
                        emit_terraform_status("Here", pp, tt);
                }
                return 0;
        }

        if (key == 'f') {
                /* "Fill" using the 4-neighbors algorithm */
                tt = palette_current_terrain(pp);
                if (tt) {
                        struct terrain *ot;
                        ot = place_get_terrain(Session->crosshair->getPlace(),
                                               Session->crosshair->getX(),
                                               Session->crosshair->getY());
                        if (tt != ot) {
                                cmd_terraform_fill(tt, ot,
                                                   Session->crosshair->getPlace(),
                                                   Session->crosshair->getX(),
                                                   Session->crosshair->getY());
                        }
                        mapUpdate(0);
                }
                return 0;
        }

        if (key == SDLK_PAGEUP) {
                // Page Up == Cycle back through terrain in palette
                palette_prev_terrain(pp);
                tt = palette_current_terrain(pp);
                emit_terraform_status("Prev", pp, tt);
                return 0;  /* Keep on keyhandling */
        }
        if (key == SDLK_PAGEDOWN) {
                // Page Down == Cycle forward through terrain in palette
                palette_next_terrain(pp);
                tt = palette_current_terrain(pp);
                emit_terraform_status("Next", pp, tt);
                return 0;  /* Keep on keyhandling */
        }
        if (key == SDLK_HOME) {
                // Home == Select first terrain in palette
                palette_first_terrain(pp);
                tt = palette_current_terrain(pp);
                emit_terraform_status("Frst", pp, tt);
                return 0;  /* Keep on keyhandling */
        }
        if (key == SDLK_END) {
                // End == Select last terrain in palette
                palette_last_terrain(pp);
                tt = palette_current_terrain(pp);
                emit_terraform_status("Last", pp, tt);
                return 0;  /* Keep on keyhandling */
        }

        if (key >= '0' && key <= '9') {
                // Number key 0..9 == get/set quick terrain
                int qt = key - '0';
    
                if ((keymod && KMOD_LCTRL) || (keymod && KMOD_RCTRL)) {
                        // Control-NUM == set quick terrain to current:
                        int index = palette_get_current_terrain_index(pp);
                        palette_set_quick_terrain(pp, qt, index);
                        tt = palette_current_terrain(pp);
                        log_msg("[Set Quick %d] %3d: %s '%s'", qt, 
                                pp->current_terrain_index, tt->tag, tt->name);
                        return 0; /* Keep on keyhandling */
                }
                // Plain NUM == set current terrain from quick terrain:
                int index = palette_get_quick_terrain_index(pp, qt);
                palette_set_current_terrain(pp, index);
                tt = palette_current_terrain(pp);
                log_msg("[Quick %d] %3d: %s '%s'", qt, 
                        pp->current_terrain_index, tt->tag, tt->name);
                return 0;  /* Keep on keyhandling */
        }

        // ...
    
        if (key == SDLK_ESCAPE) {
                data->base.abort = 1;
                return 1;  // Done (abort)
        }
        return 0;  /* Keep on keyhandling */
}

struct inv_entry *select_item(void)
{
	enum StatusMode omode;
	struct inv_entry *ie;
	struct KeyHandler kh;
	struct ScrollerContext sc;

	omode = statusGetMode();
	statusSetMode(Use);

	sc.selector = InventoryItem;
	sc.selection = NULL;
	kh.fx = scroller;
	kh.data = &sc;

	eventPushKeyHandler(&kh);
	cmdwin_push("<select>");
	eventHandle();
	cmdwin_pop();
	eventPopKeyHandler();

	statusSetMode(omode);

	ie = (struct inv_entry *) sc.selection;
	if (ie == NULL) {
		cmdwin_push("none!");
		return NULL;
	}

	cmdwin_spush(ie->type->getName());

	return ie;
}

class Character *select_party_member(void)
{
	enum StatusMode omode;
	class Character *character;

        if (1 == player_party->getSize()) {
                return player_party->getMemberByOrder(0);
        }

	omode = statusGetMode();
	statusSetMode(SelectCharacter);

	struct KeyHandler kh;
	struct ScrollerContext sc;
	sc.selector = Character;
	sc.selection = NULL;
	kh.fx = scroller;
	kh.data = &sc;

	eventPushKeyHandler(&kh);
	cmdwin_push("<select>");
	eventHandle();
	cmdwin_pop();
	eventPopKeyHandler();

	statusRepaint();

	character = (class Character *) sc.selection;

	if (character == NULL) {
		cmdwin_push("none!");
		/* Hack alert: this saves the caller from having to remember to
		 * do this. Doing it unconditionally is undesirable because it
		 * can cause status screen flashes if the old mode requires a
		 * short status window and the next mode requires a tall
		 * one. */
	} else {
		cmdwin_spush("%s", character->getName());
	}

	statusSetMode(omode);

	return character;
}

void getkey(void *data, int(*handler) (struct KeyHandler * kh, int key, int keymod))
{
	struct KeyHandler kh;
	kh.fx = handler;
	kh.data = data;

	eventPushKeyHandler(&kh);
	eventHandle();
	eventPopKeyHandler();
}

int ui_get_direction(void)
{
	int dir;
	cmdwin_push("<direction>");
	getkey(&dir, dirkey);
	cmdwin_pop();
	if (dir == CANCEL) {
		cmdwin_push("none!");
	} else {
		cmdwin_spush(directionToString(dir));
	}
	return dir;
}

static void search_visitor(class Object *obj, void *arg)
{
        class ObjectType *type = obj->getObjectType();
        if (type && type->canSearch()) {
                type->search(obj);
        }
}

bool cmdSearch(struct place *place, int x, int y)
{
	int dir;
        bool old_reveal;
        int x2,  y2;

	cmdwin_clear();
	cmdwin_spush("Search");

	dir = ui_get_direction();
	if (dir == CANCEL)
		return false;

        x2 = x + directionToDx(dir);
        y2 = y + directionToDy(dir);

        place_for_each_object_at(place, x2, y2, search_visitor, NULL);

	log_begin("You find ");
        old_reveal = Reveal;
        Reveal = true;
	place_describe(place, x2, y2, PLACE_DESCRIBE_ALL);
        log_end(".");
        Reveal = old_reveal;
	return true;
}

static int cmdGetFilter(class Object *obj)
{
        return (int)(obj->getObjectType() && 
                     obj->getObjectType()->canGet());
}

bool cmdGet(class Object *actor)
{
	class Object *item;
	int dir;
        int x, y;

	cmdwin_clear();
	cmdwin_spush("Get");

	dir = ui_get_direction();
	if (dir == CANCEL)
		return false;

        x = actor->getX() + directionToDx(dir);
        y = actor->getY() + directionToDy(dir);

	item = place_get_filtered_object(actor->getPlace(), x, y, 
                                         cmdGetFilter);
	if (!item) {
                log_msg("Get - nothing there!");
		return false;
	}
               
        log_begin_group();

        while (NULL != (item = place_get_filtered_object(
                                actor->getPlace(), 
                                x, y, cmdGetFilter))) {
                item->getObjectType()->get(item, actor);
	}

        log_end_group();

        mapSetDirty();

	return true;
}

static void cmd_describe_inv_entry(struct inv_entry *ie, void *unused)
{
        log_begin("...");
        ie->type->describe(ie->count);
        log_end(NULL);
}

bool cmdOpen(class Character * pc)
{
	int dir, x, y;
	class Object *mech;
	class Container *container;

	cmdwin_clear();
	cmdwin_spush("Open");

	// Get the party member who will open the container (in combat mode
	// this is passed in as a parameter).
	if (pc) {
		cmdwin_spush(pc->getName());
	} else {
		pc = select_party_member();
		if (pc == NULL) {
			return false;
		}
	}

	dir = ui_get_direction();
	if (dir == CANCEL)
		return false;

	if (pc) {
		x = place_wrap_x(pc->getPlace(), 
                                 pc->getX() + directionToDx(dir));
		y = place_wrap_y(pc->getPlace(), 
                                 pc->getY() + directionToDy(dir));
	} else {
		x = place_wrap_x(player_party->getPlace(),
                                 player_party->getX() + directionToDx(dir));
		y = place_wrap_y(player_party->getPlace(),
                                 player_party->getY() + directionToDy(dir));
	}

        /* Check for a mechanism */
         mech = place_get_object(pc->getPlace(), x, y, mech_layer);

         /* Check for a container */
         container = (class Container *) place_get_object(Place, x, y, 
                                                          container_layer);

         /* ignore invisible objects unless Reveal is in effect */
         if (! Reveal) {
                 if (mech && ! mech->isVisible())
                         mech = 0;
                 if (container && ! container->isVisible())
                         container = 0;
         }

         /* If both are present the user must select one */
         if (mech && mech->getObjectType()->canOpen() && container) {

                 enum StatusMode omode;
                 struct stat_list_entry statlist[2];
                 struct KeyHandler kh;
                 struct ScrollerContext data;

                 cmdwin_push("<select>");

                 statlist[0].sprite = mech->getSprite();
                 snprintf(statlist[0].line1, sizeof(statlist[0].line1), "%s",
                          mech->getName());
                 statlist[0].line2[0] = 0;
                 statlist[0].data = mech;

                 statlist[1].sprite = container->getSprite();
                 snprintf(statlist[1].line1, sizeof(statlist[1].line2), "%s",
                          container->getName());
                 statlist[1].line2[0] = 0;
                 statlist[1].data   = container;

                 omode = statusGetMode();
                 statusSetGenericList(2, statlist);
                 statusSetMode(GenericList);
                 
                 data.selection = NULL;
                 data.selector  = Generic;
                 kh.fx   = scroller;
                 kh.data = &data;
                 eventPushKeyHandler(&kh);
                 eventHandle();
                 eventPopKeyHandler();
                 
                 statusSetMode(omode);
                 
                 /* Disqualify the object NOT selected */
                 if (data.selection == mech)
                         container = NULL;
                 else
                         mech = NULL;

                 cmdwin_pop();
         }

         /* Open a mechanism */
         if (mech && mech->getObjectType()->canOpen()) {
                 cmdwin_push("%s!", mech->getName());
                 mech->getObjectType()->open(mech, pc);
                 mapSetDirty();
                 return true;
         }

         /* Nothing to open */
         if (NULL == container) {
                 cmdwin_push("abort!");
                 log_msg("Open - nothing there!");
                 return false;
         }

	/* Open Container */

        log_begin_group();

        pc->decActionPoints(NAZGHUL_BASE_ACTION_POINTS);
        cmdwin_push("%s!", container->getName());

	// Check for traps.
	if (container->isTrapped()) {

		closure_t *trap = container->getTrap();

		// Roll to disarm
		if (20 <= (dice_roll("1d20") 
                           + logBase2(pc->getDexterity())
                           + logBase2(pc->getLevel()))) {
			log_msg("You disarm a trap!");
		} else {
                        // Trigger the trap. Traps may destroy containers, so
                        // use the refcount to find out if this happened.
                        int abort = 0;

                        obj_inc_ref(container);
                        closure_exec(trap, "pp", pc, container);
                        if (container->refcount == 1) {
                                log_msg("The %s was destroyed!", 
                                        container->getName());
                                abort = 1;
                        }
                        obj_dec_ref(container);

                        if (abort) {
                                cmdwin_push("can't!");
                                log_end_group();
                                return false;
                        }
		}
	}

        // Describe the contents of the container.
        log_msg("You find:");
        container->forEach(cmd_describe_inv_entry, NULL);

	// Open the container (automagically spills all the contents onto the
	// map).
	container->open();

        // --------------------------------------------------------------------
        // Delete container automatically on the combat map because if
        // containers are stacked (and they frequently are) then the top one
        // always gets selected and the player can't get at the ones
        // underneath. On the other hand, in towns I don't want to delete
        // people's furniture.
        //
        // Addendum: everything stated above still holds, but now corpse loot
        // can also get dropped on town maps outside, so I can no longer decide
        // whether or not to delete a container based on context. Furthermore,
        // I want all containers to behave the same way as much as
        // possible. This is an open issue and it may take some time and user
        // feedback to decide what best to do, so for now I'll simply always
        // remove containers after opening them.
        // --------------------------------------------------------------------

        container->remove();

        log_end_group();

	mapSetDirty();
	return true;
}

bool cmdQuit(void)
{
	int yesno;
        char *fname = 0;

	cmdwin_clear();
	cmdwin_spush("Quit");
        cmdwin_spush("<y/n>");
	getkey(&yesno, yesnokey);
	cmdwin_pop();

        /* Cancel quit? */
	if (yesno == 'n') {
                cmdwin_spush("abort!");
                return false;
        }

        cmdwin_spush("save");
        cmdwin_spush("<y/n>");
        getkey(&yesno, yesnokey);
        cmdwin_pop();

        /* Don't save? */
        if (yesno == 'n') {
                cmdwin_spush("not saving!");
                Quit = true;
                return true;
        }

        /* Select a filename to save to. */
        cmdwin_pop();
        fname = save_game_menu();

        /* Did player cancel from the menu? */
        if (!fname) {
                cmdwin_spush("abort!");
                return false;
        }
        
        log_begin("Saving to %s...", fname);
        if (session_save(fname)) {
                log_end("^c+rfailed!^c-");
        } else {
                log_end("^c+gok!^c-");
                log_msg("Goodbye!\n");
                Quit = true;
        }

	return Quit;
}

void cmdAttack(void)
{
        int dir;
        struct move_info info;
        struct combat_info cinfo;

        // Initialize data structures.
        memset(&info, 0, sizeof(info));
        memset(&cinfo, 0, sizeof(cinfo));
        cinfo.move = &info;
        cinfo.defend = false;
		
        // Get the direction
	cmdwin_clear();
	cmdwin_spush("Attack");
        cmdwin_spush("<direction>");
	getkey(&dir, dirkey);
	cmdwin_pop();
	if (dir == CANCEL) {
		cmdwin_spush("none!");
		return;
	}
	cmdwin_spush("%s", directionToString(dir));

        // Get the npc party being attacked
        info.dx = directionToDx(dir);
        info.dy =  directionToDy(dir);;
        info.place = player_party->getPlace();
        info.x = place_wrap_x(info.place, player_party->getX() + info.dx);
        info.y = place_wrap_y(info.place, player_party->getY() + info.dy);
        info.npc_party = place_get_Party(info.place, info.x, info.y);
		
		if (info.place->wilderness) {
			//only allow adjactent attacks in wilderness
			if (info.dx && info.dy)
			{
				cmdwin_spush("adjacent foes only!");
				return;
			}
        }
		
        if (info.npc_party == NULL) {
                cmdwin_spush("nobody there!");
                return;
        } 
        info.px = player_party->getX();
        info.py = player_party->getY();

        cmdwin_spush("%s", info.npc_party->getName());

        // If the npc is not hostile then get player confirmation.
        if (! are_hostile(info.npc_party, player_party)) {
                int yesno;
                cmdwin_spush("attack non-hostile");
                cmdwin_spush("<y/n>");
                getkey(&yesno, yesnokey);
                cmdwin_pop();
                if (yesno == 'n') {
                        cmdwin_spush("no");
                        return;
                }
                cmdwin_spush("yes");

                make_hostile(info.npc_party, player_party);
        }

        // Log the attack.
        log_begin("You attack ");
        info.npc_party->describe();
        log_end(".");

        // Enter combat
        combat_enter(&cinfo);
}

void cmdFire(void)
{
	int dir;

	cmdwin_clear();
	cmdwin_spush("Fire");

        class Vehicle *vehicle = player_party->getVehicle();
	if ((!vehicle ||
             !vehicle->getOrdnance())) {
                // SAM: 
                // In future, we may check for adjacent "cannon" 
                // mechanisms here (as in U5).
		cmdwin_spush("No cannons available!");
                log_msg("Fire - nothing to fire!");
		return;
	}

	cmdwin_spush("%s", vehicle->getOrdnance()->getName());
        cmdwin_spush("<direction>");
	getkey(&dir, dirkey);
	cmdwin_pop();

	if (dir == CANCEL) {
		cmdwin_spush("none!");
		return;
	}

	cmdwin_spush("%s", directionToString(dir));
        log_begin("Fire: %s - ", directionToString(dir));
	if (! vehicle->fire_weapon(directionToDx(dir), 
                                                 directionToDy(dir), 
                                                 player_party)) {
		cmdwin_spush("Not a broadside!");
                log_end("not a broadside!");
		return;
        }
        log_end("hits away!");
}

bool cmdReady(class Character * member)
{
	bool committed = false;
	struct inv_entry *ie;
	struct KeyHandler kh;
	struct ScrollerContext sc;
	char *msg = 0;

	cmdwin_clear();
	cmdwin_spush("Ready");

        // Select user
        if (member) {
		cmdwin_spush("%s", member->getName());                
        } else {
                member = select_party_member();
                if (member == NULL)
                        return false;       

                if (member->isCharmed()) {
                        log_msg("Charmed characters can't ready arms!\n");
                        return false;
                }

        }

        log_begin_group();
        log_msg("%s readies arms:", member->getName());

	statusSelectCharacter(member->getOrder());

	player_party->sortReadiedItems(member);
	statusSetMode(Ready);
	sc.selector = InventoryItem;
	kh.fx = scroller;
	kh.data = &sc;
	eventPushKeyHandler(&kh);

        cmdwin_spush("<select/ESC>");

	for (;;) {

		sc.selection = NULL;

		eventHandle();
                cmdwin_pop();

		ie = (struct inv_entry *) sc.selection;
		if (ie == NULL) {
			cmdwin_spush("done!");
			break;
		}

		committed = true;

		class ArmsType *arms = (class ArmsType *) ie->type;

                log_begin("%s - ", arms->getName());

		if (ie->ref && member->unready(arms)) {
			msg = "unreadied!";
			statusRepaint();
		} else {

			switch (member->ready(arms)) {
			case Character::Readied:
				statusRepaint();
				msg = "readied!";
                                /* Move the readied item to the front of the
                                 * list for easy access next time, and to
                                 * percolate frequently-used items up to the
                                 * top. */
                                //player_party->inventory->moveToFront(ie);
                                /* After re-ordering the list, reset the status
                                 * viewer to synch it back up with the new
                                 * list. */
                                //statusSetMode(Ready);
				break;
			case Character::NoAvailableSlot:
				msg = "all full!";
				break;
			case Character::WrongType:
				msg = "can't use!";
				break;
			case Character::TooHeavy:
				msg = "too heavy!";
				break;
			default:
				assert(false);
				break;
			}
		}

		cmdwin_spush("%s %s", arms->getName(), msg);
                log_end(msg);
	}

	eventPopKeyHandler();
	statusSetMode(ShowParty);

        if (committed) {
				player_party->sortReadiedItems(member);
                member->decActionPoints(NAZGHUL_BASE_ACTION_POINTS);
        }

        log_end_group();

	return committed;
}

static void cmd_init_movecursor_data(struct movecursor_data *data, 
                                     struct list *suggest)
{
        struct list *entry = 0;

        memset(data, 0, sizeof(*data));
        data->jump = 1;

        if (! suggest)
                return;

        /* Copy the head of the list. */
        data->loc_list = suggest;
        data->cur_loc = data->loc_list;

        /* Look for the crosshair in the suggest list. */
        list_for_each(suggest, entry) {
                struct location_list *loc = 
                        (struct location_list*)entry;
                if (loc->x == Session->crosshair->getX()
                    && loc->y == Session->crosshair->getY()) {
                        data->cur_loc = &loc->list;
                        break;
                }
        }
}

int select_target(int ox, int oy, int *x, int *y, int range, 
                  struct list *suggest)
{
        struct movecursor_data data;
        struct KeyHandler kh;
        struct MouseButtonHandler mbh;
        struct MouseMotionHandler mmh;

        Session->crosshair->setRange(range);
        Session->crosshair->setOrigin(ox, oy);
        Session->crosshair->relocate(Place, *x, *y);   /* previous target */

        /* initially don't shade the range unless the previous target is the
         * same as the origin (implying that there is no previous target) */
        Session->crosshair->shadeRange((*x==ox)&&(*y==oy));
        Session->show_boxes = 1;
        mapSetDirty();

        cmd_init_movecursor_data(&data, suggest);

        kh.fx   = movecursor;
        kh.data = &data;
  
        mbh.fx = mouse_button_cursor;
        mbh.data = &data;

        mmh.fx = mouse_motion_cursor;
        mmh.data = &data;

        eventPushMouseButtonHandler(&mbh);
        eventPushMouseMotionHandler(&mmh);
        eventPushKeyHandler(&kh);
        cmdwin_spush("<target>");
        eventHandle();
        cmdwin_pop();
        eventPopKeyHandler();
        eventPopMouseButtonHandler();
        eventPopMouseMotionHandler();
  
        Session->show_boxes = 0;
        *x = Session->crosshair->getX();
        *y = Session->crosshair->getY();
        Session->crosshair->remove();
        mapSetDirty();

        if (data.abort) {
                cmdwin_spush("none!");
                return -1;
        }
  
        return 0;  
}

int select_target_with_doing(int ox, int oy, int *x, int *y,
                             int range,
                             v_funcpointer_iiv each_tile_func,
                             v_funcpointer_iiv each_target_func)
{
        // SAM: 
        // As select_target(), but each_tile_func() 
        // will be called at each point cursored over,
        // and each_target_func() will be called at each point
        // selected as a target.
        // 
        // Eventually, the user will abort with ESC.
        // 
        // SAM: It might be nice to return the last target,
        // in case our caller wants it, but it seems that
        // the ESC abort stomps on it.
        struct movecursor_data data;
        struct KeyHandler kh;
        struct MouseButtonHandler mbh;
        struct MouseMotionHandler mmh;

        Session->crosshair->setRange(range);
        Session->crosshair->setViewportBounded(1);
        Session->crosshair->setOrigin(ox, oy);
        Session->crosshair->relocate(Place, *x, *y); /* previous target */
        Session->show_boxes=1;
        mapSetDirty();

        memset(&data, 0, sizeof(data));
        data.each_tile_func   = each_tile_func;
        data.each_target_func = each_target_func;
        data.multi            = 1;
        data.jump             = 1;

        kh.fx   = movecursor;
        kh.data = &data;
  
        mbh.fx = mouse_button_cursor;
        mbh.data = &data;

        mmh.fx = mouse_motion_cursor;
        mmh.data = &data;

        eventPushMouseButtonHandler(&mbh);
        eventPushMouseMotionHandler(&mmh);
        eventPushKeyHandler(&kh);
        cmdwin_spush("<target> (ESC to exit)");
        eventHandle();
        cmdwin_pop();
        eventPopKeyHandler();
        eventPopMouseButtonHandler();
        eventPopMouseMotionHandler();
  
        Session->show_boxes=0;
        *x = Session->crosshair->getX();
        *y = Session->crosshair->getY();
        Session->crosshair->remove();
        mapSetDirty();
  
        if (data.abort) {
                cmdwin_spush("Done.");
                return -1;
        }
  
        return 0;
}

/**
 * cmd_terraform_cursor_func - 
 */
static int cmd_terraform_cursor_func(int ox, int oy, int *x, int *y,
                                     int range,
                                     v_funcpointer_iiv each_tile_func,
                                     v_funcpointer_iiv each_target_func,
                                     struct place * place)
{
        struct terraform_mode_keyhandler data;
        struct KeyHandler kh;
        struct MouseButtonHandler mbh;
        struct MouseMotionHandler mmh;

        /* Position the cursor */
        Session->crosshair->setRange(range);
        Session->crosshair->setViewportBounded(1);
        Session->crosshair->setOrigin(ox, oy);
        Session->crosshair->relocate(Place, *x, *y);
        mapSetDirty();
  
        /* Setup the key handler */
        data.base.each_tile_func   = each_tile_func;
        data.base.each_target_func = each_target_func;
        data.base.abort            = 0;
        data.base.multi            = 1;
        data.base.jump             = 1;
        data.map              = place->terrain_map;
        data.palette          = place->terrain_map->palette;

        kh.fx   = cmd_terraform_movecursor_and_do;
        kh.data = &data;

        mbh.fx = mouse_button_cursor;
        mbh.data = &data;

        mmh.fx = mouse_motion_cursor;
        mmh.data = &data;

        /* Start interactive mode */
        eventPushMouseButtonHandler(&mbh);
        eventPushMouseMotionHandler(&mmh);
        eventPushKeyHandler(&kh);
        cmdwin_spush("<target> (ESC to exit)");
        eventHandle();

        /* Done -  cleanup */
        cmdwin_pop();
        eventPopKeyHandler();
        eventPopMouseMotionHandler();
        eventPopMouseButtonHandler();
  
        *x = Session->crosshair->getX();
        *y = Session->crosshair->getY();
        Session->crosshair->remove();
        mapSetDirty();
  
        cmdwin_spush("Done.");

        return 0;
}

bool cmdHandle(class Character * pc)
{
	// SAM: Adding (H)andle command...
	int x;
	int y;

	cmdwin_clear();
	cmdwin_spush("Handle");

	if (pc) {
		// A party member was specified as a parameter, so this must be
		// combat mode. Use the party member's location as the origin.
		x = pc->getX();
		y = pc->getY();
		cmdwin_spush("%s", pc->getName());
	} else {
		// Must be party mode. Use the player party's location as the
		// origin.
		x = player_party->getX();
		y = player_party->getY();

		// And find out what the party member is Handling (so we can
		// print the name). If only one party member then select the
		// only one.
		if (player_party->get_num_living_members() == 1) {
			pc = player_party->get_first_living_member();
			cmdwin_spush("%s", pc->getName());
		} else {
			pc = select_party_member();
			if (pc == NULL) {
				return false;
			}
		}
	}

	// *** Pick a target ***

	if (select_target(x, y, &x, &y, 1, 0) == -1)
		return false;

        // Try to find a mech
	class Object *mech;
	mech = place_get_object(Place, x, y, mech_layer);
	if (! mech 
            || ! mech->getObjectType()->canHandle()
            || (! mech->isVisible()            
                && ! Reveal)) {
                cmdwin_spush("nothing!");
                log_msg("Handle - nothing there!");
                return false;
        }

        // Handle it (sometimes mechs are intentionally nameless so that they
        // remain hidden from x)amine and s)earch commands)
        char *mechName=mech->getName();
        if (!mechName) {
                mechName = "a hidden mechanism";
        }
        cmdwin_spush("%s", mechName);
        log_msg("%s handles %s", pc->getName(), mechName);
        mech->getObjectType()->handle(mech, pc);
        mapSetDirty();

        // I think the following was added to update LOS in cases where the
        // mech changed state and changed LOS. Not sure what happens in
        // character mode.
        //player_party->updateView();

	return true;
}

bool cmdUse(class Character * member, int flags)
{
	struct inv_entry *ie;
	class ObjectType *item;

	cmdwin_clear();
	cmdwin_spush("Use");

        // Select user
        if (flags & CMD_SELECT_MEMBER) {
                member = select_party_member();
                if (member == NULL)
                        return false;       
        } else {
                assert(member);
                cmdwin_spush("%s", member->getName());
        }
	statusSelectCharacter(member->getOrder());

        // select item to use
	statusSetMode(Use);
	ie = select_item();
	statusSetMode(ShowParty);
	if (ie == NULL) {
		return false;
        }

        /* warning: assume usable item came from player inventory; move it to
         * the front of the list so that frequently-used items percolate to the
         * top for easy selection by the player. Oh, and do this *before* using
         * it, since using it may delete the ie if it is a consumable item and
         * the last one in inventory. */
        player_party->inventory->moveToFront(ie);

	item = ie->type;
        assert(item->isUsable());

	item->use(member);
	statusRepaint();

	return true;
}

/* Helper function called by cmdNewOrder: */
static void cmd_switch_party_leader(class Character *old_leader,
                                    class Character *new_leader)
{
        new_leader->setLeader(true);
        old_leader->setLeader(false);
        old_leader->endTurn();
        old_leader->setControlMode(CONTROL_MODE_FOLLOW);
        player_party->setLeader(new_leader);
}

void cmdNewOrder(void)
{
	class Character *pc1, *pc2;

        switch (player_party->getSize()) {
        case 0:
                assert(0);
                break;
        case 1:
                log_msg("New Order - only one party member!");
                return;
        case 2:
                pc1 = player_party->getMemberByOrder(0);
                pc2 = player_party->getMemberByOrder(1);
                goto swap;
        }

	cmdwin_clear();
	cmdwin_spush("Switch");

        // Set the mode now - before calling select_party_member - so that the
        // screen will not flash back to a short status window between the two
        // calls to select_party_member.
        statusSetMode(SelectCharacter);

	pc1 = select_party_member();
	if (pc1 == NULL) {
                statusSetMode(ShowParty);
		return;
        }

	cmdwin_spush("with");

	pc2 = select_party_member();
	if (pc2 == NULL) {
                statusSetMode(ShowParty);
		return;
	}

        statusSetMode(ShowParty);
 swap:
        player_party->switchOrder(pc1, pc2);

	log_msg("New Order: %s switched with %s\n", pc1->getName(),
		     pc2->getName());

        // If one of the switched members was the party leader then make the
        // other one the new leader (unless the other one is dead or otherwise
        // incapable of being a party leader).
        if (pc1->isLeader() && pc2->canBeLeader()) {
                cmd_switch_party_leader(pc1, pc2);
        } else if (pc2->isLeader() && pc1->canBeLeader()) {
                cmd_switch_party_leader(pc2, pc1);
        }

	statusRepaint();
}

static void run_combat(bool camping, class Character * guard, int hours,
                       class Object *foe)
{
	struct move_info minfo;
	struct combat_info cinfo;

        assert(!foe || foe->isType(PARTY_ID));

	memset(&minfo, 0, sizeof(minfo));
	minfo.place = Place;
	minfo.x = player_party->getX();
	minfo.y = player_party->getY();
        minfo.px = minfo.x;
        minfo.py = minfo.y;
        minfo.npc_party = (class Party*)foe;

	memset(&cinfo, 0, sizeof(cinfo));
	cinfo.camping = camping;
	cinfo.guard = guard;
	cinfo.hours = hours;
	cinfo.move = &minfo;

        // Is there an enemy?
        if (foe) {
                // Yes, so I assume the player party is being attacked
                // (currently this happens as a result of conversation). To
                // setup the proper orientation of the parties I need to get
                // the direction vector. The direction should be from the foe
                // to the player.
                cinfo.defend = true;
                place_get_direction_vector(minfo.place, 
                                           foe->getX(), foe->getY(),
                                           minfo.x, minfo.y, 
                                           &minfo.dx, &minfo.dy);
        } else {
                // No, so we're camping or zooming in. Party values are fine
                // here.
                minfo.dx = player_party->getDx();
                minfo.dy = player_party->getDy();
        } 

	combat_enter(&cinfo);
}

struct nearest_conversant_info {
        class Object *origin;
        class Object *nearest;
        int min_distance;
        int range;
};

static void cmd_nearest_conversant_visitor(class Object *obj, void *data)
{
        struct nearest_conversant_info *info = 
                (struct nearest_conversant_info*)data;

        if (! obj->getConversation())
                return;

        if (obj->isPlayerControlled())
                return;
        
        if (! obj->isVisible() && ! Reveal)
                return;

        /* Filter out objects not in los of the subject */
        if (! place_in_los(info->origin->getPlace(),
                           info->origin->getX(),
                           info->origin->getY(),
                           obj->getPlace(),
                           obj->getX(),
                           obj->getY()))
                return;
        

        int dist = place_flying_distance(info->origin->getPlace(),
                                         info->origin->getX(),
                                         info->origin->getY(),
                                         obj->getX(),
                                         obj->getY());
        if (dist > info->range)
                return;

        if (! info->nearest
            || dist < info->min_distance) {
                info->nearest = obj;
                info->min_distance = dist;
        }
}

static class Object *cmd_get_nearest_conversant(class Object *member, int range)
{
        struct nearest_conversant_info info;
        info.origin = member;
        info.nearest = NULL;
        info.min_distance = 0;
        info.range = range;

        place_for_each_object(member->getPlace(), cmd_nearest_conversant_visitor,
                              &info);

        return info.nearest;
}

bool cmdTalk(Object *member)
{
	struct closure *conv = NULL;
        class Object *obj, *conversant;
        int x, y;

	// *** Prompt user & check if valid ***

	cmdwin_clear();
	cmdwin_spush("Talk");

        if (! member) {
                member = select_party_member();
                if (! member)
                        return false;
        }

        // start cursor on nearest object with a conversation
        conversant = cmd_get_nearest_conversant(member, 5);
        if (! conversant)
                conversant = member;

        x = conversant->getX();
        y = conversant->getY();

	if (select_target(member->getX(), member->getY(), &x, &y, 5, 0) == -1) {
		return false;
	}

	obj = place_get_object(Place, x, y, being_layer);

	if (!obj) {
                cmdwin_spush("nobody there!");
                log_msg("Try talking to a PERSON.");
                return false;
        }

        // This next bit was added to support talking to parties, where the
        // speaker is not the party itself.
        obj = obj->getSpeaker();
        if (! obj) {
                cmdwin_spush("cancel");
                return false;
        }

        conv = obj->getConversation();
        if (!conv) {
		cmdwin_spush("no response!");
                log_begin("No response from ");
                obj->describe();
                log_end(".");
		return true;
        }

	cmdwin_spush(obj->getName());

	log_msg("*** CONVERSATION ***");

	if (/*obj->getActivity() == SLEEPING || not sure why this was here... */
            ((obj->getLayer() == being_layer) &&
             ((class Character*)obj)->isAsleep())) {
		log_msg("Zzzz...\n");
                //log_end_group();
		return true;
	}

        conv_enter(obj, member, conv);
        //log_end_group();

	mapSetDirty();

        return true;
}

bool cmdZtats(class Character * pc)
{
	cmdwin_clear();
	cmdwin_spush("Stats");

	if (pc != NULL) {
		cmdwin_spush("%s", pc->getName());
	} else {
		pc = select_party_member();
		if (pc == NULL)
			return false;
	}

	cmdwin_spush("<ESC to exit>");

	statusSelectCharacter(pc->getOrder());
	statusSetMode(Ztats);

	struct KeyHandler kh;
	kh.fx = scroller;
	kh.data = NULL;
	eventPushKeyHandler(&kh);
	eventHandle();
	eventPopKeyHandler();

	cmdwin_pop();
	cmdwin_spush("ok");

	statusSetMode(ShowParty);

	return false;
}

static int select_hours(void)
{
	struct get_char_info info;

	cmdwin_spush("<hours[0-9]/[s]unrise>");

	info.c = '0';
        info.string = "0123456789sS";

	getkey(&info, &cmd_getchar);

	if (! info.c || info.c == '0') {
                cmdwin_pop();
		cmdwin_spush("none!");
                return 0;
        }
        else if (info.c == 's' ||
                 info.c == 'S') {
                int hour;
                int sunrise;

                cmdwin_pop();
                cmdwin_spush("until sunrise");
                hour = clock_time_of_day() / 60;
                sunrise = SUNRISE_HOUR + 1;
                if (hour < sunrise)
                        return sunrise - hour;
                return HOURS_PER_DAY - hour + sunrise;
        }
	else if (info.c == '1') {
		cmdwin_push(" hour");
                return 1;
        }
	else {
		cmdwin_push(" hours");
                return info.c - '0';
        }
}

int ui_get_quantity(int max)
{
	struct get_number_info info;
        char prompt[64];

        /* Push the prompt but remember it for use within getnum() */
	if (max == -1) {
                snprintf(prompt, sizeof(prompt), "<quantity>");
	} else {
                snprintf(prompt, sizeof(prompt), 
                         "<quantity[0-%d]/RET=%d>", max, max);
	}

	info.digit = 0;
	info.state = GN_ALL;
	info.prompt = prompt;

        cmdwin_spush(info.prompt);
	getkey(&info, getnum);

	if (info.state == GN_ALL) {
		if (max == -1)
			info.digit = 0;
		else
			info.digit = max;
	} else if (info.state == GN_CANCEL)
		cmdwin_spush("none!");

	return info.digit;
}

int cmd_camp_in_wilderness(class Party *camper)
{
	int hours, yesno;
	class Character *guard = 0;

	cmdwin_clear();
	cmdwin_spush("Camp");

	if (!place_is_passable(camper->getPlace(), camper->getX(), 
                               camper->getY(), camper, PFLAG_IGNOREVEHICLES)) {
		cmdwin_spush("not here!");
                log_msg("Camp - not here!");
		return 0;
	}

        if (place_get_subplace(camper->getPlace(), 
                               camper->getX(), 
                               camper->getY())) {
		cmdwin_spush("not here!");
                log_msg("Camp - not here!");
                return 0;
        }

	hours = select_hours();
	if (hours == 0)
		return 0;

        cmdwin_spush(""); /* for the '-' */
	cmdwin_spush("set a watch");
        cmdwin_spush("<y/n>");
	getkey(&yesno, &yesnokey);

	if (yesno == 'y') {

		cmdwin_pop();
		guard = select_party_member();
		if (!guard) {
			cmdwin_pop();
			cmdwin_spush("no watch");
		}
                // else select_party_member() prints the name

	} else {
		cmdwin_pop();
		cmdwin_spush("no watch");
	}

	player_party->beginCamping(guard, hours);
        camper->endTurn();
	run_combat(true, guard, hours, NULL);

        return 0;
}

void cmdLoiter(class Being *subject)
{
        int hours = 0;

        cmdwin_clear();
        cmdwin_spush("Loiter");

        /* Check if enemies are around. */
        if (place_contains_hostiles(subject->getPlace(), subject)) {
                cmdwin_spush("foes nearby!");
                log_msg("Loiter - foes nearby!");
                return;
        }

        /* Prompt for the number of hours. */
        hours = select_hours();
        if (!hours) {
                return;
        }

        /* Tell the party to start loitering. */
        cmdwin_spush("loitering...");
        player_party->beginLoitering(hours);

        /* End the turn. */
        subject->endTurn();
        
}

int cmd_camp_in_town(class Character *camper)
{
        int hours;

        cmdwin_clear();
        cmdwin_spush("Rest");

        // Party must be in follow mode.
        if (player_party->getPartyControlMode() != PARTY_CONTROL_FOLLOW) {
                cmdwin_spush("must be in follow mode!");
                log_begin_group();
                log_msg("Camp - party not in follow mode!");
                log_msg("(Hint: hit 'f' to enter follow mode)");
                log_end_group();
                return 0;
        }
                
        // Check for an object that will serve as a bed.
        if (place_get_object(camper->getPlace(), camper->getX(), 
                             camper->getY(),  bed_layer) == NULL) {
                cmdwin_spush("no bed!");
                log_msg("Camp - no bed here!");
                return 0;
        }

        // Rendezvous the party around the bed.
        if (! player_party->rendezvous(camper->getPlace(), camper->getX(), 
                                       camper->getY())) {
                log_msg("Camp - party can't rendezvous!");
                return 0;
        }

        // Prompt for the number of hours to sleep.
        hours = select_hours();
        if (hours == 0)
                return 0;

        // Put the party in "sleep" mode before returning back to the main
        // event loop.
        cmdwin_spush("resting...");
        player_party->beginResting(hours);
        camper->endTurn();

        return TURNS_PER_HOUR;
}

int get_spell_name(struct KeyHandler *kh, int key, int keymod)
{
	struct get_spell_name_data *ctx;
	char *word, letter;

	ctx = (struct get_spell_name_data *) kh->data;

        switch (ctx->state) {

        case GN_ZERO: /* No spell words are entered yet and the prompt is
                       * sitting there. */

                /* Done? */
                if (key == '\n') {
                        cmdwin_pop();
                        return 1;
                }

                /* Abort? */
                if (key == CANCEL) {
                        cmdwin_pop();
                        ctx->spell_name[0] = 0;
                        return 1;
                }

                /* A letter? */
                if (isalpha(key)) {
                        
                        /* Lookup the word that goes with the letter. */
                        letter = toupper(key);
                        word = magic_lookup_word(&Session->magic, letter);

                        /* Valid word? */
                        if (word) {

                                /* Clear prompt, show the word and advance. */
                                cmdwin_pop();
                                cmdwin_push(word);
                                *ctx->ptr = letter;
                                ctx->ptr++;
                                ctx->n++;
                                ctx->state = GN_SOME;
                        }
                }
                return 0;

        case GN_SOME: /* One or more words are already entered. */

                /* Done? Ensure null-termination. */
                if (key == '\n') {
                        /* Segment-push a null string to force a '-' following
                         * the spell name. */
                        cmdwin_spush(0);
                        *ctx->ptr = 0;
                        return 1;
                }

                /* Abort? Terminate string at beginning. */
                if (key == CANCEL) {
                        ctx->spell_name[0] = 0;
                        return 1;
                }

                /* Backspace? */
                if (key == '\b' && ctx->n) {
                        cmdwin_pop();
                        ctx->ptr--;
                        *ctx->ptr = 0;
                        ctx->n--;

                        /* Back to empty? Re-prompt. */
                        if (!ctx->n) {
                                cmdwin_spush(ctx->prompt);
                                ctx->state = GN_ZERO;
                        }
                        return 0;
                }

                /* Out of space? */
                if (ctx->n == MAX_WORDS_IN_SPELL_NAME) {
                        return 0;
                }

                /* Not a letter? */
                if (!isalpha(key))
                        return 0;

                /* Lookup the word that goes with the letter. */
                letter = toupper(key);
                word = magic_lookup_word(&Session->magic, letter);
                if (!word) {
                        return 0;
                }
                
                /* Accept the word and print it. After the first word separate words
                 * with a space. */
                cmdwin_push(" %s", word);
                *ctx->ptr = letter;
                ctx->ptr++;
                ctx->n++;
                return 0;

        default: /* Invalid state */
                assert(0);
                return 0;
        }

}

int select_spell(struct get_spell_name_data *context)
{
	struct KeyHandler kh;

	memset(context, 0, sizeof(*context));
	context->ptr = context->spell_name;
        context->prompt = "<spell name>";
        context->state = GN_ZERO;

	kh.fx = get_spell_name;
	kh.data = context;

        cmdwin_spush(context->prompt);
	eventPushKeyHandler(&kh);
	eventHandle();
	eventPopKeyHandler();

	if (strlen(context->spell_name) == 0) {
		cmdwin_spush("none!");
		return -1;
	}

	return 0;
}

bool cmdYuse(class Character *pc)
{
        /* Yuse a skill or special ability. */
        return false;
}

bool cmdCastSpell(class Character * pc)
{
	struct get_spell_name_data context;
	struct inv_entry *ie = NULL;
	struct spell *spell;
	bool mixed = false;
	bool natural = false;
	int i;
        char spell_name[MAX_SPELL_NAME_LENGTH];

        if (MagicNegated) {
                log_msg("Cast - magic negated!\n");
                return false;
        }

	cmdwin_clear();
	cmdwin_spush("Cast");

	/* If the pc is null then we are in non-combat mode and need to promp
         * the user. */
	if (pc == NULL) {
		pc = select_party_member();
		if (pc == NULL) {
			return false;
		}
		statusSetMode(ShowParty);
	}

        /* Make sure the PC is not asleep, dead, etc. */
        if (pc->isDead() || pc->isAsleep()) {
                cmdwin_spush("unable right now!");
                return false;
        }

	/* Prompt to select a spell */
	if (select_spell(&context) == -1)
		return false;

        /* The code for the spell is stored in the context, but not the full
         * name. I want the full name for log msgs. */
        magic_spell_code_to_name(&Session->magic, spell_name, 
                                 MAX_SPELL_NAME_LENGTH, 
                                 context.spell_name);

        log_begin("%s: %s - ", pc->getName(), spell_name);

	/* Lookup the spell in the list of valid spells. */
	spell = magic_lookup_spell(&Session->magic, context.spell_name);
	if (!spell) {
		cmdwin_spush("no effect!");
                log_end("no effect!");
		return false;
	}

	/* Check if the spell can be used in this context. */
	if (!(player_party->getContext() & spell->context)) {
		cmdwin_spush("not here!");
                log_end("not here!");
		return false;
	}

	/* Check if the character comes by this spell naturally. */
	for (i = 0; i < pc->species->n_spells; i++) {
		if (! strcmp(pc->species->spells[i], spell->code)) {
			natural = true;
			break;
		}
	}

        /* Check if the caster is of sufficient level. */
        /*
         * FIXME: what if the spell is natural? cast An Xen Exe on a snake and
         * try to cast In Nox Por to see what I mean...
         */
	if (!natural && pc->getLevel() < spell->level) {
		cmdwin_spush("need more experience!");
                log_end("need more experience!");
		return false;
	}

	/* Check party inventory for a mixed spell. */
	if (!natural) {
		ie = player_party->inventory->search(spell->type);
		if (ie && ie->count)
			mixed = true;
	}

	if (!natural && !mixed) {
		cmdwin_spush("none mixed!");
                log_end("none mixed!");
		return false;
	}

	/* Check if the character has enough mana to cast the spell. */
	if (pc->getMana() < spell->cost) {
		cmdwin_spush("need more mana!");
                log_end("need more mana!");
		return false;
	}

        /* Cast the spell. */
        switch (spell->type->cast(pc)) {
        case RESULT_OK:
                log_continue("ok!");
                break;
        case RESULT_NO_TARGET:
                log_end("no target!");
                return false;
        case RESULT_NO_EFFECT:
                log_continue("no effect!");
                break;
        default:
                assert(false);
                break;
        }

        /* Decrement the caster's mana. */
        pc->addMana(0 - spell->cost);
        pc->decActionPoints(max(spell->cost/2,1));
        pc->addExperience(spell->cost);

	/* If the spell was mixed then remove it from inventory. */
	if (mixed)
		player_party->takeOut(ie->type, 1);

        /* Some spells have status in the foogod window, so repaint it now. */
        foogodRepaint();

        log_end(NULL);

	return true;

}

bool cmdMixReagents(class Character *character)
{
	struct spell *spell;
	struct get_spell_name_data context;
	struct list reagents, *elem;
	int quantity, max_quantity;
	struct inv_entry *ie;
	bool mistake = false;
        char spell_name[MAX_SPELL_NAME_LENGTH];

	list_init(&reagents);

	cmdwin_clear();
	cmdwin_spush("Mix");

	// Select a spell...
	if (select_spell(&context) == -1)
		return false;

        // The code for the spell is stored in the context, but not the full
        // name. I want the full name for log msgs.
        magic_spell_code_to_name(&Session->magic, spell_name, 
                                 MAX_SPELL_NAME_LENGTH, 
                                 context.spell_name);

	// Lookup the spell. If null then keep going and bomb when done.
	spell = magic_lookup_spell(&Session->magic, context.spell_name);

	// Prompt for reagents 
	cmdwin_spush("<select, then M)ix>");

	// Show the reagents in the status window
	statusSetMode(MixReagents);

	struct ScrollerContext sc;
	sc.selector = Reagents;
	sc.done = false;
	sc.abort = false;
	sc.mixing = true;

	struct KeyHandler kh;
	kh.fx = scroller;
	kh.data = &sc;

	eventPushKeyHandler(&kh);

	for (;;) {
		sc.selection = NULL;
		eventHandle();

		if (sc.abort) {
			// u5 silently aborts here
                        cmdwin_pop();
			eventPopKeyHandler();
			cmdwin_spush("none!");
			goto done;
		}

		if (sc.done)
			break;

		ie = (struct inv_entry *) sc.selection;
                if (! ie) {
                        /* This happens when the player has no reagents
                         * whatsoever. */
			cmdwin_pop();
			eventPopKeyHandler();
			cmdwin_spush("none!");
			goto done;
                }

		if (ie->ref) {
			// unselect
			ie->ref = 0;
			list_remove(&ie->auxlist);
		} else {
			// select
			ie->ref = 1;
			list_add(&reagents, &ie->auxlist);
		}

		statusRepaint();
	}

	cmdwin_pop();
	eventPopKeyHandler();

	if (list_empty(&reagents)) {
		cmdwin_spush("none!");
		goto done;
	}

	// Determine the max number of mixtures the player can make.
	max_quantity = 0x7fffff;
	list_for_each(&reagents, elem) {
		ie = outcast(elem, struct inv_entry, auxlist);
		if (ie->count < max_quantity) {
			max_quantity = ie->count;
		}
	}

	// Prompt for the number of mixtures to make
	for (;;) {

		int dummy;

                cmdwin_push_mark();
		quantity = ui_get_quantity(max_quantity);

		if (quantity == 0) {
			goto done;
		}

		if (quantity <= max_quantity)
			break;

                cmdwin_spush(0); /* for the '-' after the quantity */
		cmdwin_spush("not enough reagents!");
		getkey(&dummy, anykey);
		cmdwin_pop_to_mark();
	}

	log_begin("Mix: %s - ", spell_name);

	// For each reagent required by the spell, check if it is in the list
	// of reagents given by the player. If not then remember this fact. If
	// the reagent is found then remove it from player inventory and remove
	// it from the list.
	if (spell) {
		for (int i = 0; i < spell->n_reagents; i++) {
			bool found = false;
			list_for_each(&reagents, elem) {
				ie = outcast(elem, struct inv_entry, auxlist);
				if (ie->type ==
				    (class ObjectType *) spell->reagents[i]) {
                                        // The following line is safe only
					// because this is the end of the
					// list_for_each loop!
					list_remove(elem);
					ie->ref--;
					player_party->takeOut(ie->type, 
                                                              quantity);
					found = true;
					break;
				}
			}
			if (!found)
				mistake = true;
		}
	}

	// Now, if any reagents remain leftover then remember this fact and
	// remove the remaining reagents from inventory.
	if (!list_empty(&reagents)) {
		mistake = true;
		elem = reagents.next;
		while (elem != &reagents) {
			struct list *tmp = elem->next;
			ie = outcast(elem, struct inv_entry, auxlist);
			list_remove(elem);
			elem = tmp;
			ie->ref--;
			player_party->takeOut(ie->type, quantity);
		}
	}

        statusSetMode(ShowParty);

        // committed to action now, so decrement AP, 2 per spell mixed
        if (character)
                character->decActionPoints(quantity);

	// If the spell is invalid or the reagents are incorrect then punish
	// the player.
	if (!spell) {
                cmdwin_spush("oops!");
                player_party->damage(DAMAGE_ACID);
                log_end("ACID!");
                goto done;

        } else if (mistake) {
                cmdwin_spush("ouch!");
                player_party->damage(DAMAGE_BOMB);
                log_end("BOMB!");
                goto done;
	}

	// All is well. Add the spell to player inventory.
        cmdwin_spush("ok");
	player_party->add(spell->type, quantity);
        log_end("ok!");

 done:
	// In case of cancellation I need to unselect all the reagents.
	elem = reagents.next;
	while (elem != &reagents) {
		struct list *tmp = elem->next;
		ie = outcast(elem, struct inv_entry, auxlist);
		list_remove(elem);
		elem = tmp;
		ie->ref--;
	}
	statusSetMode(ShowParty);
	return true;
}

void look_at_XY(struct place *place, int x, int y, void *unused)
{
        if (DeveloperMode) {
                log_begin("At XY=(%d,%d): ", x, y);
        } else {
                log_begin("");
        }

        if ( mapTileIsVisible(x, y) ) {
                if (mapTileLightLevel(x,y) < MIN_XAMINE_LIGHT_LEVEL) {
                        log_continue("You can't see!");
                } else {
                        log_continue("You see ");
                        place_describe(place, x, y, PLACE_DESCRIBE_ALL);
                }
        } else if (ShowAllTerrain) {
                log_continue("You see (via xray) ");
                place_describe(place, x, y, PLACE_DESCRIBE_TERRAIN);
        } else {
                log_continue("You can't see!");
        }

        log_end(NULL);
}

void detailed_examine_XY(struct place *place, int x, int y, void *unused)
{
	// SAM: 
	// Hmmm...how best to print more info about
	// the objects on this tile?
        if ( mapTileIsVisible(x, y) ) {
                log_msg("DETAIL XY=(%d,%d) TODO - print detailed view\n", x, y);
                // For each object/terrain on the tile, print the name (and
                // perhaps show the sprite in a Status Window mode), and also
                // show:
                //
                //     o whether this object blocks LOS (alpha)
                //     o whether this object blocks movement (pmask)
                //     o whether this object causes some effect when stepped
                //       upon (hazardous terrain effects, pressure plate
                //       triggers)
                //     o information specific to the object type, such as:
                //     o Triggers: current state, and perhaps what it is 
                //       connected to?
                //     o NpcParties: faction, movement mode 
                //       (pmask), ...
                //     o Vehicles: movement mode, armament, current HP
                //     o Portable items: weapon/armor stats, (U)se effects, 
                //       etc...
                // Hmmm...what else?
                return;
        }
        log_msg("DETAIL XY=(%d,%d) out of LOS\n", x, y);
}

/**
 * cmd_dm_xray_look_at_xy - like look_at_XY() but unconditionally reports what
 * is there.
 */
static void cmd_dm_xray_look_at_xy(struct place *place, int x, int y, 
                                   void * data)
{
        if (!mapTileIsVisible(x, y) ) {
                log_begin("(Out of LOS) At XY=(%d,%d) you see ", x, y);
                place_describe(place, x, y, PLACE_DESCRIBE_ALL);
                log_end(NULL);
                return;
        }
        log_begin("At XY=(%d,%d) you see ", x, y);
        place_describe(place, x, y, PLACE_DESCRIBE_ALL);
        log_end(NULL);
}

/*
 * cmd_terraform_xy  - terraform this tile
 */
static void cmd_terraform_xy(struct place *place, int x, int y, void * data)
{
        struct terraform_mode_keyhandler * kh = 
                (struct terraform_mode_keyhandler *) data;
        struct terrain_map     * map = kh->map;
        struct terrain_palette * pp  = kh->palette;
        struct terrain         * tt  = palette_current_terrain(pp);

        terrain_map_fill(map, x, y, 1, 1, tt);
        vmask_invalidate(place, x, y, 1, 1);
        mapSetDirty();
        mapUpdate(0);
}

bool cmdXamine(class Object * pc)
{
	// SAM: Working on an improved (L)ook command,
	// which works as a "Look Mode" rather than a 
	// "look at 1 tile" command...
	int x, y;
        bool ret = true;

	cmdwin_clear();
	cmdwin_spush("Xamine");

        x = pc->getX();
        y = pc->getY();

        log_begin_group();

        if (pc)
                log_msg("%s examines around...", pc->getName());
        else
                log_msg("You examine around...");

        look_at_XY(pc->getPlace(), x, y, 0);  // First look at the current tile
	if (select_target_with_doing(x, y, &x, &y, pc->getVisionRadius(),
				     look_at_XY, detailed_examine_XY) == -1) {
		ret = false;
	}

        log_end_group();

	return ret;
} // cmdXamine()

char * name_of_context (void)
{
        // SAM: Perhaps this function belongs in common.c?
        switch (player_party->getContext()) {
        case CONTEXT_WILDERNESS:
                return "Party Context";
                break;
        default:
                return "Character Context";
                break;
        }
} // name_of_context()

bool cmdAT (class Character * pc)
{
	int x, y;
        char * who = "";
        char * place_name = "";

	cmdwin_clear();

        // Should I check player_party->context
        // for the context info below, 
        // rather than the current method?
	if (pc) {
		// A party member was specified as a parameter, so this must be
		// combat mode. Use the party member's location as the origin.
                who = pc->getName();
                place_name =  Place->name;
		x = pc->getX();
		y = pc->getY();
	}
        else {
		// Must be party mode. 
		// Use the player party's location as the origin.
                who = "The party";
                place_name = player_party->getPlace()->name;
                x = player_party->getX();
                y = player_party->getY();
	}
        // SAM: Why is this line not safe in combat mode?
        //      Would it be The Right Thing (TM) 
        //      for it to be made safe in all contexts?
        // place_name = player_party->getPlace()->name;
    
        log_begin_group();
        log_msg("This is %s.", name_of_context() );
        log_msg("%s is in %s.", who, place_name);
		if (Place->underground) {
			log_msg("It is %s, %s of %s in the year %d.",
                day_name(), week_name(), month_name(), Session->clock.year );
        }
		else
		{
			log_msg("It is %s on %s, "
                "%s of %s in the year %d.",
                vague_time_as_string(), day_name(), 
                week_name(), month_name(), Session->clock.year );
		}
        // SAM: Is this really interesting though, I wonder?
        log_msg("%d game turns have passed.", Turn);

        log_msg("The wind is blowing from the %s.",
                directionToString(windGetDirection()) );

        if (Place->underground) {
                log_msg("%s is underground, and cannot see the sky.", 
                        who);
        } // underground
        else {
                struct list *elem;
                
                // SAM: 
                // This message won't be true if you are under 
                // a roof in a town.  In future there should be 
                // logic querying the (future) roof-ripping code here.
                log_msg("%s is beneath the open sky.", who);

                // The kernel no longer has any special knowledge about which
                // astral body is the sun, so we have to deal with all astral
                // bodies generically now. I mean, a game may have two or even
                // more suns. The time runs independently and isn't cued off
                // the sun.
                if (is_noon())
                        log_msg("It is noon.");
                else if (is_midnight())
                        log_msg("It is midnight.");

                // Report on each astral body generically.
                list_for_each(&Session->sky.bodies, elem) {
                        struct astral_body *body;
                        body = outcast(elem, struct astral_body, list);
                        if (astral_body_is_visible(body->arc)) {
                                log_begin("%s is up at arc %d", body->name, 
                                        body->arc);
                                if (body->n_phases > 1) {
                                        char *phase_name = 
                                                body->phases[body->phase].
                                                name;
                                        if (phase_name)
                                                log_continue(" in its %s "
                                                             "phase", 
                                                             phase_name);
                                        else
                                                log_continue(" in phase %d", 
                                                             body->phase);
                                }
                                log_end(".");
                        }
                }

        } // open air, under the sky

        if (player_party->getVehicle()) {
                log_msg("%s is %s a %s.", 
                        who, "using", player_party->getVehicle()->getName() );
                // SAM:
                // In future, we shall want GhulScript to specify 
                // whether one is to be
                //     "riding" "driving" "piloting" "sailing"
                // a particular vehicle type.
                // The existing 'mv_desc' field (Ride, Sail)
                // is related, but we need the gerund of the verb.
        }
        else {
                // SAM: Not true for a party of Gazers or Nixies.
                // Similar GhulScript for party / character movement mode
                // descriptions and gerunds?
                log_msg("%s is on foot.", who);
        }

        log_end_group();

        /*
          Information reported shall include:
          X the current place,X,Y
          X the in-game time in game time units (HH:MM, YYYY/MM/DD)
          X the in-game time in elapased turns (this is of less interest)
          X the current weather status (wind)
          X the current astronomy (day/night, sun, moons)
          X the UI mode of the party (Wilderness,Town,Dungeon,Combat)
          X whether the party is on foot or in a vehicle (and what type)
          . the number of party members, names, order, and basic vital stats
          . global party stats such as food and gold
          . any special effects (buffs/nerfs) currently affecting the party,
          . such as haste/quickness/slow, time stop, protection, etc.
          . Xamine type information about the tile the party is standing on.
        */

        return true;
} // cmdAT()

/**
 * cmd_terraform - edit terrain interactively
 */
bool cmd_terraform(struct place *place, int x, int y)
{
        struct terrain_map     * map;
        struct terrain_palette * palette;
        struct terrain         * terrain;

	cmdwin_clear();
	cmdwin_spush("Terraform");

        map     = place->terrain_map;
        palette = map->palette;
        terrain = palette_current_terrain(palette);

        /* SAM: It would probably be better to set the upper-right "status
         * window" to a new mode.  Then I could show the sprite for the current
         * terrain, and so forth.  That is TODO later; I have not written a new
         * status mode before.  First thing is to get the map editor working.
         */

        log_begin_group();
        log_msg("---Terraform---");
        log_msg("Place %s",     place->tag  );
        log_msg("      \"%s\"", place->name );
        log_msg("Map   %s",     map->tag    );
        log_msg("Palette %s",   palette->tag);
        emit_terraform_status("Trrn", palette, terrain);

        cmd_dm_xray_look_at_xy(place, x,y, NULL);
	cmd_terraform_cursor_func(x, y, &x, &y, 99,
                                  cmd_dm_xray_look_at_xy, 
                                  cmd_terraform_xy,
                                  place);

        log_end_group();

	return true;
} // cmdTerraform()

/*
 * cmdDumpPalette - dump all terrain sprites as one bitmap image per frame to
 * the current directory (intended as an assist for map editing) (thanks to
 * Karl Garrison for this function)
 */
void cmdDumpPalette(void)
{
        struct terrain_palette * palette;
        struct place           * place;
        struct terrain_map     * map;
        struct list *elem;
	SDL_Surface *src_surface;
	SDL_Surface *dest_surface;
	SDL_Rect rect;
	char filename[65];
	int frame_count, frames;

        place   = player_party->getPlace();
        map     = place->terrain_map;
        palette = map->palette;
        list_for_each(&palette->set, elem) {
                struct terrain_palette_entry *entry;
                entry = outcast(elem, struct terrain_palette_entry, list);
                src_surface = entry->terrain->sprite->images->images;
                rect = entry->terrain->sprite->frames[0];
                frames = entry->terrain->sprite->n_frames;
                dest_surface = screenCreateSurface(rect.w, rect.h);
                for (frame_count = 0; frame_count < frames; frame_count++) {
                        rect = entry->terrain->sprite->frames[frame_count];
                        SDL_BlitSurface(src_surface, &rect, dest_surface, 
                                        NULL);
                        sprintf( filename, "%s-%d.bmp", entry->terrain->tag, 
                                 frame_count );
                        SDL_SaveBMP(dest_surface, filename);
                }
                SDL_FreeSurface(dest_surface);
	}
}

void cmdZoomIn(void)
{
        struct place *subplace = 0;
        // 
        // SAM: Curently no "Enter" message is printed.  It turns out to be
        // moderately complicated to do so properly, as a distinct message for
        // each enter_combat() case might be desired...
        // 
        // For now, I print a placeholder message for each case here:
        
        if ((subplace = place_get_subplace(player_party->getPlace(),
                                                  player_party->getX(),
                                                  player_party->getY()))) {

                // Standing over a subplace. Try to enter with no direction,
                // this will prompt the player to provide a direction.
                log_msg("Enter-%s\n", subplace->name);
                player_party->try_to_enter_subplace_from_edge(subplace, 0, 0);

        } else if (!place_is_passable(player_party->getPlace(),
                                      player_party->getX(),
                                      player_party->getY(),
                                      player_party,
                                      PFLAG_IGNOREVEHICLES)) {

                // Currently zooming in to impassable terrain is not doable;
                // since the party might not be placeable on the default map,
                // which would be a solid grid of that impassable terrain.
                // Also, if somehow placed, the party could not escape unless
                // on an edge.  There would be no harm in it otherwise,
                // however.
                struct terrain * tt = 
                        place_get_terrain(player_party->getPlace(),
                                          player_party->getX(),
                                          player_party->getY() );
                log_msg("Enter-Cannot zoom-in to %s!\n", tt->name);
        } else {
                // If standing on ordinary terrain, zoom in:
                struct terrain * tt = 
                        place_get_terrain(player_party->getPlace(),
                                          player_party->getX(),
                                          player_party->getY() );
                log_msg("Enter-%s\n", tt->name);
                run_combat(false, 0, 0, NULL);
        }
}

void cmdSave(void)
{
        char *fname = save_game_menu();
        if (!fname)
                return;

        log_begin("Saving to %s...", fname);
        session_save(fname);
        log_end("ok!");
}

void cmdReload(void)
{
        Reload = 1;        
}

/****** New UI ******/

#define MARKUP 4


int ui_get_yes_no(char *name)
{
	int yesno;
	cmdwin_clear();
	cmdwin_spush("Reply");
        cmdwin_spush("<y/n>");
	getkey(&yesno, yesnokey);
	cmdwin_pop();
	if (yesno == 'y') {
		cmdwin_spush("yes");
		log_msg("%s: Yes", name);
                return 1;
	} else {
		cmdwin_spush("no");
		log_msg("%s: No", name);
                return 0;
	}
}

typedef struct ui_getline_data {
        char *ptr;
        char *buf;
        int room;
} getline_t;

static int ui_getline_handler(struct KeyHandler *kh, int key, int keymod)
{
        getline_t *data = (getline_t*)kh->data;

	if (key == CANCEL) {
		while (data->ptr > data->buf) {
			data->ptr--;
			*data->ptr = 0;
			cmdwin_pop();
			data->room++;
		}
		return 1;
	}

	if (key == '\n') {
		return 1;
	}

	if (key == '\b') {
		if (data->ptr != data->buf) {
			data->ptr--;
			*data->ptr = 0;
			data->room++;
			cmdwin_pop();
		}
		return 0;
	}

	if (isprintable(key) && data->room) {
		cmdwin_push("%c", key);
		*data->ptr++ = key;
		data->room--;
	}

	return 0;
}

int ui_getline_plain(char *buf, int len)
{
        struct KeyHandler kh;
        getline_t data;

        data.buf  = buf;
        data.ptr  = buf;
        data.room = len - 1;

        memset(buf, 0, len);

        kh.fx   = ui_getline_handler;
        kh.data = &data;

        eventPushKeyHandler(&kh);
        eventHandle();
        eventPopKeyHandler();

        return len - (data.room + 1);
}

int ui_getline(char *buf, int len)
{
        cmdwin_clear();
        cmdwin_push("Say: ");
        return ui_getline_plain(buf, len);
}

static void buy(struct merchant *merch)
{
	struct KeyHandler kh;
	struct ScrollerContext sc;
	struct trade_info *trade;
	int quantity, cost, max_q;

	statusSetTradeInfo(merch->n_trades, merch->trades);
	statusSetMode(Trade);

	sc.selector = TradeItem;
	kh.fx = scroller;
	kh.data = &sc;

	for (;;) {

		// *** selection ***

		sc.selection = NULL;

		cmdwin_clear();
		cmdwin_spush("Buy");
                cmdwin_spush("<select/ESC>");
		eventPushKeyHandler(&kh);
		eventHandle();
		eventPopKeyHandler();
		cmdwin_pop();

		trade = (struct trade_info *) sc.selection;

		if (!trade) {
			cmdwin_spush("none!");
			break;
		}

		cmdwin_spush("%s", trade->name);

		if (player_party->gold < trade->cost) {
			int dummy;
			cmdwin_spush("not enough gold! <hit any key>");
			getkey(&dummy, anykey);
			continue;
		}
		// *** quantity ***

                cmdwin_push_mark();
		max_q = player_party->gold / trade->cost;
		quantity = ui_get_quantity(max_q);
                cmdwin_pop_to_mark();

		if (quantity == 0) {
			cmdwin_spush("none!");
			continue;
		}

		quantity = min(quantity, max_q);
		cmdwin_spush("%d", quantity);

		cost = quantity * trade->cost;

		// *** trade ***

                class ObjectType *type = (class ObjectType*)trade->data;
		cmdwin_spush("ok");
		log_msg("You buy %d %s%s for %d gold\n", quantity,
			     trade->name, quantity > 1 ? "s" : "", cost);

		player_party->gold -= cost;
                if (type->canBuy()) {
                        type->buy(player_party->get_leader(), quantity);
                } else {
                        player_party->add(type, quantity);
                }
                trade->quantity = player_party->inventory->numAvail(type);
                statusRepaint();
		foogodRepaint();
	}

	statusSetMode(ShowParty);
}

static bool conv_filter_trade(struct inv_entry *ie, void *cookie)
{
        struct trade_info *trade = (struct trade_info*)cookie;
        return (ie->type == trade->data && ie->count > ie->ref);
}

static int fill_sell_list(struct merchant *merch, struct trade_info *trades)
{
	struct inv_entry *ie = NULL;
        struct filter filter;
	int i, j = 0;

        filter.fx = conv_filter_trade;

        for (i = 0; i < merch->n_trades; i++) {

                if (merch->trades[i].cost / MARKUP == 0)
                        continue;
                
                filter.cookie = &merch->trades[i];
                ie = player_party->inventory->first(&filter);
                if (!ie)
                        continue;

                trades[j] = merch->trades[i];
                trades[j].cost /= MARKUP;
                trades[j].quantity = ie->count - ie->ref;
                trades[j].show_quantity = 1;
                j++;
        }

	return j;
}

static void sell(struct merchant *merch)
{
	// A bit trickier than the "Buy" scenario. A merchant will only buy
	// items that it is willing to turn around and sell at a profit. When
	// it comes time to select an item to sell the user should only see the
	// list of items in player inventory which the merchant is willing to
	// buy. So here we need to build that list and feed it to the status
	// viewer.

	int n_trades = 0;
	struct trade_info *trades;
	struct KeyHandler kh;
	struct ScrollerContext sc;
	struct trade_info *trade;

	// Allocate the trade list.
	trades = new struct trade_info[merch->n_trades];
	if (!trades) {
		log_msg("%s: I don't need anything.\n", merch->name);
		return;
	}
	// Fill out the list
	n_trades = fill_sell_list(merch, trades);
	statusSetTradeInfo(n_trades, trades);
	statusSetMode(Trade);

	sc.selector = TradeItem;
	kh.fx = scroller;
	kh.data = &sc;

	for (;;) {

		struct inv_entry *ie;
		int quantity, max_q;

		sc.selection = NULL;

		cmdwin_clear();
		cmdwin_spush("Sell");
                cmdwin_spush("<select or ESC>");
		eventPushKeyHandler(&kh);
		eventHandle();
		eventPopKeyHandler();
		cmdwin_pop();

		trade = (struct trade_info *) sc.selection;

		if (!trade) {
			cmdwin_spush("none!");
			break;
		}

		cmdwin_spush("%s", trade->name);

		ie = player_party->inventory->search((class ObjectType *) trade->data);
		assert(ie);
		assert(ie->ref < ie->count);

		// quantity

		max_q = ie->count - ie->ref;

		cmdwin_push_mark();
		quantity = ui_get_quantity(max_q);
                cmdwin_pop_to_mark();

		if (quantity == 0) {
			cmdwin_spush("none!");
			continue;
		}

		quantity = min(quantity, max_q);
		cmdwin_spush("%d", quantity);

		// make the trade
		player_party->takeOut(ie->type, quantity);
		player_party->gold += quantity * trade->cost;
		foogodRepaint();

		cmdwin_spush("ok");
		log_msg("You sell %d %s%s for %d gold\n", quantity,
			     trade->name, quantity > 1 ? "s" : "",
			     quantity * trade->cost);

		// refresh the sell list
		n_trades = fill_sell_list(merch, trades);
		statusSetTradeInfo(n_trades, trades);
		statusUpdateTradeInfo(n_trades, trades);
	}

	statusSetMode(ShowParty);

	delete trades;
}

static int get_buy_or_sell_key(struct KeyHandler *kh, int key, int keymod)
{
	int *val = (int *) kh->data;

	switch (key) {
	case 'b':
	case 'B':
		*val = 'b';
		return 1;
	case 's':
	case 'S':
		*val = 's';
		return 1;
	case CANCEL:
		*val = 'x';
		return 1;
	default:
		return 0;
	}
}

void ui_trade(struct merchant *merch)
{
	int key;

	for (;;) {
		cmdwin_clear();
		cmdwin_spush("Buy or sell");
                cmdwin_spush("<B/S/ESC>");
		getkey(&key, get_buy_or_sell_key);

		switch (key) {
		case 'b':
			buy(merch);
			break;
		case 's':
			sell(merch);
			break;
		default:
			cmdwin_pop();
			cmdwin_spush("none!");
			return;
		}
	}
}

static char *cmd_help_text =
"Use the arrow keys to indicate direction.\n"
"Use the ESC key to cancel commands.\n"
"Use the first letter to start a command.\n"
"\n"
"A)ttack something\n"
"B)oard a ship or other vehicle\n"
"C)ast a spell\n"
"E)nter a town or dungeon\n"
"F)ire a ship's cannon or other ordnance\n"
"G)et something on the ground\n"
"H)andle a lever or mechanism\n"
"N)ew-Order (rearrange party order)\n"
"O)pen a chest, door or other closed object\n"
"Q)uit and save the game\n"
"R)eady weapons or armor\n"
"S)earch for hidden stuff\n"
"T)alk to somebody\n"
"U)se an item in inventory\n"
"Z)tats (show party status)\n"
"X)amine around\n"
"@)AT (info about place & time)\n"
"<space> (pass a turn)\n"
"CTRL-Q)uit without saving\n"
"CTRL-S)ave without quitting\n"
"CTRL-R)eload the last saved game\n"
"\n"
"When talking to people, enter a keyword.\n"
"Most people reply to NAME, JOB, TRADE and\n"
"JOIN. Their replies will give you hints\n"
"about more keywords.\n"
;

void cmdHelp(void)
{
        struct KeyHandler kh;

        statusSetPageText("Commands", cmd_help_text);
        statusSetMode(Page);

        kh.fx = scroller;
        kh.data = NULL;
	eventPushKeyHandler(&kh);
	eventHandle();
	eventPopKeyHandler();

        statusSetMode(ShowParty);
}

void ui_name_vehicle(class Vehicle *vehicle)
{
        int yesno;
        char buf[64];

        log_begin("Do you want to name your ");
        vehicle->describe();
        log_end("?");

        cmdwin_spush("Name");
        cmdwin_spush("<y/n>");
        getkey(&yesno, yesnokey);
        cmdwin_pop();
        cmdwin_pop();

        if (yesno == 'n') {
                cmdwin_spush("no!");
                log_msg("It's likely to be stolen!");
                return;
        }

        if (!ui_getline(buf, sizeof(buf))) {
                log_msg("It's likely to be stolen!");
                return;
        }

        vehicle->setName(buf);

        log_begin("You christen ");
        vehicle->describe();
        log_end(".");
}

void cmdSettings(void)
{
        StatusMode omode = statusGetMode();
        options_menu();
        statusSetMode(omode);
}
