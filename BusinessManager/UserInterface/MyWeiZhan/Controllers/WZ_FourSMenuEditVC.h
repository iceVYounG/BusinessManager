//
//  WZ_FourSMenuEditVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//


typedef enum{
    DiaoChaStatus,//调查问卷
    YuyueSJStatus,//预约试驾
    YuyueBYStatus,//预约保养
    FourWNDHStatus,//为你导航
        
}FoursMenuStaus;


#import <UIKit/UIKit.h>
@class SearPartData;
#import "WeiZhanBaseController.h"

@interface WZ_FourSMenuEditVC : WeiZhanBaseController
@property (nonatomic, strong) SearPartData *dataSource;

@end
















