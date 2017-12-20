//
//  ChooseVipLevelView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardModel.h"

@protocol ChooseVipLevelViewDelegate <NSObject>

- (void)didClickCardLevel:(NSString *)str;
- (void)chooseVipCardWithModel:(VipCardListModel *)listModel;

@end

@interface ChooseVipLevelView : UIView

@property (nonatomic, weak) id<ChooseVipLevelViewDelegate> delegate;

- (id)initWithVipLevelNameArray:(NSArray *)array btnName:(NSString *)btnName;
- (id)initWithVipLevelNameArray:(NSArray *)array btnName:(NSString *)btnName title:(NSString *)title;

@end

@interface ChooseVipLevelTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *cardLevel;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) VipCardListModel *model;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chooseBtnName:(NSString *)btnName;


@end