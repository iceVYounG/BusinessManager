//
//  EditCardView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EditCardView.h"
#import "VipCardMessageTextField.h"
#import "AddVipLevelButton.h"
#import "VipCardModel.h"
#import "ChooseVipLevelView.h"
#import "StringHelper.h"


#define MAX_STARWORDS_LENGTH 40

@interface EditCardView ()<UITextFieldDelegate>

@property (nonatomic, strong) VipCardMessageTextField *vipCardMoneyTF;
@property (nonatomic, strong) VipCardMessageTextField *vipCardDiscountTF;
//@property (nonatomic, strong) UITextField *cardDiscountMsgTF;
@property (nonatomic, strong) UITextView *cardDiscountMsgTF;

@end

@implementation EditCardView

- (id)initWithType:(VipCard)type Bymodel:(VipCardModel *)model{
    self = [super init];
    if (self) {
//        [self setUIWith:type];
        _model = model;
        if ([_model.businessType isEqualToString:@"1"]) {
            [self setContentSize:CGSizeMake(KScreenWidth, 480)];
            [self setUIWith:VipCardSaving];
        }else{
            [self setContentSize:CGSizeMake(KScreenWidth, 430)];
            [self setUIWith:VipCardCoupon];
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self.cardDiscountMsgTF];
        
    }
    return self;
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self.cardDiscountMsgTF];

}

- (void)setUIWith:(VipCard)type{
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    backgroundView.layer.borderWidth = 1;
    [self addSubview:backgroundView];
    if(type == VipCardSaving){
        backgroundView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 392);
    }else{
        backgroundView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 342);
    }
//    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(12);
//        make.left.right.equalTo(self);
//        //计算出的view的高
//        if(type == VipCardSaving){
//            make.height.mas_equalTo(@391);
//        }else{
//            make.height.mas_equalTo(@342);
//        }
//    }];
    
    int lineCount;
    if (type == VipCardSaving) {
        lineCount = 7;
    }else{
        lineCount = 6;
    }
    for (int i = 0; i < lineCount; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [backgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(backgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            if (i == lineCount - 2) {
//                make.width.mas_equalTo(@196);
                make.right.equalTo(backgroundView).offset(-120);
            }else{
                make.right.equalTo(backgroundView);
            }
        }];
    }
    
    NSArray *labelNameArray;
    if (type == VipCardSaving) {
        labelNameArray = @[@"会员卡编号",@"会员卡类型",@"会员卡名称",@"会员卡金额",@"折扣",@"会员卡级别",@"折扣备注信息",@"有效期"];
    }else{
        labelNameArray = @[@"会员卡编号",@"会员卡类型",@"会员卡名称",@"折扣",@"会员卡级别",@"折扣备注信息",@"有效期"];
    }
    for (int i = 0; i < labelNameArray.count; i ++) {
        UILabel *msgNameLabel  =[[UILabel alloc]init];
        msgNameLabel.textAlignment = NSTextAlignmentLeft;
        msgNameLabel.text = labelNameArray[i];
        msgNameLabel.textColor = [UIColor blackColor];
        msgNameLabel.font = [UIFont systemFontOfSize:15];
        [backgroundView addSubview:msgNameLabel];
        [msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(backgroundView).offset(15);
            make.width.mas_equalTo(@110);
            make.top.equalTo(backgroundView).offset(i * 49);
        }];
    }
    
    VipCardMessageTextField *vipCardNumberTF = [[VipCardMessageTextField alloc]initWithPlaceholder:_model.vipCardId tailStr:nil];
    vipCardNumberTF.textColor = [UIColor colorWithHexString:@"#888888"];
    vipCardNumberTF.enabled = NO;
    [backgroundView addSubview:vipCardNumberTF];
    [vipCardNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(131);
        make.height.mas_equalTo(@48);
        make.right.equalTo(backgroundView);
        make.top.equalTo(backgroundView);
    }];
    
    
    NSString *vipCardName;
    if (type == VipCardSaving) {
        vipCardName = @"储值卡";
    }else if(type == VipCardCoupon){
        vipCardName = @"优惠卡";
    }
    VipCardMessageTextField *vipCardSavingTF = [[VipCardMessageTextField alloc]initWithPlaceholder:vipCardName tailStr:nil];
    vipCardSavingTF.textColor = [UIColor colorWithHexString:@"#888888"];
    vipCardSavingTF.enabled = NO;
    [backgroundView addSubview:vipCardSavingTF];
    [vipCardSavingTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipCardNumberTF);
        make.height.mas_equalTo(@48);
        make.right.equalTo(backgroundView);
        make.top.equalTo(backgroundView).offset(49);
    }];
    
    VipCardMessageTextField *vipCardTypeTF = [[VipCardMessageTextField alloc]initWithPlaceholder:_model.cardName tailStr:nil];
    vipCardTypeTF.textColor = [UIColor colorWithHexString:@"#888888"];
    vipCardTypeTF.enabled = NO;
    [backgroundView addSubview:vipCardTypeTF];
    [vipCardTypeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipCardNumberTF);
        make.height.mas_equalTo(@48);
        make.right.equalTo(backgroundView);
        make.top.equalTo(backgroundView).offset(98);
    }];
    
    //存储卡才会有金额 一栏
    if (type == VipCardSaving) {
        NSString *count;
        if (self.model.initialAmount && ![self.model.initialAmount isEqual:[NSNull class]]) {
            double num = [self.model.initialAmount doubleValue] / 100;
            count = [NSString stringWithFormat:@"%.2f", num];
        }else if (self.model.initialAmount) {
            count = [NSString stringWithFormat:@"%@",self.model.initialAmount];
        }
        
        //存储 金额
        _vipCardMoneyTF = [[VipCardMessageTextField alloc]initWithPlaceholder:count tailStr:@"元"];
        _vipCardMoneyTF.delegate = self;
        _vipCardMoneyTF.keyboardType = UIKeyboardTypeDecimalPad;
        _vipCardMoneyTF.font = [UIFont systemFontOfSize:15];
        [_vipCardMoneyTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        _vipCardMoneyTF.textColor = [UIColor blackColor];
        [backgroundView addSubview:_vipCardMoneyTF];
        [_vipCardMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vipCardNumberTF);
            make.height.mas_equalTo(@48);
            make.right.equalTo(backgroundView).offset(-62);
            make.top.equalTo(backgroundView).offset(147);
        }];
        //存储金额x 按钮
        UIButton *xButton1 = [[UIButton alloc]init];
        [xButton1 addTarget:self action:@selector(xbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        xButton1.tag = 10001;
        [xButton1 setImage:[UIImage imageNamed:@"VipCardManager_CancelImage"] forState:UIControlStateNormal];
        [backgroundView addSubview:xButton1];
        [xButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.right.equalTo(backgroundView).offset(-15);
            make.centerY.equalTo(_vipCardMoneyTF);
        }];
    }
    // 存储 折扣
    _vipCardDiscountTF = [[VipCardMessageTextField alloc]initWithPlaceholder:_model.discount tailStr:@"折"];
    _vipCardDiscountTF.delegate = self;
    _vipCardDiscountTF.font = [UIFont systemFontOfSize:15];
    [_vipCardDiscountTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    _vipCardDiscountTF.keyboardType = UIKeyboardTypeDecimalPad;
    _vipCardDiscountTF.textColor = [UIColor blackColor];
    [backgroundView addSubview:_vipCardDiscountTF];
    [_vipCardDiscountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipCardNumberTF);
        make.height.mas_equalTo(@48);
        make.right.equalTo(backgroundView).offset(-62);
        if (type == VipCardSaving) {
            make.top.equalTo(backgroundView).offset(147 + 49);
        }else{
            make.top.equalTo(backgroundView).offset(147);
        }
    }];
    //存储 折扣 x 按钮
    UIButton *xButton2 = [[UIButton alloc]init];
    [xButton2 setImage:[UIImage imageNamed:@"VipCardManager_CancelImage"] forState:UIControlStateNormal];
    [xButton2 addTarget:self action:@selector(xbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    xButton2.tag = 10002;
    [backgroundView addSubview:xButton2];
    [xButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.equalTo(backgroundView).offset(-15);
        make.centerY.equalTo(_vipCardDiscountTF);
    }];
   
    //新增会员卡级别
    AddVipLevelButton *addVipLevelButton = [[AddVipLevelButton alloc]init];
    [addVipLevelButton addTarget:self action:@selector(addVipLevelBtn) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:addVipLevelButton];
    [addVipLevelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_vipCardLevel);
        make.height.mas_equalTo(@40);
//        make.left.equalTo(_vipCardLevel.mas_right).offset(20);
        make.width.mas_equalTo(90);
        make.right.equalTo(backgroundView).offset(-15);
        if (type == VipCardSaving) {
            make.top.equalTo(backgroundView).offset(196 + 49 + 2);
        }else{
            make.top.equalTo(backgroundView).offset(196 + 2);
        }
        
    }];
    
    //卡级别   按钮
    _vipCardLevel = [[UIButton alloc]init];
    [_vipCardLevel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_vipCardLevel setTitle:_model.cardLevel forState:UIControlStateNormal];
    _vipCardLevel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _vipCardLevel.titleLabel.font = [UIFont systemFontOfSize:15];
    [_vipCardLevel addTarget:self action:@selector(clickVipCardLevel:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:_vipCardLevel];
    [_vipCardLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipCardNumberTF);
        //        make.size.mas_equalTo(CGSizeMake(70, 48));
        make.right.equalTo(addVipLevelButton.mas_left).offset(-5);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(addVipLevelButton);
        //        if (type == VipCardSaving) {
        //            make.top.equalTo(backgroundView).offset(196 + 49);
        //        }else{
        //            make.top.equalTo(backgroundView).offset(196);
        //        }
    }];
    
    //备注信息
    self.cardDiscountMsgTF = [[UITextView alloc]init];
    self.cardDiscountMsgTF.delegate = self;
//    _cardDiscountMsgTF.textColor = [UIColor blackColor];
    if([_model.remarks isKindOfClass:[NSNull class]]){
        [self.cardDiscountMsgTF setTextColor:[UIColor colorWithHexString:@"CCCCCC"]];
        self.cardDiscountMsgTF.text = @"无";
    }else{
        [self.cardDiscountMsgTF setTextColor:[UIColor blackColor]];
        self.cardDiscountMsgTF.text = _model.remarks;
    }
//    [_cardDiscountMsgTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
//    _cardDiscountMsgTF.textAlignment = NSTextAlignmentLeft;
    self.cardDiscountMsgTF.font = [UIFont systemFontOfSize:15];
    [backgroundView addSubview:_cardDiscountMsgTF];
    [self.cardDiscountMsgTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(vipCardNumberTF);
        make.right.equalTo(backgroundView);
        make.height.mas_equalTo(@43);
        if (type == VipCardSaving) {
            make.top.equalTo(backgroundView).offset(245 + 49);
        }else {
            make.top.equalTo(backgroundView).offset(245);
        }
        
    }];
    NSString *validityTime;
    if ([_model.validityTime isEqualToString:@"0"]) {
        validityTime = @"长期有效";
    }else {
        validityTime = [NSString stringWithFormat:@"自领卡之日起%@天内有效",_model.validityTime];
    }
    VipCardMessageTextField *vipCardUseDateTF = [[VipCardMessageTextField alloc]initWithPlaceholder:validityTime tailStr:nil];
    vipCardUseDateTF.textColor = [UIColor colorWithHexString:@"#888888"];
    vipCardUseDateTF.enabled = NO;
    vipCardUseDateTF.font = [UIFont systemFontOfSize:15];
//    vipCardUseDateTF.textColor = [UIColor blackColor];
    [backgroundView addSubview:vipCardUseDateTF];
    [vipCardUseDateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vipCardNumberTF);
        make.height.mas_equalTo(@48);
        make.right.equalTo(backgroundView).offset(-5);
        if (type == VipCardSaving) {
            make.top.equalTo(backgroundView).offset(294 + 49);
        }else{
            make.top.equalTo(backgroundView).offset(294);
        }
    }];
    
    //保存修改按钮
    UIButton *saveChangeButton = [[UIButton alloc]init];
    [saveChangeButton setTitle:@"保存修改" forState:UIControlStateNormal];
    [saveChangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveChangeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    saveChangeButton.layer.cornerRadius = 4;
    saveChangeButton.backgroundColor = [UIColor colorWithHexString:@"01aaef"];
    [saveChangeButton addTarget:self action:@selector(saveDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveChangeButton];
    [saveChangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(15);
        make.top.equalTo(backgroundView.mas_bottom).offset(17);
        make.height.mas_equalTo(@44);
        make.right.equalTo(backgroundView.mas_centerX).offset(-8.5);
    }];
    
    //删除会员卡  按钮
    UIButton *deleteVipCard = [[UIButton alloc]init];
    [deleteVipCard setTitle:@"删除会员卡" forState:UIControlStateNormal];
    [deleteVipCard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteVipCard.titleLabel.font = [UIFont systemFontOfSize:17];
    deleteVipCard.layer.cornerRadius = 5;
    deleteVipCard.layer.borderWidth = 1;
    deleteVipCard.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
    deleteVipCard.layer.masksToBounds = YES;
    deleteVipCard.backgroundColor = [UIColor whiteColor];
    [deleteVipCard addTarget:self action:@selector(deleteCard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteVipCard];
    [deleteVipCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundView).offset(-15);
        make.top.equalTo(backgroundView.mas_bottom).offset(17);
        make.height.mas_equalTo(@44);
        make.left.equalTo(backgroundView.mas_centerX).offset(8.5);
    }];
}
//新增 会员卡级别 btn
- (void)addVipLevelBtn{
    if ([self.delegate respondsToSelector:@selector(didClickAddVipLevelBtn)]) {
        [self.delegate didClickAddVipLevelBtn];
    }
}
//选择 会员卡级别
- (void)clickVipCardLevel:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickChooseVipLevelBtn:)]) {
        [self.delegate didClickChooseVipLevelBtn:button.titleLabel.text];
    }
}

- (void)saveDetail {
    if ([_vipCardMoneyTF.text isEqualToString:@""]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
        [_vipCardMoneyTF becomeFirstResponder];
        return;
    }
    if ([_vipCardDiscountTF.text isEqualToString:@""]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
        [_vipCardDiscountTF becomeFirstResponder];
        return;
    }
    
    BOOL isOk = NO;
    double amount = [_vipCardMoneyTF.text doubleValue];
    if (amount > 100000.00) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD showErrorWithStatus:@"金额不要超过100000"];
        [_vipCardMoneyTF becomeFirstResponder];
        return;
    }
    //元 转为 分
    double formatAmount = amount * 100;
    _model.initialAmount = [NSString stringWithFormat:@"%.2f", formatAmount];
    _model.discount = _vipCardDiscountTF.text;
    if ([_cardDiscountMsgTF.text isEqualToString:@""] || [_cardDiscountMsgTF.text isEqualToString:@"无"]) {
        _model.remarks = @"";
    }else {
        _model.remarks = _cardDiscountMsgTF.text;
    }
    
    _model.cardLevel = _vipCardLevel.titleLabel.text;
    if ([_model.businessType isEqualToString:@"1"]) {
        //保存储值卡
        if ([self judgeInfoStr:self.model.initialAmount] == YES || [self judgeInfoStr:self.model.discount] == YES || [self judgeInfoStr:self.model.cardLevel] == YES ){
            isOk = YES;
        }
        
    }else if ([self judgeInfoStr:self.model.discount] == YES || [self judgeInfoStr:self.model.cardLevel] == YES ){
        //保存优惠卡
        isOk = YES;
    }
    //如果YES说明信息未填好  NO可以点击保存
    if (isOk == YES)
    {
        NSLog(@"将信息填写完整");
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
    }else{
        if ([self.delegate respondsToSelector:@selector(didClickSaveBtnWithModel:)]) {
            [self.delegate didClickSaveBtnWithModel:_model];
        }
    }
    
 //WZ
//    if (_vipCardDiscountTF.text.length) {
//        _model.discount = _vipCardDiscountTF.text;
//    }
//    if (_vipCardMoneyTF.text.length) {
//        _model.initialAmount = _vipCardMoneyTF.text;
//    }
//    if (_cardDiscountMsgTF.text.length) {
//        _model.remarks = _cardDiscountMsgTF.text;
//    }
//    _model.cardLevel = _vipCardLevel.titleLabel.text;
//    
//    if ([self.delegate respondsToSelector:@selector(didClickSaveBtnWithModel:)]) {
//        [self.delegate didClickSaveBtnWithModel:_model];
//    }
}

- (void)deleteCard{
    if ([self.delegate respondsToSelector:@selector(didClickDeleteBtn)]) {
        [self.delegate didClickDeleteBtn];
    }
}

//- (void)setModel:(VipCardModel *)model{
//    _model = model;
//    if ([_model.businessType isEqualToString:@"1"]) {
//        [self setUIWith:VipCardSaving];
//    }else{
//        [self setUIWith:VipCardCoupon];
//    }
//}
#pragma mark - 清除textfield - 
- (void)xbtnAction:(UIButton *)sender{
    if (sender.tag == 10001) {
        _vipCardMoneyTF.text = @"";
    }else if (sender.tag == 10002){
        _vipCardDiscountTF.text = @"";
    }
}
#pragma mark - 判断输入的信息是否为空 -
//判断填入信息是否为空
- (BOOL)judgeInfoStr:(NSString *)infoStr{
    infoStr = [self deleteSpaceWithStr:infoStr];
    if ([infoStr isEqualToString:@""] || infoStr.length == 0) {
        return YES;
    }
    return NO;
}
//去空格
- (NSString *)deleteSpaceWithStr:(NSString *)str{
    NSString *string = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

#pragma mark - UITextFieldDelegate 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_vipCardMoneyTF]) {
        return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:5];
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        //当输入框为空时，禁止输入 . 字符;
//        if ([textField.text isEqualToString:@""]) {
//            if ([string isEqualToString:@"."]) {
//                return NO;
//            }
//        }
//        //当输入框第一个字符为 0 时，必须输入小数点;
//        if ([textField.text isEqualToString:@"0"]) {
//            if ([string isEqualToString:@"."]) {
//                return YES;
//            }else {
//                return NO;
//            }
//        }
//        if (textField.text.length >= 2) {
////            NSString *firStr = [textField.text substringToIndex:2];
//            if ([textField.text hasPrefix:@"0."]) {
//                if ([string isEqualToString:@"."]) {
//                    return NO;
//                }else {
//                    if (textField.text.length > 3) {
//                        return NO;
//                    }
//                    return YES;
//                }
//            }
////            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
//            NSLog(@"---location:%ld | length:%ld",[textField.text rangeOfString:@"."].location, [textField.text rangeOfString:@"."].length);
//            if ([textField.text rangeOfString:@"."].length > 0) {
//                if ([string isEqualToString:@"."]) {
//                    return NO;
//                }else {
//                    NSInteger location = [textField.text rangeOfString:@"."].location;
//                    NSString *subStr = [textField.text substringFromIndex:location];
//                    if (subStr.length > 2) {
//                        return NO;
//                    }
//                    return YES;
//                }
//            }
//        }
//        if (textField.text.length > 5) {
//            return NO;
//        }
        
    //折扣 输入框
    }else if ([textField isEqual:_vipCardDiscountTF]) {
        return [string VIPManger_iSLegalDiscountInput:textField.text inputString:string andLimitedLength:1];
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        //当输入框为空时，禁止输入 . 字符;
//        if ([textField.text isEqualToString:@""]) {
//            if ([string isEqualToString:@"."]) {
//                return NO;
//            }
//        }
//        //当输入框第一个字符为 0 时，必须输入小数点;
//        if ([textField.text isEqualToString:@"0"]) {
//            if ([string isEqualToString:@"."]) {
//                return YES;
//            }else {
//                return NO;
//            }
//        }
//        if (textField.text.length >= 2) {
////            NSString *firStr = [textField.text substringToIndex:2];
//            if ([textField.text hasPrefix:@"0."]) {
//                if ([string isEqualToString:@"."]) {
//                    return NO;
//                }else {
//                    if (textField.text.length > 2) {
//                        return NO;
//                    }
//                    return YES;
//                }
//            }
////            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
//            NSLog(@"---location:%ld | length:%ld",[textField.text rangeOfString:@"."].location, [textField.text rangeOfString:@"."].length);
//            if ([textField.text rangeOfString:@"."].length > 0) {
//                if ([string isEqualToString:@"."]) {
//                    return NO;
//                }else {
//                    NSInteger location = [textField.text rangeOfString:@"."].location;
//                    NSString *subStr = [textField.text substringFromIndex:location];
//                    if (subStr.length > 1) {
//                        return NO;
//                    }
//                    return YES;
//                }
//            }
//        }
//        if (textField.text.length > 1) {
//            return NO;
//        }

        
        
    }
    return YES;
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.cardDiscountMsgTF.text isEqualToString:@"无"]) {
        self.cardDiscountMsgTF.text = @"";
        [self.cardDiscountMsgTF setTextColor:[UIColor blackColor]];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.cardDiscountMsgTF.text isEqualToString:@""]) {
        self.cardDiscountMsgTF.text = @"无";
        [self.cardDiscountMsgTF setTextColor:[UIColor colorWithHexString:@"CCCCCC"]];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        //        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Notification Method
-(void)textViewEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    if ([textView isEqual:self.cardDiscountMsgTF]) {
        NSString *toBeString = textView.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    
}



@end
