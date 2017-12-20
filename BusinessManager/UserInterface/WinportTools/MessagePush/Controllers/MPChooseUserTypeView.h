//
//  MPChooseUserTypeView.h
//  BusinessManager
//
//  Created by KL on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

typedef void(^ChooseTypeBlock)(NSString *userType, NSString *userNum);

typedef NS_ENUM(NSUInteger, chooseViewShowType) {
    AllUserShow = 0, //显示所有用户
    OnlyVipUserShow  //仅显示VIP用户
};

@class UserTypeTableCell;

@interface MPChooseUserTypeView : UIView<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (weak, nonatomic) IBOutlet UIView *backGDView;
@property (nonatomic, assign) BOOL isConnected; //是否联网

@property (copy, nonatomic) ChooseTypeBlock chooseTypeBlock;
@property (weak, nonatomic) IBOutlet UITableView *userTypetableView;

- (IBAction)quitBtnClick:(UIButton *)sender;
- (IBAction)confirmBtnClick:(UIButton *)sender;

@property (nonatomic, strong) NSMutableArray *dataArray;

//初始化方法

//- (instancetype)initWithFrame:(CGRect)frame block:(ChooseTypeBlock)block;
- (instancetype)initWithFrame:(CGRect)frame type:(chooseViewShowType)type WithBlock:(ChooseTypeBlock)block;

- (void)show; //显示

@end








@class VipCardLevelItemModel;

@interface UserTypeTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imgViewOK;
@property (nonatomic, strong) VipCardLevelItemModel *model;

@end
