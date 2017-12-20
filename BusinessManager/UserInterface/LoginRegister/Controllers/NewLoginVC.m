//
//  NewLoginVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/9/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "NewLoginVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"
#import "BaseNavigationController.h"
#import "WeiZhanMainVC.h"
@interface NewLoginVC ()
{
    NSString *username;
    NSString *userpasswd;
}
@property (weak, nonatomic) IBOutlet UIButton *tiYanBtn;

@end

@implementation NewLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.backItemHiden=YES;
    
    }

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden=NO;

}

-(void)initView{
    self.loginBtn.layer.cornerRadius=20;
    self.registBtn.layer.cornerRadius=20;
    self.registBtn.layer.borderWidth=1;
    self.registBtn.layer.borderColor=[UIColor colorWithHexString:@"#00aaee"].CGColor;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"快速体验建站>"];
    NSRange strRange = {0,[str length]};
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#f1594b"] range:strRange];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [ self.tiYanBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    
    
    if (SCREEN_SIZE.height<500) {
        self.qiDongImageView.image=[UIImage imageNamed:@"qiDongImage-4"];
    }
    else if (SCREEN_SIZE.height<600)
    {
     self.qiDongImageView.image=[UIImage imageNamed:@"qiDongImage-5"];
    
    }
   
    else{
     self.qiDongImageView.image=[UIImage imageNamed:@"qiDongImg"];
    
    }
}

- (IBAction)tiyanVStation:(id)sender {
    
    WeiZhanMainVC *vc=[[WeiZhanMainVC alloc]init];

    AccountInfo.isTiyan=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)gotoLogin:(id)sender {
    
    HomeController* homeVC = [[HomeController alloc]init];
    LoginVC* loginVC = [[LoginVC alloc]initWithBlock:^{
        UIViewController *vc = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
        UIWindow *topWindow = [[UIApplication sharedApplication].delegate window];
        topWindow.rootViewController=vc;

    }];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
- (IBAction)gotoRegist:(id)sender {
    WS(weakSelf);
    RegisterVC *vc = [[RegisterVC alloc]initWithNibName:@"RegisterVC" bundle:nil];
    vc.registerBlock = ^(NSString *phone,NSString *pwd){
        
        [weakSelf requestLogin:phone andPassword:pwd];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)requestLogin:(NSString *)userName andPassword:(NSString *)passWd{
    
    NSMutableDictionary *manger = [NSMutableDictionary dictionary];
    username = userName;
    userpasswd = [passWd md5];
    
    [manger setObject:username forKey:@"name"];
    [manger setObject:userpasswd forKey:@"pwd"];
    //登录改为测试地址以测试会员管理
    [[MallNetworkEngine vipCardMGshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LoginHost Params:manger CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *dic=[completedOperation responseDecodeToDic];
        
        if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"])  {
            
            NSLog(@"登录成功");
            NSDictionary *tempdic = [dic objectForKey:@"data"];
            AccountInfo.storeId = [tempdic objectForKey:@"storeId"];
            AccountInfo.storeName = [tempdic objectForKey:@"storeName"];
            AccountInfo.linkPhone = [tempdic objectForKey:@"linkPhone"];
            AccountInfo.b2cmsg = [tempdic objectForKey:@"b2cmsg"];
            AccountInfo.b2cStoreId = [tempdic objectForKey:@"b2cStoreId"];
            AccountInfo.isLogin = YES;
            NSString *b2cString=[tempdic objectForKey:@"b2cStoreId"];
            if (b2cString.length>0) {
                AccountInfo.dianShangName=userName;
            }
            else{
                AccountInfo.dianShangName=@"";
            }

            
            HomeController *vc = [[HomeController alloc]initWithNibName:@"HomeController" bundle:nil];
            UIViewController *nvc=[[BaseNavigationController alloc]initWithRootViewController:vc];
            UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
                    topWindow.rootViewController=nvc;
            
        }
        else{
            
            [OMGToast showWithText:[dic objectForKey:@"msg"]];
        }
        
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
