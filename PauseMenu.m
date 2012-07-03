//
//  PauseMenu.m
//  matchmoviebeta
//
//  Created by Ankith Konda on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseMenu.h"

@implementation PauseMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 50.0, 50.0); //start point
    CGContextAddLineToPoint(context, 250.0, 100.0);
    CGContextAddLineToPoint(context, 250.0, 350.0);
    CGContextAddLineToPoint(context, 50.0, 350.0); // end path
    
    CGContextClosePath(context); // close path
    
    CGContextSetLineWidth(context, 8.0); // this is set from now on until you explicitly change it
    
    CGContextStrokePath(context); // do actual stroking
    
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
    CGContextFillRect(context, CGRectMake(20.0, 250.0, 128.0, 128.0)); // a square at the bottom left-hand corner

}


@end
