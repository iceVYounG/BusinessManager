//
//  HomeVideoMainVC.h
//  CMCCMall
//
//  Created by 朱青 on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"

@interface HomeVideoMainVC : BaseController

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *nothingView;

@end
