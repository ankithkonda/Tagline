//
//  Movie.h
//  MatchMovie
//
//  Created by Ankith Konda on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TmdbApiClient.h"
#import "GamePageViewController.h"
#import "Genre.h"

@interface Movie : NSObject
@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *tagLine;
@property (nonatomic, strong) NSString *movieID;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic) int voteCount;
@property (nonatomic, strong) NSString *isAdult;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *genreID;


+(void)getRandMovieAtYear:(NSString *)year
         containingLetter:(NSString *)firstLetter
                   atPage:(NSString *)pageNumber
        withAdultMovies:(NSString *)includeAdult
            inTheLanguage:(NSString *)languageCode
                  Success:(void (^)(Movie *movie))gotMovie
                  failure:(void (^)(NSError *error))failure;

+ (void)getRandMovieByGenre:(NSString *)genre
                  atPage:(NSString *)pageNumber
           inTheLanguage:(NSString *)languageCode
                 Success:(void (^)(Movie *movie))gotMovie
                 failure:(void (^)(NSError *error))failure;

+ (void)getMovieByMovieID:(NSString *)movieID
                    Success:(void (^)(Movie *movie))gotMovie
                    failure:(void (^)(NSError *error))failure;

@end
