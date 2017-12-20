//
//  VerifyVipCardModel.h
//  BusinessManager
//
//  Created by Raven－z on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
//czkInfo =         {
//    "BUSINESS_TYPE" = 1;
//    "CARD_ID" = 11755;
//    "CARD_LEVEL" = "\U666e\U901a";
//    "CARD_NUM" = 10401;
//    DISCOUNT = 8;
//    REMARKS = "\U9152\U6c34\U9664\U5916";
//    "USER_MOBILE" = 15062452718;
//    "U_ID" = 22337;
//};
//yhkInfo =         {
//    "BUSINESS_TYPE" = 2;
//    "CARD_ID" = 11756;
//    "CARD_LEVEL" = "\U767d\U94f6";
//    "CARD_NUM" = 100005321;
//    DISCOUNT = 9;
//    REMARKS = "\U9152\U6c34\U9664\U5916";
//    "USER_MOBILE" = 15062452718;
//    "U_ID" = 11799;
//};
@interface VerifyVipCardModel : NSObject

@property (nonatomic, strong) NSString *BUSINESS_TYPE;
@property (nonatomic, strong) NSString *CARD_ID;
@property (nonatomic, strong) NSString *CARD_LEVEL;
@property (nonatomic, strong) NSString *CARD_NUM;
@property (nonatomic, strong) NSString *DISCOUNT;
@property (nonatomic, strong) NSString *REMARKS;
@property (nonatomic, strong) NSString *USER_MOBILE;
@property (nonatomic, strong) NSString *U_ID;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
