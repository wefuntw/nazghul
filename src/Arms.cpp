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
#include <assert.h>
#include <string.h>

#include "Arms.h"
#include "character.h"
#include "dice.h"
#include "screen.h"
#include "sprite.h"
#include "map.h"
#include "place.h"
#include "Missile.h"
#include "sound.h"
#include "player.h"
#include "log.h"

ArmsType::ArmsType(char *tag, char *name, struct sprite *sprite,
                   int slotMask,
                   char *to_hit_dice,
                   char *to_defend_dice,
                   int numHands,
                   int range,
                   int weight,
                   char *damage_dice,
                   char *armor_dice,
                   int reqActPts,
                   bool thrown,
                   bool ubiquitousAmmo,
                   char *fireSound,
                   class ArmsType *missileType
                   )
        : ObjectType(tag, name, sprite, item_layer),
          slotMask(slotMask),
          numHands(numHands),
          range(range),
          weight(weight),
          thrown(thrown),
          ubiquitousAmmo(ubiquitousAmmo)
{
        toHitDice = strdup(to_hit_dice);
        toDefendDice = strdup(to_defend_dice);
        damageDice = strdup(damage_dice);
        armorDice = strdup(armor_dice);
        assert(toHitDice && toDefendDice && damageDice && armorDice);

        if (fireSound) {
                this->fire_sound = strdup(fireSound);
                assert(fire_sound);
        } else
                this->fire_sound = NULL;

        if (missileType) {
                missile = new Missile(missileType);
                assert(missile);
        } else {
                missile = NULL;
        }

        if (thrown) {
                setMissileType(this);
        }
        
        required_action_points = reqActPts;
}

ArmsType::ArmsType()
{
        // Don't ever expect to call this. Defining it to override the default
        // one c++ automatically creates.
        assert(false);

        missile        = NULL;
        thrown         = false;
        weight         = 0;
        ubiquitousAmmo = false;
        layer          = item_layer;
        fire_sound     = NULL;
        required_action_points = 1;
}

ArmsType::~ArmsType()
{
	if (missile != NULL)
		delete missile;
        if (fire_sound)
                free(fire_sound);
        if (toHitDice)
                free(toHitDice);
        if (toDefendDice)
                free(toDefendDice);
        if (damageDice)
                free(damageDice);
        if (armorDice)
                free(armorDice);
}

bool ArmsType::isType(int classID) 
{
        if (classID == ARMS_TYPE_ID)
                return true;
        return ObjectType::isType(classID);
}

int ArmsType::getType() 
{
        return ARMS_TYPE_ID;
}

class ArmsType *ArmsType::getMissileType()
{
	if (missile == NULL)
		return NULL;
	return (class ArmsType *) missile->getObjectType();
}

void ArmsType::setMissileType(class ArmsType * missileType)
{
	if (missile != NULL) {
		delete missile;
		missile = NULL;
	}

	if (missileType == NULL)
		return;

	missile = new Missile(missileType);
}

bool ArmsType::isMissileWeapon()
{
	return (missile != NULL && !thrown);
}

bool ArmsType::fire(class Character * target, int ox, int oy)
{
	if (isMissileWeapon() || isThrownWeapon()) {
		missile->setPlace(target->getPlace());
		missile->setX(ox);
		missile->setY(oy);
		missile->animate(ox, oy, target->getX(), target->getY(), 0);
		if (!missile->hitTarget())
			return false;
	}
	return true;
}

bool ArmsType::fire(struct place * place, int ox, int oy, int tx, int ty)
{
	if (isMissileWeapon() || isThrownWeapon()) {
		missile->setPlace(place);
		missile->setX(ox);
		missile->setY(oy);
		missile->animate(ox, oy, tx, ty, 0);
	}
	return true;
}

bool ArmsType::fireInDirection(struct place *place, int ox, int oy, 
                               int dx, int dy, class Object *user)
{
        if (!isMissileWeapon() && !isThrownWeapon())
                return false;

        if (fire_sound)
                soundPlay(fire_sound, SOUND_MAX_VOLUME);

        missile->setPlace(place);
        missile->setX(ox);
        missile->setY(oy);
        missile->animate(ox, oy, 
                         dx * getRange() + ox, 
                         dy * getRange() + oy, 
                         MISSILE_IGNORE_LOS|MISSILE_HIT_PARTY);

        if (!missile->hitTarget() || !missile->getStruck())
                return false;

        log_begin("%s hit ", getName());
        missile->getStruck()->describe();
        log_end("!");
        missile->getStruck()->damage(dice_roll(damageDice));

        if (missile->getStruck()->isDestroyed()) {
                log_begin("%s destroyed ", getName());
                missile->getStruck()->describe();
                log_end("!");

                /* Uh... no reference counting on the player party, everybody
                 * assumes it is always good, so don't violate that assumption
                 * here. We need to figure out how to handle the destruction of
                 * player-controlled objects.  */
                if (missile->getStruck() != player_party)
                        delete missile->getStruck();

                mapSetDirty();
        }
        
        user->decActionPoints(getRequiredActionPoints());

        return true;
}

void ArmsType::setThrown(bool val)
{
	if (val == thrown)
		return;
	thrown = val;

	if (!val) {
		if (missile != NULL) {
			delete missile;
			missile = NULL;
		}
		return;
	}
	// the usual case:
	setMissileType(this);
}

class ArmsType *ArmsType::getAmmoType()
{
	if (thrown)
		return this;
	if (missile == NULL)
		return NULL;
	return missile->getObjectType();
}

int ArmsType::getSlotMask()
{
        return slotMask;
}

char * ArmsType::getToHitDice()
{
        return toHitDice;
}

char * ArmsType::getDamageDice()
{
        return damageDice;
}

char * ArmsType::getToDefendDice()
{
        return toDefendDice;
}

char * ArmsType::getArmorDice()
{
        return armorDice;
}

int ArmsType::getNumHands()
{
        return numHands;
}

int ArmsType::getRange()
{
        return range;
}

bool ArmsType::isThrownWeapon()
{
        return thrown;
}

void ArmsType::setUbiquitousAmmo(bool val)
{
        ubiquitousAmmo = val;
}

bool ArmsType::ammoIsUbiquitous() 
{
        return ubiquitousAmmo;
}

void ArmsType::setWeight(int val) 
{
        weight = val;
}

int ArmsType::getWeight(void) 
{
        return weight;
}
