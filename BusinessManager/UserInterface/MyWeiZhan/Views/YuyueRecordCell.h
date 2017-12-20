//
//  YuyueRecordCell.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"
@interface YuyueRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *baoyangTime;
@property (weak, nonatomic) IBOutlet UILabel *yuyueType;
@property(nonatomic,strong)YueyueDataModel *model;
@end
