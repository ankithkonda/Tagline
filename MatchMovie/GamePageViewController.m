//
//  GamePageViewController.m
//  MatchMovie
//
//  Created by Ankith Konda on 16/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePageViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "TmdbApiClient.h"
#include <stdlib.h>
#import "Movie.h"
#import "SimilarMovies.h"
#import "PauseMenu.h"
#import "Genre.h"
#import "Reachability.h"
#import "Comments.h"




@interface GamePageViewController ()



@end

@implementation GamePageViewController

@synthesize isHintPressed;
@synthesize imageBaseURL;
@synthesize commentLabel;

@synthesize moviesInApp;
@synthesize moviesInPlay;

@synthesize wrongStreakNum;
@synthesize levelOfPlayerInCurrentGame;
@synthesize playerLevel;
@synthesize genreLevelKeyString;

@synthesize currentScore;
@synthesize gameCenterManager;
@synthesize levelLabel;
@synthesize levelButton;
@synthesize streakNum;
@synthesize hasStartedLoading;
@synthesize isFirstRound;
@synthesize numberOfRun;
@synthesize imageArray;
@synthesize quickScoreShow;
@synthesize streakReductionLabel;
@synthesize backgroundImage;
@synthesize backButton;
@synthesize imageFieldA;
@synthesize imageFieldB;
@synthesize imageFieldC;
@synthesize imageFieldD;
@synthesize imageFieldE;
@synthesize imageFieldF;
@synthesize loadingLabelTest;
@synthesize roundNumberLabelTest;
@synthesize resultCommentTest;
@synthesize activity;
@synthesize correctLabel;
@synthesize imageAButton;
@synthesize imageBButton;
@synthesize imageCButton;
@synthesize imageDButton;
@synthesize imageEButton;
@synthesize imageFButton;
@synthesize taglineTextbox;
@synthesize scoreLabel;
@synthesize tempArrayWithMovieResult;
@synthesize gameWasAlreadyStarted;
@synthesize moviesWhichHaveBeenUsed;


@synthesize correctURLA;
@synthesize correctURLB;
@synthesize correctURLC;
@synthesize moviesToUseInView;
@synthesize moviesToUseNext;
@synthesize moviesToUseAfterNext;
@synthesize arrayToggleNumber;
@synthesize taglinesToUse;
@synthesize tagOne;
@synthesize tagTwo;
@synthesize tagThree;

@synthesize correctImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)isLoading:(BOOL)loading{
    
    if(loading == YES) {
        
        [self.activity startAnimating];
        [self.activity setAlpha:1.0];
        
    } else {
        [self.activity stopAnimating];
        [self.activity setAlpha:0.0];
      
    }
    
    
}

- (void)setUserInteractionForPoster:(BOOL)shouldItBeInteractive{

    [self.imageAButton setUserInteractionEnabled:shouldItBeInteractive];
    [self.imageBButton setUserInteractionEnabled:shouldItBeInteractive];
    [self.imageCButton setUserInteractionEnabled:shouldItBeInteractive];
    [self.imageDButton setUserInteractionEnabled:shouldItBeInteractive];
    [self.imageEButton setUserInteractionEnabled:shouldItBeInteractive];
    [self.imageFButton setUserInteractionEnabled:shouldItBeInteractive];
}

- (void)increaseLevel{

    
    
    
    
    
    // Button setup (to keep text central during animation)
    self.levelButton.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    CGRect cgMainScreenRect =[[UIScreen mainScreen] bounds];
    NSLog(@"FRAME :%f", cgMainScreenRect.size.width);
    // Animate
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    CGRect old = self.levelButton.frame;
    CGFloat diff = 60;
    
    if ((old.size.width + diff) > cgMainScreenRect.size.width) {
        diff = cgMainScreenRect.size.width - old.size.width;
    }
    
    self.levelButton.frame = CGRectMake(old.origin.x-diff/2.0, old.origin.y, old.size.width+diff, old.size.height);
    [UIView commitAnimations];
    
    if (old.size.width == cgMainScreenRect.size.width) {
        self.playerLevel++;
        
        /*
        
        UIColor *levelTen = [[UIColor alloc] initWithRed:137 green:0 blue:199 alpha:1];
        UIColor *levelTwenty = [[UIColor alloc] initWithRed:94 green:233 blue:255 alpha:1];
        UIColor *levelThirty = [[UIColor alloc] initWithRed:255 green:235 blue:69 alpha:1];
        UIColor *LevelFourty = [[UIColor alloc] initWithRed:204 green:34 blue:115 alpha:1];
        UIColor *LevelFifty = [[UIColor alloc] initWithRed:102 green:178 blue:30 alpha:1];
        UIColor *LevelSixty = [[UIColor alloc] initWithRed:204 green:67 blue:25 alpha:1];
        UIColor *LevelSeventy = [[UIColor alloc] initWithRed:159 green:255 blue:69 alpha:1];
        UIColor *LevelEighty = [[UIColor alloc] initWithRed:137 green:25 blue:255 alpha:1];
        UIColor *LevelNinty = [[UIColor alloc] initWithRed:255 green:0 blue:199 alpha:1];
        UIColor *LevelHundred = [[UIColor alloc] initWithRed:0 green:255 blue:248 alpha:1];
        UIColor *LevelHundredAndTen = [[UIColor alloc] initWithRed:255 green:121 blue:0 alpha:1];
        UIColor *LevelHundredAndTwenty = [[UIColor alloc] initWithRed:204 green:67 blue:255 alpha:1];
        UIColor *LevelHundredAndThirty = [[UIColor alloc] initWithRed:94 green:34 blue:0 alpha:1];
        UIColor *LevelHundredAndFourty = [[UIColor alloc] initWithRed:137 green:25 blue:255 alpha:1];
        
        
        if (self.playerLevel >= 10 && self.playerLevel < 20) {
            [self.levelButton setBackgroundColor:levelTen];
        }else if (self.playerLevel >= 20 && self.playerLevel < 30) {
            [self.levelButton setBackgroundColor:levelTwenty];
        }else if (self.playerLevel >= 30 && self.playerLevel < 40) {
            [self.levelButton setBackgroundColor:levelThirty];
        }else if (self.playerLevel >= 40 && self.playerLevel < 50) {
            [self.levelButton setBackgroundColor:LevelFourty];
        }else if (self.playerLevel >= 50 && self.playerLevel < 60) {
            [self.levelButton setBackgroundColor:LevelFifty];
        }else if (self.playerLevel >= 60 && self.playerLevel < 70) {
            [self.levelButton setBackgroundColor:LevelSixty];
        }else if (self.playerLevel >= 70 && self.playerLevel < 80) {
            [self.levelButton setBackgroundColor:LevelSeventy];
        }else if (self.playerLevel >= 80 && self.playerLevel < 90) {
            [self.levelButton setBackgroundColor:LevelEighty];
        }else if (self.playerLevel >= 90 && self.playerLevel < 100) {
            [self.levelButton setBackgroundColor:LevelNinty];
        }else if (self.playerLevel >= 100 && self.playerLevel < 110) {
            [self.levelButton setBackgroundColor:LevelHundred];
        }else if (self.playerLevel >= 110 && self.playerLevel < 120) {
            [self.levelButton setBackgroundColor:LevelHundredAndTen];
        }else if (self.playerLevel >= 120 && self.playerLevel < 130) {
            [self.levelButton setBackgroundColor:LevelHundredAndTwenty];
        }else if (self.playerLevel >= 130 && self.playerLevel < 140) {
            [self.levelButton setBackgroundColor:LevelHundredAndThirty];
        }else if (self.playerLevel >= 140 && self.playerLevel < 150) {
            [self.levelButton setBackgroundColor:LevelHundredAndFourty];
        }
        
         
         */
        [self.levelLabel setText:[NSString stringWithFormat:@"Level: %i", self.playerLevel]];
        
       [[NSUserDefaults standardUserDefaults] setInteger:self.playerLevel forKey:@"playerLevel"];
        [self.gameCenterManager reportScore:self.playerLevel forCategory:kLeaderboardID_Player];
        
        
        
        
        if (self.playerLevel == 10) {
            
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 10." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTen percentComplete:100.00];

        }else if (self.playerLevel == 20) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 20." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTwenty percentComplete:100.00];

        }else if (self.playerLevel == 30) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 30." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelThirty percentComplete:100.00];
            
        }else if (self.playerLevel == 40) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 40." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFourty percentComplete:100.00];
            
        }else if (self.playerLevel == 50) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 50." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFifty percentComplete:100.00];
            
        }else if (self.playerLevel == 60) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now achieved level 60." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelSixty percentComplete:100.00];
            
        }else if (self.playerLevel == 70) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 70." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelSeventy percentComplete:100.00];
            
        }else if (self.playerLevel == 80) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 80." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelEighty percentComplete:100.00];
            
        }else if (self.playerLevel == 90) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 90." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelNinty percentComplete:100.00];
            
        }else if (self.playerLevel == 100) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"Well Done!! you have now reached level 100." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 150) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"OMG!! you have now achieved reached 150." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelHundredAndFifty percentComplete:100.00];
            
        }else if (self.playerLevel == 200) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"This is impressive!! you have now reached level 200." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTwoHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 300) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"WOW!! you have now reached level 300." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelThreeHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 500) {
            UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"AMAZING!! you have now reached level 500." delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
            
            [alertReach show];
            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFiveHundred percentComplete:100.00];
                    
        }
        

        
        
        
        self.levelButton.frame = CGRectMake(117, old.origin.y, 86, old.size.height);
        [UIView commitAnimations];
    }

    
    
    
    

}


- (void)pressedCorrectImage{
    
    UIColor *correctColor = [[UIColor alloc] initWithRed:0 green:0.7 blue:0 alpha:1];
    UIColor *wrongColor = [[UIColor alloc] initWithRed:127 green:0 blue:0 alpha:1];

    
   
    
    
    NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageAButton, self.imageBButton, self.imageCButton, self.imageDButton, self.imageEButton, self.imageFButton, nil];
    [self removeBorder];
    
    for (UIButton *button in imageFieldArray) {
        
        [button setImage:nil forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:button cache:YES];
        [UIView commitAnimations];
    }
    [self.taglineTextbox setText:@""];
    [self setUserInteractionForPoster:NO];
    [self isLoading:YES];
    
    if (self.isHintPressed == YES) {
        
        if (self.streakNum > 0) {
            self.streakNum --;
        }
        
        self.isHintPressed = NO;
        [self.commentLabel setTextColor:wrongColor];
        [self animateAndLoadComment:[[Comments sharedClient] getBadComment]];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.quickScoreShow.layer.cornerRadius = 10;
            
            [self.quickScoreShow setText:[NSString stringWithFormat:@"0"]];
        
            
            [self.quickScoreShow setTextColor:[UIColor whiteColor]];
            [self.quickScoreShow setBackgroundColor:[UIColor darkGrayColor]];
            [self.quickScoreShow setAlpha:1.0];
        } completion:^(BOOL finished) {
            [self startRound];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];
        }];

        
        
        
    }else {
        
        [self.commentLabel setTextColor:correctColor];
        [self animateAndLoadComment:[[Comments sharedClient] getGoodComment]];
        [self increaseLevel];
        
        
        
        
        
        self.wrongStreakNum = 0;
        self.streakNum++;
        [self.streakReductionLabel setText:[NSString stringWithFormat:@"Streak: %d",  self.streakNum]];
        
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] == 0  || self.streakNum > [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"]) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.streakNum forKey:@"streak"];
            [self.gameCenterManager reportScore:self.streakNum forCategory:kLeaderboardID_Streak];
            
        }
        NSLog(@"HIGHEST STREAK: %i",[[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] );
        
        int checkStreak = [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"];
        
        if (self.streakNum == 5) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 5) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"you've managed to get 5 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
            
        }else if (self.streakNum == 10) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 10) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"don't stop you just got 10 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 15) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 15) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"you amazing person you!! 15 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 20) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 20) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"don't let me slow you down... 20 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 25) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 25) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"O_O' ... 25 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 30) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 30) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"you've managed to get 30 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 35) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 35) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"you've managed to get 35 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum == 40) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 40) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"you've managed to get 40 movies correct in a row... keep going!" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }else if (self.streakNum >= 50){
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 50) {
                UIAlertView *alertReach = [[UIAlertView alloc] initWithTitle:@"Achievement Unlocked" message:@"You shall now be known as Streak King! 50 movies correct in a row :O" delegate:self cancelButtonTitle:@"Woohoo!!" otherButtonTitles: nil];
                
                [alertReach show];
            }
            
        }
        
        
        
        
        self.currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
        self.currentScore += CORRECT_SCORE * self.streakNum;
        [[NSUserDefaults standardUserDefaults] setInteger: self.currentScore forKey:@"score"];
        
        int scoreInThisRound = CORRECT_SCORE * self.streakNum;
        
        
        
        
        
        
        
        [self.gameCenterManager reportScore:self.currentScore forCategory:kLeaderboardID_Score];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.quickScoreShow.layer.cornerRadius = 10;
            if (self.streakNum > 1) {
                [self.quickScoreShow setText:[NSString stringWithFormat:@"%i x %i",CORRECT_SCORE, self.streakNum]];
                
                
                
            }else {
                [self.quickScoreShow setText:[NSString stringWithFormat:@"%i", CORRECT_SCORE]];
            }
            
            [self.quickScoreShow setTextColor:[UIColor whiteColor]];
            [self.quickScoreShow setBackgroundColor:correctColor];
            [self.quickScoreShow setAlpha:1.0];
        } completion:^(BOOL finished) {
            if (self.streakNum > 1) {
                [UIView animateWithDuration:0.2 animations:^{
                    [self.quickScoreShow setAlpha:0.0];
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        [self.quickScoreShow setText:[NSString stringWithFormat:@"%i", scoreInThisRound]];
                        [self.quickScoreShow setAlpha:1.0];
                        
                        
                        
                    } completion:^(BOOL finished) {
                        [self updateScoreInView:scoreInThisRound Success:^{
                            NSLog(@"UPDATED THE SCORE SUCCESSFULLY");
                            [self startRound];
                        } failure:^{
                            NSLog(@"AW Snap!");
                        }];
                        
                        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];
                    }];
                    
                }];
                
                
            }else {
                [self updateScoreInView:scoreInThisRound Success:^{
                    NSLog(@"UPDATED THE SCORE SUCCESSFULLY");
                    [self startRound];
                } failure:^{
                    NSLog(@"AW Snap!");
                }];
                
                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];
            }
            
            
            
        }];
        
        
        
        
        
        
    }
    
   
    


}


- (void)updateScoreInView:(int) scoreInTheCurrentRound
                  Success:(void (^)(void))success
                  failure:(void (^)(void))failure{

    float interval = 0.01;
    
    
    
    
    
    
    
   
    
    if (scoreInTheCurrentRound == 50) {
        interval = 0.01;
    }else if (scoreInTheCurrentRound >= 100 && scoreInTheCurrentRound <= 200) {
        interval = 0.005;
    }else if (scoreInTheCurrentRound >= 201 && scoreInTheCurrentRound <= 400) {
        interval = 0.002;
    }else if (scoreInTheCurrentRound >= 401 && scoreInTheCurrentRound <= 800) {
        interval = 0.001;
    }else if (scoreInTheCurrentRound >= 1000 ) {
        interval = 0.0001;
    }
    
    NSLog(@"interval: %f",interval);
    
    
    
    for (int i = 0; i < scoreInTheCurrentRound; i++) {
        [self.scoreLabel setText:[NSString stringWithFormat:@"%d",  [self.scoreLabel.text intValue] + 1]];
        
        
        
        
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
    
    int scoreToCheck = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    
    if ( scoreToCheck == [self.scoreLabel.text intValue]) {
        NSLog(@"WOOOOOOOHOOOOO");
        success();
    }else {
        failure();
    }
    
    


}
- (IBAction)skipButtonPressed:(id)sender {
    [self skipPressed];
}

- (void)removeBorder{

    self.imageAButton.layer.borderWidth = 0;
    self.imageBButton.layer.borderWidth = 0;
    self.imageCButton.layer.borderWidth = 0;
    self.imageDButton.layer.borderWidth = 0;
    self.imageEButton.layer.borderWidth = 0;
    self.imageFButton.layer.borderWidth = 0;

}

- (void)skipPressed{
    
    self.isHintPressed = YES;
    
    UIColor *skippedColor = [[UIColor alloc] initWithRed:0 green:0.7 blue:0 alpha:1];

    int borderWidth = 6.0;
    int borderRad = 5;
    
   
        if ([self.correctImage isEqualToString:@"imageA"] ) {
            
            [[self.imageAButton layer] setBorderWidth:borderWidth];
            self.imageAButton.layer.borderColor = skippedColor.CGColor;
            self.imageAButton.layer.cornerRadius = borderRad;
            
            
            
        }else if ([self.correctImage isEqualToString:@"imageB"]) {
            [[self.imageBButton layer] setBorderWidth:borderWidth];
            self.imageBButton.layer.borderColor = skippedColor.CGColor;
            self.imageBButton.layer.cornerRadius = borderRad;
            
        }else if ([self.correctImage isEqualToString:@"imageC"]) {
            [[self.imageCButton layer] setBorderWidth:borderWidth];
            self.imageCButton.layer.borderColor = skippedColor.CGColor;
            self.imageCButton.layer.cornerRadius = borderRad;
            
        }else if ([self.correctImage isEqualToString:@"imageD"]) {
            [[self.imageDButton layer] setBorderWidth:borderWidth];
            self.imageDButton.layer.borderColor = skippedColor.CGColor;
            self.imageDButton.layer.cornerRadius = borderRad;
            
        }else if ([self.correctImage isEqualToString:@"imageE"]) {
            [[self.imageEButton layer] setBorderWidth:borderWidth];
            self.imageEButton.layer.borderColor = skippedColor.CGColor;
            self.imageEButton.layer.cornerRadius = borderRad;
            
        }else if ([self.correctImage isEqualToString:@"imageF"]) {
            [[self.imageFButton layer] setBorderWidth:borderWidth];
            self.imageFButton.layer.borderColor = skippedColor.CGColor;
            self.imageFButton.layer.cornerRadius = borderRad;
            
        }
      

    
    /*
    
    for (UIButton *button in imageFieldArray) {
        
        [button setImage:nil forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:button cache:YES];
        [UIView commitAnimations];
    }
    [self.taglineTextbox setText:@""];
    [self setUserInteractionForPoster:NO];
    [self isLoading:YES];
    

    [UIView animateWithDuration:0.2 animations:^{
        [self.quickScoreShow setAlpha:1.0];
        self.quickScoreShow.layer.cornerRadius = 10;
        [self.quickScoreShow setBackgroundColor:skippedColor];
        
        [self.quickScoreShow setText:@"Skipped"];
        
        
        
    } completion:^(BOOL finished) {
        
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];

                [self startRound];
           
        
    }];
*/
    

}

- (void)pressedIncorrectImage{
   

    
    UIColor *wrongColor = [[UIColor alloc] initWithRed:127 green:0 blue:0 alpha:1];
   
    [self.commentLabel setTextColor:wrongColor];
    [self animateAndLoadComment:[[Comments sharedClient] getBadComment]];

    
    [self setUserInteractionForPoster:NO];
    
    
     
    
    NSLog(@"I touched the wrong image");
    self.currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
     self.currentScore -= INCORRECT_SCORE;
    
    if ( self.currentScore < 0) {
         self.currentScore = 0;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger: self.currentScore forKey:@"score"];
    
   
    
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",  self.currentScore]];
    
    [self.gameCenterManager reportScore: self.currentScore forCategory:kLeaderboardID_Score];
    
    //[self uploadScore:currentScore];
    
    [UIView animateWithDuration:0.5 animations:^{
         self.quickScoreShow.layer.cornerRadius = 10;
        if ( self.currentScore > 0) {
            [self.quickScoreShow setText:[NSString stringWithFormat:@"-%i", INCORRECT_SCORE]];
        }else {
            
            
            [self.quickScoreShow setText:@"Terrible!"];
        }
        
        [self.quickScoreShow setTextColor:[UIColor whiteColor]];
        [self.quickScoreShow setBackgroundColor:wrongColor];
        
        [self.quickScoreShow setAlpha:1.0];
    } completion:^(BOOL finished) {
       
        
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];
            [self setUserInteractionForPoster:YES];
            
        
    }];
    
    
    
    
    
    
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];

    
    
    
     
   
}

- (void)showStreakReduction:(int) currentStreak
                    Success:(void (^)(void))success
                    failure:(void (^)(void))failure{
    
    //double interval = 0.01;
    
    
    
    int currentStreakPlus = currentStreak+1;
    
   // [self.streakReductionLabel setText:[NSString stringWithFormat:@"Streak fail: %d", currentStreak]];
    
    
    for (int i = 0; i < currentStreakPlus; i++) {
        [self.streakReductionLabel setText:[NSString stringWithFormat:@"Streak fail: %d",  currentStreak--]];
        
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
    }
    
    
    success();
    
    
}



-(void)resetColor{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.quickScoreShow setAlpha:0.0];
    } ];
    
}
-(void)hideLabel{

    [self.resultCommentTest setHidden:YES];

}
- (IBAction)imageAButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageA"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
       
        [self pressedIncorrectImage];
        
    }
}
- (IBAction)imageBButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageB"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
}

- (IBAction)imageCButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageC"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
    
}
- (IBAction)imageDButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageD"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}
- (IBAction)imageEButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageE"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}
- (IBAction)imageFButton:(UIButton *)sender {
    
    if ([self.correctImage isEqualToString:@"imageF"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}

- (IBAction)backPressed {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"amIInTheView"];

    
   // [self viewDidUnload];
    //[self.view setHidden:NO];
    
    //[self.view addSubview:pauseScreen];
    
   // [self.navigationController popViewControllerAnimated:YES];
    
   
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
- (void)isLoading:(BOOL)loading {
    if(loading) {
        [activity startAnimating];
        [activity setAlpha:1.0];
    } else {
        [activity stopAnimating];
        [activity setAlpha:0.0];
    }
}
 */





-(void)startScoreSystem{

    
    //get current score from facebook 
    //set it as the score
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"score"]) {
        NSLog(@"NO SCORE YET");
    }
    
    
    
    
 
}

- (void)clearImages{
    
    
    self.imageFieldA.image = nil;
    self.imageFieldB.image = nil;
    self.imageFieldC.image = nil;
    self.imageFieldD.image = nil;
    self.imageFieldE.image = nil;
    self.imageFieldF.image = nil;
    [self.taglineTextbox setText:@""];
    
    
    
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    
    if([reach isReachable])
    {
        
        
        NSLog(@"________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________STILL CONNECTED!!__________________________________________________________________________________________________________________________________________________________________________________________________________________");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    else
    {
        
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~LOST CONNECTION!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        [self backPressed];
        [reach stopNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
}




- (void)loadRandMovie:(NSString *)movieID{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
  
    
    NSLog(@"REACHABILITY STATUS: %i",[reach currentReachabilityStatus]);
    
    if ([reach currentReachabilityStatus] == 1 || [reach currentReachabilityStatus] == 0) {
        self.imageBaseURL = IMAGE_URL_PATH_LOW_QUALITY;
    }else if ([reach currentReachabilityStatus] == 2) {
        self.imageBaseURL = IMAGE_URL_PATH_HIGH_QUALITY;
    }
    
    
    [reach startNotifier];
    
    

    [Movie getMovieByMovieID:movieID Success:^(Movie *movie) {
        
        
        [SimilarMovies getSimilarMovies:movie.movieID Success:^(NSArray *similarMovies) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                return;
            }
            
            
            if ([movie.tagLine length] == 0) {
                NSLog(@"TAGLINE LENGTH IS 0");
                [self loadMovies];
                return;
            }
            
            
            numberOfRun++;
            
            NSLog(@"NUMBER OF RUN: %d", numberOfRun);
            
            NSLog(@"Movie ID: %@", movie.movieID);
            NSLog(@"Movie Name: %@", movie.movieName);
            NSLog(@"Movie TagLine: %@", movie.tagLine);
            NSLog(@"Movie Poster Path: %@", movie.posterPath);

            
            NSMutableArray *similarPosters = [[NSMutableArray alloc] init ];
            NSMutableArray *similarPostersURLS = [[NSMutableArray alloc] init];
            
            for (NSString *similarPoster in similarMovies) {
                //NSLog(@"Similar Movies: %@", similarPoster);
                
                UIImageView *tempHolder = [[UIImageView alloc] init ];
                
                NSString *URLToSimilarImage = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@",self.imageBaseURL,similarPoster]];
                
                [tempHolder setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLToSimilarImage]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                        return;
                    }
                    
                    
                    [similarPostersURLS addObject:URLToSimilarImage];
                    [similarPosters addObject:tempHolder.image];
                    
                    if (similarPosters.count == 5) {
                        
                        UIImageView *tempHolderCorrectImage = [[UIImageView alloc] init ];
                        
                        //NSString *URLToCorrectImage = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL_PATH,movie.posterPath]];
                        
                        
                        
                        [tempHolderCorrectImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.imageBaseURL,movie.posterPath]]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                return;
                            }
                            
                            NSMutableDictionary *round = [[NSMutableDictionary alloc] init];
                            [round setObject:movie.movieID forKey:@"movieID"];
                            [round setObject:movie.movieName forKey:@"Name"];
                            [round setObject:movie.tagLine forKey:@"tagline"];
                            [round setObject:tempHolderCorrectImage.image forKey:@"correctPoster"];
                            [round setObject:similarPosters forKey:@"similarPosters"];
                            [round setObject:movie.genreID forKey:@"genreID"];
                            [round setObject:movie.genre forKey:@"genre"];
                            
                            
                            
                            
                            
                            [self.moviesToUseInView addObject:round];
                            NSLog(@"%@", round);
                            NSLog(@"%d", self.isFirstRound);
                            //  NSLog(@"MOVIES TO USE IN VIEW IN LOAD MOVIES: %@", self.moviesToUseInView);
                            
                            
                            [self setMoviesIntoUserDefaultsWithArray:self.moviesToUseInView Success:^{
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                    return;
                                }
                                NSLog(@"All good bro... user defaults has some movies for next time!");
                                
                                
                            } failure:^{
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                    return;
                                }
                                NSLog(@"Awhh Shit... user defaults didn't get the message homie!");
                            }];
                            
                            
                            if (self.isFirstRound == 0) {
                                //NSLog(@"%@", isFirstRound);
                                if ([self.moviesToUseInView count] < 1) {
                                    [self loadMovies];
                                }else {
                                    //self.isFirstRound = 1;
                                    //NSLog(@"%d", isFirstRound);
                                    
                                    
                                    
                                    
                                    
                                    //[self loadMovies];
                                    [self startRound];
                                    return;
                                }
                                
                                
                            }
                            
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                return;
                            }
                            
                            NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD. It failed because it couldn't set an image to the temp image holder for correct image: %@", error);
                            [self loadMovies];
                            return;
                            
                        }];
                        
                        
                    }
                    
                    
                    
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                        return;
                    }
                    NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD. It failed because it couldn't set an image to the temp image holder for similar images: %@", error);
                    [self loadMovies];
                    return;
                    
                }];
                
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                return;
            }
            NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD, The failure occured when using GetSimilarMovies method in the SimilarMovie class, this was called within the getRandMovieAtYear method: %@", error);
            [self loadMovies];
            return;
        }];
        
    
        
        
    } failure:^(NSError *error) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
            return;
        }
        NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD, The failure occured when using getRandMovieAtYear method in the Movie class: %@", error);
        [self loadMovies];
        return;
    }];
    

}


- (void)loadMovies{

    
    int arrayLength = [self.moviesInPlay count];
    
    int randomMovieInAppIndex = arc4random() % arrayLength;
    
    NSDictionary *movie = [[NSDictionary alloc] initWithDictionary:[self.moviesInApp objectAtIndex:randomMovieInAppIndex]];
    [self.moviesInPlay removeObjectAtIndex:randomMovieInAppIndex];
    [[NSUserDefaults standardUserDefaults] setObject:self.moviesInPlay forKey:@"movies"];
    
    [self loadRandMovie: [movie objectForKey:@"tmdb_id"]];
    
    
    /*
    
    if (self.currentGenreInPlay == @"All") {
        
        int arrayLength = [self.moviesInPlay count];
        
        int randomMovieInAppIndex = arc4random() % arrayLength;
       
        NSDictionary *movie = [[NSDictionary alloc] initWithDictionary:[self.moviesInApp objectAtIndex:randomMovieInAppIndex]];
        
        [self loadRandMovie: [movie objectForKey:@"tmdb_id"]];
        
        
    }else {
        
        int arrayLength = [self.moviesInPlay count];
        
        if (arrayLength == 0) {
            NSLog(@"you're done!!");
            return;
        }
        
        int randomMovieInAppIndex = arc4random() % arrayLength;
        
        NSDictionary *movie = [[NSDictionary alloc] initWithDictionary:[self.moviesInPlay objectAtIndex:randomMovieInAppIndex]];
        
        [self loadRandMovie: [movie objectForKey:@"tmdb_id"]];
        [self.moviesInPlay removeObjectAtIndex:randomMovieInAppIndex];
        
    }
    */
    

}


- (void)setMoviesIntoUserDefaultsWithArray:(NSMutableArray *)moviesToBackup 
                                   Success:(void (^)(void))success
                                   failure:(void (^)(void))failure
{

    
    
    
    NSMutableArray *moviesForNextRound = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *roundToUseForNextGame in moviesToBackup) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:roundToUseForNextGame];
        
        
        // NSLog(@"ROUND TO USE: %@", roundToUseForNextGame);
        
        
        NSData *imgData = [[NSData alloc] init];
        imgData = UIImagePNGRepresentation([roundToUseForNextGame objectForKey:@"correctPoster"]);
        
        
        
        NSMutableArray *similarsDataArray = [[NSMutableArray alloc] init];
        for (UIImage *similar  in [roundToUseForNextGame objectForKey:@"similarPosters"]) {
            
            NSData *similarsData = [[NSData alloc] init];
            similarsData = UIImagePNGRepresentation(similar);

            [similarsDataArray addObject:similarsData];
            
        }
        
        [tempDic setObject:imgData forKey:@"correctImgData"];
        [tempDic setObject:similarsDataArray forKey:@"similarImgData"];
        //NSLog(@"TEMP DICT: %@", tempDic);
        [moviesForNextRound addObject:tempDic];
        //NSLog(@"DICT BEFORE PROCESSING: %@", roundToUseForNextGame);
        //NSLog(@"DICT AFTER PROCESSING: %@", tempDic);
        [tempDic removeObjectForKey:@"correctPoster"];
        [tempDic removeObjectForKey:@"similarPosters"];
    }
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:moviesForNextRound forKey:@"moviesInDefaults"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesInDefaults"] != nil) {
        success();
        
    }else {
        failure();
    }
    
    //NSLog(@"MOVIES FOR NEXT ROUND: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"moviesToLoadOnLaunch"]);





}


- (void) animateAndLoadTagline:(NSString *)tagline{
    [UIView beginAnimations:@"animateText" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0];
    [self.taglineTextbox setAlpha:0];
    [self.taglineTextbox setText:tagline];
    [self.taglineTextbox setAlpha:1];
    [UIView commitAnimations];
    
    
}

- (void) animateAndLoadComment:(NSString *)comment{
    [UIView beginAnimations:@"animateText" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0];
    [self.commentLabel setAlpha:0];
    [self.commentLabel setText:comment];
    [self.commentLabel setAlpha:1];
    [UIView commitAnimations];
    
    
}

-(void)hideComment{

    [UIView animateWithDuration:1.5 animations:^{
        
        [self.commentLabel setAlpha:0.0];
    }];


}

-(void)startRound{
    /*
    [round setObject:movie.tagLine forKey:@"tagline"];
    [round setObject:movie.posterPath forKey:@"correctPosterPath"];
    [round setObject:similarMovies forKey:@"similars"];
     */
    
   // [self hideComment];
    
    if (self.isFirstRound == 0) {
        self.isFirstRound = 1;
    }
    [self loadMovies];
    
    
        int randomPosterLoc = arc4random() % 6;
    NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageAButton, self.imageBButton, self.imageCButton, self.imageDButton, self.imageEButton, self.imageFButton, nil];
    //NSLog(@"MOVIES TO USE IN VIEW: %@", self.moviesToUseInView);
    
    
    
   
    
    
    if ([self.moviesToUseInView count] >= 1) {
        NSDictionary *movieToUseInRound = [[NSDictionary alloc] initWithDictionary:[self.moviesToUseInView objectAtIndex:0]];
        
        
        
        
        [self animateAndLoadTagline:[movieToUseInRound objectForKey:@"tagline"]];
        
        NSLog(@"_______________________IMAGE FIELD ARRAY_________________:%@", imageFieldArray);
        
        [(UIButton *)[imageFieldArray objectAtIndex:randomPosterLoc]  setImage:[movieToUseInRound objectForKey:@"correctPoster"] forState:UIControlStateNormal];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[imageFieldArray objectAtIndex:randomPosterLoc] imageView] cache:YES];
        [UIView commitAnimations];
        //[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];

        if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageAButton) {
            self.correctImage = @"imageA";
        }else if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageBButton) {
            self.correctImage = @"imageB";
        }else if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageCButton) {
            self.correctImage = @"imageC";
        }else if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageDButton) {
            self.correctImage = @"imageD";
        }else if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageEButton) {
            self.correctImage = @"imageE";
        }else if ([imageFieldArray objectAtIndex:randomPosterLoc] == self.imageFButton) {
            self.correctImage = @"imageF";
        }
        
        NSArray *similarPosters = [[NSArray alloc] initWithArray:[movieToUseInRound objectForKey:@"similarPosters"]];
        
        NSLog(@"CORRECT IMAGE: %@", self.correctImage);
        NSLog(@"IMAGE FIELD ARRAY: %@", similarPosters);
        
        [imageFieldArray removeObjectAtIndex:randomPosterLoc];
        
        
        for (int i = 0; i < 5; i++) {
            int randomSimilarPosterLoc = arc4random() % imageFieldArray.count;
            [(UIButton *)[imageFieldArray objectAtIndex:randomSimilarPosterLoc] setImage:[similarPosters objectAtIndex:i] forState:UIControlStateNormal ];
            
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[imageFieldArray objectAtIndex:randomSimilarPosterLoc] imageView] cache:YES];
            [UIView commitAnimations];
            //[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
            
            
            
            
            
            [imageFieldArray removeObjectAtIndex:randomSimilarPosterLoc];
        }
        [self isLoading:NO];
        [self setScaleForImagesInView];
        
        
        [self setUserInteractionForPoster:YES];
        
        
        
         
        [self.moviesToUseInView removeObjectAtIndex:0];
    }else {
        self.isFirstRound = 0;
        
        [self loadMovies];
    }
    
    
    

}

- (void)setScaleForImagesInView{

    self.imageAButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageAButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageBButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageBButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageCButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageCButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageDButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageDButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageEButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageEButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageFButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.imageFButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;

}




- (void)getMoviesFromUserDefaultsOnSuccess:(void (^)(void))success
                       failure:(void (^)(void))failure

{
    
   
    
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesInDefaults"] == nil) {
        failure();
        return;
    }
    
    NSMutableArray *defaultRounds = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesInDefaults"]];
    
    
    for (NSMutableDictionary *roundFromDefaults in defaultRounds) {
        
        NSMutableDictionary *roundFromDefaultsToUse = [[NSMutableDictionary alloc] initWithDictionary:roundFromDefaults copyItems:YES];
        
        UIImage *correctImg = [[UIImage alloc] initWithData:[roundFromDefaultsToUse objectForKey:@"correctImgData"]];
        
        NSMutableArray *similarPosterImages = [[NSMutableArray alloc] init];
        
        for (NSData *similarImgData in [roundFromDefaultsToUse objectForKey:@"similarImgData"]) {
            
            UIImage *similarImg = [[UIImage alloc] initWithData:similarImgData];
            [similarPosterImages addObject:similarImg];
            
        }
        
        //[roundFromDefaults removeObjectForKey:@"correctImgData"];
        //[roundFromDefaults removeObjectForKey:@"similarImgData"];
        
        NSLog(@"CORRECT IMAGE: %@", correctImg);
        
        [roundFromDefaultsToUse setObject:correctImg forKey:@"correctPoster"];
        [roundFromDefaultsToUse setObject:similarPosterImages forKey:@"similarPosters"];
        
        [self.moviesToUseInView addObject:roundFromDefaultsToUse];
        
        if (self.moviesToUseInView.count >= 3) {
            
            success();
            return;
        }
        
    }
    
    [self loadMovies];
    
    
    
}

-(float)convertRGBVal:(int)value{

    return value/255;


}
- (void)viewDidLoad{
     [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"amIInTheView"];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self isLoading:YES];
    self.moviesInPlay = [[NSMutableArray alloc] init];
    self.moviesInApp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"movies"] ];
    
   
    
    for (NSDictionary *movie in self.moviesInApp) {
        
      
            [self.moviesInPlay addObject:movie];
       
    }
    
    
    
    [self startScoreSystem];
    

    
   
    
    
    self.moviesToUseInView = [[NSMutableArray alloc] init ];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"streak"];
    
   
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playerLevel"] == nil) {
        self.playerLevel = 0;
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.playerLevel forKey:@"playerLevel"];
        
    }else {
        self.playerLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"playerLevel"];
    }
    
    [self.levelLabel setText:[NSString stringWithFormat:@"Level: %i",self.playerLevel]];

    
    /*
    UIColor *levelTen = [[UIColor alloc] initWithRed:137 green:0 blue:199 alpha:1];
    UIColor *levelTwenty = [[UIColor alloc] initWithRed:[self convertRGBVal:94] green:[self convertRGBVal:233] blue:[self convertRGBVal:255] alpha:1];
    UIColor *levelThirty = [[UIColor alloc] initWithRed:1.0 green:0.92 blue:0.27 alpha:1];
    UIColor *LevelFourty = [[UIColor alloc] initWithRed:204 green:34 blue:115 alpha:1];
    UIColor *LevelFifty = [[UIColor alloc] initWithRed:102 green:178 blue:30 alpha:1];
    UIColor *LevelSixty = [[UIColor alloc] initWithRed:204 green:67 blue:25 alpha:1];
    UIColor *LevelSeventy = [[UIColor alloc] initWithRed:159 green:255 blue:69 alpha:1];
    UIColor *LevelEighty = [[UIColor alloc] initWithRed:137 green:25 blue:255 alpha:1];
    UIColor *LevelNinty = [[UIColor alloc] initWithRed:255 green:0 blue:199 alpha:1];
    UIColor *LevelHundred = [[UIColor alloc] initWithRed:0 green:255 blue:248 alpha:1];
    UIColor *LevelHundredAndTen = [[UIColor alloc] initWithRed:255 green:121 blue:0 alpha:1];
    UIColor *LevelHundredAndTwenty = [[UIColor alloc] initWithRed:204 green:67 blue:255 alpha:1];
    UIColor *LevelHundredAndThirty = [[UIColor alloc] initWithRed:106 green:53 blue:16 alpha:1];
    UIColor *LevelHundredAndFourty = [[UIColor alloc] initWithRed:137 green:25 blue:255 alpha:1];
    
    [self.levelLabel setText:[NSString stringWithFormat:@"Level: %i",self.playerLevel]];
    
    
    if (self.playerLevel >= 10 && self.playerLevel < 20) {
        [self.levelButton setBackgroundColor:levelTen];
    }else if (self.playerLevel >= 20 && self.playerLevel < 30) {
        [self.levelButton setBackgroundColor:levelTwenty];
    }else if (self.playerLevel >= 30 && self.playerLevel < 40) {
        [self.levelButton setBackgroundColor:levelTwenty];
    }else if (self.playerLevel >= 40 && self.playerLevel < 50) {
        [self.levelButton setBackgroundColor:LevelFourty];
    }else if (self.playerLevel >= 50 && self.playerLevel < 60) {
        [self.levelButton setBackgroundColor:LevelFifty];
    }else if (self.playerLevel >= 60 && self.playerLevel < 70) {
        [self.levelButton setBackgroundColor:LevelSixty];
    }else if (self.playerLevel >= 70 && self.playerLevel < 80) {
        [self.levelButton setBackgroundColor:LevelSeventy];
    }else if (self.playerLevel >= 80 && self.playerLevel < 90) {
        [self.levelButton setBackgroundColor:LevelEighty];
    }else if (self.playerLevel >= 90 && self.playerLevel < 100) {
        [self.levelButton setBackgroundColor:LevelNinty];
    }else if (self.playerLevel >= 100 && self.playerLevel < 110) {
        [self.levelButton setBackgroundColor:LevelHundred];
    }else if (self.playerLevel >= 110 && self.playerLevel < 120) {
        [self.levelButton setBackgroundColor:LevelHundredAndTen];
    }else if (self.playerLevel >= 120 && self.playerLevel < 130) {
        [self.levelButton setBackgroundColor:LevelHundredAndTwenty];
    }else if (self.playerLevel >= 130 && self.playerLevel < 140) {
        [self.levelButton setBackgroundColor:LevelHundredAndThirty];
    }else if (self.playerLevel >= 140 && self.playerLevel < 150) {
        [self.levelButton setBackgroundColor:LevelHundredAndFourty];
    }
    
    
    
        */
   // [self.PauseMenuV setHidden:YES];
    
    self.currentScore = 0;
	
	if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[GameCenterManager alloc] init];
		[self.gameCenterManager setDelegate:self];
		
		
	} else {
		
		// The current device does not support Game Center.
        
	}
    
    //[self loadMovies];
   
    [self getMoviesFromUserDefaultsOnSuccess:^{
        self.isFirstRound = 1;
        //[self loadMovies];
        [self startRound];
        //[self loadMovies];
        
    } failure:^{
        
        [self isLoading:YES];
        self.isFirstRound = 0;
        [self loadMovies];
        
    }];
    
    
        
    
    //self.moviesToUseInView = [[NSMutableArray alloc] init ];
     //NSLog(@"MOVIES USER DEFAULTS: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"moviesToLoadOnLaunch"] );
   // [self loadMoviesFromDefaults];
    

    
     
     

}



- (void)viewDidAppear:(BOOL)animated{
//adultID - 39573
//iron man - 1726
     
    
}



- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setImageFieldA:nil];
    [self setImageFieldB:nil];
    [self setImageFieldB:nil];
    [self setImageFieldC:nil];
    [self setImageFieldD:nil];
    [self setImageFieldE:nil];
    [self setImageFieldF:nil];
    [self setBackgroundImage:nil];
    [self setImageAButton:nil];
    [self setImageBButton:nil];
    [self setImageCButton:nil];
    [self setImageDButton:nil];
    [self setImageEButton:nil];
    [self setImageFButton:nil];
    [self setTaglineTextbox:nil];
    [self setScoreLabel:nil];
    [self setLoadingLabelTest:nil];
    [self setRoundNumberLabelTest:nil];
    [self setResultCommentTest:nil];
    [self setActivity:nil];
    [self setCorrectLabel:nil];
    [self setQuickScoreShow:nil];
   // [self setPauseMenuV:nil];
    [self setStreakReductionLabel:nil];
    [self setLevelButton:nil];
    [self setLevelLabel:nil];
    [self setQuickScoreShow:nil];
    [self setCommentLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






@end

