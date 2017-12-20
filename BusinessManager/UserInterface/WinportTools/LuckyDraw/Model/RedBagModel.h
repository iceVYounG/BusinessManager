//
//  RedBagModel.h
//  HelpDemo
//
//  Created by NCS on 11/8/16.
//  Copyright © 2016 NCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedBagModel : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic,strong)NSString *heightType;

//@property (nonatomic, strong) NSString *labelTitle1;

//@property (strong, nonatomic) UIButton *redTypeBtn;// 红包类型

@property (strong, nonatomic) NSString *redName;// 红包名
@property (strong, nonatomic) NSString *redNum;//红包个数
@property (strong, nonatomic) NSString *drawProbability;// 中奖概率
@property (strong, nonatomic) NSString *singleLmLum;// 中奖次数

@property (nonatomic ,copy)NSString *btnTitle;

@property (strong, nonatomic) NSString *singleAmount;// 单个红包金额

//@property (strong, nonatomic) UIButton *prizeDeleteBtn;// 删除单个活动奖品



@end