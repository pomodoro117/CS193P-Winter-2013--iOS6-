//
//  Card.m
//  Matchismo
//
//  Created by Isao Ishibashi on 2/3/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end

@implementation Card

@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

- (BOOL)isFaceUp
{
    return _faceUp;
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
}

- (BOOL) isUnplayable
{
    return _unplayable;
}

- (void) setUnplayable:(BOOL)unplayable
{
    _unplayable = unplayable;
}

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }

    return score;
}


@end
