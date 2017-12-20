//
//  AddDrawCell.h
//  BusinessManager
//
//  Created by The Only on 16/8/12.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedBagModel.h"

@class AddDrawCell;
@protocol AddDrawCellDelegate <NSObject>
-(void)choosePresentTypeOfAddDrawCell:(AddDrawCell *)cell;
-(void)addDrawCell:(AddDrawCell *)myCell prizeNameTF:(UITextField *)PName prizeCountTF:(UITextField *)PCount prizeNumberTF:(UITextField *)PNumber prizeChance:(UITextField *)PChance prizeMoney:(UITextField *)PMoney type:(NSInteger)PType;
@end

@interface AddDrawCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *prizeTypeView;//奖品类型View
@property (weak, nonatomic) IBOutlet UITextField *prizeNameTF;//奖品名称
@property (weak, nonatomic) IBOutlet UITextField *prizeCount;//奖品数量
@property (weak, nonatomic) IBOutlet UITextField *prizeNumber;//中奖次数
@property (weak, nonatomic) IBOutlet UITextField *prizeChance;//中奖概率
@property (weak, nonatomic) IBOutlet UITextField *prizeSingeMoneyTF;//单个奖品金额
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightInfoPrestent;
 
@property (weak, nonatomic) IBOutlet UIButton *redBagBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *singleMoneyHeight;
@property (weak, nonatomic) IBOutlet UIView *singleMoneyLineView;
 

@property(nonatomic,strong)RedBagModel *model;

@property(nonatomic,weak)id<AddDrawCellDelegate>delegate;

/** btn title*/
@property (nonatomic ,copy)NSString *btnTitle;


@end
