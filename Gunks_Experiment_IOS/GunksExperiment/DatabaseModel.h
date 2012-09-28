//
//  HangmanModel.h
//  Hangman
//
//  Created by Matt Meuse on 5/02/12.




#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ClimbingRoute.h"

@interface DatabaseModel : NSObject{} 

@property (nonatomic, retain) NSMutableArray *climbingRoutes;
@property (nonatomic, retain) NSMutableArray *tickListRoutes;
@property (nonatomic, retain) NSMutableArray *wishListRoutes;
@property (nonatomic, retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;

-(void) updateClimbingRoute:(NSString *) routeName withWishORTick:(bool) isTick;

@end
