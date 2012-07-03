//
//  MatchMovieViewController.h
//  MatchMovie
//
//  Created by Ankith Konda on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "AppSpecificValues.h"
#import "GameCenterManager.h"
#import "Reachability.h"


@class GameCenterManager;


@interface MatchMovieViewController : UIViewController <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate> {
	

        UIImageView *splashView;
    
	GameCenterManager *gameCenterManager;
	
	NSString* currentLeaderBoard;
	
    
}
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;

@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (weak, nonatomic) IBOutlet UILabel *matchMovieTaglineLabel;

@end
