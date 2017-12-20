//
//  CloseliServiceInfo.h
//  Security
//
//  Created by Zhou Hao on 1/31/13.
//  Copyright (c) 2013 ArcSoft. All rights reserved.

/**
 *  CloseliServiceInfo is an object that specifies the camera's service detail infomation.
 */
@interface CloseliServiceInfo : NSObject<NSCopying>

/// Service id which specifies a service type. e.g:1:to use,Can't buy; 2 - 5:normal
@property (nonatomic, assign) unsigned int serviceID;
/// Camera device UUID.
@property (nonatomic, strong) NSString *deviceUUID;
/// Video storage time.(day)
@property(nonatomic,assign) unsigned int dvrDays;
/// Service create date in string format.
@property (nonatomic, strong) NSString *createDate;
/// Service start time
@property (nonatomic, assign) long long llStartDate;
/// Service finish time
@property (nonatomic, assign) long long llEndDate;
/// Service system time
@property (nonatomic, assign) long long sysDate;
/// Indicate the caemra's service status. expired or not.
@property (readonly) BOOL bExpired;
/// Automatic renewals. 0:OFF, 1:ON
@property (nonatomic, assign) unsigned int autoPayment;
/// Service name
@property (nonatomic, strong) NSString *serviceName;
/// product key of the service.
@property (nonatomic, strong) NSString *productKey;
/// 0:don't have, 1:have, -1:no purchase information
@property (nonatomic, assign) NSInteger standby;
@end
