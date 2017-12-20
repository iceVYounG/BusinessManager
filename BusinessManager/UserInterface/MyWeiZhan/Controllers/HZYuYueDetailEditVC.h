//
//  HZYuYueDetailEditVC.h
//  BusinessManager
//
//  Created by niuzs on 16/8/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^CallBack)(PartModel* model, BOOL isNew);
@interface HZYuYueDetailEditVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBack)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,strong)NSMutableArray* datasArry;

@property(nonatomic,copy)CallBack block;

@property(nonatomic,strong)NSString* templatename;
@property(nonatomic,strong)NSString* templateCode;
@property(nonatomic,strong)NSString* templateNo;



@end
