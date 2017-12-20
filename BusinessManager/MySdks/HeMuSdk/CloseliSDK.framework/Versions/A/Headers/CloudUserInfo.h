//
//  CloudUserInfo.h
//  Security
//
//  Created by Zhou Hao on 1/17/13.
//
//

#import <Foundation/Foundation.h>

@interface CloudUserInfo : NSObject

@property long long  ulUserID;
@property (nonatomic, strong) NSString * szToken;
@property (nonatomic, strong) NSString * szShortToken;
@property (nonatomic, strong) NSString * szHemuToken;
@property (nonatomic, strong) NSString * szEmail;
@property (nonatomic, strong) NSString * szUserName;
@property (nonatomic, strong) NSString * szDeviceID;
@property (nonatomic, strong) NSString * szProductID;
@property (nonatomic, strong) NSString * szUnifiedID;
@property (nonatomic, strong) NSString * szPassword;
@property (nonatomic, strong) NSString * szMobile;
@property (nonatomic, strong) NSString * szVIPNum;

@property (nonatomic, assign) NSInteger nSubscribe;
@property NSInteger eUserStatus;
@end
