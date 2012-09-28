//  MainViewController.m
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize currentWordLabel = _currentWordLabel;
@synthesize lettersGuessedLabel = _lettersGuessedLabel;
@synthesize remainingGuessesLabel = _remainingGuessesLabel;
@synthesize textField = _textField;
@synthesize currentSetOfWords = _currentSetOfWords;
@synthesize equivalenceClassDictionary = _equivalenceClassDictionary;
@synthesize guessCount = _guessCount;
@synthesize keyArray = _keyArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize Gameplay
    [self beginHangman];
} 

- (void)viewDidUnload
{
    [super viewDidUnload];
} 

//This method initializes the Application UI and variables at the start of each new game
-(void)beginHangman
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.remainingGuessesLabel.text = [NSString stringWithFormat:@"%d", appDelegate.model.defaultNumberOfGuesses];
    self.lettersGuessedLabel.text = @"";
    
    // hide text field by default and make it receive input
    self.textField.hidden = YES;
    [self.textField becomeFirstResponder];
    
    NSString* currentWord = [NSString stringWithString:@""];
    
    for(int i = 1 ; i <= appDelegate.model.defaultWordLength; i++)
    {
        currentWord = [currentWord stringByAppendingString:@"-"];
    }
    
    self.currentWordLabel.text = currentWord;
    self.currentSetOfWords = appDelegate.model.defaultWordCollection;
    self.equivalenceClassDictionary = [[NSMutableDictionary alloc] init];
    self.guessCount = 0;  
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Welcome to Hangman!"
                          message:@"Press OK to begin guessing."
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

//This method is called when the new Game button is clicked
- (IBAction)newGame:(id)sender
{   
    //Called when the new game button is clicked. Need to reinitialize model in case the settings have changed.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.model = [[HangmanModel alloc] init];

    [self beginHangman];
}

//UITextField Event Handler
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Get a character set of all of the legal characters for hangman
    NSCharacterSet *nonAlphabetChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    //From the remaining guesses label, create an integer representation
    self.guessCount = [self.remainingGuessesLabel.text intValue];

    //If the user has not exceeded his remaining guess count
    if(self.guessCount > 0)
    {
        //If the user entered a legal character proceed. Otherwise, just ignore the input and wait for user input again
        if ([string rangeOfCharacterFromSet:nonAlphabetChars].location == NSNotFound) 
        {
            NSRange range = [self.lettersGuessedLabel.text rangeOfString:string];
            
            //If the user entered in an unique guess then proceed. Otherwise, just ignore the input and wait for user input again
            if (range.length == 0)
            {
                self.guessCount = self.guessCount - 1;
                self.remainingGuessesLabel.text = [NSString stringWithFormat:@"%d",self.guessCount];
                
                // append newly typed letter to display label
                self.lettersGuessedLabel.text = [NSString stringWithFormat:@"%@%@,", self.lettersGuessedLabel.text, string];
                
                //Go to the method that handles the game logic
                [self processGuess:string];
            }
        }    
    }
    else 
    {
        //If the user ran out of guesses, console them and do not allow them to input any more guesses. The other home screen buttons will remain functional
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over"
                              message:@"You have run out of guesses. Please play again!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show];   
        
        [self.textField resignFirstResponder];
    }
   
    return YES;
}

//This method is called from the UITextField Handler to handle the state of gameplay
-(void) processGuess:(NSString*)string
{
    [self createEquivelanceClass:string];
    [self findLargestEquivelanceClass:string];
    [self hasWonGame];
}

//This method is used to create equivelance classes depending on what the user guessed
-(void) createEquivelanceClass:(NSString*)string
{
    self.keyArray = [NSMutableArray array];                             //Create an array of key values. One key, per equivelance class. Representing a concatenation of index values corresponding to the current guess
    
    //Iterate through all words in the current set
    for(NSString* word in self.currentSetOfWords)
    {
        NSString* key = [NSString stringWithString:@""];
        
        //For each character in the current word
        for (NSInteger charIndex=0; charIndex<word.length; charIndex++)
        {
            //Get the character and convert it to a String
            NSString* charString = [NSString stringWithFormat:@"%C",[word characterAtIndex:charIndex]];
            
            //If the current character matches the guess character of the user
            if([charString caseInsensitiveCompare: string] == NSOrderedSame)
            {
                //append the index of this guess character to the key
                key = [key stringByAppendingFormat: [NSString stringWithFormat:@"%d",charIndex]];
            }
        }
        
        //If the current word doesn't contain a guess character, assign it to the a key value of '-'
        if([key isEqualToString:@""])
        {
            key = @"-";
        }
        
        //Add the key to the keyArray.
        [self.keyArray addObject:key];
        
        //If there is no key value in the nsdictionary corresponding to the current word, that means an equivelance class will need to be created, the word added, and the array assigned to the dictionary
        if([self.equivalenceClassDictionary objectForKey:key] == nil)
        {
            NSMutableArray* equivelanceClass = [NSMutableArray arrayWithObjects:word, nil];
            [self.equivalenceClassDictionary setValue:equivelanceClass forKey:key];
        }
        else 
        {
            //If an equivelance class already exists for the current word, simply add the word to the equivelance class
            NSMutableArray* currentEquivalenceClass = [self.equivalenceClassDictionary objectForKey:key];
            [currentEquivalenceClass addObject:word];
            [self.equivalenceClassDictionary setObject:currentEquivalenceClass forKey:key]; 
        }
    }
}

//This method is used to find the largest possible equivelance class for the current guess
-(void) findLargestEquivelanceClass: (NSString*) string
{
    NSString* selectedEquivelanceClassKey = [NSString stringWithString:@""];        //This will store the key value for the equivelance class selected by the computer to best evaded the user's guess
    int equivalenceClassCount = 0;                                                  //This stores a count of words in the selected equivelance class
    
    //Iterate through all of the keys and find the largest equivelance class
    for(NSString *key in self.keyArray)
    {
        //Retrieve the equivalence class at the current key
        NSMutableArray* currentEquivalenceClass = [self.equivalenceClassDictionary objectForKey:key];
        
        if(currentEquivalenceClass.count >= equivalenceClassCount)
        {
            selectedEquivelanceClassKey = key;
            equivalenceClassCount = currentEquivalenceClass.count;
        }
    }
    
    //If the largest equivalence class contained the letter that the user guessed
    if(![selectedEquivelanceClassKey isEqualToString:@"-"])
    {
        //for each character in the current word
        for (NSInteger charIndex=0; charIndex<selectedEquivelanceClassKey.length; charIndex++)
        {
            //Get the character and convert it to a String
            NSString* charString = [NSString stringWithFormat:@"%C",[selectedEquivelanceClassKey characterAtIndex:charIndex]];
            
            //Add the character to the word label on the GUI so that the user knows that there guess was correct.
            int index = [charString intValue];
            self.currentWordLabel.text = [self.currentWordLabel.text stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:string];
        }
        
        //If the user made a correct guess, then congratulate them.
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Congratulations!"
                              message:@"You guessed a correct letter"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show]; 
    }
    else 
    {
        //Kindly taunt the user if they did not guess a correct letter
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Sorry, wrong guess!"
                              message:@"mwu ha ha ha ha ha"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show];    
    }
    
    //Now that we have the largest equivelance class, we can reset the array of available words for the next guess
    self.currentSetOfWords = [self.equivalenceClassDictionary objectForKey:selectedEquivelanceClassKey]; 
    self.equivalenceClassDictionary = nil;
    self.equivalenceClassDictionary = [[NSMutableDictionary alloc] init];
}

//This method is used to check that at the end of processing each guess, the user has won the game within the guess limit
-(void) hasWonGame
{
    //Only if the equivelance class left has one word, does it mean that the user has trapped the computer into choosing a word
    if(self.currentSetOfWords.count == 1)
    {
        NSString * finalWord = [self.currentSetOfWords objectAtIndex:0];
        
        //If the user can guess all of the characters within the guess limit, then they win and should be congratulated
        if([finalWord caseInsensitiveCompare:self.currentWordLabel.text] == NSOrderedSame)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Congratulations"
                                  message:@"You have won the game!"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil];
            [alert show];   
            
            [self.textField resignFirstResponder];
            
        }
    }
}

@end
