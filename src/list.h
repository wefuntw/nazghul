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
/* 
 * From-scratch impl inspired by the Linux kernel source's list.h 
 */

#ifndef list_h
#define list_h

#ifdef __cplusplus
extern "C" {
#endif

#define list_for_each(head,ptr) \
        for ((ptr) = (head)->next; (ptr) != (head); (ptr) = (ptr)->next)
#define list_init(list) { (list)->next = (list); (list)->prev = (list); }
#define list_empty(list) ((list)->next == (list) && (list)->prev == (list))
#define list_entry(ptr,type,field) \
        ((type*)((char*)(ptr)-(unsigned long)(&((type *)0)->field)))

	struct list {
		struct list *next;
		struct list *prev;
	};

	static inline void list_add_aux(struct list *before, struct list *after,
					struct list *between) {
		between->next = after;
		between->prev = before;
		before->next = between;
		after->prev = between;
	} static inline void list_add(struct list *head, struct list *ptr) {
		list_add_aux(head, head->next, ptr);
	}

	static inline void list_add_tail(struct list *head, struct list *ptr) {
		list_add_aux(head->prev, head, ptr);
	}

	static inline void list_remove(struct list *list) {
		list->prev->next = list->next;
		list->next->prev = list->prev;
		list_init(list);
	}

#ifdef __cplusplus
}
#endif

#endif
