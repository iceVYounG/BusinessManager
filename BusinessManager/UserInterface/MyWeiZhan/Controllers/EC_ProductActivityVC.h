//
//  EC_ProductActivityVC.h
//  BusinessManager
//
//  Created by 王启明 on 16/8/17.
//  Copyright © 2016年 cmcc. All rights reserved.
//
typedef enum{
    FourButtonStatus,
   
    
}buttonStatus;

typedef enum{
    FoodMenusStatus,//菜单
    AboutStatus,// 关于我们
    ActivityStatus,// 活动信息
    WeiNDHStatus // 为您导航
}menuStatus;



#import "WeiZhanBaseController.h"
@class SearPartData;
@interface EC_ProductActivityVC : WeiZhanBaseController
@property (nonatomic, strong) SearPartData *dataSource;
@property (nonatomic, assign) buttonStatus status;
@end

