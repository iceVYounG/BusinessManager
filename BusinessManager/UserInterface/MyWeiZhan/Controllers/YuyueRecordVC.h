//
//  YuyueRecordVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

typedef enum : NSUInteger {
    allType=0 ,
    shijiaType,
    baoyangType
    
} yuyueType;


#import <UIKit/UIKit.h>
#import "WeiZhanBaseController.h"
@interface YuyueRecordVC : WeiZhanBaseController
@property (strong,nonatomic)NSString *templateNo;
@property (strong,nonatomic)NSString *modelNo;
@property (assign,nonatomic)NSInteger rightArrayNum;
@end