//
//  ClimbingRoute.h
//  GunksExperiment
//
//  Created by Matt Meuse on 5/02/12.




#import <Foundation/Foundation.h>

@interface ClimbingRoute : NSObject

@property (nonatomic, retain) NSString* routeName;
@property (nonatomic, retain) NSString* routeDifficulty;
@property (nonatomic, retain) NSString* routeVerticalFeet;
@property (nonatomic, retain) NSString* routeDescription;
@property (nonatomic, retain) NSString* routePitchCount;
@property (nonatomic, retain) NSString* isAddedToWishList;
@property (nonatomic, retain) NSString* isAddedToTickList;
@property (nonatomic, retain) NSString* image;

-(id)initWithName:(NSString *)n difficulty:(NSString*)diff verticalFeet:(NSString*)vf description:(NSString *)desc pitchCount:(NSString *) pitches isAddedToWish:(NSString *)isWish IsAddedToTick:(NSString *) isTick imageUrl: (NSString*) img;

@end
