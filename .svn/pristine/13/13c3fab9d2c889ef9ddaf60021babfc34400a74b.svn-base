//
//  WZ_TextViewPhotoVC.h
//  BusinessManager
//
//  Created by Niuyp on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"


@class PartModel;

typedef void(^WZTextBlock)(PartModel* model, BOOL isNew);
@interface WZ_TextViewPhotoVC : WeiZhanBaseController
@property (nonatomic, copy) NSString *nameCode;
@property (nonatomic, copy) NSString *Modelname;
@property (nonatomic, strong) PartModel *model;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *tempName;

@property (nonatomic, copy) WZTextBlock block;


- (instancetype)initWithBlock:(WZTextBlock)block;
@end
