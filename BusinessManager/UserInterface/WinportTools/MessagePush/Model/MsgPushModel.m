//
//  MsgPushModel.m
//  BusinessManager
//
//  Created by KL on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MsgPushModel.h"


@implementation MsgPushModel


@end

//------------------短信彩信推送——------------------//

@implementation MsgPushManagerList

- (instancetype)init {
    if (self = [super init]) {
        [MsgPushManagerList mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

//------------------短信彩信购买记录---------------------//
@implementation MsgBuyNotesModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}
+(MsgBuyNotesModel *)getModelWithDic:(NSDictionary *)dic{
    MsgBuyNotesModel *model = [[MsgBuyNotesModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end

