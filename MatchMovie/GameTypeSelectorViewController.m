//
//  GameTypeSelectorViewController.m
//  matchmoviebeta
//
//  Created by Ankith Konda on 18/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTypeSelectorViewController.h"



@interface GameTypeSelectorViewController ()

@end

@implementation GameTypeSelectorViewController
@synthesize dramaLevelLabel;
@synthesize animationLevelLabel;
@synthesize actionLevelLabel;
@synthesize westernLevelLabel;
@synthesize scienceFictionLevelLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadLevelLabels{

    NSDictionary *playerLevels = [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"playerLevels" ]];
    
    NSArray *allIDs = [[Genre sharedClient] getAllGenreIDs];
    
    for (id key in playerLevels) {
        
        for (id genreID in allIDs) {
            
            
        }
       
    }
    
    


}


- (void)startSegue{
    
   // [self.navigationController pushViewController:[GamePageViewController] animated:YES];

    [self performSegueWithIdentifier:@"goToGame" sender:self];
    
}

- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)DramaButton:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_Drama forKey:D_GenreKey];
    [self startSegue];
    
    
}

- (IBAction)animationButton:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_Animation forKey:D_GenreKey];
    [self startSegue];
}

- (IBAction)actionButton:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_Action forKey:D_GenreKey];
    [self startSegue];
}
- (IBAction)westernButton:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_Indie forKey:D_GenreKey];
    [self startSegue];
    
    
}

- (IBAction)scienceFiction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_War forKey:D_GenreKey];
    [self startSegue];
    
}



- (IBAction)freeForAllButton:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:G_All forKey:D_GenreKey];
    [self startSegue];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setDramaLevelLabel:nil];
    [self setAnimationLevelLabel:nil];
    [self setActionLevelLabel:nil];
    [self setWesternLevelLabel:nil];
    [self setScienceFictionLevelLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
