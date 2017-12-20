//
//  UIDeviceHardware.m
//  CMCCMall
//
//  Created by 周易 on 13-8-5.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import "UIDeviceHardware.h"
#include <sys/utsname.h>
#import "AppDelegate.h"

@implementation UIDeviceHardware
@synthesize deviceName;


+(UIDeviceHardware *)share {
    static dispatch_once_t pred;
    static UIDeviceHardware *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[UIDeviceHardware alloc] init];
    });
    return shared;
}


-(id)init
{
	if((self = [super init]))
	{
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        if ([deviceString isEqualToString:@"iPhone1,1"])
            deviceName= @"iPhone 1G";
        if ([deviceString isEqualToString:@"iPhone1,2"])
            deviceName= @"iPhone 3G";
        if ([deviceString isEqualToString:@"iPhone2,1"])    deviceName= @"iPhone 3GS";
        if ([deviceString isEqualToString:@"iPhone3,1"])    deviceName= @"iPhone 4";
        if ([deviceString isEqualToString:@"iPhone3,2"])    deviceName= @"iPhone 4";
        if ([deviceString isEqualToString:@"iPhone3,3"])    deviceName= @"iPhone 4";
        if ([deviceString isEqualToString:@"iPhone4,1"])    deviceName= @"iPhone 4S";
        if ([deviceString isEqualToString:@"iPhone5,2"])    deviceName= @"iPhone 5";
        if ([deviceString isEqualToString:@"iPhone3,2"])    deviceName= @"Verizon iPhone 4";
        if ([deviceString isEqualToString:@"iPod1,1"])      deviceName= @"iPod Touch 1G";
        if ([deviceString isEqualToString:@"iPod2,1"])      deviceName= @"iPod Touch 2G";
        if ([deviceString isEqualToString:@"iPod3,1"])      deviceName= @"iPod Touch 3G";
        if ([deviceString isEqualToString:@"iPod4,1"])      deviceName= @"iPod Touch 4G";
        if ([deviceString isEqualToString:@"iPad1,1"])      deviceName= @"iPad";
        if ([deviceString isEqualToString:@"iPad2,1"])      deviceName= @"iPad 2 (WiFi)";
        if ([deviceString isEqualToString:@"iPad2,2"])      deviceName= @"iPad 2 (GSM)";
        if ([deviceString isEqualToString:@"iPad2,3"])      deviceName= @"iPad 2 (CDMA)";
        if ([deviceString isEqualToString:@"i386"])         deviceName= @"Simulator";
        if ([deviceString isEqualToString:@"x86_64"])       deviceName= @"Simulator";
        
	}
	return self;
}


@end

