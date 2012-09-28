//  FlipsideViewController.m
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize Wordlabel = _Wordlabel;
@synthesize Guesslabel = _Guesslabel;
@synthesize defaultWordLength = _defaultWordLength;
@synthesize defaultNumberOfGuesses = _defaultNumberOfGuesses;
@synthesize WordSlider = _WordSlider;
@synthesize GuessSlider = _GuessSlider;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //initialize the Flipside nib with application default values from the model in App Delegate
    self.WordSlider.maximumValue = appDelegate.model.largestWordLength;
    self.WordSlider.value = appDelegate.model.defaultWordLength;
    self.Wordlabel.text = [NSString stringWithFormat:@"%d", appDelegate.model.defaultWordLength];
    
    self.GuessSlider.value = appDelegate.model.defaultNumberOfGuesses;
    self.Guesslabel.text = [NSString stringWithFormat:@"%d", appDelegate.model.defaultNumberOfGuesses];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
        NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       
        [defaults registerDefaults:defaultValues];
        [defaults setObject:self.defaultWordLength forKey:@"defaultWordLength"];
        [defaults setObject:self.defaultNumberOfGuesses forKey:@"defaultNumberOfGuesses"];
        [defaults synchronize];
    
    [self.delegate flipsideViewControllerDidFinish:self];
}

//This method is an event handler for the default number of guesses UISlider on the FlipSide nib
-(IBAction)changeNumberOfGuesses:(id)sender 
{
    UISlider *slider = (UISlider *)sender;
    
    int myInt = (int)(slider.value + (slider.value > 0 ? 0.5 : -0.5));
    self.defaultNumberOfGuesses = [NSString stringWithFormat:@"%d", myInt];
    self.Guesslabel.text = self.defaultNumberOfGuesses;
}

//This method is an event handler for the default word length UISlider on the FlipSide nib
-(IBAction)changeWordLength:(id)sender 
{
    UISlider *slider = (UISlider *)sender;
    
    int myInt = (int)(slider.value + (slider.value > 0 ? 0.5 : -0.5));
    self.defaultWordLength = [NSString stringWithFormat:@"%d", myInt];
    self.Wordlabel.text = self.defaultWordLength;
}

@end