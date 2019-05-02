//
//  ViewController.h
//  Blackjack Mac
//
//  Created by Alessandro Vinciguerra on 2019-04-18.
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

#import <Cocoa/Cocoa.h>
#import "CardView.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *playerName;
@property (weak) IBOutlet NSTextField *playerWager;
@property (weak) IBOutlet CardView *dealerHand;
@property (weak) IBOutlet CardView *playerHand;

- (IBAction)beginTurn:(id)sender;

- (IBAction)playerHit:(id)sender;
- (IBAction)playerStand:(id)sender;
- (IBAction)playerDouble:(id)sender;
- (IBAction)playerSplit:(id)sender;
- (IBAction)playerSurrender:(id)sender;

@end
