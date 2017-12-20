//
//  EditHongBaoVC.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
#import "WeiZhanModel.h"
@class PartModel;
typedef void(^CallBacked)(PartModel* model, BOOL isNew);
@interface EditHongBaoVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBacked)block;

@property(nonatomic,copy) NSString* templeId; //模块编号
@property(nonatomic,strong)NSArray* models;   //所有活动数据
@property(nonatomic,strong)PartModel* model;  //点击编辑的活动
@property(nonatomic,copy) CallBacked block;
@property(nonatomic,assign)BOOL isEdite;
@property (nonatomic,assign)BOOL isKFlower;
@property (nonatomic,strong)FlowerAddressModel *TemModel;
@end
