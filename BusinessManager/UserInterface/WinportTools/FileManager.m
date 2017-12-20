//
//  FileManager.m
//  CMCCMall
//
//  Created by wesley on 16/1/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FileManager.h"

@class NSFileManager;

#define DocumentsPath [self getDocumentsPath]

@implementation FileManager


//判断目录是否存在

+ (BOOL)fileExistsAtPath:(NSString *)path

{
    
    return [[NSFileManager defaultManager]fileExistsAtPath:path];
    
}


//获取Documents路径

+(NSString *)getDocumentsPath

{
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
    
}


//在Documents目录下创建新目录或文件

+(BOOL)createDirectoryWithPath:(NSString *)path

{
    
    BOOL result = NO;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * myDirectory = [DocumentsPath stringByAppendingPathComponent:path];
    
    if ([fileManager fileExistsAtPath:myDirectory] == NO) {
        
        NSError * error = nil;
        
        result=[fileManager createDirectoryAtPath:myDirectory withIntermediateDirectories:NO attributes:nil error:&error];
        
        if (error) {
            
            NSLog(@"创建目录失败：%@",[error localizedDescription]);
            
        }
        
        
    }
    
    return result;
    
}

//全路径
+(BOOL)createAllDirectoryWithPath:(NSString *)path dictionary:(BOOL)isDic
{
    
    BOOL result = NO;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * myDirectory = path;
    
    if ([fileManager fileExistsAtPath:myDirectory] == NO) {
        
        NSError * error = nil;
        
        result=[fileManager createDirectoryAtPath:myDirectory withIntermediateDirectories:isDic attributes:nil error:&error];
        
        if (error) {
            
            NSLog(@"创建目录失败：%@",[error localizedDescription]);
            
        }
        
        
    }
    
    return result;
    
}

//获取文件夹下所有的文件名
+ (NSArray *)getAllFilesNamesAtPath:(NSString *)filePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray *array = [NSArray array];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        array = [fileManager subpathsAtPath:filePath];
        
    }
    return array;
}

//获取文件夹下所有的文件内容
+ (NSArray *)getAllFilesContentsAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableArray *array = [NSMutableArray array];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSArray *nameArray = [fileManager subpathsAtPath:filePath];
        
        for (NSString *name in nameArray) {
            
            //读取某个文件
            NSData *data = [fileManager contentsAtPath:[filePath stringByAppendingPathComponent:name]];
            [array addObject:data];
        }
     
        
    }
    return array;
}

//删除目录或文件

+(BOOL)removeFileAtPath:(NSString *)filePath

{
    
    BOOL result = NO;
    
    NSError * error = nil;
    
    NSString * fullPath = filePath;
    
    result = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
    
    if (error)
    {
        
        NSLog(@"删除失败：%@",[error localizedDescription]);
        
    }
    
    return result;
    
}


//重命名目录或文件

+(BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName

{
    
    BOOL result = NO;
    
    NSError * error = nil;
    
    result = [[NSFileManager defaultManager] moveItemAtPath:[DocumentsPath stringByAppendingPathComponent:oldName] toPath:[DocumentsPath stringByAppendingPathComponent:newName] error:&error];
    
    if (error) {
        
        NSLog(@"重命名失败：%@",[error localizedDescription]);
        
    }
    
    return result;
    
}


//读取某个文件

+(NSData *)readFileContent:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSData *data;
    
    if ([fileManager fileExistsAtPath:filePath]) {
        

        //读取某个文件
        data = [fileManager contentsAtPath:filePath];
 
        
    }
    return data;
    
}


//保存某个文件

+(BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName

{
    
    return [[NSFileManager defaultManager] createFileAtPath:[path stringByAppendingPathComponent:newName] contents:data attributes:nil];
    
    
    
}


//计算文件大小

+(float)getFileSize:(NSString *)filePath

{
    
    NSError * error = nil;
    
    NSDictionary * attributes = [NSDictionary dictionaryWithDictionary:[[NSFileManager defaultManager] attributesOfItemAtPath:[DocumentsPath stringByAppendingPathComponent:filePath] error:&error]];
    
    if (attributes != nil)
        
    {
        
        return [[attributes objectForKey:NSFileSize] floatValue];
        
    }
    
    if (error) {
        
        NSLog(@"计算文件大小失败：%@",[error localizedDescription]);
        
    }
    
    return 0;
    
}

@end