//
//  VMRechargeRecordVC.m
//  BusinessManager
//
//  Created by KL on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VMRechargeRecordVC.h"
#import "VMRechargeRecordView.h"
#import "KxMenu.h"


@interface VMRechargeRecordVC ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) VMRechargeRecordView *recordView;

@property (nonatomic, strong) UILabel *searchLabel;

@end

@implementation VMRechargeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员充值记录";
    [self setUpViews];
    
}

- (void)setUpViews {
    self.recordView = [[VMRechargeRecordView alloc] init];
    [self.view addSubview:self.recordView];
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 40)];
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction)];
    [btn addGestureRecognizer:tapped];
    
    UIImageView *img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:@"DataCount_dropArrow3.png"]];
    [btn addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn.mas_centerY);
        make.right.equalTo(btn);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@6);
    }];
    
    self.searchLabel = [[UILabel alloc] init];
    [self.searchLabel setText:@"全部"];
    [self.searchLabel setTextAlignment:NSTextAlignmentRight];
    [self.searchLabel setTextColor:[UIColor whiteColor]];
    [self.searchLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addSubview:self.searchLabel];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn.mas_centerY);
        make.right.equalTo(img.mas_left).offset(-3);
        make.width.mas_lessThanOrEqualTo(@60);
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)tappedAction {
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"全部"
                     image:nil
                       tag:1
                    target:self
                    action:@selector(selectedAction:)],
      [KxMenuItem menuItem:@"今日"
                     image:nil tag:2
                    target:self
                    action:@selector(selectedAction:)],
       [KxMenuItem menuItem:@"最近7天"
                      image:nil tag:3
                     target:self
                     action:@selector(selectedAction:)],
      [KxMenuItem menuItem:@"最近30天"
                     image:nil
                       tag:4
                    target:self
                    action:@selector(selectedAction:)],
      ];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:CGRectMake(KScreenWidth- 8, -10, 40, 60)
                 menuItems:menuItems];
}

- (void)selectedAction:(KxMenuItem *)menuItem {
    NSInteger tag = menuItem.gTag;
    switch (tag) {
        case 1:{//全部
            self.recordView.days = @"";
            self.searchLabel.text = @"全部";
        }
            break;
        case 2:{//今日
            self.recordView.days = @"1";
            self.searchLabel.text = @"今日";
        }
            break;
        case 3:{
            self.recordView.days = @"7";
            self.searchLabel.text = @"最近7天";
        }
            break;
        case 4:{
            self.recordView.days = @"30";
            self.searchLabel.text = @"最近30天";
        }
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
