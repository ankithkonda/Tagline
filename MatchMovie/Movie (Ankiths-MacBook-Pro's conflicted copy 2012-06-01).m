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


+(void)getRandMovieAtYear:(NSString *)year
         containingLetter:(NSString *)firstLetter
                   atPage:(NSString *)pageNumber
        withNoAdultMovies:(NSString *)includeAdult
            inTheLanguage:(NSString *)languageCode
            Success:(void (^)(Movie *movie))gotMovie
            failure:(void (^)(NSError *error))failure

{
    
        [[TmdbApiClient sharedClient] getMoviesByQueryAtYear:year
                                            containingLetter:firstLetter
                                                      atPage:pageNumber
                                           withNoAdultMovies:includeAdult
                                               inTheLanguage:languageCode
            Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                //NSLog(@"RESPONSE AT movie.m: %@", responseObject);
                NSLog(@"PRE A");
                
                if (![responseObject objectForKey:@"results"]) {
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie RESULTS FOR A MOVIE IS NIL" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                }
                NSArray *results = [[NSArray alloc] initWithArray:[responseObject objectForKey:@"results"]];
                //NSLog(@"RESPONSE AT movie.m: %@", results);
                NSLog(@"CLOSE TO A");
                NSMutableArray *moviesToChoose = [[NSMutableArray alloc] init];
                
                for (NSDictionary *movie in results) {
                    if ([[movie objectForKey:@"vote_count"] intValue] > 5) {
                        [moviesToChoose addObject:[movie objectForKey:@"id"]];
                    }
                }
                NSLog(@"A");
               
                NSLog(@"COUNT --------- :%d", [moviesToChoose count]);
               
                if ([moviesToChoose count] < 1) {
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH MOVIES TO CHOOSE BEING 0" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                }
                NSLog(@"B");
                int movieToChooseIndex = arc4random() % [moviesToChoose count];
                NSLog(@"C");
                NSString *randMovieID = [moviesToChoose objectAtIndex:movieToChooseIndex];
                //open user defaults
                NSLog(@"D");
                
                NSMutableArray *moviesWhichHaveBeenUsed = [[NSMutableArray alloc] init];
                
                NSLog(@"E");
                
                if([[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"] != nil) {
                    moviesWhichHaveBeenUsed = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUsed"]];
                    NSLog(@"F");
                    if ([moviesWhichHaveBeenUsed containsObject:randMovieID]) {
                        NSLog(@"G");
                        NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie" code:42 userInfo:nil];
                        failure(myInternalError);
                    }else {
                        NSLog(@"H");
                        //add it
                        [moviesWhichHaveBeenUsed addObject:randMovieID];
                        //push it to user defaults
                        [[NSUserDefaults standardUserDefaults] setObject:moviesWhichHaveBeenUsed forKey:@"moviesUsed"];
                    }
                    NSLog(@"I");
                }
                else {
                    NSLog(@"J");
                    NSMutableArray *movieWhichWasNowChosen = [[NSMutableArray alloc] initWithObjects:randMovieID, nil];
                    [[NSUserDefaults standardUserDefaults] setObject:movieWhichWasNowChosen forKey:@"moviesUsed"];
                   
                }
                NSLog(@"K");
                
                [[TmdbApiClient sharedClient] getMovieByID:randMovieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"L");
                    Movie *movie = [[Movie alloc] init];
                    movie.movieName = [responseObject objectForKey:@"original_title"];
                    movie.tagLine = [responseObject objectForKey:@"tagline"];
                    movie.movieID = [responseObject objectForKey:@"id"];
                    movie.posterPath = [responseObject objectForKey:@"poster_path"];
                    movie.voteCount = [[responseObject objectForKey:@"vote_count"] intValue];
                    movie.isAdult = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"adult"]];
                    NSLog(@"M");
                    NSLog(@"TAGLINE LENGTH:  %d", [movie.tagLine length]);
                    if ([movie.tagLine length] == 0) {
                        NSLog(@"N");
                        NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH MOVIE's TAGLINE: LENGTH IS 0" code:40 userInfo:nil];
                        failure(myInternalError);
                        return;
                    }
                    NSLog(@"O");
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





@end
