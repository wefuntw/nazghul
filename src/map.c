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
#include "map.h"
#include "sky.h"  // For time/date functions
#include "screen.h"
#include "place.h"
#include "player.h"
#include "sprite.h"
#include "cursor.h"
#include "terrain.h"

#include <SDL/SDL.h>

#define MVIEW_W  (MAP_TILE_W * 2 + 1)
#define MVIEW_H  (MAP_TILE_H * 2 + 1)
#define LMAP_W   (MAP_TILE_W)
#define LMAP_H   (MAP_TILE_H)

#define VMASK_SZ (MVIEW_W * MVIEW_H)
#define MVIEW_SZ (sizeof(struct mview) + VMASK_SZ)
#define LMAP_SZ (LMAP_W * LMAP_H)
#define MAX_LIGHTS LMAP_SZ

#define LIT 255
#define UNLIT 0

/* Global flag changeble by command-line parameters. */
int map_use_circular_vision_radius = 0;

static struct light_source {
	int x, y, light;
} lights[MAX_LIGHTS];

struct mview {
	struct list list;	/* used internally by map lib */
	SDL_Rect vrect;		/* map coords of vrect */
        SDL_Rect subrect;       /* offset into visible subrect of vrect */
	char *vmask;		/* visibility mask */
	int rad;		/* light radius */
	int zoom;
	int dirty:1;		/* needs repaint */
        int blackout:1;         /* erase only on repaint */
};

static struct map {
	SDL_Rect srect;		/* screen coords of viewer */
	SDL_Rect fpsRect;	/* screen coords of FPS counter */
	SDL_Rect locRect;	/* screen coords of locater */
	SDL_Rect clkRect;	/* screen coords of clock */
	struct place *place;	/* subject being viewed */
	struct mview *aview;	/* active view */
	struct list views;	/* list of all views */
	struct mview *cam_view;
	int cam_x, cam_y, cam_max_x, cam_max_y, cam_min_x, cam_min_y;
	bool peering;
	char vmask[VMASK_SZ];	/* final mask used to render */
} Map;

// The lightmap only needs to be as big as the map viewer window. Making it
// larger does allow for lights outside the field of view to be processed, but
// this makes dungeons appear too bright - I like them dark and gloomy.
static unsigned char lmap[LMAP_SZ];

static void myUpdateAlphaMask(struct mview *view)
{
	int vx;
	int vy;
	int mx;
	int my;
	int index = 0;

	for (vy = 0; vy < view->vrect.h; vy++) {
		my = view->vrect.y + vy;
		for (vx = 0; vx < view->vrect.w; vx++) {
			mx = view->vrect.x + vx;
			LosEngine->alpha[index] =
			    place_visibility(Map.place, mx, my);
			index++;
		}
	}
}

static void myRmView(struct mview *view, void *data)
{
	list_remove(&view->list);
}

static void myRecomputeLos(struct mview *view, void *data)
{
	myUpdateAlphaMask(view);
	if (LosEngine->r > 0)
		LosEngine->r = view->rad;
	LosEngine->compute(LosEngine);
	memcpy(view->vmask, LosEngine->vmask, VMASK_SZ);
}

static void myMergeVmask(struct mview *view, void *data)
{
	int r_src, r_src_start, c_src, c_src_start, i_src, r_end, c_end;
	int r_dst, r_dst_start, c_dst, c_dst_start, i_dst;
	int tmp;

	/* Skip this view if it is the active view */
	if (view == Map.aview)
		return;

	/* 
	 * x |<-- w -->| 
         *   +--------------------+ | A | | +-------------------+-y
	 * | |/////////.  |^ | |/////////.  || | |/////////.  || | |/////////.
	 * || | |/////////.  || | |/////////.  || | |/////////.  || |
	 * |/////////.  || | |/////////.  |h | |/////////.  || | |/////////.  ||
	 * | |/////////.  || | |/////////.  || | |/////////.  || | |/////////.
	 * || | |/////////.  |v +----------|..........  |- | B |
	 * +-------------------+ */
	if (view->vrect.x < Map.aview->vrect.x) {
		/* This view leftmost (A) */
		tmp = view->vrect.x + view->vrect.w - Map.aview->vrect.x;
		if (tmp < 0)
			return;
		c_src_start = Map.aview->vrect.x - view->vrect.x;
		c_end = c_src_start + tmp;
		c_dst_start = 0;
	} else {
		/* Active view leftmost (A) */
		tmp = Map.aview->vrect.x + Map.aview->vrect.w - view->vrect.x;
		if (tmp < 0)
			return;
		c_src_start = 0;
		c_end = tmp;
		c_dst_start = view->vrect.x - Map.aview->vrect.x;
	}

	if (view->vrect.y < Map.aview->vrect.y) {
		/* This view topmost (A) */
		tmp = view->vrect.y + view->vrect.h - Map.aview->vrect.y;
		if (tmp < 0)
			return;
		r_src_start = Map.aview->vrect.y - view->vrect.y;
		r_end = r_src_start + tmp;
		r_dst_start = 0;
	} else {
		/* Active view topmost (A) */
		tmp = Map.aview->vrect.y + Map.aview->vrect.h - view->vrect.y;
		if (tmp < 0)
			return;
		r_src_start = 0;
		r_end = tmp;
		r_dst_start = view->vrect.y - Map.aview->vrect.y;
	}

	for (r_src = r_src_start, r_dst = r_dst_start; r_src < r_end;
	     r_src++, r_dst++) {
		for (c_src = c_src_start, c_dst = c_dst_start; c_src < c_end;
		     c_src++, c_dst++) {
			i_src = r_src * MVIEW_W + c_src;
			i_dst = r_dst * MVIEW_W + c_dst;
			Map.vmask[i_dst] |= view->vmask[i_src];
		}
	}
}

static void myMarkAsDirty(struct mview *view, void *data)
{
	view->dirty = 1;
}

static void mySetViewLightRadius(struct mview *view, void *data)
{
	int rad = (int) data;
	view->rad = rad;
}

static void myBuildLightMap(struct mview *view)
{
	int x, y, i = 0, j, k, map_x, map_y;

	// Initialize the lightmap to ambient light levels.
	if (Map.place->underground) {
		memset(lmap, UNLIT, sizeof(lmap));
	} else {
		memset(lmap, Sun.light, sizeof(lmap));
	}

	// Pass 1: fill out all the light sources
	for (y = 0; y < LMAP_H; y++) {
		map_y = view->vrect.y + view->subrect.y + y;
		for (x = 0; x < LMAP_W; x++) {
			int light;

			map_x = view->vrect.x + view->subrect.x + x;
			light = place_get_light(Map.place, map_x, map_y);
			if (!light)
				continue;

			// Remember the light source
			lights[i].x = map_x;
			lights[i].y = map_y;
			lights[i].light = light;
			i++;
		}
	}

	// Don't forget the player if this is not a small-scale map. Even if
	// the player has light zero, by simply adding a light source on his
	// location we make sure that the tile he is standing on will be
	// lit.
	if (player_party->context != CONTEXT_COMBAT) {
		lights[i].x = place_wrap_x(Map.place, player_party->getX());
		lights[i].y = place_wrap_y(Map.place, player_party->getY());
		lights[i].light = player_party->light;
		i++;
	}

	// Skip further processing if there are no light sources
	if (!i)
		return;

	// Pass 2: distribute the light to all the squares in the lmap
	for (y = 0, k = 0; y < LMAP_H; y++) {
		map_y = view->vrect.y + view->subrect.y + y;

		for (x = 0; x < LMAP_W; x++, k++) {
			map_x = view->vrect.x + view->subrect.x + x;

			// For each light source...
			for (j = 0; j < i; j++) {

				int dx, dy, D, tmp;

                                // Check if los is blocked. This might *really* bog us
                                // down on slow machines.
                                if (place_los_blocked(Map.place, 
                                                      lights[j].x, lights[j].y,
                                                      map_x, map_y))
                                        continue;

				// Calculate the distance squared.
                                // fixme -- need to wrap, use place fx?
				dx = lights[j].x - map_x;
				dy = lights[j].y - map_y;
				D = (dx * dx) + (dy * dy) + 1;

				// Calculate the light as source luminence over
                                // distance squared. Clamp to 255.
				tmp = lmap[k] + lights[j].light / D;
				if (tmp > 255)
					tmp = 255;
				lmap[k] = tmp;
			}
		}
	}
}

static void myShadeScene(SDL_Rect *subrect)
{
	int x, y;
	SDL_Rect rect;
        int lmap_i;

	rect.x = Map.srect.x;
	rect.y = Map.srect.y;
	rect.w = TILE_W;
	rect.h = TILE_H;

        //lmap_i = subrect->y * MVIEW_W + subrect->x;
        lmap_i = 0;

	// Iterate over the tiles in the map window and the corresponding
	// values in the lightmap simultaneously */
	for (y = 0; y < MAP_TILE_H; y++, rect.y += TILE_H, 
                     lmap_i += LMAP_W /*lmap_i += MVIEW_W*/) {
		for (x = 0, rect.x = Map.srect.x;
		     x < MAP_TILE_W; x++, rect.x += TILE_W) {

			/* Set the shading based on the lightmap value. The
			 * lightmap values must be converted to opacity values
			 * for a black square, so I reverse them by subtracting
			 * them from LIT. */
			screenShade(&rect, LIT - lmap[lmap_i + x]);
		}
	}
}

static inline void myAdjustCameraInBounds(void)
{
	if (Map.place->wraps)
		return;

	Map.cam_x = min(Map.cam_x, Map.cam_max_x);
	Map.cam_x = max(Map.cam_x, Map.cam_min_x);
	Map.cam_y = min(Map.cam_y, Map.cam_max_y);
	Map.cam_y = max(Map.cam_y, Map.cam_min_y);
}

void mapForEach(void (*fx) (struct mview *, void *), void *data)
{
	struct list *list;
	list = Map.views.next;
	while (list != &Map.views) {
		struct list *tmp;
		struct mview *view;
		view = outcast(list, struct mview, list);
		tmp = list->next;
		fx(view, data);
		list = tmp;
	}
}

int mapInit(char *los)
{

	memset(&Map, 0, sizeof(Map));

	if (!(Map.cam_view = mapCreateView()))
		return -1;

	Map.srect.x = MAP_X;
	Map.srect.y = MAP_Y;
	Map.srect.w = MAP_W;
	Map.srect.h = MAP_H;

	Map.fpsRect.x = MAP_X;
	Map.fpsRect.y = MAP_Y;
	Map.fpsRect.w = ASCII_W * 10;
	Map.fpsRect.h = ASCII_H;

	Map.locRect.x = MAP_X;
	Map.locRect.y = MAP_Y + MAP_H - ASCII_H;
	Map.locRect.w = ASCII_W * 9;
	Map.locRect.h = ASCII_H;

	Map.clkRect.w = ASCII_W * 7;
	Map.clkRect.h = ASCII_H;
	Map.clkRect.x = MAP_X + MAP_W - Map.clkRect.w;
	Map.clkRect.y = MAP_Y;

	list_init(&Map.views);
	Map.peering = false;

	/* fixme -- why create this here? why not just pass it in? */
#if 0
	LosEngine = los_create(los, MAP_TILE_W, MAP_TILE_H,
			       map_use_circular_vision_radius ?
			       MAX_VISION_RADIUS : -1);
#else
	LosEngine = los_create(los, MVIEW_W, MVIEW_H,
			       map_use_circular_vision_radius ?
			       MAX_VISION_RADIUS : -1);
#endif
	if (!LosEngine) {
		mapDestroyView(Map.cam_view);
		return -1;
	}

	return 0;
}

void mapFlash(int mdelay)
{
	screenFlash(&Map.srect, mdelay, White);
}

void mapSetPlace(struct place *place)
{
	Map.place = place;

	if (place->wraps)
		return;

	if (place_w(place) > MAP_TILE_W) {
		Map.cam_max_x = place_w(place) - MAP_TILE_W / 2 - 1;
		Map.cam_min_x = MAP_TILE_W / 2;
	} else {
		Map.cam_min_x = Map.cam_max_x = (place_w(place) + 1)/ 2 - 1;
	}

	if (place_h(place) > MAP_TILE_W) {
		Map.cam_max_y = place_h(place) - MAP_TILE_H / 2 - 1;
		Map.cam_min_y = MAP_TILE_H / 2;
	} else {
		Map.cam_min_y = Map.cam_max_y = (place_h(place) + 1) / 2 - 1;
	}
}

struct mview *mapCreateView(void)
{
	struct mview *v;

	/* Allocate a new view */
	if (!(v = (struct mview *) malloc(MVIEW_SZ)))
		return 0;

	/* Initialize the new view */
	memset(v, 0, MVIEW_SZ);
	list_init(&v->list);
	v->vrect.w = MVIEW_W;
	v->vrect.h = MVIEW_H;
	v->vmask = (char *) v + sizeof(*v);
        v->zoom = 1;
        v->subrect.w = MAP_TILE_W * v->zoom;
        v->subrect.h = MAP_TILE_H * v->zoom;
        v->subrect.x = (v->vrect.w - v->subrect.w) / 2;
        v->subrect.y = (v->vrect.h - v->subrect.h) / 2;

	return v;

}

void mapDestroyView(struct mview *view)
{
	free(view);
}

void mapAddView(struct mview *view)
{
	list_add(&Map.views, &view->list);
}

void mapRmView(struct mview *view)
{
	if (view == ALL_VIEWS)
		mapForEach(myRmView, 0);
	else
		myRmView(view, 0);
}

void mapCenterView(struct mview *view, int x, int y)
{
        x -= view->vrect.w / 2; // back up to corner of vrect
        y -= view->vrect.h / 2; // back up to corner of vrect
	view->vrect.x = place_wrap_x(Map.place, x);
	view->vrect.y = place_wrap_y(Map.place, y);
}

void mapRecomputeLos(struct mview *view)
{
	if (view == ALL_VIEWS)
		mapForEach(myRecomputeLos, 0);
	else
		myRecomputeLos(view, 0);
}

void mapRepaintClock(void)
{
  char * date_time_str = time_HHMM_as_string();
  
  // Show the clock time:
  screenErase(&Map.clkRect);
  screenPrint(&Map.clkRect, 0, "%s", date_time_str);
  screenUpdate(&Map.clkRect);
} // mapRepaintClock()

static void map_convert_point_to_vrect(int *x, int *y)
{
        SDL_Rect *vrect = &Map.aview->vrect;
  
        // If the view rect extends past the right side of the map, and x is
        // left of the view rect, then convert x to be right of the view rect.
        if ((vrect->x + vrect->w) > place_w(Map.place) && 
            *x < vrect->x) {
                *x += place_w(Map.place);
        }
        
        // Likewise if the view rect extends beyond the southern edge of the
        // map, and y is less than the top of the view rect, then convert y to
        // be south of the view rect.
        if ((vrect->y + vrect->h) > place_h(Map.place) && 
            *y < vrect->y) {
                *y += place_h(Map.place);
        }
}

static void map_paint_cursor(void)
{
        int x, y;
        int sx, sy;

        if (!Cursor->is_active())
                return;

        // Convert to view rect offset
        x = Cursor->getX();
        y = Cursor->getY();
        map_convert_point_to_vrect(&x, &y);
        if (!point_in_rect(x, y, &Map.aview->vrect)) {
                return;
        }

        // Paint it
        sx = Map.srect.x + (x - (Map.aview->vrect.x + Map.aview->subrect.x)) * 
                TILE_W;
        sy = Map.srect.y + (y - (Map.aview->vrect.y + Map.aview->subrect.y)) * 
                TILE_H;
        printf("[%d %d %d %d] [%d %d] [%d %d]\n", 
               Map.aview->vrect.x, Map.aview->vrect.y, 
               Map.aview->vrect.w, Map.aview->vrect.h,
               x, y, sx, sy);
        spritePaint(Cursor->getSprite(), 0, sx, sy);
}

static void mapPaintPlace(struct place *place, 
                          SDL_Rect * region,   /* portion of place covered by
                                                * the vmask */
                          SDL_Rect * dest,     /* screen rectangle */
                          unsigned char *mask, /* visibility mask for entire
                                                * region */
                          SDL_Rect * subrect,  /* sub-rectangle within region
                                                * that the map viewer sees */
                          int tile_h, 
                          int tile_w)
{
	int row;
	int col;
	int map_y; /* in rows */
	int map_x; /* in cols */
	int scr_x; /* in pixels */
	int scr_y; /* in pixels */
        int mask_i;
	bool use_mask;

	if (place->wraps) {
		region->x = place_wrap_x(place, region->x);
		region->y = place_wrap_y(place, region->y);
	}

        /* 
           +-----------------------------------------------------------------+
           | region/mask                                                     |
           |                                                                 |
           |                    +-------------------------+                  |
           |                    | subrect                 |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    |                         |                  |
           |                    +-------------------------+                  |
           |                                                                 |
           |                                                                 |
           +-----------------------------------------------------------------+
        */

	use_mask = (mask != NULL);
	map_y = region->y + subrect->y;
        mask_i = (subrect->y * region->w) + subrect->x;

	for (row = 0; 
             row < subrect->h; 
             row++, map_y++, mask_i += region->w) {

                /* Test if the row is off-map */
		if (place->wraps) {
			map_y = place_wrap_y(place, map_y);
		} else if (map_y < 0) {
			continue;
		} else if (map_y >= place->terrain_map->h) {
			break;
		}
                
                /* Set the screen pixel row */
		scr_y = row * tile_h + dest->y;

                /* Set the initial map column for this row */
		map_x = region->x + subrect->x;

		for (col = 0; col < subrect->w; col++, map_x++) {

			struct sprite *sprite;
                        struct terrain *terrain;

                        /* Test if the column is off-map */
			if (place->wraps) {
				map_x = place_wrap_x(place, map_x);
			} else if (map_x < 0) {
				continue;
			} else if (map_x >= place->terrain_map->w) {
				break;
			}

			/* Skip terrain that is masked out unless
                           show-all-terrain is in effect */
			if (!ShowAllTerrain && use_mask && !mask[mask_i + col])
				continue;

                        /* Set the screen pixel column */
			scr_x = col * tile_w + dest->x;

			/* Paint the terrain */
                        terrain = place_get_terrain(place, map_x, map_y);
			sprite = terrain->sprite;
			spritePaint(sprite, 0, scr_x, scr_y);

			/* Shade terrain that is masked out if show-all-terrain
                           is in effect */
			if (ShowAllTerrain) { 
                                if (use_mask && !mask[mask_i + col]) {
                                        SDL_Rect shade_rect;
                                        shade_rect.x = scr_x;
                                        shade_rect.y = scr_y;
                                        shade_rect.w = TILE_W;
                                        shade_rect.h = TILE_H;
                                        screenShade(&shade_rect, 128);
                                }
                        } else {
                                /* Show-all-terrain is not in effect, so this
                                   tile must not be masked out. Paint the
                                   objects. */
                                place_paint_objects(place, map_x, map_y, 
                                                    scr_x, scr_y);
                        }
		}
	}

	place->dirty = 0;
}


void mapRepaintView(struct mview *view, int flags)
{
	int t2, t3, t4, t5, t6, t7, t8;

	Map.aview = view;

	if (flags & REPAINT_IF_DIRTY && !view->dirty)
		return;
	view->dirty = 0;

	int start = SDL_GetTicks();

	screenErase(&Map.srect);

        if (Map.aview->blackout) {
                // In blackout mode leave the screen erased
                goto done_painting_place;
        }

	t2 = SDL_GetTicks();
        
	if (Map.aview->zoom > 1) {
                spriteZoomOut(Map.aview->zoom);
		screenZoomOut(Map.aview->zoom);
		mapPaintPlace(Map.place, &view->vrect, &Map.srect, 
                              0/* vmask */, &view->subrect, 
                              TILE_W / Map.aview->zoom, 
                              TILE_H / Map.aview->zoom);
		screenZoomIn(Map.aview->zoom);
                spriteZoomIn(Map.aview->zoom);
	} else if (flags & REPAINT_NO_LOS) {
		mapPaintPlace(Map.place, &view->vrect, &Map.srect, 0, 
                              &view->subrect, TILE_W, TILE_H);
	} else {
		memcpy(Map.vmask, Map.aview->vmask, VMASK_SZ);
		t3 = SDL_GetTicks();
		mapForEach(myMergeVmask, 0);
		t4 = SDL_GetTicks();
		myBuildLightMap(view);
		t5 = SDL_GetTicks();
		mapPaintPlace(Map.place, &view->vrect, &Map.srect,
                              (unsigned char *) Map.vmask, &view->subrect,
                              TILE_W, TILE_H);
		t6 = SDL_GetTicks();
		myShadeScene(&view->subrect);
		t7 = SDL_GetTicks();
                map_paint_cursor();
	}

 done_painting_place:

	// Show the player's location. In combat mode use the leader, else use
	// the party.
	class Character *leader = player_party->get_leader();
	if (leader)
		screenPrint(&Map.locRect, 0, "[%d,%d]", leader->getX(),
			    leader->getY());
	else
		screenPrint(&Map.locRect, 0, "[%d,%d]", player_party->getX(),
			    player_party->getY());

	mapRepaintClock();	// since we erased it above

	screenUpdate(&Map.srect);
	t8 = SDL_GetTicks();

	// Show the frame rate (do this after the update above to get a better
	// measure of the time it takes to paint the screen).
	screenPrint(&Map.fpsRect, 0, "FPS: %d",
		    1000 / (SDL_GetTicks() - start + 1));
	screenUpdate(&Map.fpsRect);

#ifdef PROFILE
	printf("Total time=%d\n", t8 - start);
	printf("  Erase screen=%d\n", t2 - start);
	printf("  memcpy=%d\n", t3 - t2);
	printf("  merge vmasks=%d\n", t4 - t3);
	printf("  build lightmap=%d\n", t5 - t4);
	printf("  paint place=%d\n", t6 - t5);
	printf("  shade=%d\n", t7 - t6);
	printf("  update screen=%d\n", t8 - t7);
#endif
}

int mapTileIsWithinViewport(int x, int y)
{
  SDL_Rect *vrect = &Map.aview->vrect;
  
  // If the view rect extends past the right side of the map, and x is
  // left of the view rect, then convert x to be right of the view rect.
  if ((vrect->x + vrect->w) > place_w(Map.place) && 
      x < vrect->x) {
    x += place_w(Map.place);
  }
  
  // Likewise if the view rect extends beyond the southern edge of the
  // map, and y is less than the top of the view rect, then convert y to
  // be south of the view rect.
  if ((vrect->y + vrect->h) > place_h(Map.place) && 
      y < vrect->y) {
    y += place_h(Map.place);
  }
  
  // check if the coords are in the view rect
  if (x < vrect->x ||
      x >= (vrect->x + vrect->w) ||
      y < vrect->y ||
      y >= (vrect->y + vrect->h))
    return 0;

  return 1;  
}

int mapTileIsVisible(int x, int y)
{       
        int index;
        SDL_Rect *vrect = &Map.aview->vrect;

        // If the view rect extends past the right side of the map, and x is
        // left of the view rect, then convert x to be right of the view rect.
        if ((vrect->x + vrect->w) > place_w(Map.place) && 
            x < vrect->x) {
                x += place_w(Map.place);
        }

        // Likewise if the view rect extends beyond the southern edge of the
        // map, and y is less than the top of the view rect, then convert y to
        // be south of the view rect.
        if ((vrect->y + vrect->h) > place_h(Map.place) && 
            y < vrect->y) {
                y += place_h(Map.place);
        }
        

        // check if the coords are in the view rect
        if (x < vrect->x ||
            x >= (vrect->x + vrect->w) ||
            y < vrect->y ||
            y >= (vrect->y + vrect->h))
                return 0;

        // check if the tile is marked as visible in the view rect
        index = (y - vrect->y) * vrect->w +
                (x - vrect->x);
        
        return Map.vmask[index];
            
}
void mapMarkAsDirty(struct mview *view)
{
	if (view == ALL_VIEWS)
		mapForEach(myMarkAsDirty, 0);
	else
		myMarkAsDirty(view, 0);
}

void mapSetRadius(struct mview *view, int rad)
{
	if (view == ALL_VIEWS)
		mapForEach(mySetViewLightRadius, (void *) rad);
	else
		mySetViewLightRadius(view, (void *) rad);
}

int mapGetRadius(struct mview *view)
{
	return view->rad;
}

void mapGetMapOrigin(int *x, int *y)
{
	assert(Map.aview);
	*x = Map.aview->vrect.x + Map.aview->subrect.x;
	*y = Map.aview->vrect.y + Map.aview->subrect.y;
}

void mapGetScreenOrigin(int *x, int *y)
{
	*x = Map.srect.x;
	*y = Map.srect.y;
}

void mapGetTileDimensions(int *w, int *h)
{
        *w = TILE_W / Map.aview->zoom;
        *h = TILE_H / Map.aview->zoom;
}

void mapSetActiveView(struct mview *view)
{
	Map.aview = view;
}

void mapCenterCamera(int x, int y)
{
	Map.cam_x = x;
	Map.cam_y = y;

	Map.cam_x = place_wrap_x(Map.place, Map.cam_x);
	Map.cam_y = place_wrap_y(Map.place, Map.cam_y);

	myAdjustCameraInBounds();
	mapCenterView(Map.cam_view, Map.cam_x, Map.cam_y);
}

void mapMoveCamera(int dx, int dy)
{
	mapCenterCamera(Map.cam_x + dx, Map.cam_y + dy);
}

void mapUpdate(int flags)
{
	mapRepaintView(Map.cam_view, flags);
}

void mapSetDirty(void)
{
	Map.cam_view->dirty = 1;
}

void mapJitter(bool val)
{
	Map.srect.x = MAP_X;
	Map.srect.y = MAP_Y;
	Map.srect.w = MAP_W;
	Map.srect.h = MAP_H;

	if (val) {
		Map.srect.x += (random() % 5) - 2;
		Map.srect.y += (random() % 5) - 2;
	}
}

void mapPeer(bool val)
{
#define PEER_ZOOM 2
	int dx, dy;
	// Peering will apply to the camera view. Set the scale factor and
	// adjust the pertinent rectangle dimensions.
        Map.peering = val;
	if (val) {
		Map.cam_view->zoom = PEER_ZOOM;
		dx = (Map.cam_view->vrect.w / 2) * (PEER_ZOOM - 1);
		dy = (Map.cam_view->vrect.h / 2) * (PEER_ZOOM - 1);
		Map.cam_view->vrect.x -= dx;
		Map.cam_view->vrect.y -= dy;
		Map.cam_view->vrect.w *= PEER_ZOOM;
		Map.cam_view->vrect.h *= PEER_ZOOM;
	} else {
		Map.cam_view->zoom = 1;
		Map.cam_view->vrect.w /= PEER_ZOOM;
		Map.cam_view->vrect.h /= PEER_ZOOM;
		dx = (Map.cam_view->vrect.w / 2) * (PEER_ZOOM - 1);
		dy = (Map.cam_view->vrect.h / 2) * (PEER_ZOOM - 1);
		Map.cam_view->vrect.x += dx;
		Map.cam_view->vrect.y += dy;
	}

        Map.cam_view->subrect.w = MAP_TILE_W * Map.cam_view->zoom;
        Map.cam_view->subrect.h = MAP_TILE_H * Map.cam_view->zoom;
        Map.cam_view->subrect.x = (Map.cam_view->vrect.w - 
                                   Map.cam_view->subrect.w) / 2;
        Map.cam_view->subrect.y = (Map.cam_view->vrect.h - 
                                   Map.cam_view->subrect.h) / 2;
}

void mapTogglePeering(void)
{
        mapPeer(!Map.peering);
        mapCenterCamera(Map.cam_x, Map.cam_y); // recenter
        mapUpdate(0);
}

void mapGetCameraFocus(struct place **place, int *x, int *y)
{
        *place = Map.place;
        *x = Map.cam_x;
        *y = Map.cam_y;
}

void mapBlackout(int val)
{
        Map.cam_view->blackout = !!val;
}

static void mapPaintProjectile(SDL_Rect *rect, struct sprite *sprite,
                               SDL_Surface *surf)
{
	// The rect coordinates are in SCREEN coordinates (not map) so I need
	// to do some clipping here to make sure we don't paint off the map
	// viewer.
	if (rect->x < MAP_X || rect->y < MAP_Y ||
	    ((rect->x + rect->w) > (MAP_X + MAP_W)) ||
	    ((rect->y + rect->h) > (MAP_Y + MAP_H)))
		return;

	// Save the backdrop of the new location
	screenCopy(rect, NULL, surf);

	// Paint the missile at the new location
        spriteZoomOut(Map.aview->zoom);
        screenZoomOut(Map.aview->zoom);
	spritePaint(sprite, 0, rect->x, rect->y);
        spriteZoomIn(Map.aview->zoom);
        screenZoomIn(Map.aview->zoom);

	screenUpdate(rect);

	// Pause. Doing nothing is too fast, usleep and SDL_Delay are both too
	// slow, so use the custom calibrated busywait.
	busywait(1);

	// Erase the missile by blitting the background
	screenBlit(surf, NULL, rect);
	screenUpdate(rect);
}

void mapAnimateProjectile(int Ax, int Ay, int *Bx, int *By, 
                          struct sprite *sprite, struct place *place)
{
	// 
	// Derived from Kenny Hoff's Bresenhaum impl at
	// http://www.cs.unc.edu/~hoff/projects/comp235/bresline/breslin1.txt
	// (no license or copyright noted)
	// 

        SDL_Surface * surf;	// for saving/restoring the background

        // Get the (possible zoomed) tile dimensions.
        int tile_w;
        int tile_h;
        mapGetTileDimensions(&tile_w, &tile_h);

	// Create a scratch surface for saving/restoring the background
        surf = screenCreateSurface(tile_w, tile_h);
        assert(surf);

	// Get the map coordinates of the view origin (upper left corner)
	int Ox, Oy;
	mapGetMapOrigin(&Ox, &Oy);

	// Get the screen coordinates of the map viewer origin
	int Sx, Sy;
	mapGetScreenOrigin(&Sx, &Sy);

	// Copy the place coordinates of the origin of flight. I'll walk these
	// along as the missile flies and check for obstructions.
	int Px, Py;
	Px = Ax;
	Py = Ay;

	// Convert to screen coordinates. (I need to keep the original
	// B-coordinates for field effects at the bottom of this routine).
	Ax = (Ax - Ox) * tile_w + Sx;
	Ay = (Ay - Oy) * tile_h + Sy;
	int sBx = (*Bx - Ox) * tile_w + Sx;
	int sBy = (*By - Oy) * tile_h + Sy;

	// Create the rect which bounds the missile's sprite (used to update
	// that portion of the screen after blitting the sprite).
	SDL_Rect rect;
	rect.x = Ax;
	rect.y = Ay;
	rect.w = TILE_W;
	rect.h = TILE_H;

	// Get the distance components
	int dX = sBx - rect.x;
	int dY = sBy - rect.y;
	int AdX = abs(dX);
	int AdY = abs(dY);

	// Select the sprite orientation based on direction of travel
        if (sprite) {
                spriteSetFacing(sprite, vector_to_dir(dX, dY));
        }

	// Moving left?
	int Xincr = (rect.x > sBx) ? -1 : 1;

	// Moving down?
	int Yincr = (rect.y > sBy) ? -1 : 1;

	// Walk the x-axis?
	if (AdX >= AdY) {

		int dPr = AdY << 1;
		int dPru = dPr - (AdX << 1);
		int P = dPr - AdX;

		// For each x
		for (int i = AdX; i >= 0; i--) {

			Px = ((rect.x - Sx) / tile_w + Ox);
			Py = ((rect.y - Sy) / tile_h + Oy);
			if (!place_visibility(place, Px, Py))
				goto done;

                        if (sprite)
                                mapPaintProjectile(&rect, sprite, surf);

			if (P > 0) {
				rect.x += Xincr;
				rect.y += Yincr;
				P += dPru;
			} else {
				rect.x += Xincr;
				P += dPr;
			}
		}
	}
	// Walk the y-axis
	else {
		int dPr = AdX << 1;
		int dPru = dPr - (AdY << 1);
		int P = dPr - AdY;

		// For each y
		for (int i = AdY; i >= 0; i--) {

			Px = ((rect.x - Sx) / tile_w + Ox);
			Py = ((rect.y - Sy) / tile_h + Oy);
			if (!place_visibility(place, Px, Py))
				goto done;

                        if (sprite)
                                mapPaintProjectile(&rect, sprite, surf);

			if (P > 0) {
				rect.x += Xincr;
				rect.y += Yincr;
				P += dPru;
			} else {
				rect.y += Yincr;
				P += dPr;
			}
		}
	}

      done:
	// erase the missile
	// mapRepaintView(NULL, REPAINT_ACTIVE);
	mapUpdate(0);

	// restore the missile sprite to the default facing
        if (sprite)
                spriteSetFacing(sprite, SPRITE_DEF_FACING);

	if (surf != NULL)
		SDL_FreeSurface(surf);

        *Bx = Px;
        *By = Py;

}


#if 0
	// This is the original peering code which used one pixel per
	// tile. That makes the map WAY too small. But it could be useful for a
	// minimap so I'm keeping the code for now.

	int sx, sy, mx, my, max_sx, max_sy;
	int start_mx, start_my;
	int center_mx, center_my;

	Map.peering = val;

	if (!val)
		return;

	if (screenLock() < 0)
		return;

	// Find the map coordinates of the center of the viewed area.
	class Character *leader = playerGetLeader();
	if (leader) {
		center_mx = leader->getX();
		center_my = leader->getY();
	} else {
		center_mx = player_party->getX();
		center_my = player_party->getY();
	}

	// Find the edges in map coordinates. Ok if negative.
	start_my = center_my - MVIEW_H / 2;
	start_mx = center_mx - MVIEW_W / 2;

	// Iterate over the visible region. Paint one pixel for each tile
	// colored according to its terrain type.
	max_sx = Map.srect.x + Map.srect.w;
	max_sy = Map.srect.y + Map.srect.h;
	my = start_my;
	for (sy = Map.srect.y; sy < max_sx; my++, sy++) {
		mx = start_mx;
		for (sx = Map.srect.x; sx < max_sx; mx++, sx++) {
			screenSetPixel(sx, sy, place_get_color(Place, mx, my));
		}
	}

	screenUnlock();

	screenUpdate(&Map.srect);
#endif
