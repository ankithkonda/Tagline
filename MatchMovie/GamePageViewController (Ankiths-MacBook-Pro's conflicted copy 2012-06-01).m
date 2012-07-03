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

//#define IMAGE_URL_PATH @"http://cf2.imgobject.com/t/p/w92" 
//Small Image


#define IMAGE_URL_PATH @"http://cf2.imgobject.com/t/p/w185" 
//Large Image

@interface GamePageViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldA;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldB;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldC;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldD;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldE;
@property (strong, nonatomic) IBOutlet UIImageView *imageFieldF;
@property (strong, nonatomic) IBOutlet UILabel *loadingLabelTest;
@property (strong, nonatomic) IBOutlet UILabel *roundNumberLabelTest;
@property (strong, nonatomic) IBOutlet UILabel *resultCommentTest;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (strong, nonatomic) IBOutlet UILabel *correctLabel;

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







@property (strong, nonatomic) NSString *correctImage;


@end

@implementation GamePageViewController

@synthesize imageArray;
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

- (void)pressedCorrectImage{

    int currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    currentScore += 50;
    [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"score"];
    [scoreLabel setText:[NSString stringWithFormat:@"%d", currentScore]];
    
    [self isLoading:YES];
    
    [resultCommentTest setHidden:NO];
    UIColor *correctColor = [[UIColor alloc] initWithRed:0 green:0.7 blue:0 alpha:1];
    resultCommentTest.text = @"Correct!";
    [resultCommentTest setTextColor:correctColor];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];
    
    [imageAButton setEnabled:NO];
    [imageBButton setEnabled:NO];
    [imageCButton setEnabled:NO];
    [imageDButton setEnabled:NO];
    [imageEButton setEnabled:NO];
    [imageFButton setEnabled:NO];
   // [self startGame];


}


- (void)pressedIncorrectImage{
    
    UIColor *wrongColor = [[UIColor alloc] initWithRed:127 green:0 blue:0 alpha:1];
    NSLog(@"I touched the wrong image");
    [resultCommentTest setHidden:NO];
    resultCommentTest.text = @"Wrong!... Try Again";
    [resultCommentTest setTextColor:wrongColor];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];

}
-(void)hideLabel{

    [self.resultCommentTest setHidden:YES];

}
- (IBAction)imageAButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageA"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
       
        [self pressedIncorrectImage];
        
    }
}
- (IBAction)imageBButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageB"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
}

- (IBAction)imageCButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageC"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
    
}
- (IBAction)imageDButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageD"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}
- (IBAction)imageEButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageE"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}
- (IBAction)imageFButton:(UIButton *)sender {
    
    if ([correctImage isEqualToString:@"imageF"]) {
        
        [self pressedCorrectImage];
        
        
    }else {
        
        [self pressedIncorrectImage];
        
    }
    
}

- (IBAction)backPressed {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)isLoading:(BOOL)loading {
    if(loading) {
        [activity startAnimating];
        [activity setAlpha:1.0];
    } else {
        [activity stopAnimating];
        [activity setAlpha:0.0];
    }
}

-(void)startScoreSystem{

    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"score"];

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


- (void)loadMovies{


    NSString *randomYear = [NSString stringWithFormat:@"%d", (1990 + arc4random()% 22)];
    NSString *randomPage = [NSString stringWithFormat:@"%d", (arc4random()% 3)];
    NSString *randomLetter = [@"abcdefghijklmnopqrstuvwxyz" substringWithRange:NSMakeRange((arc4random() % 26), 1)];
    NSLog(@"Year:%@    Letter:%@    page:%@", randomYear, randomLetter, randomPage);
    
    [Movie getRandMovieAtYear:randomYear containingLetter:randomLetter atPage:randomPage withNoAdultMovies:@"false" inTheLanguage:@"en" Success:^(Movie *movie) {
        
        
        [SimilarMovies getSimilarMovies:movie.movieID Success:^(NSArray *similarMovies) {
            
            
            
            
            
            
            
            
            NSLog(@"Movie ID: %@", movie.movieID);
            NSLog(@"Movie Name: %@", movie.movieName);
            NSLog(@"Movie TagLine: %@", movie.tagLine);
            NSLog(@"Movie Poster Path: %@", movie.posterPath);
            for (NSString *similarPoster in similarMovies) {
                 NSLog(@"Similar Movies: %@", similarPoster);
            }
           
            
            [self loadMovies];
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD, The failure occured when using GetSimilarMovies method in the SimilarMovie class, this was called within the getRandMovieAtYear method: %@", error);
            [self loadMovies];
            return;
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"ERROR AT GAME PAGE VIEW CONTROLLER IN THE LOAD MOVIES METHOD, The failure occured when using getRandMovieAtYear method in the Movie class: %@", error);
        [self loadMovies];
        return;
    }];
    

    
   













}


- (void)viewDidAppear:(BOOL)animated{
//adultID - 39573
//iron man - 1726
    
    [self loadMovies]; 
    NSLog(@"G");
    [self startScoreSystem];
    NSLog(@"MOVIES TO USE IN VIEW DID APPEAR: %d", self.moviesToUseInView.count);
   
    

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end


/*
 
 
 
 
 - (void)startNextGame{
 
 [self clearImages];
 [self isLoading:YES];
 UIColor *loadingColor = [[UIColor alloc] initWithRed:0 green:0 blue:1.16 alpha:1];
 [self.loadingLabelTest setText:@"Loading... Please wait"];
 [self.loadingLabelTest setTextColor:loadingColor];
 
 if (self.moviesToUseNext.count == 6) {
 
 [self startGameToggleIs:1];
 [self loadThirdSet];
 
 }else if(moviesToUseAfterNext.count == 6){
 
 [self startGameToggleIs:2];
 [self loadSecondSet]; 
 
 }else {
 [self loadMovies];
 }
 
 }
 
 
 - (IBAction)imageAButton:(UIButton *)sender {
 
 //[resultCommentTest setText:@""];
 if ([correctImage isEqualToString:@"imageA"]) {
 NSLog(@"Correct");
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 [self startNextGame];
 
 }
 
 
 }
 - (IBAction)imageBButton:(UIButton *)sender {
 //[resultCommentTest setText:@""];
 if ([correctImage isEqualToString:@"imageB"]) {
 NSLog(@"Correct");
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 [self startNextGame];
 
 }
 
 }
 
 - (IBAction)imageCButton:(UIButton *)sender {
 //[resultCommentTest setText:@""];
 if ([correctImage isEqualToString:@"imageC"]) {
 NSLog(@"Correct");
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 [self startNextGame];
 
 }
 
 
 
 }
 - (IBAction)imageDButton:(UIButton *)sender {
 //[resultCommentTest setText:@""];
 if ([correctImage isEqualToString:@"imageD"]) {
 NSLog(@"Correct");
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 [self startNextGame];
 
 }
 
 
 }
 - (IBAction)imageEButton:(UIButton *)sender {
 //[resultCommentTest setText:@""];
 if ([correctImage isEqualToString:@"imageE"]) {
 NSLog(@"Correct");
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 [self startNextGame];
 
 }
 
 
 }
 - (IBAction)imageFButton:(UIButton *)sender {
 //[resultCommentTest setText:@""];
 
 if ([correctImage isEqualToString:@"imageF"]) {
 
 [self clearImages];
 [self isLoading:YES];
 [resultCommentTest setText:@"Correct !!"];
 NSLog(@"Correct");
 [self startNextGame];
 
 }
 
 }
 
 
 - (void)startGameToggleIs:(int)toggle{
 [self.taglineTextbox setText:self.taglineToUse];
 
 
 [self.loadingLabelTest setText:@""];
 [resultCommentTest setText:@""];
 int static round = 0;
 round++;
 
 [self.roundNumberLabelTest setText:[NSString stringWithFormat:@"%d",round]];
 
 NSLog(@"GAME HAS STARTED");
 NSLog(@"TOGGLE: %d", toggle);
 
 
 
 if (toggle == 0) {
 
 
 if ([self.moviesToUseInView count] != 6) {
 [self loadMovies]; NSLog(@"H");
 return;
 }
 
 NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageFieldA, self.imageFieldB, self.imageFieldC, self.imageFieldD, self.imageFieldE, self.imageFieldF, nil];
 for (int i = 0; i < 6; i++) {
 
 //rand between 0 - 6
 NSLog(@"MOVIES TO USE IN VIEW LENGTH: %d", [self.moviesToUseInView count]);
 //if ([self.moviesToUseInView count] < 0) 
 
 int randomImageIndex = arc4random() % [self.moviesToUseInView count];
 
 NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://cf2.imgobject.com/t/p/w92%@",[self.moviesToUseInView objectAtIndex:randomImageIndex]]];
 
 NSLog(@"URL : %@", imageURL);
 NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
 UIImage *image = [UIImage imageWithData:imageData];
 
 NSLog(@"%d", randomImageIndex);
 if ([self.correctURL isEqualToString:[self.moviesToUseInView objectAtIndex:randomImageIndex]]) {
 if (i == 0) {
 correctImage = [[NSString alloc]initWithString:@"imageA"];
 }else if (i == 1) {
 correctImage = [[NSString alloc]initWithString:@"imageB"];
 }else if (i == 2) {
 correctImage = [[NSString alloc]initWithString:@"imageC"];
 }else if (i == 3) {
 correctImage = [[NSString alloc]initWithString:@"imageD"];
 }else if (i == 4) {
 correctImage = [[NSString alloc]initWithString:@"imageE"];
 }else if (i == 5) {
 correctImage = [[NSString alloc]initWithString:@"imageF"];
 }
 }
 
 NSLog(@"%d", randomImageIndex);
 [(UIImageView *)[imageFieldArray objectAtIndex:i] setImage:image];
 [self.moviesToUseInView removeObjectAtIndex:randomImageIndex];
 
 
 
 }
 [self isLoading:NO];
 //[self.resultCommentTest setText:@""];
 
 }else if (toggle == 1) {
 
 
 NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageFieldA, self.imageFieldB, self.imageFieldC, self.imageFieldD, self.imageFieldE, self.imageFieldF, nil];
 for (int i = 0; i < 6; i++) {
 
 //rand between 0 - 6
 NSLog(@"MOVIES TO USE IN VIEW LENGTH: %d", [self.moviesToUseNext count]);
 //if ([self.moviesToUseInView count] < 0) 
 
 int randomImageIndex = arc4random() % [self.moviesToUseNext count];
 
 NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://cf2.imgobject.com/t/p/w92%@",[self.moviesToUseNext objectAtIndex:randomImageIndex]]];
 
 NSLog(@"URL : %@", imageURL);
 NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
 UIImage *image = [UIImage imageWithData:imageData];
 
 NSLog(@"%d", randomImageIndex);
 if ([self.correctURL isEqualToString:[self.moviesToUseNext objectAtIndex:randomImageIndex]]) {
 if (i == 0) {
 correctImage = [[NSString alloc]initWithString:@"imageA"];
 }else if (i == 1) {
 correctImage = [[NSString alloc]initWithString:@"imageB"];
 }else if (i == 2) {
 correctImage = [[NSString alloc]initWithString:@"imageC"];
 }else if (i == 3) {
 correctImage = [[NSString alloc]initWithString:@"imageD"];
 }else if (i == 4) {
 correctImage = [[NSString alloc]initWithString:@"imageE"];
 }else if (i == 5) {
 correctImage = [[NSString alloc]initWithString:@"imageF"];
 }
 }
 
 NSLog(@"%d", randomImageIndex);
 [(UIImageView *)[imageFieldArray objectAtIndex:i] setImage:image];
 [self.moviesToUseNext removeObjectAtIndex:randomImageIndex];
 
 
 
 }
 [self isLoading:NO];
 //[self.resultCommentTest setText:@""];
 
 
 } else if (toggle == 2) {
 NSMutableArray *imageFieldArray = [[NSMutableArray alloc] initWithObjects:self.imageFieldA, self.imageFieldB, self.imageFieldC, self.imageFieldD, self.imageFieldE, self.imageFieldF, nil];
 for (int i = 0; i < 6; i++) {
 
 //rand between 0 - 6
 NSLog(@"MOVIES TO USE IN VIEW LENGTH: %d", [self.moviesToUseAfterNext count]);
 //if ([self.moviesToUseInView count] < 0) 
 
 int randomImageIndex = arc4random() % [self.moviesToUseAfterNext count];
 
 NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://cf2.imgobject.com/t/p/w92%@",[self.moviesToUseAfterNext objectAtIndex:randomImageIndex]]];
 
 NSLog(@"URL : %@", imageURL);
 NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
 UIImage *image = [UIImage imageWithData:imageData];
 
 NSLog(@"%d", randomImageIndex);
 if ([self.correctURL isEqualToString:[self.moviesToUseAfterNext objectAtIndex:randomImageIndex]]) {
 if (i == 0) {
 correctImage = [[NSString alloc]initWithString:@"imageA"];
 }else if (i == 1) {
 correctImage = [[NSString alloc]initWithString:@"imageB"];
 }else if (i == 2) {
 correctImage = [[NSString alloc]initWithString:@"imageC"];
 }else if (i == 3) {
 correctImage = [[NSString alloc]initWithString:@"imageD"];
 }else if (i == 4) {
 correctImage = [[NSString alloc]initWithString:@"imageE"];
 }else if (i == 5) {
 correctImage = [[NSString alloc]initWithString:@"imageF"];
 }
 }
 
 NSLog(@"%d", randomImageIndex);
 [(UIImageView *)[imageFieldArray objectAtIndex:i] setImage:image];
 [self.moviesToUseAfterNext removeObjectAtIndex:randomImageIndex];
 
 
 
 }
 [self isLoading:NO];
 //[self.resultCommentTest setText:@""];
 }
 
 
 
 
 
 
 
 }
 
 
 

 
 - (void)loadSecondSet{
 
 
 NSString *randomYear = [NSString stringWithFormat:@"%d", (1990 + arc4random()% 22)];
 NSString *randomPage = [NSString stringWithFormat:@"%d", (arc4random()% 3)];
 NSString *randomLetter = [@"abcdefghijklmnopqrstuvwxyz" substringWithRange:NSMakeRange((arc4random() % 26), 1)];
 NSLog(@"SECOND SET: Year:%@    Letter:%@    page:%@", randomYear, randomLetter, randomPage);
 
 
 
 [Movie getRandMovieAtYear:randomYear
 containingLetter:randomLetter 
 atPage:randomPage
 withNoAdultMovies:@"false"
 inTheLanguage:@"en" 
 Success:^(Movie *movie) {
 
 if ([movie.posterPath length] == 0 || [movie.tagLine isEqualToString:@"No one has entered a tagline."]) {
 [self loadSecondSet]; NSLog(@"lh");
 return;
 }else{
 NSLog(@"SUCCESS AT VIEW DID APPEAR: %@",movie.movieName);
 NSLog(@"Movie ID: %@", movie.movieID);
 
 NSLog(@"Movie Poster: %@", movie.posterPath);
 NSLog(@"Movie Vote Count: %d", movie.voteCount);
 NSLog(@"Movie Tag Line: %@", movie.tagLine);
 NSLog(@"Movie is Adult: %@", movie.isAdult);
 // NSLog(@"User Default moviesUsed: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]);
 
 [[TmdbApiClient sharedClient] getSimilarMoviesofMovieID:movie.movieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSArray *similars = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
 NSMutableArray *similarsToUse = [[NSMutableArray alloc] init];
 
 for (NSDictionary *similarMovie in similars) {
 NSLog(@"SIMILAR MOVIE OBJECT FOR KEY :%@", [similarMovie objectForKey:@"vote_count"]);
 if ([similarMovie objectForKey:@"vote_count"] != nil) {
 if ([[similarMovie objectForKey:@"vote_count"] intValue] > 1) {
 [similarsToUse addObject:[similarMovie objectForKey:@"poster_path"] ];
 }
 }else {
 [self loadSecondSet]; NSLog(@"li"); 
 return;
 }
 }
 //NSLog(@"SIMILAR MOVIES POSTER PATHS: %@", similarsToUse);
 self.moviesToUseNext = [[NSMutableArray alloc] init];
 if ([similarsToUse count] >= 5) {
 [self.moviesToUseNext addObject:movie.posterPath];
 //NSLog(@"POSTER PATH TO USE:%d", [movie.tagLine length]);
 if([movie.tagLine length] == 0){
 
 [self loadSecondSet]; NSLog(@"lj"); 
 return;
 }else {
 self.taglineToUse = [[NSString alloc] initWithString:movie.tagLine];
 
 for (int i = 0; i < 5; i++) {
 [self.moviesToUseNext addObject:[similarsToUse objectAtIndex:i]];
 }
 //NSLog(@"all poster paths with the first path being the correct movie:%@", self.moviesToUseInView);
 }
 
 correctURL = [[NSString alloc]initWithString:movie.posterPath];
 NSLog(@"_____________I LOADED THE SECOND SET ______________");
 self.arrayToggleNumber = 1;
 
 
 
 
 }else {
 [self loadSecondSet]; NSLog(@"lk"); 
 return;
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 [self loadSecondSet]; NSLog(@"ll"); 
 return;
 }];
 }
 } failure:^(NSError *error) {
 NSLog(@"ERROR AT loadMovies in GamePageViewController.m: %@", error);
 [self loadSecondSet]; NSLog(@"lm"); 
 return;
 }];
 
 
 
 
 }
 
 - (void)loadThirdSet{
 
 
 NSString *randomYear = [NSString stringWithFormat:@"%d", (1990 + arc4random()% 22)];
 NSString *randomPage = [NSString stringWithFormat:@"%d", (arc4random()% 3)];
 NSString *randomLetter = [@"abcdefghijklmnopqrstuvwxyz" substringWithRange:NSMakeRange((arc4random() % 26), 1)];
 NSLog(@"THIRD SET: Year:%@    Letter:%@    page:%@", randomYear, randomLetter, randomPage);
 
 
 
 [Movie getRandMovieAtYear:randomYear
 containingLetter:randomLetter 
 atPage:randomPage
 withNoAdultMovies:@"false"
 inTheLanguage:@"en" 
 Success:^(Movie *movie) {
 
 if ([movie.posterPath length] == 0 || [movie.tagLine isEqualToString:@"No one has entered a tagline."]) {
 [self loadThirdSet];
 return;
 }else{
 NSLog(@"SUCCESS AT VIEW DID APPEAR: %@",movie.movieName);
 NSLog(@"Movie ID: %@", movie.movieID);
 
 NSLog(@"Movie Poster: %@", movie.posterPath);
 NSLog(@"Movie Vote Count: %d", movie.voteCount);
 NSLog(@"Movie Tag Line: %@", movie.tagLine);
 NSLog(@"Movie is Adult: %@", movie.isAdult);
 //NSLog(@"User Default moviesUsed: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]);
 
 [[TmdbApiClient sharedClient] getSimilarMoviesofMovieID:movie.movieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSArray *similars = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
 NSMutableArray *similarsToUse = [[NSMutableArray alloc] init];
 
 for (NSDictionary *similarMovie in similars) {
 NSLog(@"SIMILAR MOVIE OBJECT FOR KEY :%@", [similarMovie objectForKey:@"vote_count"]);
 
 if ([similarMovie objectForKey:@"vote_count"] != nil) {
 if ([[similarMovie objectForKey:@"vote_count"] intValue] > 1) {
 [similarsToUse addObject:[similarMovie objectForKey:@"poster_path"] ];
 }
 }else {
 [self loadThirdSet]; 
 return;
 }
 }
 //NSLog(@"SIMILAR MOVIES POSTER PATHS: %@", similarsToUse);
 self.moviesToUseAfterNext = [[NSMutableArray alloc] init];
 if ([similarsToUse count] >= 5) {
 [self.moviesToUseAfterNext addObject:movie.posterPath];
 //NSLog(@"POSTER PATH TO USE:%d", [movie.tagLine length]);
 if([movie.tagLine length] == 0){
 
 [self loadThirdSet]; 
 return;
 }else {
 self.taglineToUse = [[NSString alloc] initWithString:movie.tagLine];
 
 for (int i = 0; i < 5; i++) {
 [self.moviesToUseAfterNext addObject:[similarsToUse objectAtIndex:i]];
 }
 //NSLog(@"all poster paths with the first path being the correct movie:%@", self.moviesToUseInView);
 }
 
 correctURL = [[NSString alloc]initWithString:movie.posterPath];
 NSLog(@"_____________I LOADED THE THIRD SET ______________");
 self.arrayToggleNumber = 1;
 
 
 
 }else {
 [self loadThirdSet]; 
 return;
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 [self loadThirdSet]; 
 return;
 }];
 }
 } failure:^(NSError *error) {
 NSLog(@"ERROR AT loadMovies in GamePageViewController.m: %@", error);
 [self loadThirdSet]; 
 return;
 }];
 
 
 
 
 }
 
 
 
 - (void)loadMovies{
 
 
 
 static int blah = 0;
 blah++;
 NSString *randomYear = [NSString stringWithFormat:@"%d", (1990 + arc4random()% 22)];
 NSString *randomPage = [NSString stringWithFormat:@"%d", (arc4random()% 3)];
 NSString *randomLetter = [@"abcdefghijklmnopqrstuvwxyz" substringWithRange:NSMakeRange((arc4random() % 26), 1)];
 NSLog(@"Year:%@    Letter:%@    page:%@", randomYear, randomLetter, randomPage);
 
 
 
 [Movie getRandMovieAtYear:randomYear
 containingLetter:randomLetter 
 atPage:randomPage
 withNoAdultMovies:@"false"
 inTheLanguage:@"en" 
 Success:^(Movie *movie) {
 
 if ([movie.posterPath length] == 0 || [movie.tagLine isEqualToString:@"No one has entered a tagline."]) {
 [self loadMovies]; NSLog(@"A");
 return;
 }else{
 NSLog(@"SUCCESS AT VIEW DID APPEAR: %@",movie.movieName);
 NSLog(@"Movie ID: %@", movie.movieID);
 
 NSLog(@"Movie Poster: %@", movie.posterPath);
 NSLog(@"Movie Vote Count: %d", movie.voteCount);
 NSLog(@"Movie Tag Line: %@", movie.tagLine);
 NSLog(@"Movie is Adult: %@", movie.isAdult);
 //NSLog(@"User Default moviesUsed: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]);
 
 [[TmdbApiClient sharedClient] getSimilarMoviesofMovieID:movie.movieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSArray *similars = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
 NSMutableArray *similarsToUse = [[NSMutableArray alloc] init];
 
 for (NSDictionary *similarMovie in similars) {
 NSLog(@"SIMILAR MOVIE OBJECT FOR KEY :%@", [similarMovie objectForKey:@"vote_count"]);
 
 if ([similarMovie objectForKey:@"vote_count"] != nil) {
 if ([[similarMovie objectForKey:@"vote_count"] intValue] > 1) {
 [similarsToUse addObject:[similarMovie objectForKey:@"poster_path"] ];
 }
 }else {
 [self loadMovies]; NSLog(@"B"); 
 return;
 }
 }
 NSLog(@"SIMILAR MOVIES POSTER PATHS: %@", similarsToUse);
 self.moviesToUseInView = [[NSMutableArray alloc] init];
 if ([similarsToUse count] >= 5) {
 [self.moviesToUseInView addObject:movie.posterPath];
 NSLog(@"POSTER PATH TO USE:%d", [movie.tagLine length]);
 if([movie.tagLine length] == 0){
 
 [self loadMovies]; NSLog(@"C"); 
 return;
 }else {
 //[taglineTextbox setText:movie.tagLine];
 self.taglineToUse = [[NSString alloc] initWithString:movie.tagLine];
 
 for (int i = 0; i < 5; i++) {
 [self.moviesToUseInView addObject:[similarsToUse objectAtIndex:i]];
 }
 NSLog(@"all poster paths with the first path being the correct movie:%@", self.moviesToUseInView);
 }
 
 correctURL = [[NSString alloc]initWithString:movie.posterPath];
 NSLog(@"_____________I LOADED THE FIRST SET ______________");
 self.arrayToggleNumber = 0;
 [self startGameToggleIs:0];
 [self loadSecondSet]; NSLog(@"la");
 
 }else {
 [self loadMovies]; NSLog(@"D"); 
 return;
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 [self loadMovies]; NSLog(@"E"); 
 return;
 }];
 }
 } failure:^(NSError *error) {
 NSLog(@"ERROR AT loadMovies in GamePageViewController.m: %@", error);
 [self loadMovies]; NSLog(@"F"); 
 return;
 }];
 
 
 
 }
 */
