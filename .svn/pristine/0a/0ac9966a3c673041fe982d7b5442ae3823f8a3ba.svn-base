//
//  EditShopProfileVC.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^CallBacked)(PartModel* model, BOOL isNew);

@interface EditShopProfileVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBacked)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,copy)CallBacked block;

@end
