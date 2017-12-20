//
//  WCG_ShopServicevc.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^CallBack)(PartModel* model, BOOL isNew);
@interface WCG_ShopServicevc : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBack)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,strong)NSMutableArray* datasArry;
@property(nonatomic,strong)NSMutableArray* datasArry2;
@property(nonatomic,copy)CallBack block;

@end
