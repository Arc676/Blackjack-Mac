//
//  ViewController.m
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

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
	[NSNotificationCenter.defaultCenter addObserver:self
										   selector:@selector(newGame:)
											   name:[TableConfig newGameNotif]
											 object:nil];
	char* dealerName = malloc(7);
	sprintf(dealerName, "Dealer");
	self.dealer = player_new(dealerName, 1, -1);
	[self setTurnActive:NO];
}

- (void)setTurnActive:(BOOL)active {
	[self.hitButton setEnabled:active];
	[self.standButton setEnabled:active];
	[self.doubleButton setEnabled:active];
	[self.splitButton setEnabled:active];
	[self.surrenderButton setEnabled:active];
	[self.nextButton setEnabled:!active];
}

- (void)newGame:(NSNotification *)notif {
	if (self.deck) {
		rust_freedeck(self.deck);
		self.deck = NULL;
		for (Player** pplayer = self.players; pplayer < self.players + self.playerCount; pplayer++) {
			rust_freeplayer(*pplayer);
		}
		free(self.players);
	}
	self.deck = deck_new([notif.userInfo[@"Decks"] intValue]);

	NSMutableArray* names = notif.userInfo[@"Names"];
	NSMutableArray* balances = notif.userInfo[@"Balances"];
	self.playerCount = (int)names.count;
	self.currentPlayer = 0;
	self.players = malloc(self.playerCount * sizeof(Player*));
	for (int i = 0; i < self.playerCount; i++) {
		char* name = malloc([names[i] length] + 1);
		sprintf(name, "%s", [names[i] cStringUsingEncoding:NSUTF8StringEncoding]);
		self.players[i] = player_new(name, 0, [balances[i] intValue]);
	}
	player_bet(self.dealer, 0, self.deck);
}

- (IBAction)beginTurn:(id)sender {
	self.dealerHand.player = NULL;
	[self.dealerHand setNeedsDisplay:YES];

	int wager = [self.playerWager intValue];
	Player* player = self.players[self.currentPlayer];
	player_bet(player, wager, self.deck);
	self.playerHand.player = player;
	[self.playerHand setNeedsDisplay:YES];
	[self setTurnActive:YES];
}

- (IBAction)passTurn:(id)sender {
	self.currentPlayer = (self.currentPlayer + 1) % self.playerCount;
	if (self.currentPlayer == 0) {
		BOOL dealerPlays = NO;
		for (int i = 0; i < self.playerCount; i++) {
			if (!player_hasLost(self.players[i])) {
				dealerPlays = YES;
				break;
			}
		}
		unsigned int dealerValue = 0;
		if (dealerPlays) {
			dealerValue = player_playAsDealer(self.dealer, self.deck);
			self.dealerHand.player = self.dealer;
			[self.dealerHand setNeedsDisplay:YES];
		}
		for (Player** pplayer = self.players; pplayer < self.players + self.playerCount; pplayer++) {
			Player* player = *pplayer;
			player_gameOver(player, dealerValue);
		}
	} else {
		self.playerHand.player = NULL;
		[self.playerHand setNeedsDisplay:YES];
		[self setTurnActive:YES];
	}
}

- (IBAction)playerHit:(id)sender {
	if (player_hit(self.players[self.currentPlayer], self.deck)) {
		[self setTurnActive:NO];
	}
	[self.playerHand setNeedsDisplay:YES];
}

- (IBAction)playerStand:(id)sender {
	Player* player = self.players[self.currentPlayer];
	player_stand(player);
	if (!player_isPlaying(player)) {
		[self setTurnActive:NO];
	}
}

- (IBAction)playerDouble:(id)sender {
	player_double(self.players[self.currentPlayer], self.deck);
	[self.playerHand setNeedsDisplay:YES];
	[self setTurnActive:NO];
}

- (IBAction)playerSplit:(id)sender {
	if (player_split(self.players[self.currentPlayer], self.deck)) {
		[self.playerHand setNeedsDisplay:YES];
	} else {
	}
}

- (IBAction)playerSurrender:(id)sender {
	Player* player = self.players[self.currentPlayer];
	player_surrender(player);
	if (!player_isPlaying(player)) {
		[self setTurnActive:NO];
	}
}

@end
