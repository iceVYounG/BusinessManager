//
//  BuyNotesTableViewCell.h
//  BusinessManager
//
//  Created by 周迎春 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgPushModel.h"
@interface BuyNotesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLB;
@property (weak, nonatomic) IBOutlet UILabel *goodsContentLB;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLB;

@property (nonatomic, strong) MsgBuyNotesModel *model;

@property (nonatomic, strong) NSDateFormatter *inputFormat;
@property (nonatomic, strong) NSDateFormatter *outputFormat;

@end
