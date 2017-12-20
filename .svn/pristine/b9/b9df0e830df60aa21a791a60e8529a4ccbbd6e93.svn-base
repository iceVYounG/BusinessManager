//
//  MPBuyMessageVC.m
//  BusinessManager
//
//  Created by 周迎春 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MPBuyMessageVC.h"
#import "MPBuyNotesVC.h"
#import "MsgPushModel.h"
#import "MPBuySMSVC.h"

#define count_1000 @"1000"
#define pay_80 @"80"
#define msgGoodsId_1000 @"1509"

#define count_3000 @"3000"
#define pay_210 @"210"
#define msgGoodsId_3000 @"1510"

#define count_5000 @"5000"
#define pay_300 @"300"
#define msgGoodsId_5000 @"1511"


@interface MPBuyMessageVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *Btn80;
@property (weak, nonatomic) IBOutlet UIButton *Btn210;
@property (weak, nonatomic) IBOutlet UIButton *Btn300;

@property (weak, nonatomic) IBOutlet UILabel *leaveMsgNum;

@property (weak, nonatomic) IBOutlet UIButton *InstanceBuyBtn;
@property (weak, nonatomic) IBOutlet UITextField *inPutTF;
@property (weak, nonatomic) IBOutlet UILabel *msgNumberLB;

@property (weak, nonatomic) IBOutlet UILabel *label_80;
@property (weak, nonatomic) IBOutlet UILabel *label_210;
@property (weak, nonatomic) IBOutlet UILabel *label_300;
@property (weak, nonatomic) IBOutlet UILabel *payAccountLab;
@property (weak, nonatomic) IBOutlet UILabel *cost_80;
@property (weak, nonatomic) IBOutlet UILabel *cost_210;
@property (weak, nonatomic) IBOutlet UILabel *cost_300;

- (IBAction)btn_80_Click:(UIButton *)sender;
- (IBAction)btn_210_click:(UIButton *)sender;
- (IBAction)btn_300_click:(UIButton *)sender;
- (IBAction)buyBtnClick:(UIButton *)sender;

@end

@implementation MPBuyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.leftTitle = @"购买短信";
    self.title = @"购买短信";
    self.leaveMsgNum.text = NoNullStr(self.leaveNum, @"0");
    //购买记录buyNotes
    UIBarButtonItem *buyNotesBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"购买记录" style:UIBarButtonItemStylePlain target:self action:@selector(buyNotesAction)];
    self.navigationItem.rightBarButtonItem = buyNotesBarBtn;
    
    self.inPutTF.delegate = self;
    self.inPutTF.keyboardType = UIKeyboardTypeNumberPad;
    //设置购买短信btn属性
    [self setBtnsBorderCornerRadioWithUIview:self.Btn80 ColorString:@"#00aaee"];
    [self setBtnsBorderCornerRadioWithUIview:self.Btn210 ColorString:@"#00aaee"];
    [self setBtnsBorderCornerRadioWithUIview:self.Btn300 ColorString:@"#00aaee"];
    [self setBtnsBorderCornerRadioWithUIview:self.InstanceBuyBtn ColorString:@"#00aaee"];
    [self setBtnsBorderCornerRadioWithUIview:self.inPutTF ColorString:@"#e5e5e5"];
    
    self.Btn80.selected = NO;
    self.Btn210.selected = NO;
    self.Btn300.selected = NO;
    self.payAccountLab.text = @"0.00 元";
    
    //监听textfield输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:self.inPutTF];
    //交易后刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewDatas:) name:@"MP_BUYMSGVC_REFRESHDATAS" object:nil];
    
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.inPutTF];
}

#pragma mark - textfield输入进入方法 -
- (void)textFiledEditChanged:(NSNotification *)sender{
    
    self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：%@ 条",self.inPutTF.text];
    if ([self.inPutTF.text isEqualToString:count_1000]) {
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_80];
        [self btn_80_Click:nil];
        return;
    }
    if ([self.inPutTF.text isEqualToString:count_3000]) {
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_210];
        [self btn_210_click:nil];
        return;
    }
    if ([self.inPutTF.text isEqualToString:count_5000]) {
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_300];
        [self btn_300_click:nil];
        return;
    }
    
    [self recoveryDeSelectedBtn_80];
    [self recoveryDeselectedBtn_210];
    [self recoveryDeselected_300];
    
    NSUInteger msgAccount = [self.inPutTF.text integerValue];
    //显示的金额数  单位： 元  0.1元/条
    self.payAccountLab.text = [NSString stringWithFormat:@"%.2f 元", msgAccount * 0.1];
}

#pragma mark - TextFieldDelegate -
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.inPutTF.text isEqualToString:@""]) {
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：0 条"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length > 3) {
        return NO;
    }
    if ([string isValidateNumber]) {
        return YES;
    }else {
        return NO;
    }
//    return YES;
}

#pragma mark - 设置购买短信btn属性 -
-(void)setBtnsBorderCornerRadioWithUIview:(UIView *)btn ColorString:(NSString *)colorStr{
    btn.layer.borderWidth = 0.5f;
    btn.layer.borderColor = [UIColor colorWithHexString:colorStr].CGColor;
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = YES;
}
#pragma mark - 跳转购买记录页面 -
- (void)buyNotesAction
{
    MPBuyNotesVC *buyNotesVC = [[MPBuyNotesVC alloc]initWithNibName:@"MPBuyNotesVC" bundle:nil];
    [self.navigationController pushViewController:buyNotesVC animated:YES];
}


#pragma mark - 请求
/*
*   amount: 金额    单位：分
*   totalQuantity:短信条数
*   msgGoodsId: 商品类型 对应商品ID, 自定义则为@"";
*
*/
- (void)requestBuySMSPackageDataWith:(NSString *)msgGoodsId amount:(long)amount totalQuantity:(NSString *)totalQuantity {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *account = NoNullStr(AccountInfo.storeId, @"");
    double storeId = [account doubleValue];
    [params setObject:@(storeId) forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.linkPhone, @"") forKey:@"mobile"];
    [params setObject:@(amount) forKey:@"amount"];     //金额
    [params setObject:NoNullStr(totalQuantity, @"") forKey:@"totalQuantity"];   //总条数
    [params setObject:NoNullStr(msgGoodsId, @"") forKey:@"msgGoodsId"];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:@"请稍等..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_MessagePush_buySMSPackage Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@">>>>>>:%@",dic);

        if (Succeed(dic)) {  //minimumDismissTimeInterval
            [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showInfoWithStatus:@"正在跳转到支付页面..."];
            
            NSDictionary *data = [dic objectForKey:@"data"];
            NSString *url = [data objectForKey:@"REDIRECT_URL"];
            //跳往支付地址
            [self turnToBuyWebViewWith:url];
            
        }else {
            [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"交易失败！"];
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍后再试！"];
    }];
}

- (void)refreshNewDatas:(NSNotification *)notifi {
    NSString *name = notifi.name;
    if ([name isEqualToString:@"MP_BUYMSGVC_REFRESHDATAS"]) {
        [self requestLeaveMsgAccount];
    }
}

#pragma mark - 请求剩余短信条数

- (void)requestLeaveMsgAccount {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *account = NoNullStr(AccountInfo.storeId, @"");
    double storeId = [account doubleValue];
    [params setObject:@(storeId) forKey:@"storeId"];  //商户ID
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_MPBuyMessage_leaveMsgNum Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSDictionary *dataDic = dic[@"data"];
        if (Succeed(dic)) {
            self.leaveMsgNum.text = [NSString stringWithFormat:@"%@ 条", dataDic[@"num"]];
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - Btn_Action

- (IBAction)btn_80_Click:(UIButton *)sender {
    [self.Btn80 setSelected:!self.Btn80.selected];
    if (self.Btn80.selected) {
        [self settingSelectedBtn_80];
         self.inPutTF.text = @"1000";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：1000 条"];
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_80];
    }else {
        [self recoveryDeSelectedBtn_80];
         self.inPutTF.text = @"";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：0 条"];
    }
    
    [self recoveryDeselectedBtn_210];
    [self recoveryDeselected_300];
   
    
}

- (IBAction)btn_210_click:(UIButton *)sender {
    [self.Btn210 setSelected:!self.Btn210.selected];
    if (self.Btn210.selected) {
        [self settingSelectedBtn_210];
         self.inPutTF.text = @"3000";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：3000 条"];
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_210];
        
    }else {
        [self recoveryDeselectedBtn_210];
         self.inPutTF.text = @"";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：0 条"];
    }
    
    [self recoveryDeSelectedBtn_80];
    [self recoveryDeselected_300];
    
}

- (IBAction)btn_300_click:(UIButton *)sender {
    [self.Btn300 setSelected:!self.Btn300.selected];
    if (self.Btn300.selected) {
        [self settingSelectedBtn_300];
         self.inPutTF.text = @"5000";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：5000 条"];
        self.payAccountLab.text = [NSString stringWithFormat:@"%@.00 元", pay_300];
        
    }else {
        [self recoveryDeselected_300];
         self.inPutTF.text = @"";
        self.msgNumberLB.text = [NSString stringWithFormat:@"短信条数 ：0 条"];
    }
    
    [self recoveryDeselectedBtn_210];
    [self recoveryDeSelectedBtn_80];
    
}


//设置 btn80 选中状态
- (void)settingSelectedBtn_80 {
    self.Btn80.backgroundColor = [UIColor colorWithHexString:@"#01aaef"];
    self.Btn80.layer.borderColor = [UIColor colorWithHexString:@"#01aaef"].CGColor;
    self.Btn80.layer.borderWidth = 0.5f;
    self.Btn80.layer.cornerRadius = 5.0f;
    self.Btn80.layer.masksToBounds = YES;
    [self.label_80 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.cost_80 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];

}
//还原 Btn80 未选中状态
- (void)recoveryDeSelectedBtn_80 {
    self.Btn80.selected = NO;
    self.Btn80.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.Btn80.layer.borderColor = [UIColor colorWithHexString:@"#00aaee"].CGColor;
    self.Btn80.layer.borderWidth = 0.5f;
    self.Btn80.layer.cornerRadius = 5.0f;
    self.Btn80.layer.masksToBounds = YES;
    [self.label_80 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
    [self.cost_80 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
    
}

//设置 btn210 选中状态
- (void)settingSelectedBtn_210 {
    self.Btn210.backgroundColor = [UIColor colorWithHexString:@"#01aaef"];
    self.Btn210.layer.borderColor = [UIColor colorWithHexString:@"#01aaef"].CGColor;
    self.Btn210.layer.borderWidth = 0.5f;
    self.Btn210.layer.cornerRadius = 5.0f;
    self.Btn210.layer.masksToBounds = YES;
    [self.label_210 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.cost_210 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];

}

//还原 btn210 未选中状态
- (void)recoveryDeselectedBtn_210 {
//    if (self.Btn210.selected) {
        self.Btn210.selected = NO;
        self.Btn210.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.Btn210.layer.borderColor = [UIColor colorWithHexString:@"#00aaee"].CGColor;
        self.Btn210.layer.borderWidth = 0.5f;
        self.Btn210.layer.cornerRadius = 5.0f;
        self.Btn210.layer.masksToBounds = YES;
        [self.label_210 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
        [self.cost_210 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
        
//    }
}

//设置 btn300 选中状态
- (void)settingSelectedBtn_300 {
    self.Btn300.backgroundColor = [UIColor colorWithHexString:@"#01aaef"];
    self.Btn300.layer.borderColor = [UIColor colorWithHexString:@"#01aaef"].CGColor;
    self.Btn300.layer.borderWidth = 0.5f;
    self.Btn300.layer.cornerRadius = 5.0f;
    self.Btn300.layer.masksToBounds = YES;
    [self.label_300 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self.cost_300 setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
}

//荒原 btn300 未选中状态
- (void)recoveryDeselected_300 {
//    if (self.Btn300.selected) {
        self.Btn300.selected = NO;
        self.Btn300.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.Btn300.layer.borderColor = [UIColor colorWithHexString:@"#00aaee"].CGColor;
        self.Btn300.layer.borderWidth = 0.5f;
        self.Btn300.layer.cornerRadius = 5.0f;
        self.Btn300.layer.masksToBounds = YES;
        [self.label_300 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
        [self.cost_300 setTextColor:[UIColor colorWithHexString:@"#00aaee"]];
        
//    }
}


#pragma mark - 取消键盘 -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inPutTF resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 购买短信
- (IBAction)buyBtnClick:(UIButton *)sender {
    self.inPutTF.enabled = NO;
    self.Btn80.enabled = NO;
    self.Btn210.enabled = NO;
    self.Btn300.enabled = NO;
    
    //过滤非数字输入
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self.inPutTF.text]) {
        self.inPutTF.enabled = YES;
        self.Btn80.enabled = YES;
        self.Btn210.enabled = YES;
        self.Btn300.enabled = YES;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
        
        [self.inPutTF becomeFirstResponder];
        return;
    }
    
    //过滤 空字符 和 0 , < 1 的输入
    NSInteger msgAccount = [self.inPutTF.text integerValue];
    if (self.inPutTF.text.length == 0 || [self.inPutTF.text isEqualToString:@""] || [self.inPutTF.text isEqualToString:@"0"] || msgAccount < 1) {
        self.inPutTF.enabled = YES;
        self.Btn80.enabled = YES;
        self.Btn210.enabled = YES;
        self.Btn300.enabled = YES;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"最少购买 1 条短信！"];
        
        [self.inPutTF becomeFirstResponder];
        return;
    }
    //过滤 0012这样的非法输入
    NSString *firstStr = [self.inPutTF.text substringToIndex:1];
    if ([firstStr isEqualToString:@"0"] ) {
        self.inPutTF.enabled = YES;
        self.Btn80.enabled = YES;
        self.Btn210.enabled = YES;
        self.Btn300.enabled = YES;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入正确内容！"];
        
        [self.inPutTF becomeFirstResponder];
        return;
    }
    NSInteger num = [self.inPutTF.text integerValue];
    if (num > 9999) {
        self.inPutTF.enabled = YES;
        self.Btn80.enabled = YES;
        self.Btn210.enabled = YES;
        self.Btn300.enabled = YES;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"购买数量不得超过9999条！"];
        [self.inPutTF becomeFirstResponder];
        return;
    }
    
    NSString *msgGoodsId;
    if ([self.inPutTF.text isEqualToString:count_1000]) {
        msgGoodsId = msgGoodsId_1000;
    }else if ([self.inPutTF.text isEqualToString:count_3000]) {
        msgGoodsId = msgGoodsId_3000;
    }else if ([self.inPutTF.text isEqualToString:count_5000]) {
        msgGoodsId = msgGoodsId_5000;
    }else {
        msgGoodsId = @"";
    }
    //金额
    NSString *payStr = [self.payAccountLab.text stringByReplacingOccurrencesOfString:@" 元" withString:@""];
    double payCount = [payStr doubleValue];       //单位是 元
    long amount = (long)(payCount * 100);          //单位是 分
    //短信条数
    NSString *total = self.inPutTF.text;    //短信条数
    
    [self requestBuySMSPackageDataWith:msgGoodsId amount:amount totalQuantity:total];
    
    self.inPutTF.enabled = YES;
    self.Btn80.enabled = YES;
    self.Btn210.enabled = YES;
    self.Btn300.enabled = YES;
    
}

- (void)turnToBuyWebViewWith:(NSString *)url {
    MPBuySMSVC *vc = [[MPBuySMSVC alloc] initWithNibName:@"MPBuySMSVC" bundle:nil];
    vc.url = url;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
