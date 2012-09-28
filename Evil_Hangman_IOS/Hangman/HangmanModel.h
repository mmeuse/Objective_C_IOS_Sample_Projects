//  HangmanModel.h
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import <Foundation/Foundation.h>

@interface HangmanModel : NSObject{} 

@property (assign, nonatomic) int largestWordLength;
@property (retain,atomic,strong) NSMutableArray* defaultWordCollection;
@property (assign, nonatomic) int defaultWordLength;
@property (assign, nonatomic) int defaultNumberOfGuesses;

-(void)loadNSDefaults;

@end
