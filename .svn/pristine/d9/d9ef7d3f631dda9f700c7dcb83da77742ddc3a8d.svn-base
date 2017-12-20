//
//  RegisterVC.h
//  BusinessManager
//
//  Created by xiong on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#import "HomeController.h"
#import "WebViewController.h"

typedef void (^RegisterSuccessBlock)(NSString *phone,NSString *pwd);

@interface RegisterVC : BaseController<UIGestureRecognizerDelegate>{
    

    NSInteger downtimer;
    NSTimer *timer;
    
}

@property (copy, nonatomic) RegisterSuccessBlock registerBlock;     //注册回调
@property (weak, nonatomic) IBOutlet UITextField *usernametext;     //企业名或者商户名
@property (weak, nonatomic) IBOutlet UITextField *userphonetext;    //手机号码
@property (weak, nonatomic) IBOutlet UITextField *smscodetext;      //短信验证码
@property (weak, nonatomic) IBOutlet UITextField *userpasswdtext;   //用户密码
@property (weak, nonatomic) IBOutlet UIButton *smscodebtn;          //获取短信验证码
@property (strong, nonatomic) NSString *getcodestr;  //发送的验证码
@property (weak, nonatomic) IBOutlet UIButton *registerbtn;



- (IBAction)registerAction:(UIButton *)sender;           //请求注册
- (IBAction)businessprotocalAction:(UIButton *)sender;   //商户宝协议

@end
