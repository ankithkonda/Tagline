//
//  MatchMovieViewController.m
//  MatchMovie
//
//  Created by Ankith Konda on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
//

#import "MatchMovieViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import "Movie.h"


@interface MatchMovieViewController ()

@property (strong, nonatomic) IBOutlet UILabel *playerNameLabel;


@end

@implementation MatchMovieViewController


@synthesize playerNameLabel;
@synthesize startGameButton;
@synthesize gameCenterManager;
@synthesize currentLeaderBoard;
@synthesize matchMovieTaglineLabel;
@synthesize activityIndicator;


- (IBAction)startGameButton:(id)sender {
    
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    
    if ([reach isReachable]) {
        
        [self performSegueWithIdentifier:@"goGame" sender:self];
    }
    [reach startNotifier];
}

- (IBAction)openLeaderboard:(id)sender {
    
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardController != NULL) 
	{
		leaderboardController.category = self.currentLeaderBoard;
		leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
		leaderboardController.leaderboardDelegate = self; 
		[self presentModalViewController: leaderboardController animated: YES];
	}
}
- (IBAction)openAchievementsBoard:(id)sender {
    GKAchievementViewController *achievementView = [[GKAchievementViewController alloc] init];
    
    if (achievementView != NULL) {
        achievementView.achievementDelegate = self;
        [self presentModalViewController:achievementView animated:YES];
    }
    
    
}

-(void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController{
    
    
    [self dismissModalViewControllerAnimated:YES];

}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[self dismissModalViewControllerAnimated: YES];
}

- (void)animateSplash {
    // set default portrait for now, will be updated if necessary
    NSString *imageName = @"Default@2x.png";
    CGRect imageFrame = CGRectMake( 0, 0, self.view.frame.size.width , self.view.frame.size.height );
    
    splashView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    splashView.frame = imageFrame;
    [self.view addSubview:splashView];
    [self.view bringSubviewToFront:splashView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    
    splashView.alpha = 0.0f;
    
    [UIView commitAnimations];
}



- (void)viewDidLoad
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [super viewDidLoad];
    
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    
  
    
    
}


-(void)viewDidAppear:(BOOL)animated{


    [self startEverything];


}

- (void)startEverything{

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    [reach startNotifier];
    
   
    
    
	if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[GameCenterManager alloc] init] ;
		[self.gameCenterManager setDelegate:self];
        
		[self.gameCenterManager authenticateLocalUser];
		
		
	} else {
		
		// The current device does not support Game Center.
        
	}
    
    
    
    
    
    

}



- (void)loadTagline{
    
    [self.matchMovieTaglineLabel setText:@""];
    [self isLoading:YES];
    NSArray *tempAll = [[NSArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"movies"]];
    
    int randIndex = arc4random() % [tempAll count];
    
    
    [[TmdbApiClient sharedClient] getMovieByID:[[tempAll objectAtIndex:randIndex] objectForKey:@"tmdb_id"] Success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isLoading:NO];
        [self.matchMovieTaglineLabel setText:[NSString stringWithFormat:@"'%@' - %@", [responseObject objectForKey:@"tagline"],[responseObject objectForKey:@"original_title"]]];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    


}








-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    
    if([reach isReachable])
    {
        
        [self.startGameButton setEnabled:YES];
        [self.startGameButton setBackgroundColor:nil];

        [self loadTagline];
        [reach stopNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    else
    {
        
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Network Failed" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        
        
            [self.matchMovieTaglineLabel setText:@"Internet connection not detected - please connect to the internet to play the game"];
            [alertReach show];
         
        
        UIColor *buttonDisabledColor = [[UIColor alloc] initWithRed:42 green:42 blue:42 alpha:1];

        [self.startGameButton setEnabled:NO];
        [self.startGameButton setBackgroundColor:buttonDisabledColor];
        [reach stopNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
}




- (void)isLoading:(BOOL)loading{
    
    if(loading == YES) {
        
        [self.activityIndicator startAnimating];
        [self.activityIndicator setAlpha:1.0];
        
    } else {
        [self.activityIndicator stopAnimating];
        [self.activityIndicator setAlpha:0.0];
        
    }
    
    
}




- (void)viewDidUnload
{
  
    [self setPlayerNameLabel:nil];
    [self setMatchMovieTaglineLabel:nil];
    [self setStartGameButton:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}








@end
