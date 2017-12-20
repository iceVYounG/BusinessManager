//
//  VerifyVipCardModel.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VerifyVipCardModel.h"

@implementation VerifyVipCardModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.BUSINESS_TYPE = [dic objectForKey:@"BUSINESS_TYPE"];
        self.CARD_ID = [dic objectForKey:@"CARD_ID"];
        self.CARD_LEVEL = [dic objectForKey:@"CARD_LEVEL"];
        self.CARD_NUM = [dic objectForKey:@"CARD_NUM"];
        self.DISCOUNT = [dic objectForKey:@"DISCOUNT"];
        self.REMARKS = [dic objectForKey:@"REMARKS"];
        self.USER_MOBILE = [dic objectForKey:@"USER_MOBILE"];
        self.U_ID = [dic objectForKey:@"U_ID"];
    }
    return self;
}

@end
