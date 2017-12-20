//
//  MallNetworkEngine.h
//  CMCCMall
//
//  Created by 萧 曦 on 13-4-27.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "MKNetworkOperation+category.h"
typedef void (^MKNKisCachedBlock)(BOOL isCached);

//网络请求
#define NETWORK_ENGINE ([MallNetworkEngine share])

@interface UpLoadImageModel : NSObject
@property (strong, nonatomic) NSData *imageData;
@property (assign, nonatomic) BOOL isGif;
@property (strong, nonatomic) NSString *fileName;

@end

@interface MallNetworkEngine : MKNetworkEngine


@property (nonatomic,retain)NSString *mainPathRequest;//首页请求



@property (nonatomic, copy) MKNKisCachedBlock cachedBlock;

-(MKNetworkOperation*)requestWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSMutableDictionary *)params  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error;

#pragma mark - 不加密请求
-(MKNetworkOperation*)requestNotEncodeWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSMutableDictionary *)params  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error;


- (MKNetworkOperation*)requestWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSDictionary *)params picsArray:(NSArray *)picArray CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error;

-(MKNetworkOperation*)requestNotEncodeWithDate:(NSDate *)date requestWithPath:(NSString*)path ParamString:(NSString *)str  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error;


/**
 生成请求
 @param remoteURL 远程文件地址
 @param filePath 本地文件地址
 @param  hostName  
 @returns return value description
 */
-(MKNetworkOperation*) downloadFatAssFileFrom:(NSString*)remoteURL toFile:(NSString*) filePath CompletionHandler:(MKNKResponseBlock) response ErrorHandler:(MKNKResponseErrorBlock) error;

//单例
+(MallNetworkEngine *)share;
+(MallNetworkEngine *)loginshare; //登录
+(MallNetworkEngine *)vipCardMGshare; //会员卡测试
@end


