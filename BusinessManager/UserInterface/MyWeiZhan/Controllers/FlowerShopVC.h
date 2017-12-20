//
//  FlowerShopVC.h
//  BusinessManager
//
//  Created by 王启明 on 16/9/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
typedef enum{
    BannerPictureStatus,//banner图
    shopInfoStatus,//店铺信息编辑
    hotStatus,//轮播编辑
    FlowerShopHongBaoStatus,//活动
    floorStatus, //楼层
} FlowerShopStatus;

@interface FlowerShopVC : WeiZhanBaseController
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *titleStr;

@end