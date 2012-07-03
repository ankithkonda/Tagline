//
//  StartPageCustomSegue.m
//  MatchMovie
//
//  Created by Ankith Konda on 3/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StartPageCustomSegue.h"

@implementation StartPageCustomSegue


- (void) perform {
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    [UIView transitionWithView:src.navigationController.view duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:^(BOOL completed){
                    
                       
                    }];
    
    
}


@end
