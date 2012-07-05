//
//  GamePageViewController.h
//  MatchMovie
//
//  Created by Ankith Konda on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUIAnimatableLabel.h"
#import <GameKit/GameKit.h>
#import "AppSpecificValues.h"
#import "GameCenterManager.h"
#import <iAd/iAd.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <QuartzCore/QuartzCore.h>



@interface GamePageViewController : UIViewController <GameCenterManagerDelegate, ADBannerViewDelegate> {
	
	
	GameCenterManager *gameCenterManager;
	
    int64_t  currentScore;
	
    
}

@property (strong, nonatomic) NSString *imageBaseURL;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *hintButton;
@property (nonatomic) BOOL isHintPressed;
@property (nonatomic) BOOL isHintEnabled;
@property (nonatomic) int levelOfPlayerInCurrentGame;

@property (nonatomic, assign) int64_t currentScore;
@property (nonatomic, assign) int64_t streakNum;
@property (nonatomic, assign) int64_t wrongStreakNum;
@property (nonatomic, assign) int64_t playerLevel;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@property (strong, nonatomic) IBOutlet UILabel *levelLabel;

@property (strong, nonatomic) NSString *genreLevelKeyString;



@property (strong, nonatomic) IBOutlet UIButton *levelButton;


@property (strong, nonatomic) IBOutlet UILabel *quickScoreShow;


@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;



@property (strong, nonatomic) IBOutlet UIButton *imageAButton;

@property (strong, nonatomic) IBOutlet UIButton *imageBButton;

@property (strong, nonatomic) IBOutlet UIButton *imageCButton;

@property (strong, nonatomic) IBOutlet UIButton *imageDButton;

@property (strong, nonatomic) IBOutlet UIButton *imageEButton;

@property (strong, nonatomic) IBOutlet UIButton *imageFButton;


@property (strong, nonatomic) IBOutlet UILabel *taglineTextbox;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;


@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *moviesWhichHaveBeenUsed;

@property (strong, nonatomic) NSDictionary *tempArrayWithMovieResult;


@property (strong, nonatomic) UIImage *correctURLA;
@property (strong, nonatomic) UIImage *correctURLB;
@property (strong, nonatomic) UIImage *correctURLC;
@property (strong, nonatomic) NSMutableArray *moviesToUseInView;
@property (strong, nonatomic) NSMutableArray *moviesToUseNext;
@property (strong, nonatomic) NSMutableArray *moviesToUseAfterNext;
@property (strong, nonatomic) NSMutableDictionary *taglinesToUse;
@property (strong, nonatomic) NSString *tagOne;
@property (strong, nonatomic) NSString *tagTwo;
@property (strong, nonatomic) NSString *tagThree;




@property ( nonatomic) int arrayToggleNumber;
@property ( nonatomic)  int numberOfRun;
@property (nonatomic) BOOL gameWasAlreadyStarted;


@property (nonatomic) int isFirstRound;
@property (strong, nonatomic) NSString *correctImage;
@property (nonatomic) int hasStartedLoading;

@property (strong, nonatomic) NSMutableArray *moviesInApp;
@property (strong, nonatomic) NSMutableArray *moviesInPlay;

@end
