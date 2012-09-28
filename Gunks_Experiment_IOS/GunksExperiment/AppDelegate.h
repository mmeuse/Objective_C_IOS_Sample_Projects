//  AppDelegate.h
//  GunksExperiment
//  Created by Matt Meuse on 5/02/12.

#import <UIKit/UIKit.h>
#import "DatabaseModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, strong) DatabaseModel *model;

@end
