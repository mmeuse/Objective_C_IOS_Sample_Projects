//
//  MasterViewController.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "MasterViewController.h"
#import "RouteListViewController.h"
#import "MapViewController.h"
#import "TickListViewController.h"
#import "WishListViewController.h"
#import "WeatherViewController.h"
#import "ViewInformationViewController.h"

@interface MasterViewController()
{
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize routeViewController,mapViewController,weatherViewController,tickListViewController,wishListViewController,viewInformationViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        self.title = @"Main Menu";
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];

    //Populate the Master table view with the Application Options
    [self insertNewObject:@"View Information.jpg"];
    [self insertNewObject:@"View Weather.jpg"];
    [self insertNewObject:@"Get Directions.jpg"];
    [self insertNewObject:@"My Wish List.jpg"]; 
    [self insertNewObject:@"My Tick List.jpg"];
    [self insertNewObject:@"Search Routes.jpg"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Call this method to add a row in the table view
- (void)insertNewObject: (NSString*) image
{
    if (!_objects) 
    {
        _objects = [[NSMutableArray alloc] init];
    }
    
    NSString *item = image;
    
    [_objects insertObject:item atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    
    NSString* label =   [object.description stringByDeletingPathExtension];    
    cell.textLabel.text = label;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:object.description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    //If the user chooses to search routes
    if(indexPath.row == 0)
    {
        self.routeViewController = [[RouteListViewController alloc] initWithNibName:@"RouteListViewController" bundle:nil];
        [self.navigationController pushViewController:self.routeViewController animated:YES];
    }
    
    //If the user chooses to View their tick list
    if(indexPath.row == 1)
    {
        self.tickListViewController = [[TickListViewController alloc] initWithNibName:@"TickListViewController" bundle:nil];
        [self.navigationController pushViewController:self.tickListViewController animated:YES];
    }
   
    //If the user chooses to View their wish list
    if(indexPath.row == 2)
    {
        self.wishListViewController = [[WishListViewController alloc] initWithNibName:@"WishListViewController" bundle:nil];
        [self.navigationController pushViewController:self.wishListViewController animated:YES];
    }
     
    //If the user chooses to Get Directions to the Gunks
    if(indexPath.row == 3)
    {
        self.mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        [self.navigationController pushViewController:self.mapViewController animated:YES];
    }
    
    //If the user chooses to View the Weather for the Gunks
    if(indexPath.row == 4)
    {
        self.WeatherViewController = [[WeatherViewController alloc] initWithNibName:@"WeatherViewController" bundle:nil];
        [self.navigationController pushViewController:self.weatherViewController animated:YES];
    }
    
    //If the user chooses to View Additional Information about the Gunks
    if(indexPath.row == 5)
    {
        self.viewInformationViewController = [[ViewInformationViewController alloc] initWithNibName:@"ViewInformationViewController" bundle:nil];
        [self.navigationController pushViewController:self.viewInformationViewController animated:YES];
    }
}

@end