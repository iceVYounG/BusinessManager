//
//  ResetPasswordVC.m
//  BusinessManager
//
//  Created by 朕 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "LoginVC.h"

@interface ResetPasswordVC ()
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldPassTF;
@property (weak, nonatomic) IBOutlet UITextField *resetPassTF;
@property (weak, nonatomic) IBOutlet UITextField *resetPassAgainTF;

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 4.0f;
}


- (IBAction)confirmClick:(id)sender {
    if ([self.oldPassTF.text isEqualToString:@""]) {
        [OMGToast showWithText:@"请输入原密码"];
    }else if ([self.resetPassTF.text isEqualToString:@""]) {
        [OMGToast showWithText:@"请输入新密码"];
    }else if ([self.resetPassAgainTF.text isEqualToString:@""]) {
        [OMGToast showWithText:@"请再次输入新密码"];
    }
    else if ([self.oldPassTF.text isEqualToString:self.resetPassTF.text])
    {
        [OMGToast showWithText:@"新密码和原密码相同"];
    }
    else if(![self.resetPassTF.text isEqual:self.resetPassAgainTF.text])
    {
        [OMGToast showWithText:@"两次新密码输入不一致"];
    }
    else if(self.resetPassTF.text.length < 5 || self.resetPassAgainTF.text.length < 5)
    {
        [OMGToast showWithText:@"密码不能低于五位!"];
    }
    else
    {
//        self.confirmBtn.enabled = NO;
        [self changePassRequest];
    }
    
}

- (void)changePassRequest
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.linkPhone, @"") forKey:@"linkPhone"];
    [params setObject:[self.oldPassTF.text md5] forKey:@"pwd"];
    [params setObject:[self.resetPassTF.text md5] forKey:@"newPwd"];
    [[MallNetManager share] request:API_CHANGEPASS parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success == %@",responseObject);
        
        if (Succeed(responseObject)) {
            [OMGToast showWithText:@"修改成功"];
            
            LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [OMGToast showWithText:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];
//    [[MallNetworkEngine loginshare]requestWithDate:self.requestDate requestWithPath:API_CHANGEPASS Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSDictionary *dic = [completedOperation responseDecodeToDic];
//        if ([[dic objectForKey:@"code"]isEqualToString:@"00-00"]) {
//            [OMGToast showWithText:@"修改成功"];
//        }else
//        {
//            [OMGToast showWithText:[dic objectForKey:@"msg"]];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        self.confirmBtn.enabled = YES;
//    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"错误信息--%@",error);
//        self.confirmBtn.enabled = YES;
//        [OMGToast showWithText:@"服务器忙，请稍后再试"];
//    }];
}

@end
