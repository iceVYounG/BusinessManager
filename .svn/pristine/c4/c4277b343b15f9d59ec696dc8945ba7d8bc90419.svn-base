//
//  FoodDetailEditVC.h
//  BusinessManager
//
//  Created by Niuyp on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"

#define KCollectionCellW     (KScreenWidth-16*3)/2
//KCollectionCellW * 7.5/12
#define KCollectionCellH     (KScreenWidth-16*3)/2 * 22/15

@class PartModel;

typedef void(^FoodMenuBlock)(PartModel* model,BOOL isNewData);
@interface FoodDetailEditVC : WeiZhanBaseController


@property (nonatomic, strong) PartModel *model;

@property (nonatomic, copy) FoodMenuBlock block;

- (instancetype)initWithBlock:(FoodMenuBlock)block;

@end
