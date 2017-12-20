//
//  HZEditActivitiesVC.h
//  BusinessManager
//
//  Created by niuzs on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#import "WeiZhanBaseController.h"

typedef enum{
    FitPriceStatus,//装修报价
    MoreCaseStatus,// 更多案例
    ForYouNavStatus,// 为你导航
    UnderstandUsStatus // 了解我们
}menuStatu;


@class SearPartData;
@interface HZEditActivitiesVC : WeiZhanBaseController
@property (nonatomic, strong) SearPartData *dataSource;
@property (nonatomic, assign) menuStatu status;
@end
