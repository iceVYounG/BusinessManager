//
//  EaditDrawActivityVC.h
//  BusinessManager
//
//  Created by The Only on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#import "LuckDrawModel.h"
@interface EaditDrawActivityVC : BaseController
@property (weak, nonatomic) IBOutlet UITableView *presentInfoTableView;

@property (weak, nonatomic) IBOutlet UIView *activityInfoView;// 活动信息View
@property (weak, nonatomic) IBOutlet UILabel *myAvtivityLable;//我的活动
@property (weak, nonatomic) IBOutlet UILabel *startTimeLable;//活动开始时间
@property (weak, nonatomic) IBOutlet UILabel *endTimeLable;//活动结束时间
@property (weak, nonatomic) IBOutlet UILabel *redValidFate;//电子券红包有效天数
@property (weak, nonatomic) IBOutlet UIButton *takeACtivityPeopleBtn;// 可参与活动的用户
@property (weak, nonatomic) IBOutlet UITextField *redNum;

@property (weak, nonatomic) IBOutlet UILabel *presentInfoLable;//奖品信息
@property (strong,nonatomic) avtivityListItem *acItemModel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTableViewHeight;
- (IBAction)saveAndDeleteActivityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteActivityBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollerViewHeight;

 
@property (weak, nonatomic) IBOutlet UIButton *continuePrizeBtn;// 继续添加奖品
@property (weak, nonatomic) IBOutlet UIView *continueAddPrizeView;
//- (IBAction)continueAddPrizeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIView *presentInfoView;


@end
