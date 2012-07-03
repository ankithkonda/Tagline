//
//  TmdbApiClient.m
//  MatchMovie
//
//  Created by Ankith Konda on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TmdbApiClient.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AppSpecificValues.h"


static NSString * const tmdbBaseURLString = @"http://api.themoviedb.org/";



@implementation TmdbApiClient




+ (TmdbApiClient *)sharedClient {
    static TmdbApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TmdbApiClient alloc] initWithBaseURL:[NSURL URLWithString:tmdbBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}




- (void)getSimilarMoviesofMovieID:(NSString *)movieID
                          Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success    
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *apiPath = [NSString stringWithFormat:@"3/movie/%@/similar_movies?api_key=%@", movieID, TMDB_API_KEY];
    NSLog(@"%@",apiPath);
    
    
    [self getPath:apiPath parameters:nil success:success failure:failure];
    
   // NSLog(@"getSimilarMovie!");
    
    
}

- (void)getMovieByID:(NSString *)movieID
             Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success    
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *apiPath = [NSString stringWithFormat:@"3/movie/%@?api_key=%@", movieID, TMDB_API_KEY];
    [self getPath:apiPath parameters:nil success:success failure:failure];
    
    //NSLog(@"getMovie!");
    
    
}


//http://api.themoviedb.org/3/search/movie?api_key=302be0711f8a7ba1e5851b08f1d3b23e&query=b+2011&page=1&include_adult=false&language=en

- (void)getMoviesByQueryAtYear:(NSString *)year
              containingLetter:(NSString *)firstLetter
                        atPage:(NSString *)pageNumber
             withAdultMovies:(NSString *)includeAdult
                 inTheLanguage:(NSString *)languageCode
                 Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{

        NSString *apiPath = [NSString stringWithFormat:@"3/search/movie?api_key=%@&query=%@+%@&page=%@&include_adult=%@&language=%@", TMDB_API_KEY, firstLetter, year, pageNumber, includeAdult, languageCode];
        [self getPath:apiPath parameters:nil success:success failure:failure];


}


- (void)getMoviesByGenre:(NSString *)genre
                  atPage:(NSString *)pageNumber
           inTheLanguage:(NSString *)languageCode
                 Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    
    NSString *apiPath = [NSString stringWithFormat:@"3/genre/%@/movies?api_key=%@&page=%@&language=%@", genre, TMDB_API_KEY, pageNumber, languageCode];
    
    NSLog(@"apiPath: %@", apiPath);
    [self getPath:apiPath parameters:nil success:success failure:failure];


}





@end
