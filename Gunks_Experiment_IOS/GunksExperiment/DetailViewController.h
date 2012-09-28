//
//  DetailViewController.h
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import <UIKit/UIKit.h>
#import "ClimbingRoute.h"
#import "AppDelegate.h"
#import <sqlite3.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ClimbingRoute * route;
@property (strong, nonatomic) IBOutlet UITextField *detailRouteName;
@property (strong, nonatomic) IBOutlet UITextField *detailDifficulty;
@property (strong, nonatomic) IBOutlet UITextField *detailVerticalFeet;
@property (strong, nonatomic) IBOutlet UITextField *detailPitchCount;
@property (strong, nonatomic) IBOutlet UITextView *detailDescription;
@property (strong, nonatomic) IBOutlet UIImageView *image;

- (IBAction)addToWishList:(id)sender;
- (IBAction)addToTickList:(id)sender;

@end
