//
//  E_Commerce.h
//  BusinessManager
//
//  Created by 王启明 on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

typedef enum {

    BannerStatus,//店铺名称
    MenuStatus,//菜单编辑
    LunBoStatus,//轮播编辑
    HongBaoStatus,//活动
    LouYStatus, //楼层一
    LouEStatus//楼层二

}EC_commerceStatue;


#define KSpace 3
#define KShopNameCellHeight 117
#define KBtnCellHeight KScreenWidth/4.0
#define KImageCellHeight 139
#define KProductorCellHeight 169
@interface E_Commerce : WeiZhanBaseController

@end


@interface BannerModel1 : BaseModel

@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, strong) UIImage *image;

@end