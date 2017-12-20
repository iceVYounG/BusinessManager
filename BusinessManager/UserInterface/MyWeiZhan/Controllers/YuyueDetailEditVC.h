//
//  YuyueDetailEditVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^CallBack)(PartModel* model, BOOL isNew);
@interface YuyueDetailEditVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBack)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,strong)NSMutableArray* datasArry;

@property(nonatomic,copy)CallBack block;

@property(nonatomic,strong)NSString* templatename;
@property(nonatomic,strong)NSString* templateCode;
@property(nonatomic,strong)NSString* templateNo;

@end
