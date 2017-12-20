//
//  PrizeTypeView.h
//  BusinessManager
//
//  Created by The Only on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrizeTypeView : UIView
@property (strong, nonatomic) IBOutlet PrizeTypeView *presentView;// 奖品view
//
@property (weak, nonatomic) IBOutlet UIView *prizeTypeView;//奖品类型View
@property (weak, nonatomic) IBOutlet UITextField *prizeName;//奖品名称
@property (weak, nonatomic) IBOutlet UITextField *prizeCount;//奖品数量
@property (weak, nonatomic) IBOutlet UITextField *prizeNumber;//中奖次数
@property (weak, nonatomic) IBOutlet UITextField *prizeChance;//中奖概率

@property (weak, nonatomic) IBOutlet UILabel *prizeTypeLable;
@property (weak, nonatomic) IBOutlet UIButton *prizeType;//奖品类型btn
@property (strong, nonatomic) IBOutlet PrizeTypeView *chooseTypeView;// 选择奖品View

/**
 *  构造方法
 *
 *  @return 返回创建的视图
 */
+ (instancetype)loadCustomView;

/**
 *  构造方法，通过传入frame来设置view的大小
 *
 *  @param frame
 *
 *  @return
 */
+ (instancetype)loadCustomViewWithFrame:(CGRect)frame;
@end
