//
//  TableConfig.m
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

#import "TableConfig.h"

@implementation TableConfig

- (void)viewDidLoad {
	self.playerNames = [NSMutableArray array];
	self.playerBalances = [NSMutableArray array];
}

- (IBAction)addPlayer:(id)sender {
	[self.playerNames addObject:[self.playerName stringValue]];
	[self.playerBalances addObject:@([self.playerBalance intValue])];
	[self.playerTable reloadData];
}

- (IBAction)removeSelectedPlayer:(id)sender {
	int idx = (int)[self.playerTable selectedRow];
	if (idx > 0) {
		[self.playerNames removeObjectAtIndex:idx];
		[self.playerBalances removeObjectAtIndex:idx];
		[self.playerTable reloadData];
	}
}

- (IBAction)cancelGame:(id)sender {
	[self.view.window close];
}

- (IBAction)startGame:(id)sender {
	[self.view.window close];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	if ([tableColumn.title isEqualToString:@"Player Name"]) {
		return self.playerNames[row];
	} else {
		return self.playerBalances[row];
	}
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return self.playerNames.count;
}

@end
