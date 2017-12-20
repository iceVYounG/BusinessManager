//
//  WZ_LoopVC.h
//  BusinessManager
//
//  Created by Niuyp on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^WZLoopBlock)(PartModel *model, BOOL isNewData);


@interface WZ_LoopVC : WeiZhanBaseController

@property (nonatomic, strong) PartModel *model;
@property (nonatomic, copy) WZLoopBlock block;


- (instancetype)initWithCoder:(NSCoder *)aDecoder block:(WZLoopBlock)block;

@end
