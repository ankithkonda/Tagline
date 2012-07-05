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
#import "Genre.h"
#import "Reachability.h"
#import "Comments.h"




@interface GamePageViewController ()



@end

@implementation GamePageViewController

@synthesize isHintPressed;
@synthesize isHintEnabled;
@synthesize imageBaseURL;
@synthesize commentLabel;
@synthesize hintButton;

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
@synthesize backgroundImage;
@synthesize backButton;
@synthesize activity;
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
        
        
        
        UIColor *level10 = [UIColor colorWithRed:0.515 green:0.271 blue:0.874 alpha:1.000];
        UIColor *level20 = [UIColor colorWithRed:0.631 green:0.264 blue:0.000 alpha:1.000];
        UIColor *level30 = [UIColor colorWithRed:0.914 green:0.770 blue:0.000 alpha:1.000];
        UIColor *level40 = [UIColor colorWithRed:0.076 green:0.770 blue:0.000 alpha:1.000];
        UIColor *level50 = [UIColor colorWithRed:0.737 green:0.322 blue:0.453 alpha:1.000];
        UIColor *level60 = [UIColor colorWithRed:0.000 green:0.322 blue:0.453 alpha:1.000];
        UIColor *level70 = [UIColor colorWithRed:1.000 green:0.009 blue:0.453 alpha:1.000];
        UIColor *level80 = [UIColor colorWithRed:0.278 green:0.009 blue:0.453 alpha:1.000];
        UIColor *level90 = [UIColor colorWithRed:1.000 green:0.258 blue:0.000 alpha:1.000];
        UIColor *level100 = [UIColor colorWithRed:0.283 green:0.587 blue:0.521 alpha:1.000];
        
        
        if (self.playerLevel >= 10 && self.playerLevel < 20) {
            
            [self.levelButton setBackgroundColor:level10];
        }else if (self.playerLevel >= 20 && self.playerLevel < 30) {
            [self.levelButton setBackgroundColor:level20];
        }else if (self.playerLevel >= 30 && self.playerLevel < 40) {
            [self.levelButton setBackgroundColor:level30];
        }else if (self.playerLevel >= 40 && self.playerLevel < 50) {
            [self.levelButton setBackgroundColor:level40];
        }else if (self.playerLevel >= 50 && self.playerLevel < 60) {
            [self.levelButton setBackgroundColor:level50];
        }else if (self.playerLevel >= 60 && self.playerLevel < 70) {
            [self.levelButton setBackgroundColor:level60];
        }else if (self.playerLevel >= 70 && self.playerLevel < 80) {
            [self.levelButton setBackgroundColor:level70];
        }else if (self.playerLevel >= 80 && self.playerLevel < 90) {
            [self.levelButton setBackgroundColor:level80];
        }else if (self.playerLevel >= 90 && self.playerLevel < 100) {
            [self.levelButton setBackgroundColor:level90];
        }else if (self.playerLevel >= 100 && self.playerLevel < 110) {
            [self.levelButton setBackgroundColor:level100];
        }else if (self.playerLevel >= 110 && self.playerLevel < 120) {
            [self.levelButton setBackgroundColor:level10];
        }else if (self.playerLevel >= 120 && self.playerLevel < 130) {
            [self.levelButton setBackgroundColor:level20];
        }else if (self.playerLevel >= 130 && self.playerLevel < 140) {
            [self.levelButton setBackgroundColor:level30];
        }else if (self.playerLevel >= 140 && self.playerLevel < 150) {
            [self.levelButton setBackgroundColor:level60];
        }
        
         
         
        [self.levelLabel setText:[NSString stringWithFormat:@"Level: %i", self.playerLevel]];
        
       [[NSUserDefaults standardUserDefaults] setInteger:self.playerLevel forKey:@"playerLevel"];
        [self.gameCenterManager reportScore:self.playerLevel forCategory:kLeaderboardID_Player];
        
        UIColor *achievementColor = [[UIColor alloc] init];
        achievementColor = [UIColor yellowColor];
        
        
        if (self.playerLevel == 10) {
            
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 10"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTen percentComplete:100.00];

        }else if (self.playerLevel == 20) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 20"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTwenty percentComplete:100.00];

        }else if (self.playerLevel == 30) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 30"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelThirty percentComplete:100.00];
            
        }else if (self.playerLevel == 40) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 40"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFourty percentComplete:100.00];
            
        }else if (self.playerLevel == 50) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 50"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFifty percentComplete:100.00];
            
        }else if (self.playerLevel == 60) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 60"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelSixty percentComplete:100.00];
            
        }else if (self.playerLevel == 70) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 70"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelSeventy percentComplete:100.00];
            
        }else if (self.playerLevel == 80) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 80"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelEighty percentComplete:100.00];
            
        }else if (self.playerLevel == 90) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 90"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelNinty percentComplete:100.00];
            
        }else if (self.playerLevel == 100) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 100"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 150) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 150"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelHundredAndFifty percentComplete:100.00];
            
        }else if (self.playerLevel == 200) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 200"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelTwoHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 300) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 300"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelThreeHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 400) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 400"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFourHundred percentComplete:100.00];
            
        }else if (self.playerLevel == 500) {
            [self.commentLabel setTextColor:achievementColor];

            [self animateAndLoadComment:@"Achievement Unlocked: Reached Level 500"];

            
            [self.gameCenterManager submitAchievement:kAchievementID_LevelFiveHundred percentComplete:100.00];
                    
        }
        

        
        
        
        self.levelButton.frame = CGRectMake(117, old.origin.y, 86, old.size.height);
        [UIView commitAnimations];
    }

    
    
    
    

}


- (void)pressedCorrectImage{
    
    
    UIColor *correctColor = [[UIColor alloc] initWithRed:0 green:0.7 blue:0 alpha:1];
    /*
    UIColor *wrongColor = [[UIColor alloc] initWithRed:127 green:0 blue:0 alpha:1];

    UIColor *achievementColor = [[UIColor alloc] initWithRed:1 green:0.9 blue:0 alpha:1];
     */
    
    
    //UIColor *correctColor = [[UIColor alloc] init];
    //correctColor = [UIColor greenColor];
    
    UIColor *wrongColor = [[UIColor alloc] init];
    wrongColor = [UIColor redColor];

    UIColor *achievementColor = [[UIColor alloc] init];
    achievementColor = [UIColor yellowColor];

    
    
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
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] == 0  || self.streakNum > [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"]) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.streakNum forKey:@"streak"];
            [self.gameCenterManager reportScore:self.streakNum forCategory:kLeaderboardID_Streak];
            
        }
        
        int checkStreak = [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"];
       

        if (self.streakNum == 5) {
            [self.gameCenterManager submitAchievement:kAchievementID_Streaker percentComplete:100.00];
            
            
            
            if (checkStreak <= 5) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streaker"];

                
            }
            
            
        }else if (self.streakNum == 10) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTen percentComplete:100.00];
            
            if (checkStreak <= 10) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 10"];

            }
            
        }else if (self.streakNum == 15) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakFifteen percentComplete:100.00];
            
            if (checkStreak <= 15) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 15"];

            }
            
        }else if (self.streakNum == 20) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTwenty percentComplete:100.00];
            
            if (checkStreak <= 20) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 20"];

            }
            
        }else if (self.streakNum == 25) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakTwentyFive percentComplete:100.00];
            
            if (checkStreak <= 25) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 25"];

            }
            
        }else if (self.streakNum == 30) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakThirty percentComplete:100.00];
            
            if (checkStreak <= 30) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 30"];
            }
            
        }else if (self.streakNum == 35) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakThirtyFive percentComplete:100.00];
            
            if (checkStreak <= 35) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 35"];

            }
            
        }else if (self.streakNum == 40) {
            [self.gameCenterManager submitAchievement:kAchievementID_StreakFourty percentComplete:100.00];
            
            if (checkStreak <= 40) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak 40"];

            }
            
        }else if (self.streakNum >= 50){
            [self.gameCenterManager submitAchievement:kAchievementID_StreakKing percentComplete:100.00];
            
            if (checkStreak <= 50) {
                [self.commentLabel setTextColor:achievementColor];

                [self animateAndLoadComment:@"Achievement Unlocked: Streak King"];

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
                            
                            [self startRound];
                        } failure:^{
                            
                        }];
                        
                        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetColor) userInfo:nil repeats:NO];
                    }];
                    
                }];
                
                
            }else {
                [self updateScoreInView:scoreInThisRound Success:^{
                    [self startRound];
                } failure:^{
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
    }else if (scoreInTheCurrentRound >= 401 && scoreInTheCurrentRound <= 600) {
        interval = 0.001;
    }else if (scoreInTheCurrentRound >= 601 && scoreInTheCurrentRound <= 1000) {
        interval = 0.0003;
    }else if (scoreInTheCurrentRound >= 1001 ) {
        interval = 0.0001;
    }
    
    
    
    
    for (int i = 0; i < scoreInTheCurrentRound; i++) {
        [self.scoreLabel setText:[NSString stringWithFormat:@"%d",  [self.scoreLabel.text intValue] + 1]];
        
        
        
        
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
    
    int scoreToCheck = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    
    if ( scoreToCheck == [self.scoreLabel.text intValue]) {
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
    
    
    if (self.isHintEnabled == YES) {
        self.isHintPressed = YES;
        
        int borderWidth = 8.0;
        int borderRad = 1;
        UIColor *skippedColor = [[UIColor alloc] initWithRed:0 green:0.7 blue:0 alpha:1];

        
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
    }else if (self.playerLevel < 5  && [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] < 5) {
        UIAlertView *hintAlert = [[UIAlertView alloc] initWithTitle:@"Cheat Locked" message:@"To unlock 'Cheat', reach level 5 & get 5 posters correct in a row." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [hintAlert show];
    }else if (self.playerLevel < 5 || [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] < 5) {
        if (self.playerLevel < 5 && [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] >= 5) {
            UIAlertView *hintAlert = [[UIAlertView alloc] initWithTitle:@"Hint Locked" message:@"To unlock 'Cheat', you still need to reach level 5" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [hintAlert show];
        }else if (self.playerLevel >= 5 && [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] < 5) {
            UIAlertView *hintAlert = [[UIAlertView alloc] initWithTitle:@"Hint Locked" message:@"To unlock 'Cheat', you still need to get 5 posters correct in a row." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [hintAlert show];
        }
    }
    
    
    
    
      

    
    

}

- (void)pressedIncorrectImage{
   

    
    UIColor *wrongColor = [[UIColor alloc] initWithRed:127 green:0 blue:0 alpha:1];
   
    [self.commentLabel setTextColor:wrongColor];
    [self animateAndLoadComment:[[Comments sharedClient] getBadComment]];

    
    [self setUserInteractionForPoster:NO];
    
    self.streakNum = 0;
     
    
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
    
    
    
    
    
    
    
    
    
    
     
   
}





-(void)resetColor{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.quickScoreShow setAlpha:0.0];
    } ];
    
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





-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    
    if([reach isReachable])
    {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    else
    {
        
        
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
                [self loadMovies];
                return;
            }
            
            
            numberOfRun++;
            

            
            NSMutableArray *similarPosters = [[NSMutableArray alloc] init ];
            NSMutableArray *similarPostersURLS = [[NSMutableArray alloc] init];
            
            for (NSString *similarPoster in similarMovies) {
                
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
                          
                            
                            [self setMoviesIntoUserDefaultsWithArray:self.moviesToUseInView Success:^{
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                    return;
                                }
                                
                                
                            } failure:^{
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                    return;
                                }
                            }];
                            
                            
                            if (self.isFirstRound == 0) {
                                if ([self.moviesToUseInView count] < 1) {
                                    [self loadMovies];
                                }else {
                                    
                                    [self startRound];
                                    return;
                                }
                                
                                
                            }
                            
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                                return;
                            }
                            
                            [self loadMovies];
                            return;
                            
                        }];
                        
                        
                    }
                    
                    
                    
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                        return;
                    }
                    
                    [self loadMovies];
                    return;
                    
                }];
                
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
                return;
            }
            
            [self loadMovies];
            return;
        }];
        
    
        
        
    } failure:^(NSError *error) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"amIInTheView"] == @"NO") {
            return;
        }
     
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
    
    


}


- (void)setMoviesIntoUserDefaultsWithArray:(NSMutableArray *)moviesToBackup 
                                   Success:(void (^)(void))success
                                   failure:(void (^)(void))failure
{

    
    
    
    NSMutableArray *moviesForNextRound = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *roundToUseForNextGame in moviesToBackup) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:roundToUseForNextGame];
        
        
        
        
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
   
        [moviesForNextRound addObject:tempDic];
 
        [tempDic removeObjectForKey:@"correctPoster"];
        [tempDic removeObjectForKey:@"similarPosters"];
    }
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:moviesForNextRound forKey:@"moviesInDefaults"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesInDefaults"] != nil) {
        success();
        
    }else {
        failure();
    }
    
   




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
    
    
    if (self.isFirstRound == 0) {
        self.isFirstRound = 1;
    }
    [self loadMovies];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] >= 5 && self.playerLevel >= 5) {
        self.isHintEnabled = YES;
    }
    
    if (self.isHintEnabled == YES) {
        UIColor *hintButtonColor = [[UIColor alloc] initWithRed:0 green:0.634419 blue:0.873641 alpha:1]; 

    
        [self.hintButton setBackgroundColor:hintButtonColor];
    }
    
    
        int randomPosterLoc = arc4random() % 6;
    NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageAButton, self.imageBButton, self.imageCButton, self.imageDButton, self.imageEButton, self.imageFButton, nil];

    
   
    
    
    if ([self.moviesToUseInView count] >= 1) {
        NSDictionary *movieToUseInRound = [[NSDictionary alloc] initWithDictionary:[self.moviesToUseInView objectAtIndex:0]];
        
        
        
        
        [self animateAndLoadTagline:[movieToUseInRound objectForKey:@"tagline"]];
        
        
        [(UIButton *)[imageFieldArray objectAtIndex:randomPosterLoc]  setImage:[movieToUseInRound objectForKey:@"correctPoster"] forState:UIControlStateNormal];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[imageFieldArray objectAtIndex:randomPosterLoc] imageView] cache:YES];
        [UIView commitAnimations];

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
        
     
        
        [imageFieldArray removeObjectAtIndex:randomPosterLoc];
        
        
        for (int i = 0; i < 5; i++) {
            int randomSimilarPosterLoc = arc4random() % imageFieldArray.count;
            [(UIButton *)[imageFieldArray objectAtIndex:randomSimilarPosterLoc] setImage:[similarPosters objectAtIndex:i] forState:UIControlStateNormal ];
            
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[imageFieldArray objectAtIndex:randomSimilarPosterLoc] imageView] cache:YES];
            [UIView commitAnimations];
            
            
            
            
            
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
    
    
    
   
    
    
    self.moviesToUseInView = [[NSMutableArray alloc] init ];
    

    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"score"];
    
   
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playerLevel"] == nil) {
        self.playerLevel = 0;
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.playerLevel forKey:@"playerLevel"];
        
    }else {
        self.playerLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"playerLevel"];
    }
    
   
    
    if (self.playerLevel >= 5 && [[NSUserDefaults standardUserDefaults] integerForKey:@"streak"] >= 5) {
        UIColor *hintButtonColor = [[UIColor alloc] initWithRed:0 green:0.634419 blue:0.873641 alpha:1]; 

        self.isHintEnabled = YES;
        [self.hintButton setBackgroundColor:hintButtonColor];
        
        
    }else {
        self.isHintEnabled = NO;
        [self.hintButton setBackgroundColor:[UIColor darkGrayColor]];
    }
    
    [self.levelLabel setText:[NSString stringWithFormat:@"Level: %i",self.playerLevel]];

    
    
    UIColor *level10 = [UIColor colorWithRed:0.515 green:0.271 blue:0.874 alpha:1.000];
    UIColor *level20 = [UIColor colorWithRed:0.631 green:0.264 blue:0.000 alpha:1.000];
    UIColor *level30 = [UIColor colorWithRed:0.914 green:0.770 blue:0.000 alpha:1.000];
    UIColor *level40 = [UIColor colorWithRed:0.076 green:0.770 blue:0.000 alpha:1.000];
    UIColor *level50 = [UIColor colorWithRed:0.737 green:0.322 blue:0.453 alpha:1.000];
    UIColor *level60 = [UIColor colorWithRed:0.000 green:0.322 blue:0.453 alpha:1.000];
    UIColor *level70 = [UIColor colorWithRed:1.000 green:0.009 blue:0.453 alpha:1.000];
    UIColor *level80 = [UIColor colorWithRed:0.278 green:0.009 blue:0.453 alpha:1.000];
    UIColor *level90 = [UIColor colorWithRed:1.000 green:0.258 blue:0.000 alpha:1.000];
    UIColor *level100 = [UIColor colorWithRed:0.283 green:0.587 blue:0.521 alpha:1.000];
    
    
   
    
    
    if (self.playerLevel >= 10 && self.playerLevel < 20) {

        [self.levelButton setBackgroundColor:level10];
    }else if (self.playerLevel >= 20 && self.playerLevel < 30) {
        [self.levelButton setBackgroundColor:level20];
    }else if (self.playerLevel >= 30 && self.playerLevel < 40) {
        [self.levelButton setBackgroundColor:level30];
    }else if (self.playerLevel >= 40 && self.playerLevel < 50) {
        [self.levelButton setBackgroundColor:level40];
    }else if (self.playerLevel >= 50 && self.playerLevel < 60) {
        [self.levelButton setBackgroundColor:level50];
    }else if (self.playerLevel >= 60 && self.playerLevel < 70) {
        [self.levelButton setBackgroundColor:level60];
    }else if (self.playerLevel >= 70 && self.playerLevel < 80) {
        [self.levelButton setBackgroundColor:level70];
    }else if (self.playerLevel >= 80 && self.playerLevel < 90) {
        [self.levelButton setBackgroundColor:level80];
    }else if (self.playerLevel >= 90 && self.playerLevel < 100) {
        [self.levelButton setBackgroundColor:level90];
    }else if (self.playerLevel >= 100 && self.playerLevel < 110) {
        [self.levelButton setBackgroundColor:level100];
    }else if (self.playerLevel >= 110 && self.playerLevel < 120) {
        [self.levelButton setBackgroundColor:level10];
    }else if (self.playerLevel >= 120 && self.playerLevel < 130) {
        [self.levelButton setBackgroundColor:level20];
    }else if (self.playerLevel >= 130 && self.playerLevel < 140) {
        [self.levelButton setBackgroundColor:level30];
    }else if (self.playerLevel >= 140 && self.playerLevel < 150) {
        [self.levelButton setBackgroundColor:level60];
    }
    
    
    
        
    
    self.currentScore = 0;
	
	if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[GameCenterManager alloc] init];
		[self.gameCenterManager setDelegate:self];
		
		
	} else {
		
		// The current device does not support Game Center.
        
	}
    
   
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
    
    
        
    
    
     

}



- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setBackgroundImage:nil];
    [self setImageAButton:nil];
    [self setImageBButton:nil];
    [self setImageCButton:nil];
    [self setImageDButton:nil];
    [self setImageEButton:nil];
    [self setImageFButton:nil];
    [self setTaglineTextbox:nil];
    [self setScoreLabel:nil];
    [self setActivity:nil];
    [self setQuickScoreShow:nil];
    [self setLevelButton:nil];
    [self setLevelLabel:nil];
    [self setQuickScoreShow:nil];
    [self setCommentLabel:nil];
    [self setHintButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






@end

