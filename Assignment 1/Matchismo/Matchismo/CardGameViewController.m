//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Isao Ishibashi on 2/3/13.
//  Copyright (c) 2013 Isao's Awesome App Store. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];
    
}

- (IBAction)matchModeSegmentedControlPressed:(id)sender {
    NSLog(@"matchMode= %d", self.matchModeSegmentedControl.selectedSegmentIndex);
    [self.game setMatchMode:self.matchModeSegmentedControl.selectedSegmentIndex];
}

- (IBAction)dealButtonPressed:(UIButton *)sender {
    NSLog(@"Deal Button Pressed");
    self.game = nil;
    self.flipCount = 0;
    self.matchModeSegmentedControl.enabled = YES;
    self.matchModeSegmentedControl.selectedSegmentIndex = 0;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount is updated to %d", self.flipCount);
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        UIImage *cardImage = [UIImage imageNamed:@"cardback.png"];
        [cardButton setImage:cardImage forState:UIControlStateNormal];
        cardButton.imageEdgeInsets = UIEdgeInsetsFromString(@"{3.0,3.0,3.0,3.0}");
        UIImage *blankImage = [[UIImage alloc] init];
        [cardButton setImage:blankImage forState:UIControlStateSelected];
        [cardButton setImage:blankImage forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.resultLabel.text = [NSString stringWithFormat:@"%@", self.game.result];
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    if (self.flipCount > 0) {
        self.matchModeSegmentedControl.enabled = NO;
    }
    [self updateUI];
}

@end
