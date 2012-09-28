//  HangmanModel.m
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import "HangmanModel.h"

@implementation HangmanModel

@synthesize largestWordLength=_wordLength;
@synthesize defaultWordCollection=_defaultWordCollection;
@synthesize defaultNumberOfGuesses = _defaultNumberOfGuesses;
@synthesize defaultWordLength = _defaultWordLength;

- (id)init
{
    int currentWordLength = 0;
    
    if (self = [super init]) 
    {
         self.defaultWordCollection = [[NSMutableArray alloc] init];
        [self loadNSDefaults];
        
        // load plist file into dictionary
        NSMutableArray* Words = [[NSMutableArray alloc] initWithContentsOfFile:
                                 [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
        
        for(NSString* string in Words)
        {
            //Find the largest possible Word Length to initialize the GUI
            if(string.length > currentWordLength)
            {
                currentWordLength = string.length;
            }
            
            //If the current word matches the default word length, then add it to the word collection
            if(string.length == self.defaultWordLength)
            {
               [self.defaultWordCollection addObject:string]; 
            }
        }
        
        self.largestWordLength = currentWordLength;
        Words = nil;
    }
        
    return self;
}

//Loads the Application Default saved values for defaultWordLength and defaultNumberOfGuesses
-(void) loadNSDefaults
{
    //// set default values
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"" forKey:@"text"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    
    if([defaults objectForKey:@"defaultWordLength"] != nil)
    {
        self.defaultWordLength = [defaults integerForKey:@"defaultWordLength"];
    }
    else 
    {
        self.defaultWordLength = 4;
        [defaults setObject:@"4" forKey:@"defaultWordLength"];
        [defaults synchronize];
    }
    
    if([defaults objectForKey:@"defaultNumberOfGuesses"] != nil)
    {
        self.defaultNumberOfGuesses = [defaults integerForKey:@"defaultNumberOfGuesses"];
    }
    else 
    {
        self.defaultNumberOfGuesses = 4;
        [defaults setObject:@"4" forKey:@"defaultNumberOfGuesses"];
        [defaults synchronize];
    }
}

@end
