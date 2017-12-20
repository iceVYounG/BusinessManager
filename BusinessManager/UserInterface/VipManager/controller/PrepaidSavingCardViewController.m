//
//  PrepaidSavingCardViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "PrepaidSavingCardViewController.h"
#import "PrepaidSavingCardView.h"
#import "VMRechargeRecordVC.h"
#import "StringHelper.h"

@interface PrepaidSavingCardViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) PrepaidSavingCardView *prepaidSavingCardView;

@end

@implementation PrepaidSavingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"储值卡充值";
    //右上角button
    [self setUpButton];
    
    self.prepaidSavingCardView = [[PrepaidSavingCardView alloc]init];
    [self.prepaidSavingCardView.perpaidButton addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.prepaidSavingCardView.moneyLabel.text = [NSString stringWithFormat:@"%@ 元", self.balance];
    self.prepaidSavingCardView.moneyTF.delegate = self;
//    self.buyAccountTF = self.prepaidSavingCardView.moneyTF;
    [self.view addSubview:self.prepaidSavingCardView];
    [self.prepaidSavingCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.equalTo(self.view);
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //移除通知
//    [self.prepaidSavingCardView removeNotifiFromPrepaidSavingCardView];
}

- (void)setUpButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitle:@"充值记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(rechargeRecordClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITextFieldDelegate 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    double num = [textField.text doubleValue];
////    NSInteger count = num *  100 / 1.0;
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    if (num < 1) {
//        if (textField.text.length > 3) {
//            return NO;
//        }
////        return NO;
//    }
//    return YES;
    return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:3];
}


#pragma mark - 购买
- (void)buyBtnClick {
    
    //过滤 空字符 和 0 的输入
    if (self.prepaidSavingCardView.moneyTF.text.length == 0 || [self.prepaidSavingCardView.moneyTF.text isEqualToString:@""] || [self.prepaidSavingCardView.moneyTF.text isEqualToString:@"0"]) {
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额！"];
        [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
        return;
    }
    //过滤非数字输入
//    NSString *regex = @"^[0-9]+$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    if (![pred evaluateWithObject:self.prepaidSavingCardView.moneyTF.text]) {
//
//        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
//        [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
//        
//        [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
//        return;
//    }
    //过滤 0012这样的非法输入
    NSString *firstStr = [self.prepaidSavingCardView.moneyTF.text substringToIndex:1];
    
    if ([firstStr isEqualToString:@"0"] ) {
        if (self.prepaidSavingCardView.moneyTF.text.length > 2) {
            NSString *secondStr = [self.prepaidSavingCardView.moneyTF.text substringFromIndex:1 toIndex:2];
            if (secondStr && [secondStr isEqualToString:@"."]) {
                double num = [self.prepaidSavingCardView.moneyTF.text doubleValue];
                if (num < 0.01) {
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                    [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
                    
                    [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
                    return;
                }
            }
        }else {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
            
            [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
            return;
        }
        
    }
    double num = [self.prepaidSavingCardView.moneyTF.text doubleValue];
    
    if (num > 1000000.00) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"充值金额不得超过999999元！"];
        [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
        return;
    }
    
    double account = [self.prepaidSavingCardView.moneyTF.text doubleValue];
//    double account = (double)money;
    if ([self.prepaidSavingCardView.moneyTF.text isEqualToString:@""] || self.prepaidSavingCardView.moneyTF.text.length == 0 || account < 0.01) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
        [self.prepaidSavingCardView.moneyTF becomeFirstResponder];
        return;
    }
    
    [self sendToRecharge:account];
    
}

#pragma mark - 充值记录Action
- (void)rechargeRecordClick {
    VMRechargeRecordVC *vc = [[VMRechargeRecordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 请求
- (void)sendToRecharge:(double)account {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(account) forKey:@"amt"];
    [params setObject:NoNullStr(self.vipUserID, @"")  forKey:@"cardId"];
    [params setObject:NoNullStr(AccountInfo.storeName, @"") forKey:@"storeName"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    
    [[MallNetworkEngine vipCardMGshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_recharge Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"----->>>:%@", dic);

        if (Succeed(dic)) {
            //请求余额
            [self requestYuerData];
            [SVProgressHUD showSuccessWithStatus:@"充值成功!"];
        }else {
  
            [SVProgressHUD showErrorWithStatus:@"充值失败!"];
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {

        [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试!"];
    }];
    
}


#pragma mark - 请求余额
- (void)requestYuerData {
    NSString *cardId = self.vipUserID;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@"900000000069" forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:cardId forKey:@"cardId"];
    
    [[MallNetworkEngine vipCardMGshare] requestNotEncodeWithDate:nil requestWithPath:API_VipCardManger_view Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            VipCardVipUserDetailModel *model = [VipCardVipUserDetailModel mj_objectWithKeyValues:[dic objectForKey:@"data"]];
            self.prepaidSavingCardView.moneyLabel.text = [NSString stringWithFormat:@"%@ 元", model.balance];
            //通过代理改变上一页面的余额值
            if ([self.prepaidSavingDelegate conformsToProtocol:@protocol(prepaidSavingCardVCDelegate)]
                &&
                [self.prepaidSavingDelegate respondsToSelector:@selector(prepaidSavingCardVCRefreshTheBalance:)]) {
                [self.prepaidSavingDelegate prepaidSavingCardVCRefreshTheBalance:[NSString stringWithFormat:@"%@元", model.balance]];
            }
        }else {
            
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
}



#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end