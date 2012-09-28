//  FlipsideViewController.h
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *Guesslabel;
@property (strong, nonatomic) IBOutlet UILabel *Wordlabel;
@property (strong,nonatomic) NSString* defaultNumberOfGuesses;
@property (strong,nonatomic) NSString* defaultWordLength;
@property (strong, nonatomic) IBOutlet UISlider  *GuessSlider;
@property (strong, nonatomic) IBOutlet UISlider  *WordSlider;

- (IBAction)done:(id)sender;
- (IBAction) changeNumberOfGuesses:(id)sender;
- (IBAction) changeWordLength:(id)sender;

@end
