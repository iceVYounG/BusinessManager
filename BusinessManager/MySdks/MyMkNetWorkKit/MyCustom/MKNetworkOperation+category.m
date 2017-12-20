//
//  MKNetworkOperation+category.m
//  CMCCMall
//
//  Created by 萧 曦 on 13-4-28.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import "MKNetworkOperation+category.h"
#import "MKNetworkKit.h"

@implementation MKNetworkOperation (category)



/**
	返回baseHex解码的返回串
	@returns string
 */
-(NSString*)responseDecodeToString{
    if([self responseData] == nil) return nil;
   return  [[self responseString] baseHexDecode];
}



/**
	返回解码json
	@returns dic
 */
-(id)responseDecodeToDic{
    if([self responseData] == nil) return nil;
    NSString *str = [self responseString];
//    NSLog(@"%@",str);
    if ([str hasPrefix:@"{"]) {
        NSError *error = nil;
        id returnValue = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        if(error) DLog(@"JSON Parsing Error: %@", error);
        NSLog(@"Response Data: %@",returnValue);
        return returnValue;
    }
    NSString* decodeString=[[self responseString] baseHexDecode];
    NSLog(@"Response Data: %@",decodeString);
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:[decodeString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if(error) DLog(@"JSON Parsing Error: %@", error);
    NSLog(@"Response Data: %@",returnValue);
    return returnValue;
}

//add by zhuqing
/**
 解析本地json,测试使用
 @returns dic
 */
-(id)responseDecodeToDic:(NSString *)jsonString{
    if(jsonString == nil) return nil;
    NSString *str = jsonString;
    if ([str hasPrefix:@"{"]) {
        NSError *error = nil;
        id returnValue = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        if(error) DLog(@"JSON Parsing Error: %@", error);
        //        NSLog(@"Response Data: %@",returnValue);
        return returnValue;
    }
    NSString* decodeString=[jsonString baseHexDecode];
//    NSLog(@"Response Data: %@",decodeString);
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:[decodeString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if(error) DLog(@"JSON Parsing Error: %@", error);
    NSLog(@"Response Data: %@",returnValue);
    return returnValue;
}

@end
