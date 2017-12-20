//
//  WatchGhostCameraView.m
//  BusinessManager
//
//  Created by KL on 16/7/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WatchGhostCameraView.h"

@implementation WatchGhostCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WatchGhostCameraView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

@end
