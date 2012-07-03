//
//  Comments.m
//  matchmovieprerelease
//
//  Created by Ankith Konda on 2/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Comments.h"

@implementation Comments


+ (Comments *)sharedClient {
    static Comments *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Comments alloc] init];
    });
    
    return _sharedClient;
}

- (NSString *)getGoodComment{

    NSMutableArray *commentsArray = [[NSMutableArray alloc] init];
    
    [commentsArray addObject:@"Nice!"];
    [commentsArray addObject:@"Well Done!"];
    [commentsArray addObject:@"You go guy/girl!"];
    [commentsArray addObject:@"You deserve a medal!"];
    [commentsArray addObject:@"Great Scott!! you go it right."];
    [commentsArray addObject:@"Woah, you're on a roll, i think"];
    [commentsArray addObject:@"Okay i think you're awesome"];
    [commentsArray addObject:@"Good job!"];
    [commentsArray addObject:@"Excellent!"];
    [commentsArray addObject:@"Booya!"];
    [commentsArray addObject:@"phew! i though you were going to get that wrong!"];
    
    
    int randIndex = arc4random() % [commentsArray count];
    
    
    return [commentsArray objectAtIndex:randIndex];
}

- (NSString *)getBadComment{

    NSMutableArray *commentsArray = [[NSMutableArray alloc] init];
    
    [commentsArray addObject:@"c'mon you can do better!"];
    [commentsArray addObject:@"I thought you were my hero!"];
    [commentsArray addObject:@"you need to stop failing"];
    [commentsArray addObject:@"Advice: stop getting it wrong!"];
    [commentsArray addObject:@"Not-So-Great Scott!! ."];
    [commentsArray addObject:@"What is this, a round for losers?"];
    [commentsArray addObject:@"Okay stop, think first!"];
    [commentsArray addObject:@"Bad.. very Bad"];
    [commentsArray addObject:@"I vote you off the island"];
    [commentsArray addObject:@"Can someone get this guy some movies?"];
    [commentsArray addObject:@"I knew you were not smart enough to get that right"];
    [commentsArray addObject:@"Even my cat is smart enough for this!"];
    [commentsArray addObject:@"No offence, but you're really bad at this"];


    
    
    int randIndex = arc4random() % [commentsArray count];
    
    return [commentsArray objectAtIndex:randIndex];
}


@end
