//
//  dataCountModel.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "dataCountModel.h"

@implementation dataCountModel

@end


@implementation dataMainModel

- (instancetype)init {
    if (self = [super init]) {
        [dataMainModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"dataMoneyModel", @"list" : @"dataMoneyModel"};
        }];
        
    }
    return self;
}

@end

@implementation dataMoneyModel



@end

@implementation dataDicModel



@end


//对账
@implementation checkDeatalModel
- (instancetype)init {
    if (self = [super init]) {
        [checkDeatalModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"checkDeatalDataModel"};
        }];
        
    }
    return self;
}



@end


@implementation checkDeatalDataModel



@end





@implementation activeCountModel
- (instancetype)init {
    if (self = [super init]) {
        [activeCountModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"activeDataModel"};
        }];
        
    }
    return self;
}


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"activId" : @"id"
             };
}



@end

//-------活动统计-------
@implementation activeDeatailModel
- (instancetype)init {
    if (self = [super init]) {
        [activeCountModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"winList" : @"activeDeatailDataModel"};
        }];
        
    }
    return self;
}
@end


@implementation activeDeatailDataModel

@end


@implementation DCFlowCountMainModel
- (instancetype)init {
    if (self = [super init]) {
        [DCFlowCountMainModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"DCFlowCountItemModel"};
        }];
    }
    return self;
}

@end




@implementation DCFlowCountTotalModel

@end




@implementation DCFlowCountItemModel


@end










