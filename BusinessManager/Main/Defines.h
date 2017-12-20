//
//  Defines.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIColor+Hex.h"
#import "StringHelper.h"
#import "NSDateHelper.h"
#import "UnitMetiodManager.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "UIView+Utils.h"
#import "MallNetworkEngine.h"
#import "Host.h"
#import "OMGToast.h"
#import "UserInformation.h"
#import "BaseModel.h"
#import "BaseService.h"
#import "MallNetManager.h"
#import "SVProgressHUD.h"
#import "CloseliApiManager.h"

#define IOS_DEBUG
#ifdef IOS_DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)

#else
#define NSLog(...){}

#endif

#define MAINPAGEJSONDEBUGMODE NO

#define VERSIONCHOOSEH5TEST NO


//-----------APP--------------//
#define  BUNDLE_ID     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define  APP_VERSION   [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]
#define  BUILD_VERSION [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]
#define  SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
#define  MyWindow      (((AppDelegate *)[[UIApplication sharedApplication] delegate]).window)
#define  NavigationH 64

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 传jsonStr时，以这个值为键
#define KValue  @"dataArr"

//----------判断机型-------------//
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6sPlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//----------判断ios系统------------//
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

//----------带参数-----------------//
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HexColor(str)          [UIColor colorWithHexString:str]
#define HexAColor(str,float)   [UIColor colorWithHexString:str alpha:float]
#define CHENK_VALUE(value) [UnitMetiodManager exchangeTheReturnValueToString:value]

#define AccountInfo ([UserInformation shareUserInfo])


//----------------Key---Key--Key-------------//

#define BaiDuKey @"TFypRw4SdYzYArpTX3F6fnX5HG4V2jIP"

//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;



#endif /* Defines_h */