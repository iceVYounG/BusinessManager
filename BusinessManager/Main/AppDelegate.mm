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
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import "LoginVC.h"
#import "NewLoginVC.h"
#import "HZCaseDetailVC.h"

@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self settingMainWindow]; //主window
    
    [self settingBaiduMap]; //百度地图
    
    return YES;
}

-(void)settingMainWindow{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    __weak typeof(self) wSelf = self;
    
    NewLoginVC *newLoginVC=[[NewLoginVC  alloc]initWithNibName:@"NewLoginVC" bundle:nil];
    
    HomeController* homeVC = [[HomeController alloc]init];
    LoginVC* loginVC = [[LoginVC alloc]initWithBlock:^{
    
         wSelf.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    }];
    self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:newLoginVC];


}

-(void)settingBaiduMap{
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiDuKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application{

    [UserInformation saveUserInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    //进入后台时调用
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RESIGN_ACTIVE object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //从后台进入程序时调用
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_BECOME_ACTIVE object:nil];
}


@end
