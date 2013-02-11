//
//  Deck.m
//  Matchismo
//
//  Created by Isao Ishibashi on 2/3/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *)drawCard
{
    Card * card = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        card = [self.cards objectAtIndex:index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return card;
}

@end
