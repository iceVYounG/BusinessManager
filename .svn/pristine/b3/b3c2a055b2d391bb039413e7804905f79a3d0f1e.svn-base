//
//  HomeMapController.m
//  酒司令
//
//  Created by Developer on 16/1/18.
//  Copyright © 2016年 ZJH. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
  
//在子类化的视图中用self.viewController直接找到所在的viewController
    
  //响应者能够响应三种事件：触摸、动作感应、远程控制
  //UIView\UIViewController\UIApplication\AppDelegate ---- UIResponder
  
  //UIControl 三种事件模式：触摸、值改变、编辑
  //UIbutton\UISlider\UITextField\UITextView\UISwitch\UIRefreshControl
  
    //通过响应者链关系，取得此视图的下一个响应者
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    
    return nil;
}

@end
