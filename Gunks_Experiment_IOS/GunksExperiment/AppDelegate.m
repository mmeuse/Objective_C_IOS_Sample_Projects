//  AppDelegate.m
//  GunksExperiment
//  Created by Matt Meuse on 5/02/12.

#import "AppDelegate.h"

#import "MasterViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize model = _model;   //Global reference to the database that contains climbs to populate the GUI


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Initialize the model variable that will be used across view controllers. Like a global variable.
    self.model = [[DatabaseModel alloc] init];
    
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end