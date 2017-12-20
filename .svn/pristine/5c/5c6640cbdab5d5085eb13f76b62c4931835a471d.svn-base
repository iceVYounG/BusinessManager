//
//  FileManager.h
//  CMCCMall
//
//  Created by wesley on 16/1/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManager : NSObject

+(BOOL)fileExistsAtPath:(NSString *)path;

+(NSString *)getDocumentsPath;

+(BOOL)createDirectoryWithPath:(NSString *)path;
+(BOOL)createAllDirectoryWithPath:(NSString *)path dictionary:(BOOL)isDic;

+ (NSArray *)getAllFilesNamesAtPath:(NSString *)filePath;
+ (NSArray *)getAllFilesContentsAtPath:(NSString *)filePath;

+(BOOL)removeFileAtPath:(NSString *)filePath;

+(BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName;

+(NSData *)readFileContent:(NSString *)filePath;

+(BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName;

+(float)getFileSize:(NSString *)filePath;

@end