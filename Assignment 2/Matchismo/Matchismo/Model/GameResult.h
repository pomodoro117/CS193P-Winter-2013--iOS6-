//
//  GameResult.h
//  Matchismo
//
//  Created by Isao Ishibashi on 3/26/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults;

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
