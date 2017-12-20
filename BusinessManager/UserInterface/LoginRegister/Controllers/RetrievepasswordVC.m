//
//  RetrievepasswordVC.m
//  BusinessManager
//
//  Created by 朕 on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "RetrievepasswordVC.h"

@interface RetrievepasswordVC () <UIGestureRecognizerDelegate>{
    
    NSDate *resignBackgroundDate;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;  //手机号码
@property (weak, nonatomic) IBOutlet UITextField *testingTF;   //验证码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;  //密码
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;      //提交
@property (weak, nonatomic) IBOutlet UIButton *getTestBtn;     //获取验证码

@end

@implementation RetrievepasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self initView];
    
    //添加点击手势
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    tapGr.delegate=self;
    [self.view addGestureRecognizer:tapGr];
    
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
//     self.navigationController.navigationBar.hidden = NO;
    [self.phoneNumTF becomeFirstResponder];
    

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [timer invalidate];  //离开界面，清空计时器
    timer = nil;
    [self.phoneNumTF resignFirstResponder];
//    self.navigationController.navigationBar.hidden = YES;
    

}



- (void)initView
{
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 4.0f;
    self.getTestBtn.layer.cornerRadius = 3.0f;   //获取验证码
    self.getTestBtn.layer.borderWidth = 0.50f;
    self.getTestBtn.layer.borderColor = [UIColor colorWithHexString:@"#01AAEF"].CGColor;
}




- (IBAction)getTestClick:(id)sender {
    
    //判断11位手机号码
    if ([self.phoneNumTF.text length] == 11 && [self.phoneNumTF.text judgeTelephone]) {
        
        
        downtimer = 60;
        self.getTestBtn.enabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(addTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        
        NSMutableDictionary *manger = [NSMutableDictionary dictionary];
        [manger setObject:self.phoneNumTF.text forKey:@"linkPhone"];
        
        [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_SmsCodeHost Params:manger CompletionHandler:^(MKNetworkOperation *completedOperation) {
            
            NSDictionary *dic = [completedOperation responseDecodeToDic];
            
            if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"]) {
                
                NSDictionary *tempdic = [dic objectForKey:@"data"];
                self.getcodestr = [tempdic objectForKey:@"smsCode"];
                NSLog(@"发送成功");
                
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
        
        [OMGToast showWithText:@"请输入注册手机号码"];
    }

}


- (IBAction)submitClick:(id)sender {
    
    if ( ![self checkInput]) {
        
        return;
    }
    
    NSMutableDictionary *manger = [NSMutableDictionary dictionary];
    
    [manger setObject:self.phoneNumTF.text forKey:@"linkPhone"];
    [manger setObject:[self.testingTF.text md5] forKey:@"smsCode"];
    [manger setObject:[self.passwordTF.text md5] forKey:@"pwd"];
    
    [SVProgressHUD showWithStatus:@"正在修改中.."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_retrievePwdHost Params:manger CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"]) {
            
            NSLog(@"修改成功！！");
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
       [OMGToast showWithText:[dic objectForKey:@"msg"]];
        
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD dismiss];
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
        
    }];
    
}

-(void)addTimer{
    
    downtimer = downtimer - 1;
    
    if (downtimer <= 0) {
        [self.getTestBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        self.getTestBtn.enabled = YES;
    }
    else {
        
        
        NSString *title = [NSString stringWithFormat:@"重新获取(%lds)", (long)downtimer];
        [self.getTestBtn setTitle:title forState:UIControlStateNormal];
    }
} 

-(BOOL)checkInput{
    
    if ([self.phoneNumTF.text length] !=11) {
        
        [OMGToast showWithText:@"请输入注册手机号码"];
        return NO;
    }
    
    
    
    
    if(![self.testingTF.text isEqualToString:self.getcodestr]){
        
        if ([self.testingTF.text isEqualToString:@""]) {
            [OMGToast showWithText:@"请输入验证码"];
        }
        else{
            
            [OMGToast showWithText:@"验证码不正确"];
        }
        
        return NO;
    }
    
    if([self.passwordTF.text length] <5 ){
        
        if([self.passwordTF.text isEqualToString:@""]){
            
            [OMGToast showWithText:@"请输入密码"];
        }
        
        else{
            
            [OMGToast showWithText:@"密码至少为5位"];
        }
        
        return NO;
    }
    
    return YES;
}



- (void)viewTapped
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
