//
//  dataCountModel.h
//  BusinessManager
//
//  Created by 张心亮 on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface dataCountModel : BaseModel
@property(strong,nonatomic)NSString *onlineSales;
@property(strong,nonatomic)NSString *cardVerify;
@property(strong,nonatomic)NSString *pvTotal;
@property(strong,nonatomic)NSString *uvTotal;
@property(strong,nonatomic)NSString *addMembers;
@property(strong,nonatomic)NSString *memberYz;




@end

@class dataDicModel;
@interface dataMainModel : BaseModel
@property (nonatomic, strong) NSString *avaCount;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSString *pageCount;
@property (nonatomic, strong) dataDicModel *moneyTotalInfo;
@end



@interface dataMoneyModel : NSObject
@property (nonatomic, strong) NSString *HB_MONEY;
@property (nonatomic, strong) NSString *STATISTIC_DATE;
@property (nonatomic, strong) NSString *VIPCARD_MONEY;
@property (nonatomic, strong) NSString *YHK_NUM;
@end
  


@interface dataDicModel : NSObject

@property (nonatomic, strong) NSString *END_DATE;
@property (nonatomic, strong) NSString *HB_MONEY_TOTAL;
@property (nonatomic, strong) NSString *MONEY_TOTAL;
@property (nonatomic, strong) NSString *START_DATE;
@property (nonatomic, strong) NSString *VIPCARD_MONEY_TOTAL;
@property (nonatomic, strong) NSString *YHK_NUM_TOTAL;

@end





//对账详情
@class dataDicModel;
@interface checkDeatalModel : BaseModel
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *pageCount;
@property (nonatomic, strong) dataDicModel *totalPrice;

@end



@interface checkDeatalDataModel : NSObject
@property (nonatomic, strong) NSString *MOBLE;
@property (nonatomic, strong) NSString *AMT;
@property (nonatomic, strong) NSString *TYPE;
@property (nonatomic, strong) NSString *CREATE_TIME;
@end


//活动统计
@interface activeCountModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *activId;//id
@end


//-------------流量统计---------------------//
@class DCFlowCountTotalModel;
@interface DCFlowCountMainModel : BaseModel


@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) DCFlowCountTotalModel *total;

@end

@interface DCFlowCountTotalModel : NSObject

@property (nonatomic, strong) NSString *pvTotal;    //浏览总量
@property (nonatomic, strong) NSString *pvTotalUp;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *templateNo;
@property (nonatomic, strong) NSString *uvTotal;    //访客总量
@property (nonatomic, strong) NSString *uvTotalUp;

@end

@interface DCFlowCountItemModel : NSObject

@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, assign) NSInteger pv;     //浏览量
@property (nonatomic, assign) NSInteger uv;     //访问量

@end




//活动统计详情
@interface activeDeatailModel : BaseModel
@property (nonatomic, strong) NSString *addUsers;
@property (nonatomic, strong) NSString *winUsers;
@property (nonatomic, strong) NSString *joinUsers;//参与人数
@property (strong,nonatomic)NSString *total_num;
@property (strong,nonatomic) NSArray *winList;
@end



@interface activeDeatailDataModel : NSObject
@property (strong,nonatomic)NSString *mobile;
@property (strong,nonatomic)NSString *prizeName;
@property (strong,nonatomic)NSString *updateTime;//参与时间
@property (strong,nonatomic)NSString *state;//是否中奖
@end


