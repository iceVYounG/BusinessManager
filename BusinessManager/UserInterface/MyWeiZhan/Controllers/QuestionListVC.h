//
//  QuestionListVC.h
//  BusinessManager
//
//  Created by 朕 on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
#import "WeiZhanModel.h"

@interface QuestionListVC : WeiZhanBaseController
@property(nonatomic,strong)PartModel* model;
@property(nonatomic,assign)BOOL isYJFK;
@end
