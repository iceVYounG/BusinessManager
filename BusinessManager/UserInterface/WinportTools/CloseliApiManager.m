//
//  CloseliApiManager.m
//  BusinessManager
//
//  Created by wesley on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CloseliApiManager.h"

#define PRODUCT_KEY         @"910fb531-4d0"
#define PRODUCT_SECRET      @"exdKev9Akoj4MNzsAHY8"
#define SERVER_TYPE_STRING  @"cn_mobile" //@"cn_stage"
#define QRCODE_KEY          @"g13"

@implementation CloseliApiManager

+(CloseliApiManager*)share
{
    static CloseliApiManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CloseliApiManager alloc]init];
        
        //Initialize CloseliSDK with product key and password
        manager.mySDK = [[CloseliSDK alloc] initWithProductKey:PRODUCT_KEY
                                           withPassword:PRODUCT_SECRET
                                             serverType:SERVER_TYPE_STRING];
        [manager.mySDK setDebugWithFlag:DebugFlag_all];
      
    });
    return manager;
}


- (CloudUserInfo *)loginWithEmail:(NSString *)email withPassword:(NSString *)password error:(NSError **)error
{
    return [self.mySDK loginWithAccount:email withPassword:password error:error];
}


- (void)showAlertOfError:(NSError *)error
{
    NSString *message = error ? [error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey]: @"unknown error!";
    [OMGToast showWithText:@"登录失败，无效的用户名或者密码"];
}
@end
