//
//  MallNetworkEngine.m
//  CMCCMall
//
//  Created by 萧 曦 on 13-4-27.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import "MallNetworkEngine.h"
#import "UIDeviceHardware.h"
#import "GTMBase641.h"
#import "Utils.h"

#define SERVER_HOST @"112.4.28.64:8080"
#define LOGIN_HOST @"112.4.27.9"

@implementation UpLoadImageModel

NSString * VERSION_ID = @"1.0";
NSString * iOSKey = @"ios900";
NSString * SID = @"SID";
NSString * clientName = @"clientName";
NSString * timeStr = @"timeStr";
NSString * VERSION = @"VERSION";
NSString * version = @"version";


@end


@implementation MallNetworkEngine



/**
	添加特定header
	@returns 
 */
-(NSMutableDictionary*)makeCustomHeadersWithPath:(NSString *)path
{
    NSMutableDictionary* headers=[NSMutableDictionary dictionary];
   
    NSString *now = [NSDate nowString];
    
    
    NSString* str;
    if (now.length > 12) {
        str = [now substringWithRange:NSMakeRange(0, now.length - 2)];
    }
    [headers setObject:str forKey:timeStr];
    [headers setObject:iOSKey forKey:clientName];
    
    NSString* pwdStr = [NSString stringWithFormat:@"%@%@%@",iOSKey,str,@"q#9asdjasj"];
    [headers setObject:[pwdStr md5] forKey:@"pwd"];

    //uuid
    NSString *uuid = [[UnitMetiodManager share] UUID];
    if (uuid.length == 0) {
        uuid = [[UnitMetiodManager share]getChainkey];
    }
    [headers setObject:uuid forKey:@"uuid"];
    
    //版本号
    
    if(VERSIONCHOOSEH5TEST)
    {
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"VERSIONCHOOSEH5TEST"])
        {
            [headers setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"VERSIONCHOOSEH5TEST"] forKey:version];
        }
        else
        {
            [headers setObject:APP_VERSION forKey:version];
        }
       
    }
    else
    {
        [headers setObject:APP_VERSION forKey:version];
    }
    
    return headers;
}


/**
	添加特定params
	@returns 
 */
- (NSMutableDictionary *)makeCustomParamsWithPath:(NSString *)path{

    NSMutableDictionary* params=[NSMutableDictionary dictionaryWithCapacity:5];
    //汽车票请求不加version字段
  
        //VERSION
      [params setObject:VERSION_ID forKey:VERSION];
    
    return params;
}


/**
	对请求参数进行编码
	@param params
	@returns 
 */
- (NSString*) encodedSendingBody:(NSDictionary *)params
{
	NSString * data = [params jsonEncodedKeyValueString];
    NSLog(@"Request Body: %@", data);
	NSData *encodingData = [GTMBase641 encodeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* base64EncodingString = [[NSString alloc] initWithBytes:[encodingData bytes] length:[encodingData length] encoding:NSUTF8StringEncoding];
    NSString* requestBody = [Utils stringToHex:base64EncodingString];
    return  requestBody;
    
}

-(NSDictionary *)responseAfterRequestSucceedWithPath:(NSString*)path Params:(NSMutableDictionary*)params  CompletionHandler:(MKNKResponseBlock) response ErrorHandler:(MKNKResponseErrorBlock) error failHandler:(requestFail)fail successHandler:(requestSuccess)success requestTag:(NSInteger)tag{
    MallNetworkEngine *reEngine = [[MallNetworkEngine alloc]init];
     NSDictionary *__block dic = [NSDictionary dictionary];
    
    MKNetworkOperation *op = [reEngine requestWithPath:path Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        dic = [completedOperation responseDecodeToDic];
        if (dic) {
            if (success) {
                success();
            }
        }else{
            if (fail) {
                fail();
            }
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (fail) {
            fail();
        }
        
//        [SVProgressHUD dismissWithStatus:@"服务器忙，请稍候再试" afterDelay:1];
    }];
    op.tag = tag;
    return dic;
    
}

-(void)cancelrequest:(MKNetworkOperation *)operation{
    if (operation) {
        [operation cancel];
    }else{
        
    }
}

-(void) setcachedBlock:(MKNKisCachedBlock) isCached {
    
    self.cachedBlock = isCached;
}
/**
	发起请求
	@param path 请求地址路径
	@param params 参数
	@param  response
	@param
	@returns
 */
-(MKNetworkOperation*)requestWithPath:(NSString*)path Params:(NSMutableDictionary *)params  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error{
    
    //extra params 增加特殊参数
    [params addEntriesFromDictionary:[self makeCustomParamsWithPath:path]];
//    static NSInteger count = 1;
//    count++;
    
    MKNetworkOperation * op;
   
    if (params) {
        op =[self operationWithPath:path params:params httpMethod:@"POST"];
//        op.tag = count;
        //extra header 增加特殊头部 验证之类的
        [op addHeaders:[self makeCustomHeadersWithPath:path]];
        
        //定义传送参数的方式   放在body里的string
        [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
            //汽车票不需要编码
            //信鸽
            if ([path isEqualToString:@"/client_notify/12580/tags/binding"]) {
                
                return [params jsonEncodedKeyValueString];
            }
            else{
                return [self encodedSendingBody:postDataDict];
            }
            
        } forType:@"txt/html"];
    }
    else{
        op = [self operationWithPath:path params:nil httpMethod:@"GET"];
    }
   
    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {

        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {

    }];

    
    //加入队列
    [self enqueueOperation:op];

    
    return op;
    
}

/**
	发起请求
	@param path 请求地址路径
	@param params 参数
	@param  response
	@param
	@returns
 */
-(MKNetworkOperation*)requestWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSMutableDictionary *)params  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error{
    
    //extra params 增加特殊参数
    [params addEntriesFromDictionary:[self makeCustomParamsWithPath:path]];
    //    static NSInteger count = 1;
    //    count++;
    
    MKNetworkOperation * op;
    
    
    if (params) {
//        NSLog(@"Request Body: %@", [params jsonEncodedKeyValueString]);

        op =[self operationWithPath:path params:params httpMethod:@"POST"];
        //        op.tag = count;
        //extra header 增加特殊头部 验证之类的
        [op addHeaders:[self makeCustomHeadersWithPath:path]];
        
        //定义传送参数的方式   放在body里的string
        [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
            //推送接口不需要编码
           if ([path isEqualToString:@""]||[path isEqualToString:@""]) {
               
                return [params jsonEncodedKeyValueString];
            }       //
            else{
                return [self encodedSendingBody:postDataDict];
            }
         
        } forType:@"txt/html"];
    }
    else{
        op = [self operationWithPath:path params:nil httpMethod:@"GET"];
    }
    
    op.date = date;
    if(self.cachedBlock != nil){
        if ([self cachedDataForOperation:op] == nil) {
            self.cachedBlock(FALSE);
        }else{
            self.cachedBlock(TRUE);

        }
        self.cachedBlock = nil;
    }

    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    
    //加入队列
    [self enqueueOperation:op];
    
  
    
    return op;
    
}

/**
 *  特殊请求，请求体是jsonStr
 */
-(MKNetworkOperation*)requestNotEncodeWithDate:(NSDate *)date requestWithPath:(NSString*)path ParamString:(NSString *)str  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error{
    
    //extra params 增加特殊参数
    //    static NSInteger count = 1;
    //    count++;
    
    MKNetworkOperation * op;
    
    if (str) {
        
        op =[self operationWithPath:path params:[NSDictionary dictionary] httpMethod:@"POST"];
        //        op.tag = count;
        //extra header 增加特殊头部 验证之类的
        [op addHeaders:[self makeCustomHeadersWithPath:path]];
        
        //定义传送参数的方式   放在body里的string
        [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
            
            return str;
            
            
        } forType:@"txt/html"];
    }
    else{
        op = [self operationWithPath:path params:nil httpMethod:@"GET"];
    }
    
    op.date = date;
    if(self.cachedBlock != nil){
        if ([self cachedDataForOperation:op] == nil) {
            self.cachedBlock(FALSE);
        }else{
            self.cachedBlock(TRUE);
            
        }
        self.cachedBlock = nil;
    }
    
    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    
    //加入队列
    [self enqueueOperation:op];
    
    
    
    return op;
    
}


-(MKNetworkOperation*)requestNotEncodeWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSMutableDictionary *)params  CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error{
    
    //extra params 增加特殊参数
    [params addEntriesFromDictionary:[self makeCustomParamsWithPath:path]];
    //    static NSInteger count = 1;
    //    count++;
    
    MKNetworkOperation * op;
    
    if (params) {

        op =[self operationWithPath:path params:params httpMethod:@"POST"];
        //        op.tag = count;
        //extra header 增加特殊头部 验证之类的
        [op addHeaders:[self makeCustomHeadersWithPath:path]];
        
        //定义传送参数的方式   放在body里的string
        [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
           
            return [params jsonEncodedKeyValueString];
           
            
        } forType:@"txt/html"];
    }
    else{
        op = [self operationWithPath:path params:nil httpMethod:@"GET"];
    }
    
    op.date = date;
    if(self.cachedBlock != nil){
        if ([self cachedDataForOperation:op] == nil) {
            self.cachedBlock(FALSE);
        }else{
            self.cachedBlock(TRUE);
            
        }
        self.cachedBlock = nil;
    }
    
    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    
    //加入队列
    [self enqueueOperation:op];
    
    
    
    return op;
    
}


/**
 生成请求
 @param remoteURL 远程文件地址
 @param filePath 本地文件地址
 @param  hostName
 @returns return value description
 */
-(MKNetworkOperation*) downloadFatAssFileFrom:(NSString*)remoteURL toFile:(NSString*) filePath CompletionHandler:(MKNKResponseBlock) response ErrorHandler:(MKNKResponseErrorBlock) error
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:SERVER_HOST customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithURLString:remoteURL
                                                     params:nil
                                                 httpMethod:@"GET"];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                            append:YES]];
//    [op onDownloadProgressChanged:^(double progress) {
//        //下载进度
//        NSLog(@"download progress: %.2f", progress*100.0);
//    }];
    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    
    //加入队列
    [engine enqueueOperation:op];
    
    return op;
}

/**
	生成请求
	@param path
	@param params
	@param  response
	@param
	@returns 
 */
//+(MKNetworkOperation*)requestWithPath:(NSString*)path Params:(NSMutableDictionary*)params  CompletionHandler:(MKNKResponseBlock) response ErrorHandler:(MKNKResponseErrorBlock) error{
//    
//    
//    return  [NETWORK_ENGINE requestWithPath:path Params:params CompletionHandler:response ErrorHandler:error];
//    
//}

/**
	发起请求
	@param path 请求地址路径
	@param params 参数
	@param  response
	@param
	@returns
 */
- (MKNetworkOperation*)requestWithDate:(NSDate *)date requestWithPath:(NSString*)path Params:(NSDictionary *)params picsArray:(NSArray *)picArray CompletionHandler:(MKNKResponseBlock)response ErrorHandler:(MKNKResponseErrorBlock) error{
    
    MKNetworkOperation * op;
    
    
    op =[self operationWithPath:path params:params httpMethod:@"POST"];
    [op addHeaders:[self makeCustomHeadersWithPath:path]];
    
    //定义传送参数的方式   放在body里的string
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        
        return [self encodedSendingBody:postDataDict];
        
        
    } forType:@"txt/html"];
    
    op.date = date;
    
    if (picArray.count > 0) {
        
        for (NSInteger i = 0;i < picArray.count; i++) {
            UpLoadImageModel *model = [picArray objectAtIndex:i];
            
            NSData *encodingData = [GTMBase641 encodeData:model.imageData];
            NSString* base64EncodingString = [[NSString alloc] initWithBytes:[encodingData bytes] length:[encodingData length] encoding:NSUTF8StringEncoding];
            
            [op addData:[base64EncodingString dataUsingEncoding:NSUTF8StringEncoding] forKey:model.fileName mimeType:@"application/octet-stream" fileName:model.fileName];
        }
    }
    //处理句柄
    [op addCompletionHandler:response errorHandler:error];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    
    //加入队列
    [self enqueueOperation:op];
    
    
    
    return op;
    
}

/**
 单例
 @returns
 */
+(MallNetworkEngine *)share {
    static dispatch_once_t pred;
    static MallNetworkEngine *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[MallNetworkEngine alloc]initWithHostName:SERVER_HOST];
        [shared useCache];
    });
    return shared;
}

/**
 单例
 @returns
 */
+(MallNetworkEngine *)loginshare {
    static dispatch_once_t pred;
    static MallNetworkEngine *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[MallNetworkEngine alloc]initWithHostName:Server];
        [shared useCache];
    });
    return shared;
}

/**
 单例
 @returns
 */
+(MallNetworkEngine *)vipCardMGshare {
    static dispatch_once_t pred;
    static MallNetworkEngine *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[MallNetworkEngine alloc]initWithHostName:VIPCARD_Server];
        [shared useCache];
    });
    return shared;
}



@end



