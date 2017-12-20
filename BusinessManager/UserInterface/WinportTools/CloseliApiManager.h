//
//  CloseliApiManager.h
//  BusinessManager
//
//  Created by wesley on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#if !BUILD_FOR_STATIC
#import <CloseliSDK/CloseliSDK.h>
#endif

@interface CloseliApiManager : NSObject
@property (nonatomic, strong) CloseliSDK *mySDK;
+(CloseliApiManager*)share;
- (CloudUserInfo *)loginWithEmail:(NSString *)email withPassword:(NSString *)password error:(NSError **)error;

- (void)showAlertOfError:(NSError *)error;
@end
