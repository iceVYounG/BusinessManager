//
//  EditUnderstandUsVC.h
//  BusinessManager
//
//  Created by 牛志胜 on 16/9/1.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^CallBacked)(PartModel* model, BOOL isNew);

@interface EditUnderstandUsVC : WeiZhanBaseController

-(instancetype)initWithBlock:(CallBacked)block;

@property(nonatomic,strong)PartModel* model;

@property(nonatomic,copy)CallBacked block;

@end