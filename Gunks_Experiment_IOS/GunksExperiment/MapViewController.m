//
//  MapViewController.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title = @"Driving Directions";
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigate to a Gunks Specific Google Maps Direction URL
    NSString *fullURL = @"http://maps.google.com/maps?daddr=41.747593,-74.086809";
    
    NSURL *url = [NSURL URLWithString:fullURL];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestObj]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
