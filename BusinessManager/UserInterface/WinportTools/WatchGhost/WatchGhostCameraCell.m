//
//  WatchGhostCameraCell.m
//  BusinessManager
//
//  Created by KL on 16/7/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WatchGhostCameraCell.h"

@implementation WatchGhostCameraCell

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)chooseCaremaToView:(UIGestureRecognizer *)touch {
    NSInteger tag = touch.view.tag;
    NSLog(@">>>>>>>>>>tag:%ld", tag);
    WS(weakSelf);
    
    if (self.chooseMonitorToView) {
        self.chooseMonitorToView(tag, weakSelf.section);
    }
    
}

- (void)layoutSubviews {
    self.cameraScrollView.contentSize = CGSizeMake(self.count * cameraViewWidth, 0);
    
    for (int i = 0; i < self.count; i++) {
        CGRect rect = CGRectMake(i * cameraViewWidth, 5, cameraViewWidth, cameraViewHight);
        WatchGhostCameraView *view = [[WatchGhostCameraView alloc] initWithFrame:rect];
        view.frame = rect;
        view.backgroundColor = [UIColor greenColor];
        view.tag = 2000 + i;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCaremaToView:)];
        [view addGestureRecognizer:tapped];
        [self.cameraScrollView addSubview:view];
    }
    
}

@end
