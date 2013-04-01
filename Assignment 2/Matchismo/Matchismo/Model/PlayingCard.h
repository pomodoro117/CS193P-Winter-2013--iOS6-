//
//  PlayingCard.h
//  Matchismo
//
//  Created by Isao Ishibashi on 2/4/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic)NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
