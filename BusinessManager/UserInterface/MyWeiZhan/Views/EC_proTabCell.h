//
//  EC_proTabCell.h
//  BusinessManager
//
//  Created by 王启明 on 16/8/17.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"

@class WeiZhanModel;
@interface EC_proTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic,strong) TemplateModel *model;
@end
@class WeiZhanModel;
@interface EC_proTabSelect : UITableViewCell
@property (nonatomic,strong)UIButton *seleteBtn;
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)TemplateModel *model;

@end



