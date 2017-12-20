//
//  FourSLoopEditVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "WeiZhanBaseController.h"
#import "WeiZhanModel.h"
typedef void(^WZLoopBlock)(PartModel *model, BOOL isNewData);
@interface FourSLoopEditVC : WeiZhanBaseController
- (instancetype)initWithCoder:(NSCoder *)aDecoder block:(WZLoopBlock)block;
@property (nonatomic, copy) WZLoopBlock block;
@property (nonatomic, strong) PartModel *model;
@property (nonatomic,strong)NSString *temPleName;
@property (nonatomic,strong)NSString *temPleCode;
@property (nonatomic,strong)NSString *temPleNo;
@end
