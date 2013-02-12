//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Isao Ishibashi on 2/6/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (readwrite, nonatomic)int score;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@property (readwrite, nonatomic)NSString *result; // of the last flip
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSString *)result
{
    if(!_result) _result = @"";
    return _result;
}

#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 2;
#define FLIP_COST 1;

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            
            self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            
            for (Card *otherCards in self.cards) {
                if (otherCards.isFaceUp && !otherCards.isUnplayable) {
                    int matchScore = [card match:@[otherCards]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCards.unplayable = YES;
                        int point = matchScore * MATCH_BONUS;
                        self.score += point;
                        self.result = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCards.contents, point];
                    }else {
                        otherCards.faceUp = NO;
                        int point = MISMATCH_PENALTY;
                        self.score -= point;
                        self.result = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!", card.contents, otherCards.contents, point];
                    }
                    break;
                }

            }
            self.score -= FLIP_COST;
            
            
        }
        card.faceUp = !card.isFaceUp;
    }

}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawCard];
            if (card) {
                self.cards[i] = card;
            }else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

@end
