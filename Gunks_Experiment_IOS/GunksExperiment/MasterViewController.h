//
//  MasterViewController.h
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import <UIKit/UIKit.h>

@class RouteListViewController;
@class MapViewController;
@class WeatherViewController;
@class TickListViewController;
@class WishListViewController;
@class ViewInformationViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) RouteListViewController *routeViewController;
@property (strong, nonatomic) MapViewController *mapViewController;
@property (strong, nonatomic) WeatherViewController *weatherViewController;
@property (strong, nonatomic) TickListViewController *tickListViewController;
@property (strong, nonatomic) WishListViewController *wishListViewController;
@property (strong, nonatomic) ViewInformationViewController *viewInformationViewController;

@end
