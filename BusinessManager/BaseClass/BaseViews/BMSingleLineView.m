//
//  BMSingleLineView.m
//  BusinessManager
//
//  Created by KL on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BMSingleLineView.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation BMSingleLineView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];

}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    /**
    *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    
    CGFloat pixelAdjustOffset = 0;
    if (((int)(SINGLE_LINE_WIDTH * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    if (self.bounds.size.width == 1) {

        [bezierPath moveToPoint:CGPointMake(rect.size.width - SINGLE_LINE_ADJUST_OFFSET, 0.0)];
        [bezierPath addLineToPoint:CGPointMake(rect.size.width - SINGLE_LINE_ADJUST_OFFSET, rect.size.height)];

    }else if (self.bounds.size.height == 1) {

        [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height - SINGLE_LINE_ADJUST_OFFSET)];
        [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - SINGLE_LINE_ADJUST_OFFSET)];

    }

//    [[UIColor colorWithHexString:@"#e5e5e5"] setStroke];
    if (self.lineColor) {
        [self.lineColor setStroke];
    }else {
        [[UIColor lightGrayColor] setStroke];
    }
    
    [bezierPath setLineWidth:SINGLE_LINE_WIDTH];
    [bezierPath stroke];
    
}

@end
