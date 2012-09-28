//
//  WeatherViewController.h
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
