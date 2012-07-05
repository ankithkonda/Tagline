//
//  MatchMovieAppDelegate.m
//  MatchMovie
//
//  Created by Ankith Konda on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchMovieAppDelegate.h"

#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import "MatchMovieViewController.h"
#import "Reachability.h"



@implementation MatchMovieAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"movies"] == nil) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filteredMovies" ofType:@"json"];
        
        //création d'un string avec le contenu du JSON
        NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];   
        
        NSString *fixA = [myJSON stringByReplacingOccurrencesOfString:@"/" withString:@" "]; 
        
        NSString *finalJSONString = [fixA stringByReplacingOccurrencesOfString:@"\\" withString:@" "]; 
        
        
        NSArray *movies = [finalJSONString JSONValue];
        [[NSUserDefaults standardUserDefaults] setObject:movies forKey:@"movies"];
    }
    
    sleep(1.0);
    
    
    // in application:didFinishLaunchingWithOptions: in app delegate
    
    // before [window makeKeyAndVisible];
    UIImageView *splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.window.frame.size.width, self.window.frame.size.height)];
    splashView.image = [UIImage imageNamed:@"Default@2x.png"];
    
    
    [self.window makeKeyAndVisible];
    // after [window makeKeyAndVisible];
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.window.frame.size.width, self.window.frame.size.height)];
    splashView.image = [UIImage imageNamed:@"Default@2x.png"];
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
    
    [UIView animateWithDuration:0.5 animations:^{
        [splashView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [splashView removeFromSuperview];
    }];
    
	
    
    
    // Override point for customization after application launch.
    return YES;
}





							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    exit(0);
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
