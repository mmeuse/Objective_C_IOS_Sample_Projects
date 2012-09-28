//  AppDelegate.h
//  Hangman
//  Created by Matt Meuse on 4/12/12.

#import <UIKit/UIKit.h>
#import "HangmanModel.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (nonatomic, strong) HangmanModel *model;

@end
