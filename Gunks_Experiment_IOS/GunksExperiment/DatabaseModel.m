//
//  HangmanModel.m
//  Hangman
//
//  Created by Matt Meuse on 5/02/12.




#import "DatabaseModel.h"

//This class is the data access layer to the SQL Lite Database stored on the user's device
@implementation DatabaseModel

@synthesize climbingRoutes,tickListRoutes,wishListRoutes;
@synthesize databaseName,databasePath;

- (id)init
{
    if (self = [super init]) 
    {
        databaseName = @"ClimbingDatabase.sql";
        
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        // Execute the "checkAndCreateDatabase" function
        [self checkAndCreateDatabase];
        
        // Query the database for all animal records and construct the "routes" array
        [self readClimbingRoutesFromDatabase];    
    }
        
    return self;
}

//This method is call to see if the database exists on the device. If it doesn't, one should be created
-(void) checkAndCreateDatabase
{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

//This method reads in the necessary collections from the database to populate the GUI
-(void) readClimbingRoutesFromDatabase 
{
	// Setup the database object
	sqlite3 *database;
    
	// Init the climbing routes Array
	self.climbingRoutes = [[NSMutableArray alloc] init];
    self.tickListRoutes = [[NSMutableArray alloc] init];
    self.wishListRoutes = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from routes";
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
            {
				// Read the data from the result row
				NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aDifficulty = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aVerticalFeet = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString *aDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *aPitchCount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *aIsWishList = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *aIsTickList = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
                NSString *aImageURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
                
				// Create a new route object with the data from the database
                ClimbingRoute *route = [[ClimbingRoute alloc] initWithName:aName difficulty:aDifficulty verticalFeet:aVerticalFeet description:aDescription pitchCount:aPitchCount isAddedToWish:aIsWishList IsAddedToTick:aIsTickList imageUrl:aImageURL];
                
				// Add the route object to the route Array
				[self.climbingRoutes addObject:route];
                
                if([aIsTickList isEqualToString:@"Yes"]==TRUE)
                {
                    [self.tickListRoutes addObject:route];
                }
                
                if([aIsWishList isEqualToString:@"Yes"]==TRUE)
                {
                    [self.wishListRoutes addObject:route];                      
                }
			}
		}
        
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);        
	}
    
	sqlite3_close(database);    
}

//This method is called to add a climb to a user's tick list
-(void) updateClimbingRoute:(NSString *) routeName withWishORTick:(bool) isTick
{
	// Setup the database object
	sqlite3 *database;
    const char *updateStatement;
    
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
		// Setup the SQL Statement and compile it for faster access
        if(isTick)
        {
            updateStatement = [[NSString stringWithFormat:@"UPDATE routes SET onTickList = 'Yes' where name = '%@'",routeName] UTF8String];
        }
        else
        {
            updateStatement = [[NSString stringWithFormat:@"UPDATE routes SET onWishList = 'Yes' where name = '%@'",routeName] UTF8String]; 
        }
        
        //Pre-compile the SQL statement
		sqlite3_stmt *compiledStatement;
		sqlite3_prepare_v2(database, updateStatement, -1, &compiledStatement, NULL);
        
        //Execute the SQL statement
        sqlite3_step(compiledStatement);
        
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
    
	sqlite3_close(database);    
    
    //Reload the database after the changes
    [self readClimbingRoutesFromDatabase];
}

@end
