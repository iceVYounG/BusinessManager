//
//  RegisterVC.m
//  BusinessManager
//
//  Created by xiong on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC (){
    
    NSDate *resignBackgroundDate;
}

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self initView];
}

-(void)initView{
    
    //添加点击手势
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    tapGr.delegate=self;
    [self.view addGestureRecognizer:tapGr];
    
    self.registerbtn.layer.cornerRadius = 4;
    self.smscodebtn.layer.cornerRadius = 3;   //获取验证码
    self.smscodebtn.layer.borderWidth = 0.5;
    self.smscodebtn.layer.borderColor = [UIColor colorWithHexString:@"#01AAEF"].CGColor;
    [self.smscodebtn addTarget:self action:@selector(sendSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActiveToRecordState)
                                                 name:NOTIFICATION_RESIGN_ACTIVE
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActiveToRecordState)
                                                 name:NOTIFICATION_BECOME_ACTIVE
                                               object:nil];
 
}

- (void)resignActiveToRecordState
{
    resignBackgroundDate = [NSDate date];
}

- (void)becomeActiveToRecordState
{
    NSTimeInterval timeHasGone = [[NSDate date] timeIntervalSinceDate:resignBackgroundDate];
    downtimer = downtimer-timeHasGone;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    [self.usernametext becomeFirstResponder];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [self.usernametext resignFirstResponder];
    
    [timer invalidate];  //离开界面，清空计时器
    timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark-------------按钮的点击事件---------------

//获取验证码按钮点击事件
-(void)sendSmsCode:(UIButton *)sender{
    
    //判断11位手机号码
    if ([self.userphonetext.text length] == 11 && [self.userphonetext.text judgeTelephone]) {
        
        
        downtimer = 60;
        self.smscodebtn.enabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(addTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        NSMutableDictionary *manger = [NSMutableDictionary dictionary];
        [manger setObject:self.userphonetext.text forKey:@"linkPhone"];
        
        [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_SmsCodeHost Params:manger CompletionHandler:^(MKNetworkOperation *completedOperation) {
            
            NSDictionary *dic = [completedOperation responseDecodeToDic];
            
            if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"]) {
                
                NSLog(@"发送成功");
                
                NSDictionary *tempdic = [dic objectForKey:@"data"];
                
                self.getcodestr  = [tempdic objectForKey:@"smsCode"];  //请求到的验证码
                NSLog(@"%@",self.getcodestr);
                
                [OMGToast showWithText:@"发送成功！"];
            }
            
            else{
                
                [OMGToast showWithText:@"异常"];
            }
            
            
            
        } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            
            [OMGToast showWithText:@"服务器忙，请稍后再试！"];
        }];
 
    }
    
    else{
        
        [OMGToast showWithText:@"请输入正确的11位手机号码"];
    }
    
}

-(void)addTimer{
    
    downtimer = downtimer - 1;
    
    if (downtimer <= 0 ) {
        [self.smscodebtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        self.smscodebtn.enabled = YES;
    }
    else {
        
        NSString *title = [NSString stringWithFormat:@"重新获取(%lds)", (long)downtimer];
        [self.smscodebtn setTitle:title forState:UIControlStateNormal];
    }
    
}

-(BOOL)checkInput{
    
    if (self.usernametext.text.length==0) {
        
        [OMGToast showWithText:@"请输入商户或企业名称"];
        return NO;
    }
    if (self.usernametext.text.length>20) {
        [OMGToast showWithText:@"商户名称不能超过20位"];
        return NO;
    }
   if (self.userphonetext.text.length !=11){
        
        [OMGToast showWithText:@"请输入正确的11位手机号码"];
        return NO;
    }
    if (self.smscodetext.text.length != 5 || ![self.smscodetext.text isEqualToString:self.getcodestr]){
        
        if(self.smscodetext.text.length == 0){
           
            [OMGToast showWithText:@"请输入验证码"];
        }
        else{
            
            [OMGToast showWithText:@"验证码不正确"];
        }
        
        return NO;
    }
    if (self.userpasswdtext.text.length <5){
        
        if (self.userpasswdtext.text.length ==0) {
            
          [OMGToast showWithText:@"请设置您的登录密码"];
        }
        
        [OMGToast showWithText:@"密码至少为5位"];
        return NO;
    }
    
    return YES;
    
}

/*
 
 4.注册接口/register.chtml
 参数：
storeName：必传
linkPhone：必传
smsCode：必传，md5加密
pwd：必传,md5加密
version:必传，版本
 用例：
 入口参数：
 {
 "storeName":"苏州中心8号1001",
 "linkPhone":"18013149177",
 "smsCode":"f70287c490d07c052ba0c18e14cf82a1",
 "pwd":"4297f44b13955235245b2497399d7a93",
 "version":"ios1.0"
 }
 返回：
 {
 "code":"00-00",
 "msg":"操作成功",
 "data":
 {
 "storeId":"900000000200",
 "storeName":"苏州中心8号1001",
 "linkPhone":"18013149177",
 "storeCenterId":null,
 "scmsg":"查不到数据"
 }
 } 
 或  
 {
 "code":"02-05",
 "msg":"企业名称已存在"
 }
 
 */

//请求注册
- (IBAction)registerAction:(UIButton *)sender{

    if (![self checkInput]) {
        return;
    }
    
    NSMutableDictionary *manger = [NSMutableDictionary dictionary];
    
    [manger setObject:self.usernametext.text forKey:@"storeName"];       //商户名
    [manger setObject:self.userphonetext.text forKey:@"linkPhone"];      //手机号码
    [manger setObject:[self.getcodestr md5] forKey:@"smsCode"];          //验证码
    [manger setObject:[self.userpasswdtext.text md5]forKey:@"pwd"];      //密码
    
//    [SVProgressHUD showWithStatus:@"正在注册" maskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"正在注册中.."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_RegisterHost Params:manger CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"]) {
            
            //成功
            if (self.registerBlock) {
                
                self.registerBlock(self.userphonetext.text,self.userpasswdtext.text);
            }
//
//            NSDictionary *tempdic = [dic objectForKey:@"data"];
//            AccountInfo.storeId = [tempdic objectForKey:@"storeId"];
//            AccountInfo.storeName = [tempdic objectForKey:@"storeName"];
//            AccountInfo.linkPhone = [tempdic objectForKey:@"linkPhone"];

            //            AccountInfo.userPhone = self.userphonetext.text;
//            AccountInfo.userPasswd = [self.userpasswdtext.text md5];
            
//            HomeController *vc = [[HomeController alloc]initWithNibName:@"HomeController" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
        [OMGToast showWithText:[dic objectForKey:@"msg"]];

        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD dismiss];
        
        [OMGToast showWithText:@"服务器忙，请稍微再试！"];
    }];
    
}


//商户宝协议
- (IBAction)businessprotocalAction:(UIButton *)sender {
    
    /**/
    WebViewController *webview =[[WebViewController alloc] initWithUrl:API_aboutpProtocol];
    [self.navigationController pushViewController:webview animated:YES];
    
    
}

- (void)viewTapped
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
