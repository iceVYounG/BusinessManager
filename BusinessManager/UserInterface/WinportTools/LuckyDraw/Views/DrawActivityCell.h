//
//  DrawActivityCell.h
//  BusinessManager
//
//  Created by The Only on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLable;//活动编号
@property (weak, nonatomic) IBOutlet UILabel *activityName;// 活动名称
@property (weak, nonatomic) IBOutlet UILabel *startActivityTimeLable;// 活动开始时间
@property (weak, nonatomic) IBOutlet UILabel *endActivityTimeLable;// 活动结束时间
@property (weak, nonatomic) IBOutlet UIButton *jianTouImage;

@end
