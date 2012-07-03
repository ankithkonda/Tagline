//
//  SimilarMovies.h
//  MatchMovie
//
//  Created by Ankith Konda on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TmdbApiClient.h"

@interface SimilarMovies : NSObject



+ (void)getSimilarMovies:(NSString *)movieID
                 Success:(void (^)(NSArray *similarMovies))gotMovies
                 failure:(void (^)(NSError *error))failure;




@end
