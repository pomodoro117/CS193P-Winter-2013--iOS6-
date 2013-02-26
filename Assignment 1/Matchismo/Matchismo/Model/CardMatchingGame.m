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
@property (readwrite, nonatomic)NSString *result; //of the Last Flip
@property (readwrite, nonatomic)NSMutableArray *resultArray; //of Result;
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

- (NSArray *)resultArray
{
    if(!_resultArray) {
        _resultArray = [[NSMutableArray alloc] init];
        [_resultArray addObject:@""];
    }
    return _resultArray;
}

#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 2;
#define FLIP_COST 1;
#define THREE_CARD_MATCH_MODE_PENALTY 10;
#define THREE_CARD_MATCH_MODE_FLIP_COST 5;

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            
            self.result = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            
            if (self.matchMode == TWO_CARD_MATCH_MODE) {
                for (Card *otherCards in self.cards) {
                    if (otherCards.isFaceUp && !otherCards.isUnplayable) {
                        int matchScore = [card match:@[otherCards] usingMatchMode:self.matchMode];
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

            } else if (self.matchMode == THREE_CARD_MATCH_MODE) {
                NSMutableArray *matchCards = [[NSMutableArray alloc] init];
                for (Card *oterCards in self.cards) {
                    if (oterCards.isFaceUp && !oterCards.isUnplayable) {
                        [matchCards addObject:oterCards];
                    }
                }
                if ([matchCards count] > 1) {
                    NSLog(@"THREE_CARD_MATCH_MODE");
                    int matchScore = [card match:matchCards usingMatchMode:self.matchMode];
                    if (matchScore) {
                        card.unplayable = YES;
                        for (Card *card in matchCards) {
                            card.unplayable = YES;
                        }

                        int point = matchScore * MATCH_BONUS;
                        self.score += point;
                        self.result = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points", card.contents, [[matchCards objectAtIndex:0] contents], [[matchCards objectAtIndex:1] contents], point];
                    }else {
                        for (Card *card in matchCards) {
                            card.faceUp = NO;
                        }
                        int point = MISMATCH_PENALTY;
                        point *= THREE_CARD_MATCH_MODE_PENALTY;
                        self.score -= point ;
                        self.result = [NSString stringWithFormat:@"%@ & %@ & %@ don't match! %d point penalty!", card.contents, [[matchCards objectAtIndex:0] contents], [[matchCards objectAtIndex:1] contents], point];
                    }
                }
                
                self.score -= THREE_CARD_MATCH_MODE_FLIP_COST;

            }
            [self.resultArray addObject:self.result];
            if ([self.resultArray count] > 10) {
                [self.resultArray removeObjectAtIndex:0];
            }
            
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
