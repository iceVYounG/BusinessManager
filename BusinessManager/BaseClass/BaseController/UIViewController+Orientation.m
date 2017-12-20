//
//  UIViewController+Orientation.m
//  CMCCMall
//
//  Created by 朱青 on 16/9/14.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "UIViewController+Orientation.h"

@implementation UIViewController (Orientation)

//支持旋转
-(BOOL)shouldAutorotate{
    return NO;
}

//支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
