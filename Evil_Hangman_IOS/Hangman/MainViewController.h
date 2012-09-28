//  MainViewController.h
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import "FlipsideViewController.h"
#import "AppDelegate.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *remainingGuessesLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentWordLabel;
@property (strong, nonatomic) IBOutlet UILabel *lettersGuessedLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, atomic) NSMutableArray* currentSetOfWords;
@property (strong, atomic) NSMutableDictionary* equivalenceClassDictionary;
@property int guessCount;
@property (strong,atomic) NSMutableArray* keyArray;

-(void)createEquivelanceClass:NSString;
-(void)findLargestEquivelanceClass:NSString;
-(void)processGuess:NSString;
-(void)beginHangman;
-(void)hasWonGame;

- (IBAction)showInfo:(id)sender;
- (IBAction)newGame:(id)sender;

@end
