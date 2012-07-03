//
//  TmdbApiClient.h
//  MatchMovie
//
//  Created by Ankith Konda on 18/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONUtilities.h"
#import "AFJSONRequestOperation.h"

#define kApiBase @"http://api.themoviedb.org/"

@class AFHTTPRequestOperation;




@interface TmdbApiClient : AFHTTPClient


+ (TmdbApiClient *)sharedClient;

- (void)getSimilarMoviesofMovieID:(NSString *)movieID
                          Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success    
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getMovieByID:(NSString *)movieID
             Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success    
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getMoviesByQueryAtYear:(NSString *)year
              containingLetter:(NSString *)firstLetter
                        atPage:(NSString *)pageNumber
             withAdultMovies:(NSString *)includeAdult
                 inTheLanguage:(NSString *)languageCode
                 Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getMoviesByGenre:(NSString *)genre
                        atPage:(NSString *)pageNumber
                 inTheLanguage:(NSString *)languageCode
                       Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

