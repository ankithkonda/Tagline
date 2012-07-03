//
//  SimilarMovies.m
//  MatchMovie
//
//  Created by Ankith Konda on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimilarMovies.h"

@implementation SimilarMovies



+ (void)getSimilarMovies:(NSString *)movieID
                      Success:(void (^)(NSArray *similarMovies))gotMovies
                      failure:(void (^)(NSError *error))failure{
    
   
    
    
    [[TmdbApiClient sharedClient] getSimilarMoviesofMovieID:movieID Success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSMutableArray *similars = [[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"results"]];
        NSMutableArray *similarsToPrune = [[NSMutableArray alloc]init];
        NSMutableArray *similarsToUse = [[NSMutableArray alloc]init];
        
        //check for NULL, empty response or incorrect response
        if ([similars count] < 5) {
            NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH GETTING SIMILAR MOVIES, Didn;t get enough" code:40 userInfo:nil];
            failure(myInternalError);
            return;
        }
        
        for (NSDictionary *movie in similars) {
            if (movie) {
                if ([movie objectForKey:@"vote_count"] == nil || [movie objectForKey:@"poster_path"] == nil) {
                    NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH GETTING SIMILAR MOVIES, vote count or poster than are null" code:40 userInfo:nil];
                    failure(myInternalError);
                    return;
                }
                
                
                if([[movie objectForKey:@"vote_count"] intValue] > 1){
                    
                    [similarsToPrune addObject:[movie objectForKey:@"poster_path"]];
                    
                }
            }else {
                NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH GETTING SIMILAR MOVIES, THE SIMILAR MOVIE WAS NULL" code:40 userInfo:nil];
                failure(myInternalError);
                return;
            }
            
            
            
        }
        
        
        if([similarsToPrune count] >= 5){
            
            for (int i=0; i<5; i++) {
                [similarsToUse addObject:[similarsToPrune objectAtIndex:i]];
            }
        
        }else {
            
            NSError *myInternalError = [[NSError alloc] initWithDomain:@"com.ankithkonda.matchmovie ERROR WITH GETTING SIMILAR MOVIES Not enough similar movies" code:40 userInfo:nil];
            failure(myInternalError);
            return;
            
        }
        
        NSArray *similarsToSend = [[NSArray alloc] initWithArray:similarsToUse];
        gotMovies(similarsToSend);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"ERROR AT SimilarMovies.m");
        failure(error);
        
        
    }];
    
    
    
}


@end
