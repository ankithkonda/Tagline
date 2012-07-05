//
//  Movie.m
//  MatchMovie
//
//  Created by Ankith Konda on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"





@implementation Movie

@synthesize movieName;
@synthesize tagLine;
@synthesize movieID;
@synthesize posterPath;
@synthesize voteCount;
@synthesize isAdult;
@synthesize genre;
@synthesize genreID;





+(void)getRandMovieAtYear:(NSString *)year
         containingLetter:(NSString *)firstLetter
                   atPage:(NSString *)pageNumber
        withAdultMovies:(NSString *)includeAdult
            inTheLanguage:(NSString *)languageCode
            Success:(void (^)(Movie *movie))gotMovie
            failure:(void (^)(NSError *error))failure

{

    
        [[TmdbApiClient sharedClient] getMoviesByQueryAtYear:year
                                            containingLetter:firstLetter
                                                      atPage:pageNumber
                                           withAdultMovies:includeAdult
                                               inTheLanguage:languageCode
            Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                //check to see if there are already ids to use, if yes then use it, else do the following
                
                
                
                
                if ([responseObject objectForKey:@"results"] == (id)[NSNull null] || [[responseObject objectForKey:@"results"] count] == 0 ) {
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie RESPONSE FOR GET MOVIE BY QUERY IS EITHER NULL OR IT RETURNED AN EMPTY RESPONSE" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                }
                
                NSArray *resultsFromResponse = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
                NSMutableArray *moviesToChoose = [[NSMutableArray alloc] init];
                
                for (NSDictionary *movie in resultsFromResponse) {
                    if ([movie objectForKey:@"vote_count"] == (id)[NSNull null] ) {
                        
                        NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie VOTE COUNT EITHER NULL OR IT RETURNED AN EMPTY RESPONSE" code:40 userInfo:nil];
                        failure(myInternalError);
                        return;
                        
                        
                    }else {
                        if ([[movie objectForKey:@"vote_count"] intValue] > 3) {
                            [moviesToChoose addObject:[movie objectForKey:@"id"]];
                        }
                    }
                }
                
                
                
                
                
                
                if ([moviesToChoose count] < 1) {
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie NO MOVIES TO CHOOSE FROM" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                }
                
               
                int movieToChooseIndex = arc4random() % [moviesToChoose count];
                
                NSString *randMovieID = [moviesToChoose objectAtIndex:movieToChooseIndex];
                //open user defaults
                
                
                
                
                
                
                
                NSMutableArray *moviesWhichHaveBeenUsed = [[NSMutableArray alloc] init];
                
                
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"] != nil) {
                    moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
                    if ([moviesWhichHaveBeenUsed containsObject:randMovieID]) {
                        
                        NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie" code:42 userInfo:nil];
                        failure(myInternalError);
                        return;
                    }else {
                        //add it
                        [moviesWhichHaveBeenUsed addObject:randMovieID];
                        //push it to user defaults
                        [[NSUserDefaults standardUserDefaults] setObject:moviesWhichHaveBeenUsed forKey:@"moviesUsed"];
                    }
                    
                }
                else {
                    
                    NSMutableArray *movieWhichWasNowChosen = [[NSMutableArray alloc] initWithObjects:randMovieID, nil];
                    [[NSUserDefaults standardUserDefaults] setObject:movieWhichWasNowChosen forKey:@"moviesUsed"];
                   
                }
                
                
                [[TmdbApiClient sharedClient] getMovieByID:randMovieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    Movie *movie = [[Movie alloc] init];
                    movie.movieName = [responseObject objectForKey:@"original_title"];
                    movie.tagLine = [responseObject objectForKey:@"tagline"];
                    movie.movieID = [responseObject objectForKey:@"id"];
                    movie.posterPath = [responseObject objectForKey:@"poster_path"];
                    movie.voteCount = [[responseObject objectForKey:@"vote_count"] intValue];
                    movie.isAdult = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"adult"]];
                    
                    
                    
                    gotMovie(movie);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    failure(error);
                }];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
        
        
   
   
    

}



+ (void)getRandMovieByGenre:(NSString *)genre
                     atPage:(NSString *)pageNumber
              inTheLanguage:(NSString *)languageCode
                    Success:(void (^)(Movie *movie))gotMovie
                    failure:(void (^)(NSError *error))failure

{


    
    
    [[TmdbApiClient sharedClient] getMoviesByGenre:genre 
                                            atPage:pageNumber 
                                     inTheLanguage:languageCode 
        Success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            if ([responseObject objectForKey:@"results"] == (id)[NSNull null] || [[responseObject objectForKey:@"results"] count] == 0 ) {
                NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie RESPONSE FOR GET MOVIE BY QUERY IS EITHER NULL OR IT RETURNED AN EMPTY RESPONSE" code:40 userInfo:nil];
                failure(myInternalError);
                return;
            }
            
            
            
            NSArray *resultsFromResponse = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
            NSMutableArray *moviesToChoose = [[NSMutableArray alloc] init];
            
            for (NSDictionary *movie in resultsFromResponse) {
                if ([movie objectForKey:@"vote_count"] == (id)[NSNull null] ) {
                    
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie VOTE COUNT EITHER NULL OR IT RETURNED AN EMPTY RESPONSE" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                    
                    
                }else {
                    if ([[movie objectForKey:@"vote_count"] intValue] > 3) {
                        [moviesToChoose addObject:[movie objectForKey:@"id"]];
                    }
                }
            }
            
            if ([moviesToChoose count] < 1) {
                NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie NO MOVIES TO CHOOSE FROM" code:40 userInfo:nil];
                failure(myInternalError);
                return;
            }
            
            
            int movieToChooseIndex = arc4random_uniform([moviesToChoose count]);
            //int movieToChooseIndex = arc4random() % [moviesToChoose count];
            
            NSString *randMovieID = [moviesToChoose objectAtIndex:movieToChooseIndex];
            //open user defaults
            
            [moviesToChoose removeObjectAtIndex:movieToChooseIndex];
            
            
            
            for (NSString *mID in moviesToChoose) {
                
                
                
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:moviesToChoose forKey:[NSString stringWithFormat:@"%@IDs",D_GenreKey]];
            
            NSMutableArray *moviesWhichHaveBeenUsed = [[NSMutableArray alloc] init];
            
            
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"] != nil) {
                moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
                if ([moviesWhichHaveBeenUsed containsObject:randMovieID]) {
                    
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie: MOVIE HAD ALREADY BEEN USED" code:42 userInfo:nil];
                    failure(myInternalError);
                    return;
                }else {
                    //add it
                    [moviesWhichHaveBeenUsed addObject:randMovieID];
                    //push it to user defaults
                    [[NSUserDefaults standardUserDefaults] setObject:moviesWhichHaveBeenUsed forKey:@"moviesUsed"];
                }
                
            }
            else {
                 
                
                NSMutableArray *movieWhichWasNowChosen = [[NSMutableArray alloc] initWithObjects:randMovieID, nil];
                [[NSUserDefaults standardUserDefaults] setObject:movieWhichWasNowChosen forKey:@"moviesUsed"];
                
            }
            
            [[TmdbApiClient sharedClient] getMovieByID:randMovieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                
                
                
                Movie *movie = [[Movie alloc] init];
                movie.movieName = [responseObject objectForKey:@"original_title"];
                movie.tagLine = [responseObject objectForKey:@"tagline"];
                movie.movieID = [responseObject objectForKey:@"id"];
                movie.posterPath = [responseObject objectForKey:@"poster_path"];
                movie.voteCount = [[responseObject objectForKey:@"vote_count"] intValue];
                movie.isAdult = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"adult"]];
                movie.genre = [[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]];
                movie.genreID = [[Genre sharedClient] getGenreNameFromID:[[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]]];
                
               
                
                gotMovie(movie);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
                                               
                                               
                                               
    
                                               
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    


}


+ (void)getMovieByMovieID:(NSString *)movieID
                  Success:(void (^)(Movie *movie))gotMovie
                  failure:(void (^)(NSError *error))failure{

    NSMutableArray *moviesWhichHaveBeenUsed = [[NSMutableArray alloc] init];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"] != nil) {
        moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
        if ([moviesWhichHaveBeenUsed containsObject:movieID]) {
            
            NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie: MOVIE HAD ALREADY BEEN USED" code:42 userInfo:nil];
            failure(myInternalError);
            return;
        }else {
            //add it
            [moviesWhichHaveBeenUsed addObject:movieID];
            //push it to user defaults
            [[NSUserDefaults standardUserDefaults] setObject:moviesWhichHaveBeenUsed forKey:@"moviesUsed"];
        }
        
    }
    else {
        
        
        NSMutableArray *movieWhichWasNowChosen = [[NSMutableArray alloc] initWithObjects:movieID, nil];
        [[NSUserDefaults standardUserDefaults] setObject:movieWhichWasNowChosen forKey:@"moviesUsed"];
        
    }

    [[TmdbApiClient sharedClient] getMovieByID:movieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        Movie *movie = [[Movie alloc] init];
        movie.movieName = [responseObject objectForKey:@"original_title"];
        movie.tagLine = [responseObject objectForKey:@"tagline"];
        movie.movieID = [responseObject objectForKey:@"id"];
        movie.posterPath = [responseObject objectForKey:@"poster_path"];
        movie.voteCount = [[responseObject objectForKey:@"vote_count"] intValue];
        movie.isAdult = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"adult"]];
        movie.genreID = [[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]];
        movie.genre = [[Genre sharedClient] getGenreNameFromID:[[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]]];
        
       
        
        
        gotMovie(movie);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];



}





@end
