//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Isao Ishibashi on 2/6/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic)int score;

@property  (readonly, nonatomic)NSString *result;

@property (nonatomic)NSUInteger matchMode;

@property (readonly, nonatomic)NSMutableArray *resultArray;

@end
