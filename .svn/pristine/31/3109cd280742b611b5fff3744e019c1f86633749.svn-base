//
//  Base64.h
//  CMCCMall
//
//  Created by user on 13-7-4.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase641.h"
@interface Base64 : NSObject

//base64加密
+ (NSString*)encodeBase64String:(NSString*)input;
+ (NSString*)decodeBase64String:(NSString*)input;
+ (NSString*)encodeBase64Data:(NSData*)data;
+ (NSString*)decodeBase64Data:(NSData*)data;

//与服务器匹配得hmac加密
+ (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text;

//3des加解密
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt withKey:(NSString *)DESKEY;

//MD5
+ (NSString *)md5:(NSString *)str;

+(NSData *)encodeData:(NSData *)data;


@end
