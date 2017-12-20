//
//  BaseService.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseService.h"

@interface BaseService ()
{
    
}
@end
@implementation BaseService

+ (instancetype)sharedManager{
    static BaseService *baseManager = nil;
    if (baseManager == nil) {
        baseManager = [[self allocWithZone:nil] init];
    }
    return baseManager;
}

+(UIViewController *)getCurrectController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}


NSString* NoNullStr(NSString *normalStr,NSString *placeHodelStr){
    
    if ([normalStr isKindOfClass:[NSNull class]] || normalStr.length == 0 || [normalStr isEqualToString:@"(null)"]) {
        return placeHodelStr;
    }
    return normalStr;
}

@end
