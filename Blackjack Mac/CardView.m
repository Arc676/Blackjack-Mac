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
	NSString* text = @"Dealer's hand";
	if (!self.isDealerHand) {
		char* name = player_getName(self.player);
		text = [NSString stringWithFormat:@"%s's hand", name];
		rust_freestr(name);
	}
	[text drawAtPoint:NSMakePoint(10, 80) withAttributes:nil];

	unsigned int handCount = player_handCount(self.player);
	for (unsigned int ih = 0; ih < handCount; ih++) {
		Hand* hand = player_getHandWithIndex(self.player, ih);
		int x = 20;
		[[NSString stringWithFormat:@"Hand #%d", ih] drawAtPoint:NSMakePoint(x, 60) withAttributes:nil];
		unsigned int cardCount = hand_cardCount(hand);
		for (unsigned int ic = 0; ic < cardCount; ic++) {
			Card* card = hand_getCardWithIndex(hand, ic);
			unsigned int cardNo = card_toU32(card);
			[[self cardToImage:cardNo] drawInRect:NSMakeRect(x, 10, 36, 50)];
			rust_freecard(card);
		}
		rust_freehand(hand);
	}
}

- (void)setIsDealer:(BOOL)isDealer {
	_isDealerHand = isDealer;
	[self setNeedsDisplay:YES];
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
