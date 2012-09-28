//
//  WishListViewController.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "WishListViewController.h"
#import "DetailViewController.h"


@interface WishListViewController()
{
    NSMutableArray *_routes;
}
@end

@implementation WishListViewController

@synthesize detailViewController = _DetailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        self.title = @"Climbs on Wish List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _routes = appDelegate.model.wishListRoutes;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _routes.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
	ClimbingRoute *route = (ClimbingRoute *)[_routes objectAtIndex:indexPath.row];
	cell.textLabel.text = route.routeName;
    
	return cell;
}

//Event Handler that loads the climbing details for the specified row in the tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    ClimbingRoute *routes = [_routes objectAtIndex:indexPath.row];
    self.detailViewController.route = routes;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end

