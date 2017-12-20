//
//  LoopTableVIew.h
//  BusinessManager
//
//  Created by Niuyp on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TemplateModelData;

@interface LoopTableVIew : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) NSMutableArray *originImages;

@property (nonatomic, strong) TemplateModelData* dataSources;

@end
