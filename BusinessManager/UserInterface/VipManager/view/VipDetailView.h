//
//  VipDetailView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardModel.h"

typedef void(^RefreshUI)(VipCardVipUserDetailModel * model);

@protocol VipDetailViewDelegate <NSObject>

- (void)didClickPrepaidButton;
- (void)didClickDeleteButton;

@end

@protocol VipDetailViewDataSource <NSObject>

- (VipCardVipUserDetailModel *)vipDetailSetUpViews;

@end

typedef NS_ENUM(NSInteger,VipCard){
    VipCardSaving,
    VipCardCoupon
};

@interface VipDetailView : UIScrollView

@property (nonatomic, weak) id<VipDetailViewDelegate> viewDelegate;
@property (nonatomic, weak) id<VipDetailViewDataSource> viewDataSource;

@property (nonatomic, copy) RefreshUI refreshUIData;
@property (nonatomic, strong) VipCardVipUserDetailModel *model;

@property (nonatomic, strong) UIView *backgroundView;   //背景View

@property (nonatomic, strong) NSString *balance;  //余额，用于下页面代理刷新此页面的余额值

- (id)initWithType:(VipCard)type;
//----------add by Huzy ------------//
- (instancetype)initWithType:(VipCard)type andModel:(VipCardVipListModel *)model;

@end
