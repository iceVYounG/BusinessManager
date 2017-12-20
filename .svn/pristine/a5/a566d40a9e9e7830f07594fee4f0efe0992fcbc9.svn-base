//
//  BaseModel.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

BOOL Succeed(id rsp){
    
    if ([rsp isKindOfClass:[NSDictionary class]]) {
        
        if (![rsp objectForKey:@"code"]) {
            return NO;
        }
        NSString* code = [rsp objectForKey:@"code"];
        
        if ([code isEqualToString:@"00-00"] || [code isEqualToString:@"0"]) {
            
            return YES;
        }
        return NO;
    }else{
        BaseModel* model = (BaseModel*)rsp;
        if ([model.code isEqualToString:@"00-00"] || [model.code isEqualToString:@"0"]) {
            return YES;
        }
        return NO;
    }
};

@end
