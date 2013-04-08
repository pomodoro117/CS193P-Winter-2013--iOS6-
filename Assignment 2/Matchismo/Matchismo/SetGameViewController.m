//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Isao Ishibashi on 4/4/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "SetGameViewController.h"
#import "Card.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (void) setup
{
    // Initialization that can't wait untill viewDidLoad
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setMatchMode:[NSNumber numberWithInt:THREE_CARD_MATCH_MODE]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
