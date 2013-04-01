//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Isao Ishibashi on 3/25/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString *displayText = @"";
    for (GameResult *result in [GameResult allGameResults]) {
        NSCalendar *userCalendar = [NSCalendar currentCalendar];
        NSUInteger flag
        = NSYearCalendarUnit
        | NSMonthCalendarUnit
        | NSDayCalendarUnit
        | NSHourCalendarUnit
        | NSMinuteCalendarUnit
        | NSSecondCalendarUnit;
        NSDateComponents *c = [userCalendar components:flag fromDate:result.end];
        NSString *date = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", [c year], [c month], [c day], [c hour], [c minute], [c second]];
//        displayText = [displayText stringByAppendingFormat:@"Score : %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
        displayText = [displayText stringByAppendingFormat:@"Score : %d (%@, %0g)\n", result.score, date, round(result.duration)];

    }
self.display.text = displayText;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setup
{
    // initialization that can't wait untill viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    // Custom initialization
    [self setup];
    return self;
}


@end
