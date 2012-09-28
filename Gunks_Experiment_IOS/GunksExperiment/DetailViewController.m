//
//  DetailViewController.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "DetailViewController.h"
#import "DatabaseModel.h"

@implementation DetailViewController

@synthesize route = _route;
@synthesize detailDescription = _detailDescription;
@synthesize detailRouteName = _detailRouteName;
@synthesize detailDifficulty = _detailDifficulty;
@synthesize detailPitchCount = _detailPitchCount;
@synthesize detailVerticalFeet = _detailVerticalFeet;
@synthesize image = _image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     //Get a handle on the scroll view to set it's default content size
     UIScrollView *tempScrollView=(UIScrollView *)self.view;
     tempScrollView.contentSize=CGSizeMake(320,709);
    
    //Initialize the GUI with the passed in climb from the Search
    self.detailRouteName.text = self.route.routeName;
    self.detailDescription.text = self.route.routeDescription;
    self.detailVerticalFeet.text = self.route.routeVerticalFeet;
    self.detailDifficulty.text = self.route.routeDifficulty;
    self.detailPitchCount.text = self.route.routePitchCount;
    self.image.image = [UIImage imageNamed:self.route.image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.route = nil;
    self.detailRouteName = nil;
    self.detailDifficulty = nil;
    self.detailDescription = nil;
    self.detailPitchCount = nil;
    self.detailVerticalFeet = nil;
    self.image = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
           self.title = @"Current Climb";
    }
    
    return self;
}

//This event handler adds the Climb to the User's ticklist
-(void) addToTickList:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DatabaseModel* model = [[DatabaseModel alloc] init];
    [(DatabaseModel*) model updateClimbingRoute: self.detailRouteName.text withWishORTick:TRUE];
    
    //Update the model
    appDelegate.model = model;

}

//This event handler adds the Climb to the User's wishlist
-(void) addToWishList:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    DatabaseModel* model = [[DatabaseModel alloc] init];
    [(DatabaseModel*) model updateClimbingRoute: self.detailRouteName.text withWishORTick:FALSE];
    
    //Update the model
    appDelegate.model = model;
}
							
@end
