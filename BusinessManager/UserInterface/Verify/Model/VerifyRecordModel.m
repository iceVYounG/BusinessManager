//
//  VerifyRecordModel.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VerifyRecordModel.h"

@implementation VerifyRecordModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.MOBLE = [dic objectForKey:@"MOBLE"];
        self.TYPE = [dic objectForKey:@"TYPE"];
        self.CREATE_TIME = [dic objectForKey:@"CREATE_TIME"];
        self.DISCOUNT = [dic objectForKey:@"DISCOUNT"];
        self.AMT = [dic objectForKey:@"AMT"];
    }
    return self;
}

@end
