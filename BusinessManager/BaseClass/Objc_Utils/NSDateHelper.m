//
//  NSDateHelper.m
//  StoreAlliance
//
//  Created by 枪枪成 on 11-4-4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSDateHelper.h"



@implementation NSDate (NSDateHelper)


+(NSString *)nowString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT_14];
    return [formatter stringFromDate:[NSDate date]];
}

@end
