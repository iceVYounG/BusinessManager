//
//  WZ_TextPhotoVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "WeiZhanBaseController.h"


@class PartModel;

typedef void(^WZTextBlock)(PartModel* model, BOOL isNew);
@interface WZ_TextPhotoVC : WeiZhanBaseController
@property (nonatomic, copy) NSString *nameCode;
@property (nonatomic, copy) NSString *Modelname;
@property (nonatomic, strong) PartModel *model;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *tempName;

@property (nonatomic, copy) WZTextBlock block;


- (instancetype)initWithBlock:(WZTextBlock)block;
@end
