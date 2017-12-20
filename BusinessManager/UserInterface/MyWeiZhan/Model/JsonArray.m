//
//  JsonArray.m
//  BusinessManager
//
//  Created by zhaojh on 16/8/1.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "JsonArray.h"

@implementation NSArray (ToJsonStr)

-(NSArray*)jm_ArryPrams{

    NSMutableArray* targetArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary* dic = [obj mj_keyValues];
        NSString* str;
        if ([dic objectForKey:@"templateModelnameDate"]) {
            
             str = [[dic objectForKey:@"templateModelnameDate"] mj_JSONString];
            
             [dic setObject:str forKey:@"templateModelnameDate"];
        }
        [targetArr addObject:dic];
    }];
    return targetArr;
}

@end



