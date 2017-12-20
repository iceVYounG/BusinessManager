//
//  MallNetManager.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.http://v.12580.com/
//

#import "AFHTTPSessionManager.h"

#define URL_Root @"/bfsh-ws-inter/"
#define ImagePre            @"http://v.12580.com/storeimg/"
#define ImagePre2            @"http://v.12580.com/"

#define BussinessImagePre   @"http://mall.12580.com/"
#define ErWeiMaImagePre     @"http://183.207.110.93.8085/newmovie/qrimg/"

// http://112.4.27.8/bfsh-ws_inter/
//#define URL_Server @"http://112.4.27.8"
#define URL_Server  @"http://183.207.110.93:8085"
//#define URL_Server @"http://10.35.10.146:8088"


//#define URL_Server @"http://112.4.27.8"
//#define URL_Server  @"http://183.207.110.93:8085"


@interface MallNetManager : AFHTTPSessionManager

+ (instancetype)share;

#pragma mark - POST
- (NSURLSessionDataTask *)request:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

#pragma mark - GET
- (NSURLSessionDataTask *)requestGET:(NSString *)URLString
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

#pragma mark - EnCode_POST
- (NSURLSessionDataTask *)requestEncode:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


#pragma mark - 自带HUD提示的请求 00-00才调成功block
-(NSURLSessionDataTask *)request:(NSString*)urlStr prams:(id)prams succeed:(void (^)(id responseObject))success showHUD:(BOOL)showHUD;

#pragma mark - 数据上传时的提示语更改
-(NSURLSessionDataTask *)NewFloorRequest:(NSString*)urlStr params:(id)params succeed:(void (^)(id responseObject))success showHUD:(BOOL)showHUD;


+ (void)cancleAllRequest;

+ (void)reset;

@end
