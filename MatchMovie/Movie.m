//
//  Movie.m
//  MatchMovie
//
//  Created by Ankith Konda on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 
 RAND MOVIE: {
 adult = 0;
 "backdrop_path" = "/ZQixhAZx6fH1VNafFXsqa1B8QI.jpg";
 "belongs_to_collection" =     {
 "backdrop_path" = "/xCbb3hIID1AnEOBxPzsnBXG3n2h.jpg";
 id = 86311;
 name = "The Avengers Collection";
 "poster_path" = "/hiLkVTP34V24JtzOQ22r7Uu8eMc.jpg";
 };
 budget = 140000000;
 genres =     (
 {
 id = 28;
 name = Action;
 },
 {
 id = 12;
 name = Adventure;
 },
 {
 id = 878;
 name = "Science Fiction";
 },
 {
 id = 53;
 name = Thriller;
 }
 );
 homepage = "http://www.ironmanmovie.com/";
 id = 1726;
 "imdb_id" = tt0371746;
 "original_title" = "Iron Man";
 overview = "After escaping from kidnappers using makeshift power armor, an ultrarich inventor and weapons maker turns his creation into a force for good by using it to fight crime. But his skills are stretched to the limit when he must face the evil Iron Monger.";
 popularity = "24803.92";
 "poster_path" = "/848chlIWVT41VtAAgyh9bWymAYb.jpg";
 "production_companies" =     (
 {
 id = 4;
 name = "Paramount Pictures";
 },
 {
 id = 325;
 name = "Marvel Enterprises";
 },
 {
 id = 420;
 name = "Marvel Studios";
 }
 );
 "production_countries" =     (
 {
 "iso_3166_1" = US;
 name = "United States of America";
 }
 );
 "release_date" = "2008-05-02";
 revenue = 585174222;
 runtime = 126;
 "spoken_languages" =     (
 {
 "iso_639_1" = en;
 name = English;
 }
 );
 tagline = "Heroes aren't born. They're built.";
 title = "Iron Man";
 "vote_average" = "8.4";
 "vote_count" = 93;
 }
 
 
 */

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
                
                
                
                //NSLog(@"RESPONSE AT movie.m: %@", responseObject);
                
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
                
                NSLog(@"~~~~~~~~~~~~> %d", [moviesToChoose count]);
               
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
                    
                    NSLog(@"TAGLINE LENGTH:  %d", [movie.tagLine length]);
                    /*
                    if (movie.tagLine == (id)[NSNull null] || [movie.tagLine length] == 0 || movie.movieName == (id)[NSNull null] || [movie.movieName length] == 0 || movie.movieID == (id)[NSNull null] || [movie.movieID length] == 0  || movie.posterPath == (id)[NSNull null] || [movie.posterPath length] == 0  ||[responseObject objectForKey:@"vote_count"] == (id)[NSNull null] || movie.voteCount == 0  || movie.isAdult == (id)[NSNull null] || [movie.isAdult length] == 0  ) {
                        NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie MOVIE WHICH WAS RETRIEVED AT MOVIE.M IS HAS NULL RESPONSES OR 0 LENGTH (EMPTY) RESPONSES" code:40 userInfo:nil];
                        failure(myInternalError);
                        return;
                    }
                     */
                    
                    
                    gotMovie(movie);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"ERROR AT getMovieByID in Movie.m");
                    failure(error);
                }];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"ERROR AT getMoviesByQuery in Movie.m");
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
            
            //NSLog(@"RESPONSE AT movie.m: %@", responseObject);
            
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
            
            NSLog(@"~~~~~~~~~~~~> %d", [moviesToChoose count]);
            
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
                 NSLog(@"9090090909090909090990");
                moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
                if ([moviesWhichHaveBeenUsed containsObject:randMovieID]) {
                    
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie: MOVIE HAD ALREADY BEEN USED" code:42 userInfo:nil];
                    NSLog(@"MOVIE ID WHICH HAS BEEN USED: %@", randMovieID);
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
            NSLog(@"101010101010101010101010101");
            
            [[TmdbApiClient sharedClient] getMovieByID:randMovieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                NSLog(@"_______: %@", [[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]]);
                
                
                Movie *movie = [[Movie alloc] init];
                movie.movieName = [responseObject objectForKey:@"original_title"];
                movie.tagLine = [responseObject objectForKey:@"tagline"];
                movie.movieID = [responseObject objectForKey:@"id"];
                movie.posterPath = [responseObject objectForKey:@"poster_path"];
                movie.voteCount = [[responseObject objectForKey:@"vote_count"] intValue];
                movie.isAdult = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"adult"]];
                movie.genre = [[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]];
                movie.genreID = [[Genre sharedClient] getGenreNameFromID:[[Genre sharedClient] getGenreOfMovieID:[responseObject objectForKey:@"id"]]];
                
                NSLog(@"TAGLINE LENGTH:  %d", [movie.tagLine length]);
                /*
                 if (movie.tagLine == (id)[NSNull null] || [movie.tagLine length] == 0 || movie.movieName == (id)[NSNull null] || [movie.movieName length] == 0 || movie.movieID == (id)[NSNull null] || [movie.movieID length] == 0  || movie.posterPath == (id)[NSNull null] || [movie.posterPath length] == 0  ||[responseObject objectForKey:@"vote_count"] == (id)[NSNull null] || movie.voteCount == 0  || movie.isAdult == (id)[NSNull null] || [movie.isAdult length] == 0  ) {
                 NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie MOVIE WHICH WAS RETRIEVED AT MOVIE.M IS HAS NULL RESPONSES OR 0 LENGTH (EMPTY) RESPONSES" code:40 userInfo:nil];
                 failure(myInternalError);
                 return;
                 }
                 */
                
                NSLog(@"MOVIE **** : %@", movie.movieName);
                
                gotMovie(movie);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"ERROR AT getMovieByID in Movie.m");
                failure(error);
            }];
                                               
                                               
                                               
    
                                               
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR AT getMoviesByQuery in Movie.m");
        failure(error);
    }];
    


}


+ (void)getMovieByMovieID:(NSString *)movieID
                  Success:(void (^)(Movie *movie))gotMovie
                  failure:(void (^)(NSError *error))failure{

    NSMutableArray *moviesWhichHaveBeenUsed = [[NSMutableArray alloc] init];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"] != nil) {
        NSLog(@"9090090909090909090990");
        moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
        if ([moviesWhichHaveBeenUsed containsObject:movieID]) {
            
            NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie: MOVIE HAD ALREADY BEEN USED" code:42 userInfo:nil];
            NSLog(@"MOVIE ID WHICH HAS BEEN USED: %@", movieID);
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
        
        NSLog(@"TAGLINE LENGTH:  %d", [movie.tagLine length]);
       
        /*
         if (movie.tagLine == (id)[NSNull null] || [movie.tagLine length] == 0 || movie.movieName == (id)[NSNull null] || [movie.movieName length] == 0 || movie.movieID == (id)[NSNull null] || [movie.movieID length] == 0  || movie.posterPath == (id)[NSNull null] || [movie.posterPath length] == 0  ||[responseObject objectForKey:@"vote_count"] == (id)[NSNull null] || movie.voteCount == 0  || movie.isAdult == (id)[NSNull null] || [movie.isAdult length] == 0  ) {
         NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie MOVIE WHICH WAS RETRIEVED AT MOVIE.M IS HAS NULL RESPONSES OR 0 LENGTH (EMPTY) RESPONSES" code:40 userInfo:nil];
         failure(myInternalError);
         return;
         }
         */
        
        
        gotMovie(movie);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR AT getMovieByID in Movie.m");
        failure(error);
    }];



}





@end
