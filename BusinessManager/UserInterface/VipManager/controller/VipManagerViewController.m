//
//  VipManagerViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipManagerViewController.h"
#import "VipMangerView.h"
#import "VipManagerChildViewController.h"
#import "VipCardViewController.h"

@interface VipManagerViewController ()

@end

@implementation VipManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员管理";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    VipMangerView *vipCardManager = [[VipMangerView alloc]initWithTitle:@"会员卡管理" image:[UIImage imageNamed:@"VipCardManager"] iconColor:[UIColor colorWithHexString:@"01aaef"]];
    [vipCardManager addTapGRWithTarget:self Sel:@selector(pushToVipCardManagerVC)];
    [self.view addSubview:vipCardManager];
    [vipCardManager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(@88);
    }];
    
    VipMangerView *vipManager = [[VipMangerView alloc]initWithTitle:@"会员管理" image:[UIImage imageNamed:@"VipManager"] iconColor:[UIColor greenColor]];
    [vipManager addTapGRWithTarget:self Sel:@selector(pushToVipManagerChildVC)];
    [self.view addSubview:vipManager];
    [vipManager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipCardManager.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(@88);
    }];
}

- (void)pushToVipCardManagerVC{
    [self.navigationController pushViewController:[[VipCardViewController alloc]init] animated:YES];
}

- (void)pushToVipManagerChildVC{
    [self.navigationController pushViewController:[[VipManagerChildViewController alloc]init] animated:YES];
}

@end
