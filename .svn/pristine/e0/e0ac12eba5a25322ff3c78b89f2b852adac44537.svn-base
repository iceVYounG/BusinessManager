//
//  UserInformation.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "UserInformation.h"

@implementation UserInformation

- (void) encodeWithCoder: (NSCoder *)coder{
    
    [coder encodeObject:self.terminalId forKey:@"terminalId"];
    [coder encodeObject:self.area_code forKey:@"area_code"];
    [coder encodeObject:self.groupByDefaultMobileNum forKey:@"groupByDefaultMobileNum"];
    [coder encodeObject:self.sid forKey:@"sid"];
    [coder encodeObject:self.storeId forKey:@"storeId"];
    [coder encodeObject:self.linkPhone forKey:@"linkPhone"];
    [coder encodeObject:self.storeName forKey:@"storeName"];
    [coder encodeObject:self.b2cStoreId forKey:@"b2cStoreId"];
    [coder encodeObject:self.b2cmsg forKey:@"b2cmsg"];
    [coder encodeObject:self.dianShangName forKey:@"dianShangName"];

    [coder encodeObject:@(self.isLogin) forKey:@"isLogin"];
}

- (id)initWithCoder: (NSCoder *) coder{
    _terminalId = [[coder decodeObjectForKey:@"terminalId"] copy];
    _area_code = [[coder decodeObjectForKey:@"area_code"] copy];
    _groupByDefaultMobileNum = [[coder decodeObjectForKey:@"groupByDefaultMobileNum"] copy];
    _sid = [[coder decodeObjectForKey:@"sid"] copy];
    _storeId = [[coder decodeObjectForKey:@"storeId"] copy];
    _uid = [[coder decodeObjectForKey:@"uid"] copy];
    _linkPhone = [[coder decodeObjectForKey:@"linkPhone"] copy];
    _storeName = [[coder decodeObjectForKey:@"storeName"] copy];
    _b2cStoreId = [[coder decodeObjectForKey:@"b2cStoreId"] copy];
    _b2cmsg = [[coder decodeObjectForKey:@"b2cmsg"] copy];
    _dianShangName = [[coder decodeObjectForKey:@"dianShangName"] copy];
    _isLogin = [[[coder decodeObjectForKey:@"isLogin"] copy] boolValue];
    
    return self;
}

+ (void)saveUserInfo{
    
    [NSKeyedArchiver archiveRootObject:AccountInfo toFile:[self getPath]];
}

+ (UserInformation *)shareUserInfo{
    static dispatch_once_t pred;
    static UserInformation *shared = nil;
    dispatch_once(&pred, ^{
    shared = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPath]];
         if (shared == nil) {
            shared = [[UserInformation alloc] init];
        }
    });
    return shared;
}

+ (NSString*)getPath{
    
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject];
    NSString* fileName = @"BusinessManagerUserInfo.plist";
    NSString *filePath = [docuPath stringByAppendingPathComponent:fileName];
    return filePath;
}



@end
