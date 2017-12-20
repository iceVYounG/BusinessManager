//
//  LuckDrawModel.h
//  BusinessManager
//
//  Created by The Only on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuckDrawModel : BaseModel


@end

// 抽奖活动列表
@interface activityListModel :BaseModel

@property (nonatomic,strong)NSArray *data;

@end

@interface avtivityListItem : BaseModel

@property(nonatomic,strong)NSString *createTime;// 创建时间
@property(nonatomic,strong)NSString *endTime;// 结束时间
@property(nonatomic,strong)NSString *ID;// 活动ID
@property(nonatomic,strong)NSString *joinUsers;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *memberType;
@property(nonatomic,strong)NSString *outActivityId;
@property(nonatomic,strong)NSString *startTime;// 开始时间
@property(nonatomic,strong)NSString *state;// 1 有效 0 无效
@property(nonatomic,strong)NSString *storeId;// 商户ID
@property(nonatomic,strong)NSString *userDays;
@property(nonatomic,strong)NSString *winUsers;

@end

//现金红包充值记录
@interface RechargeDetailModel :BaseModel

@property (nonatomic,strong) NSArray *data;

@end

@interface RechargeDetailItemModel : BaseModel

@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *b2cOrderId;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *moble;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *storeId;
@property(nonatomic,strong)NSString *updateTime;

@end

@interface activityInfoModel : BaseModel

@property(nonatomic,strong)NSArray *prizes;

@end

@interface activityInfoItem : BaseModel

@property(nonatomic,strong)NSString *activituId;
@property(nonatomic,strong)NSString *drawProbability;// 每个人抽中红包的概率
@property(nonatomic,strong)NSString *InfoID;// 活动ID
@property(nonatomic,strong)NSString *outPrizeId;
@property(nonatomic,strong)NSString *redName;//红包名字
@property(nonatomic,strong)NSString *redNum;// 红包数量
@property(nonatomic,strong)NSString *singleAmountY;// 单个金额：分 0.5
@property(nonatomic,strong)NSString *singleAmount;
@property(nonatomic,strong)NSString *singleLmLum;//每个人拆中红包限制的次数
@property(nonatomic,strong)NSString *state;// 有效
@property(nonatomic,strong)NSString *type;// 1 实物 2 商户红包 3  现金红包
@property(nonatomic,strong)NSString *updateTime;// 更新时间

// 自己添加的属性
@property(nonatomic,strong)NSString *chooseDrawType;
@property (nonatomic ,copy)NSString *btnTitle;

//@property(nonatomic,strong)NSString *redBagName;//名称
//@property(nonatomic,strong)NSString *redBagNumber;//数量
//@property(nonatomic,strong)NSString *redBagZJGaiLv;//中奖概率
//@property(nonatomic,strong)NSString *redBagZJCiShu;// 中奖次数
//@property(nonatomic,strong)NSString *redBagMoney;// 红包金额
@end
