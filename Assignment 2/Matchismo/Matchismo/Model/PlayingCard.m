//
//  PlayingCard.m
//  Matchismo
//
//  Created by Isao Ishibashi on 2/4/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (int) match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            } else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
        }

    }
    return score;
}

- (int) match:(NSArray *)otherCards usingMatchMode:(NSUInteger)matchMode
{
    int score = 0;
    if (matchMode == TWO_CARD_MATCH_MODE) {
        
        if ([otherCards count] == 1) {
            id otherCard = [otherCards lastObject];
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
                if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                    score = 1;
                } else if (otherPlayingCard.rank == self.rank) {
                    score = 4;
                }
            }
            
        }
        
    }else if (matchMode == THREE_CARD_MATCH_MODE) {
        if ([otherCards count] == 2) {
            
            id otherCard;
            PlayingCard *firstOtherCard;
            PlayingCard *secondOtherCard;
            
            otherCard = [otherCards objectAtIndex:0];
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                firstOtherCard = (PlayingCard *)otherCard;
            }
            
            otherCard = [otherCards objectAtIndex:1];
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                secondOtherCard = (PlayingCard *)otherCard;
            }

            if ([firstOtherCard.suit isEqualToString:self.suit] &&
                [secondOtherCard.suit isEqualToString:self.suit]) {
                
                score = 10;
                
            } else if ([firstOtherCard.suit isEqualToString:self.suit] ||
               [secondOtherCard.suit isEqualToString:self.suit] ||
               [firstOtherCard.suit isEqualToString:secondOtherCard.suit]) {
                
                score = 1;
                
            } else if (firstOtherCard.rank == self.rank &&
                       secondOtherCard.rank == self.rank) {
                
                score = 40;
                
            }else if (firstOtherCard.rank == self.rank ||
                       secondOtherCard.rank == self.rank ||
                       firstOtherCard.rank == secondOtherCard.rank) {
                
                score = 1;
                
            }
        }
    }

    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
