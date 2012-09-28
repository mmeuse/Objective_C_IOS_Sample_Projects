//
//  WeatherViewController.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "WeatherViewController.h"


@implementation WeatherViewController

@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title = @"Gunks Weather";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *fullURL = @"http://m.weather.com/right_now/USNY0990";
    
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
