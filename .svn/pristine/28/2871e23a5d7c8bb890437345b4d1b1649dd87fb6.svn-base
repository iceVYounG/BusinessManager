//
//  PrepaidSavingCardViewController.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#import "VipCardModel.h"

@protocol prepaidSavingCardVCDelegate <NSObject>

- (void)prepaidSavingCardVCRefreshTheBalance:(NSString *)balance;  //刷新上一页面的余额数据

@end

@interface PrepaidSavingCardViewController : BaseController

//@property (nonatomic, strong) VipCardVipUserDetailModel *model;
@property (nonatomic, strong) NSString *vipUserID;  //会员ID
@property (nonatomic, strong) NSString *balance;    //账户鱼儿

@property (nonatomic, weak) id<prepaidSavingCardVCDelegate> prepaidSavingDelegate;  //

@end
