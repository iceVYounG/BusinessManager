//
//  CloseliLoginViewController.m
//  BusinessManager
//
//  Created by wesley on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CloseliLoginViewController.h"
#import "HomeVideoMainVC.h"

@interface CloseliLoginViewController ()

@end

@implementation CloseliLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    
   

}

-(void)initView{
    self.title = @"手机看店";

    if (SCREEN_SIZE.width<330) {
        [self.phoneTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        [self.pwdTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    
    [self.loginBtn addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onLoginClick:(UIButton *)btn{
  
    if([self checkInput]){
        [self requestUserLogin];
    }
    
    
}

-(BOOL)checkInput{
    
    //用户名大于零即可
    if (self.phoneTextField.text.length ==0) {
        
        [OMGToast showWithText:@"请输入手机号码"];
        return NO;
    }
    
    
    if (self.pwdTextField.text.length == 0) {
        
        [OMGToast showWithText:@"请输入密码/短信验证码"];
        return NO;
    }


    return YES;
}



-(void)requestUserLogin{
    
    NSError *error = nil;
    CloudUserInfo *userinfo;
    userinfo = [[CloseliApiManager share] loginWithEmail:self.phoneTextField.text withPassword:self.pwdTextField.text error:&error];
    if (userinfo) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setObject:NoNullStr(AccountInfo.storeId, @"")  forKey:@"storeId"];
        [paramDic setObject:NoNullStr(AccountInfo.linkPhone, @"")  forKey:@"storeMobile"];

        [paramDic setObject:NoNullStr(self.phoneTextField.text, @"")  forKey:@"shopviewMobile"];
        [paramDic setObject:NoNullStr(self.pwdTextField.text, @"")  forKey:@"shopviewPassword"];
        [paramDic setObject:@"1"  forKey:@"type"];//1：商户宝2：12580
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD showWithStatus:@"数据请求中..."];
        [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_userBinding Params:paramDic CompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSDictionary *dic = [completedOperation responseDecodeToDic];
            NSString *code = [dic objectForKey:@"code"];
            NSString *msg = [dic objectForKey:@"msg"];
            if ([code isEqualToString:@"00-00"]) {
                
                HomeVideoMainVC *vc = [[HomeVideoMainVC alloc] initWithNibName:@"HomeVideoMainVC" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                [SVProgressHUD dismiss];
                [OMGToast showWithText:msg];
            }
            NSLog(@"%@",dic);
        } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
        }];

        
      
        
    }else{
        
        [[CloseliApiManager share] showAlertOfError:error];
    }

    
    
    
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
