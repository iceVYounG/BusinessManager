//
//  AppDelegate.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[[HomeController alloc]init]];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{

    [UserInformation saveUserInfo];
}




@end
