//
//  Genre.m
//  matchmoviebeta
//
//  Created by Ankith on 20/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Genre.h"


@implementation Genre

+ (Genre *)sharedClient{

    static Genre *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Genre alloc] init];
    });
    
    return _sharedClient;

}

- (NSString *)getGenreLevelKey:(NSString *)genreName{

    return [NSString stringWithFormat:@"%@_level", genreName];

}

- (NSArray *)getAllGenreIDs{


    NSMutableArray *gIDs = [[NSMutableArray alloc] init];
    
    
    [gIDs addObject:G_All];
    [gIDs addObject:G_Action];
    [gIDs addObject:G_Adventure];
    [gIDs addObject:G_Animation];
    [gIDs addObject:G_Comedy];
    [gIDs addObject:G_Crime];
    [gIDs addObject:G_Drama];
    [gIDs addObject:G_Family];
    [gIDs addObject:G_Fantasy];
    [gIDs addObject:G_History];
    [gIDs addObject:G_Horror];
    [gIDs addObject:G_Indie];
    [gIDs addObject:G_Mystery];
    [gIDs addObject:G_Romance];
    [gIDs addObject:G_ScienceFiction];
    [gIDs addObject:G_Suspense];
    [gIDs addObject:G_Thriller];
    [gIDs addObject:G_War];
    [gIDs addObject:G_Western];
    
    
    NSArray *idsToReturn = [[NSArray alloc] initWithArray:gIDs];

    return idsToReturn;
}

- (NSString *)getGenreNameFromID:(NSString *)genreID{

    if (genreID == G_All) {
        return @"All";
    }else if (genreID == G_Action) {
        return @"Action";
    }else if (genreID == G_Adventure) {
        return @"Adventure";
    }else if (genreID == G_Animation) {
        return @"Animation";
    }else if (genreID == G_Comedy) {
        return @"Comedy";
    }else if (genreID == G_Crime) {
        return @"Crime";
    }else if (genreID == G_Drama) {
        return @"Drama";
    }else if (genreID == G_Family) {
        return @"Family";
    }else if (genreID == G_Fantasy) {
        return @"Fantasy";
    }else if (genreID == G_History) {
        return @"History";
    }else if (genreID == G_Horror) {
        return @"Horror";
    }else if (genreID == G_Indie) {
        return @"Indie";
    }else if (genreID == G_Mystery) {
        return @"Mystery";
    }else if (genreID == G_Romance) {
        return @"Romance";
    }else if (genreID == G_ScienceFiction) {
        return @"ScienceFiction";
    }else if (genreID == G_Suspense) {
        return @"Suspense";
    }else if (genreID == G_Thriller) {
        return @"Thriller";
    }else if (genreID == G_War) {
        return @"War";
    }else if (genreID == G_Western) {
        return @"Western";
    }  
    
    
    return @"All";

}


- (NSString *)getGenreOfMovieID:(NSString *)movieID{

    

    NSArray *moviesInApp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"movies"] ];
    
    for (NSDictionary *movie in moviesInApp) {
        
        if ([[movie objectForKey:@"tmdb_id"] intValue] == [movieID intValue]) {
            NSLog(@"GENRE ID FROM GENRE.m : %@", [movie objectForKey:@"genre_id"]);
            return [movie objectForKey:@"genre_id"];
        }
        
    }
    
    return @"unknown";
}


@end
