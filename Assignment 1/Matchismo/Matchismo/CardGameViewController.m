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
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
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

- (void)setHistorySlider:(UISlider *)historySlider
{
    _historySlider = historySlider;
    _historySlider.maximumValue = 10.0;
    _historySlider.minimumValue = 1.0;
}

- (IBAction)historySliderValueChanged:(id)sender {
    if (self.historySlider.value > [self.game.resultArray count]) {
        self.historySlider.value = [self.game.resultArray count];
    }
    NSUInteger sliderValue = floorf(self.historySlider.value);
    NSLog(@"sliderValue is %d", sliderValue);
    self.resultLabel.text = [NSString stringWithFormat:@"%@", [self.game.resultArray objectAtIndex:sliderValue - 1]];
    self.resultLabel.alpha = (sliderValue == [self.game.resultArray count]) ? 1.0 : 0.3;
}

- (IBAction)matchModeSegmentedControlPressed:(id)sender {
    NSLog(@"matchMode= %d", self.matchModeSegmentedControl.selectedSegmentIndex);
    [self.game setMatchMode:self.matchModeSegmentedControl.selectedSegmentIndex];
}

- (IBAction)dealButtonPressed:(UIButton *)sender {
    NSLog(@"Deal Button Pressed");
    self.game = nil;
    self.flipCount = 0;
    self.historySlider.value = 0.0;
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
    }
    self.historySlider.value = [self.game.resultArray count];
    self.resultLabel.alpha = 1.0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultLabel.text = [NSString stringWithFormat:@"%@", [self.game.resultArray lastObject] ? [self.game.resultArray lastObject] : @""];
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
