//
//  HZCaseDetailVC.h
//  BusinessManager
//
//  Created by niuzs on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "WeiZhanBaseController.h"



@class PartModel;
typedef void(^CallBack)(PartModel* model, BOOL isNew);

@interface HZCaseDetailVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBack)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,copy)CallBack block;

@end
