//
//  GiveVipCardView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardModel.h"

@protocol VipManageViewDelegate <NSObject>

- (void)didClickGiveCardButton;
- (void)didClickTableViewCell;
- (void)didClickTableViewCellWithModel:(VipCardVipListModel *)model;

@end

@interface VipManageView : UIView

@property (nonatomic, weak) id<VipManageViewDelegate> delegate;

- (id)init;

@end

//优惠卡cell
@interface VipManageViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userPhoneNumber;
@property (nonatomic, strong) UILabel *vipCardName;
@property (nonatomic, strong) UILabel *discount;

@property (nonatomic, strong) VipCardVipListModel *model; //数据

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

