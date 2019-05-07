//
//  CardView.m
//  Blackjack Mac
//
//  Created by Alessandro Vinciguerra on 2019-05-02.
//      <alesvinciguerra@gmail.com>
//  Copyright (C) 2019 Arc676/Alessandro Vinciguerra

//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation (version 3)

//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//  See README and LICENSE for more details

#import "CardView.h"

@implementation CardView

- (void)drawRect:(NSRect)rect {
	[[NSColor whiteColor] set];
	NSRectFill(rect);
	if (!self.player) {
		return;
	}
	char* name = player_getName(self.player);
	[[NSString stringWithFormat:@"%s's hand", name] drawAtPoint:NSMakePoint(10, 80) withAttributes:nil];
	rust_freestr(name);

	unsigned int handCount = player_handCount(self.player);
	int x = 20;
	for (unsigned int ih = 0; ih < handCount; ih++) {
		if (x != 20) {
			x += 80;
		}
		Hand* hand = player_getHandWithIndex(self.player, ih);
		[[NSString stringWithFormat:@"Hand #%d (%s): %d points",
		  ih + 1,
		  (hand_isSet(hand) ? "set" : "playing"),
		  hand_value(hand)]
		 drawAtPoint:NSMakePoint(x, 60) withAttributes:nil];
		unsigned int cardCount = hand_cardCount(hand);
		for (unsigned int ic = 0; ic < cardCount; ic++) {
			Card* card = hand_getCardWithIndex(hand, ic);
			unsigned int cardNo = card_toU32(card);
			[[self cardToImage:cardNo] drawInRect:NSMakeRect(x, 10, 36, 50)];
			rust_freecard(card);
			x += 40;
		}
		rust_freehand(hand);
	}
}

- (NSImage *)cardToImage:(unsigned int)cardNo {
	char c = 'c';
	switch (cardNo & SUIT) {
		case DIAMONDS:
			c = 'd';
			break;
		case HEARTS:
			c = 'h';
			break;
		case SPADES:
			c = 's';
			break;
		case CLUBS:
		default:
			break;
	}
	int val = cardNo & VALUE;
	return [NSImage imageNamed:[NSString stringWithFormat:@"%c%02d.png", c, val]];
}

@end
