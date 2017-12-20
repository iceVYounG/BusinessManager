//
//  LineView.m
//  Pet
//
//  Created by 朱青 on 15/8/10.
//  Copyright (c) 2015年 c-platform. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
}

- (void)drawRect:(CGRect)rect
{
//    self.backgroundColor = [UIColor colorWithHexString:@"dddddd"];

    // Draw bottom line
    //划线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    if (self.frame.size.width == 1) {
        
        
        if (self.frame.origin.x == 0) {
            
            [bezierPath moveToPoint:CGPointMake(0.2, 0.0)];
            [bezierPath addLineToPoint:CGPointMake(0.2, rect.size.height)];
            
            
        }
        else{
            [bezierPath moveToPoint:CGPointMake(rect.size.width - 0.2, 0.0)];
            [bezierPath addLineToPoint:CGPointMake(rect.size.width - 0.2, rect.size.height)];
        }
        
        
    }
    else if (self.frame.size.height == 1){
    
        if (self.frame.origin.y == 0) {
        
            [bezierPath moveToPoint:CGPointMake(0.0, 0.2)];
            [bezierPath addLineToPoint:CGPointMake(rect.size.width, 0.2)];
            
            
        }
        else{
      
            [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height - 0.2)];
            [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 0.2)];

        }
        
    }
    [[UIColor lightGrayColor] setStroke];
    [bezierPath setLineWidth:0.2];
    [bezierPath stroke];

}


@end
