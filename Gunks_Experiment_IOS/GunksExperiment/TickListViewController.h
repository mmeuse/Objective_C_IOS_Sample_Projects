//
//  TickListViewController.h
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class DetailViewController;

@interface TickListViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
