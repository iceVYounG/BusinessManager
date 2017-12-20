//
//  WZ_LoopVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_LoopVC.h"
#import "LoopTableVIew.h"
#import "JMView.h"
#import "WeiZhanModel.h"

@interface WZ_LoopVC ()

@property (nonatomic, strong) LoopTableVIew* tableView;
@end

@implementation WZ_LoopVC


- (instancetype)initWithCoder:(NSCoder *)aDecoder block:(WZLoopBlock)block{
    if (self = [super initWithCoder:aDecoder]) {
        self.block = block;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"轮播图编辑";
    
    [self setUpOther];
}
- (void)setUpOther{

    
    if (self.model) {
        self.tableView.dataSources = self.model.templateModelnameDate;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@synthesize tableView = _tableView;

- (LoopTableVIew *)tableView{
    
    if (!_tableView) {
        _tableView = [[LoopTableVIew alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:UITableViewStyleGrouped];
        
        _tableView.tableFooterView = [[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:YES block:^{
            
            NSLog(@"保存Action...");
        }];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}
@end
