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
#import "TableConfig.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *playerName;
@property (weak) IBOutlet NSTextField *playerWager;
@property (weak) IBOutlet CardView *dealerHand;
@property (weak) IBOutlet CardView *playerHand;

@property (weak) IBOutlet NSButton *hitButton;
@property (weak) IBOutlet NSButton *standButton;
@property (weak) IBOutlet NSButton *doubleButton;
@property (weak) IBOutlet NSButton *splitButton;
@property (weak) IBOutlet NSButton *surrenderButton;
@property (weak) IBOutlet NSButton *nextButton;

@property (assign) Deck* deck;
@property (assign) Player** players;
@property (assign) Player* dealer;
@property (assign) int playerCount, currentPlayer;

- (void)newGame:(NSNotification*)notif;

- (IBAction)beginTurn:(id)sender;
- (IBAction)passTurn:(id)sender;
- (void)setTurnActive:(BOOL)active;

- (IBAction)playerHit:(id)sender;
- (IBAction)playerStand:(id)sender;
- (IBAction)playerDouble:(id)sender;
- (IBAction)playerSplit:(id)sender;
- (IBAction)playerSurrender:(id)sender;

@end
