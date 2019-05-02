//
//  TableConfig.h
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

#import <Cocoa/Cocoa.h>

@interface TableConfig : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *deckCount;
@property (weak) IBOutlet NSTextField *playerName;
@property (weak) IBOutlet NSTextField *playerBalance;
@property (weak) IBOutlet NSTableView *playerTable;

@property (retain) NSMutableArray *playerNames, *playerBalances;

- (IBAction)addPlayer:(id)sender;
- (IBAction)removeSelectedPlayer:(id)sender;

- (IBAction)cancelGame:(id)sender;
- (IBAction)startGame:(id)sender;

@end
