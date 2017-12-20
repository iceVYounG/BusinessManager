//
//  MKNetworkOperation+category.h
//  CMCCMall
//
//  Created by 萧 曦 on 13-4-28.
//  Copyright (c) 2013年 cmcc. All rights reserved.
//

#import "MKNetworkOperation.h"

@interface MKNetworkOperation (category)



-(NSString*)responseDecodeToString;

-(id)responseDecodeToDic;

//add by zhuqing 解析本地json,测试使用
-(id)responseDecodeToDic:(NSString *)jsonString;

@end
