//
//  ClimbingRoute.m
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import "ClimbingRoute.h"

//This class represents all of the fields associated with a climbing route
@implementation ClimbingRoute

@synthesize  routeName,routeDifficulty,routeVerticalFeet,routeDescription,routePitchCount,isAddedToWishList,isAddedToTickList,image;

-(id)initWithName:(NSString *)n difficulty:(NSString*)diff verticalFeet:(NSString*)vf description:(NSString *)desc pitchCount:(NSString *)pitches isAddedToWish:(NSString *)isWish IsAddedToTick:(NSString *) isTick imageUrl: (NSString*) img;
{
    self.routeName = n;
    self.routeDifficulty = diff;
    self.routeVerticalFeet = vf;
    self.routeDescription = desc;
    self.routePitchCount = pitches;
    self.isAddedToWishList = isWish;
    self.isAddedToTickList = isTick;
    self.image = img;
    
    return self;
}

@end