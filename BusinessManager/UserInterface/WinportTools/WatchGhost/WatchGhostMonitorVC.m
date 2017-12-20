//
//  WatchGhostMonitorVC.m
//  BusinessManager
//
//  Created by KL on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WatchGhostMonitorVC.h"

@interface WatchGhostMonitorVC ()

@end

@implementation WatchGhostMonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
}

- (void)setUpViews {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
//    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn setTitle:@"放大" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(enlargeViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

#pragma mark - Action

-(void)enlargeViewAction {
    //旋转视图
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
