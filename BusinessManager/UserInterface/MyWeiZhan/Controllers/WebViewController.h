//
//  WebViewController.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@interface WebViewController : WeiZhanBaseController
@property (nonatomic, assign) BOOL needHeader;
-(instancetype)initWithUrl:(NSString*)urlStr;


@end
