//
//  Comments.h
//  matchmovieprerelease
//
//  Created by Ankith Konda on 2/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject


+ (Comments *)sharedClient;

- (NSString *)getGoodComment;

- (NSString *)getBadComment;


@end
