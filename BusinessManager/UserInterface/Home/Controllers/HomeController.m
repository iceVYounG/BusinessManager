//
//  HomeController.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HomeController.h"
#import "MyWeiZhanVC.h"
#import "DrawActivityManageVC.h"
#import "HomePageView.h"
#import "WinportToolsVC.h"
#import "VipManagerViewController.h"
#import "MySettingVC.h"
#import "DataCountVC.h"
#import "VerifyViewController.h"

@interface HomeController (){

    UILabel *_topViewLabel;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"首页";
    self.backItemHiden = YES;
    
    
    NSLog(@" acc =====%d",AccountInfo.isLogin);
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    _topViewLabel.text = [NSString stringWithFormat:@"欢迎您 ，%@ !",AccountInfo.storeName];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];

    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HomePage_Top"]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@84);
    }];
    
    _topViewLabel = [[UILabel alloc]init];
    _topViewLabel.textAlignment = NSTextAlignmentCenter;
    _topViewLabel.font = [UIFont systemFontOfSize:17];
    _topViewLabel.textColor = [UIColor whiteColor];
    [topView addSubview:_topViewLabel];
//    _topViewLabel.text = [NSString stringWithFormat:@"欢迎您，%@！",_usernamestr];
    [_topViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    
    HomePageView * myWeb = [[HomePageView alloc]initWithTitleStr:@"我的微站"];
    myWeb.iconView.image = [UIImage imageNamed:@"HomePage_Web"];
    myWeb.backgroundColor = [UIColor colorWithHexString:@"d5346c"];
    [myWeb addTapGRWithTarget:self Sel:@selector(pushWeiZhanAction:)];
    [self.view addSubview:myWeb];
    [myWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(6);      //old 6.5
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX).offset(-3);   //old 6
        make.height.mas_equalTo((SCREEN_SIZE.height-84-18)/3);  //old -26
    }];
    
    HomePageView * vipManager = [[HomePageView alloc]initWithTitleStr:@"会员管理"];
    vipManager.backgroundColor = [UIColor colorWithHexString:@"fa9300"];
    vipManager.iconView.image = [UIImage imageNamed:@"HomePage_VipManager"];
    [vipManager addTapGRWithTarget:self Sel:@selector(pushToVipMangerVC)];
    [self.view addSubview:vipManager];
    [vipManager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myWeb.mas_bottom).offset(6);    //old 6
        make.left.equalTo(self.view);
        make.right.equalTo(myWeb);
        make.height.equalTo(myWeb);
    }];
    
    HomePageView * webData = [[HomePageView alloc]initWithTitleStr:@"数据统计"];
    webData.iconView.image = [UIImage imageNamed:@"HomePage_Data"];
    [webData addTapGRWithTarget:self Sel:@selector(clickWebData)];
    webData.backgroundColor = [UIColor colorWithHexString:@"00b7c7"];
    [self.view addSubview:webData];
    [webData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipManager.mas_bottom).offset(6);     //old 6
        make.left.equalTo(self.view);
        make.right.equalTo(myWeb);
        make.height.equalTo(myWeb);
    }];
    
    HomePageView * verify = [[HomePageView alloc]initWithTitleStr:@"验证功能"];
    verify.iconView.image = [UIImage imageNamed:@"HomePage_Verify"];
    verify.backgroundColor = [UIColor colorWithHexString:@"75aa00"];
    [verify addTapGRWithTarget:self Sel:@selector(clickVerify)];
    [self.view addSubview:verify];
    [verify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myWeb);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX).offset(3);   //old 6
        make.height.equalTo(myWeb);
    }];
    
    HomePageView * shop = [[HomePageView alloc]initWithTitleStr:@"旺铺工具"];
    shop.backgroundColor = [UIColor colorWithHexString:@"e8bb00"];
    shop.iconView.image = [UIImage imageNamed:@"HomePage_Shop"];
    [shop addTapGRWithTarget:self Sel:@selector(clickShop)];
    [self.view addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipManager);
        make.right.equalTo(self.view);
        make.left.equalTo(verify);
        make.height.equalTo(myWeb);
    }];
    
    HomePageView * setting = [[HomePageView alloc]initWithTitleStr:@"我的设置"];
    setting.iconView.image = [UIImage imageNamed:@"HomePage_Setting"];
    [setting addTapGRWithTarget:self Sel:@selector(clickSetting)];
    setting.backgroundColor = [UIColor colorWithHexString:@"2f8cf4"];
    [self.view addSubview:setting];
    [setting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(webData);
        make.right.equalTo(self.view);
        make.left.equalTo(verify);
        make.height.equalTo(myWeb);
    }];
}

- (void)clickVerify{
    //验证功能
    VerifyViewController *vVC = [[VerifyViewController alloc]init];
    [self.navigationController pushViewController:vVC animated:YES];
}

- (void)clickShop{
    //旺铺工具
    WinportToolsVC *winportVC = [[WinportToolsVC alloc]initWithNibName:@"WinportToolsVC" bundle:nil];
    [self.navigationController pushViewController:winportVC animated:YES];
}

- (void)clickSetting{
    //我的设置
    MySettingVC *vc = [[MySettingVC alloc]initWithNibName:@"MySettingVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushToWinport:(id)sender {

    WinportToolsVC *winportVC = [[WinportToolsVC alloc]initWithNibName:@"WinportToolsVC" bundle:nil];
    [self.navigationController pushViewController:winportVC animated:YES];
    
    
}

- (void)pushWeiZhanAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[MyWeiZhanVC alloc]init] animated:YES];
}


- (void)pushToVipMangerVC{
    [self.navigationController pushViewController:[[VipManagerViewController alloc]init] animated:YES];
}

- (void)clickWebData{
    DataCountVC *vc=[[DataCountVC alloc]initWithNibName:nil bundle:nil] ;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    /////////////////////
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
