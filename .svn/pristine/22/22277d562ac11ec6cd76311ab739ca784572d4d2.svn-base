//
//  VipManagerChildViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipManagerChildViewController.h"
#import "VipManageView.h"
#import "GiveVipCardViewController.h"
#import "VipDetailViewController.h"

@interface VipManagerChildViewController ()<VipManageViewDelegate>

@end

@implementation VipManagerChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员管理";
    VipManageView *vc = [[VipManageView alloc]init];
    vc.delegate = self;
    [self.view addSubview:vc];
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
#pragma mark - 点击发放button
- (void)didClickGiveCardButton{
    [self.navigationController pushViewController:[[GiveVipCardViewController alloc]init] animated:YES];
}


#pragma mark - 点击cell代理方法
- (void)didClickTableViewCellWithModel:(VipCardVipListModel *)model {
    VipDetailViewController *vc = [[VipDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
