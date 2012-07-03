//
//  Genre.h
//  matchmoviebeta
//
//  Created by Ankith on 20/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSpecificValues.h"

@interface Genre : NSObject


+ (Genre *)sharedClient;

- (NSString *)getGenreNameFromID:(NSString *)genreID;

- (NSArray *)getAllGenreIDs;

- (NSString *)getGenreLevelKey:(NSString *)genreName;

- (NSString *)getGenreOfMovieID:(NSString *)movieID;

@end
