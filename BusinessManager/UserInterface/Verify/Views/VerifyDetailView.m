//
//  VerifyDetailView.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VerifyDetailView.h"
#import "VerifyVipCardModel.h"
#import "CountButton.h"

@interface VerifyDetailView ()

@property (nonatomic,strong) UITextField *expenditureTF;
@property (nonatomic,strong) UITextField *verificationCodeTF;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *AMT;
@property (nonatomic,strong) CountButton *countButton;

@end

@implementation VerifyDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (dataArray.count == 3) {
        [self setTwoCardUI:dataArray];
        _type = @"2";
    }else{
        VerifyVipCardModel *cardModel = (VerifyVipCardModel *)dataArray[0];
        if ([cardModel.BUSINESS_TYPE isEqualToString:@"1"]) {
            [self setCzkUI:dataArray];
            _type = @"2";
        }else{
            [self setYhkUI:dataArray];
            _type = @"1";
        }
    }
}

- (void)setYhkUI:(NSArray *)dataArray{
    VerifyVipCardModel *yhkCardModel = (VerifyVipCardModel *)dataArray[0];
    _mobile = yhkCardModel.USER_MOBILE;
    NSString *moneyStr;
    if (dataArray.count == 2) {
        moneyStr = [NSString stringWithFormat:@"%@",dataArray[1]];
    }
    if (moneyStr.length) {
        _AMT = moneyStr;
        
        UIView *backgroundView1 = [[UIView alloc]init];
        backgroundView1.backgroundColor = [UIColor whiteColor];
        backgroundView1.layer.borderWidth = 1;
        backgroundView1.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        [self addSubview:backgroundView1];
        [backgroundView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(12);
            make.height.mas_equalTo(@48);
        }];
        
        UILabel *moneyLabel = [[UILabel alloc]init];
        moneyLabel.text = @"可用红包余额";
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        moneyLabel.textColor = [UIColor blackColor];
        [self addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(backgroundView1);
            make.left.equalTo(backgroundView1).offset(15);
        }];
        
        UILabel *money = [[UILabel alloc]init];
        money.text = [NSString stringWithFormat:@"%@元",moneyStr];
        money.textAlignment = NSTextAlignmentLeft;
        money.textColor = [UIColor grayColor];
        [self addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(backgroundView1);
            make.left.equalTo(moneyLabel.mas_right).offset(30);
        }];
    }
    
    if (moneyStr.length) {
        UIView *expenditureView = [[UIView alloc]init];
        expenditureView.backgroundColor = [UIColor whiteColor];
        expenditureView.layer.borderWidth = 1;
        expenditureView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        [self addSubview:expenditureView];
        [expenditureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(@96);
            if (moneyStr.length) {
                make.top.equalTo(self).offset(72);
            }else{
                make.top.equalTo(self).offset(12);
            }
        }];
        
        _expenditureTF = [[UITextField alloc]init];
        _expenditureTF.placeholder = @"请输入本次消费金额";
        _expenditureTF.font = [UIFont systemFontOfSize:16];
        _expenditureTF.textColor = [UIColor colorWithHexString:@"cccccc"];
        [self addSubview:_expenditureTF];
        [_expenditureTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(expenditureView).offset(15);
            make.right.top.equalTo(expenditureView);
            make.height.mas_equalTo(@48);
        }];
        
        _countButton = [[CountButton alloc]init];
        [_countButton addTarget:self action:@selector(clickCountButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_countButton];
        [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40));
            make.centerY.equalTo(_expenditureTF);
            make.right.equalTo(expenditureView).offset(-15);
        }];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_expenditureTF.mas_bottom).offset(0.5);
            make.height.mas_equalTo(@1);
            make.right.equalTo(expenditureView).offset(-15);
            make.left.equalTo(expenditureView).offset(15);
        }];
        
        _verificationCodeTF = [[UITextField alloc]init];
        _verificationCodeTF.placeholder = @"请输入验证码";
        _verificationCodeTF.font = [UIFont systemFontOfSize:16];
        _verificationCodeTF.textColor = [UIColor colorWithHexString:@"cccccc"];
        [self addSubview:_verificationCodeTF];
        [_verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(expenditureView).offset(15);
            make.bottom.right.equalTo(expenditureView);
            make.height.mas_equalTo(@48);
        }];

        
        UIButton *confirmBtn = [[UIButton alloc]init];
        [confirmBtn setTitle:@"确认扣减" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmBtn.backgroundColor = [UIColor colorWithHexString:@"01aafe"];
        confirmBtn.layer.cornerRadius = 5;
        [confirmBtn addTarget:self action:@selector(clickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(expenditureView.mas_bottom).offset(20);
            make.left.equalTo(self).offset(15);
            make.height.mas_equalTo(@48);
            make.right.equalTo(self.mas_centerX).offset(-8.5);
        }];
        
        UIButton *cancelBtn = [[UIButton alloc]init];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(expenditureView.mas_bottom).offset(20);
            make.left.equalTo(confirmBtn.mas_right).offset(17);
            make.height.mas_equalTo(@48);
            make.right.equalTo(self).offset(-15);
        }];
    }
    
    if (!yhkCardModel.BUSINESS_TYPE) {
        return;
    }
    
    UIView *secondBackgroundView = [[UIView alloc]init];
    secondBackgroundView.backgroundColor = [UIColor whiteColor];
    secondBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    secondBackgroundView.layer.borderWidth = 1;
    [self addSubview:secondBackgroundView];
    [secondBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        if (moneyStr.length) {
            make.top.equalTo(_expenditureTF.mas_bottom).offset(20 + 65 + 48);
        }else{
            make.top.equalTo(self).offset(10);
        }
        make.height.mas_equalTo(@244);
    }];
    
    NSArray *labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员卡级别",@"会员卡折扣"];
    
    for (int i = 0; i < labelNameArray.count; i ++) {
        UILabel *msgNameLabel  =[[UILabel alloc]init];
        msgNameLabel.textAlignment = NSTextAlignmentLeft;
        msgNameLabel.text = labelNameArray[i];
        msgNameLabel.textColor = [UIColor blackColor];
        msgNameLabel.font = [UIFont systemFontOfSize:15];
        [secondBackgroundView addSubview:msgNameLabel];
        [msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(secondBackgroundView).offset(15);
            make.width.mas_equalTo(@126);
            make.top.equalTo(secondBackgroundView).offset(i * 49);
        }];
    }
    
    for (int i = 0; i < 4; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [secondBackgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(secondBackgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(secondBackgroundView);
        }];
    }
    
    NSArray * detailArray;
    if ([yhkCardModel.DISCOUNT isEqualToString:@"10"] || !yhkCardModel.DISCOUNT.length) {
        detailArray = @[yhkCardModel.USER_MOBILE,yhkCardModel.CARD_NUM,@"优惠卡",yhkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"无折扣(%@)",yhkCardModel.REMARKS]];
    }else{
        detailArray = @[yhkCardModel.USER_MOBILE,yhkCardModel.CARD_NUM,@"优惠卡",yhkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"%@(%@)",yhkCardModel.DISCOUNT,yhkCardModel.REMARKS]];
    }
    
    for (int i = 0; i < detailArray.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor colorWithHexString:@"888888"];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [secondBackgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(secondBackgroundView).offset(126 + 15);
            make.right.equalTo(secondBackgroundView);
            make.top.equalTo(secondBackgroundView).offset(i * 49);
        }];
    }

}

- (void)setCzkUI:(NSArray *)dataArray{
    VerifyVipCardModel *czkCardModel = (VerifyVipCardModel *)dataArray[0];
    _mobile = czkCardModel.USER_MOBILE;
    _AMT = [NSString stringWithFormat:@"%@",dataArray[1]];
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(12);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@293);
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [backgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(backgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(backgroundView);
        }];
    }
    
    NSArray *labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员卡级别",@"会员卡折扣",@"余额"];
    
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
            make.width.mas_equalTo(@126);
            make.top.equalTo(backgroundView).offset(i * 49);
        }];
    }
    
    NSArray * detailArray;
    if ([czkCardModel.DISCOUNT isEqualToString:@"10"] || !czkCardModel.DISCOUNT.length) {
         detailArray = @[czkCardModel.USER_MOBILE,czkCardModel.CARD_NUM,@"储值卡",czkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"无折扣(%@)",czkCardModel.REMARKS],[NSString stringWithFormat:@"%@",dataArray[1]]];
    }else{
        detailArray = @[czkCardModel.USER_MOBILE,czkCardModel.CARD_NUM,@"储值卡",czkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"%@(%@)",czkCardModel.DISCOUNT,czkCardModel.REMARKS],[NSString stringWithFormat:@"%@",dataArray[1]]];
    }
    
    for (int i = 0; i < detailArray.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor colorWithHexString:@"888888"];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [backgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(backgroundView).offset(126 + 15);
            make.right.equalTo(backgroundView);
            make.top.equalTo(backgroundView).offset(i * 49);
        }];
    }
    
    UIView *expenditureView = [[UIView alloc]init];
    expenditureView.backgroundColor = [UIColor whiteColor];
    expenditureView.layer.borderWidth = 1;
    expenditureView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    [self addSubview:expenditureView];
    [expenditureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom).offset(12);
        make.left.right.equalTo(backgroundView);
        make.height.mas_equalTo(@96);
    }];
    
    _expenditureTF = [[UITextField alloc]init];
    _expenditureTF.placeholder = @"请输入本次消费金额";
    _expenditureTF.font = [UIFont systemFontOfSize:16];
    _expenditureTF.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self addSubview:_expenditureTF];
    [_expenditureTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expenditureView).offset(15);
        make.right.top.equalTo(expenditureView);
        make.height.mas_equalTo(@48);
    }];
    
    _countButton = [[CountButton alloc]init];
    [_countButton addTarget:self action:@selector(clickCountButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_countButton];
    [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerY.equalTo(_expenditureTF);
        make.right.equalTo(expenditureView).offset(-15);
    }];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expenditureTF.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@1);
        make.right.equalTo(expenditureView).offset(-15);
        make.left.equalTo(expenditureView).offset(15);
    }];
    
    _verificationCodeTF = [[UITextField alloc]init];
    _verificationCodeTF.placeholder = @"请输入验证码";
    _verificationCodeTF.font = [UIFont systemFontOfSize:16];
    _verificationCodeTF.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self addSubview:_verificationCodeTF];
    [_verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expenditureView).offset(15);
        make.bottom.right.equalTo(expenditureView);
        make.height.mas_equalTo(@48);
    }];

    
    UIButton *confirmBtn = [[UIButton alloc]init];
    [confirmBtn setTitle:@"确认扣减" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor colorWithHexString:@"01aafe"];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(clickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenditureView.mas_bottom).offset(20);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(@48);
        make.right.equalTo(self.mas_centerX).offset(-8.5);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.layer.cornerRadius = 5;
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenditureView.mas_bottom).offset(20);
        make.left.equalTo(confirmBtn.mas_right).offset(17);
        make.height.mas_equalTo(@48);
        make.right.equalTo(self).offset(-15);
    }];

}

- (void)setTwoCardUI:(NSArray *)dataArray{
    VerifyVipCardModel *czkCardModel;
    VerifyVipCardModel *yhkCardModel;

    czkCardModel = dataArray[0];
    yhkCardModel = dataArray[1];
    _AMT = [NSString stringWithFormat:@"%@",dataArray[2]];
    _mobile = czkCardModel.USER_MOBILE;
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(12);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@293);
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [backgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(backgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(backgroundView);
        }];
    }
    
    NSArray *labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员卡级别",@"会员卡折扣",@"余额"];
    
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
            make.width.mas_equalTo(@126);
            make.top.equalTo(backgroundView).offset(i * 49);
        }];
    }
    
    NSArray * detailArray;
    if ([czkCardModel.DISCOUNT isEqualToString:@"10"] || !czkCardModel.DISCOUNT.length) {
        detailArray = @[czkCardModel.USER_MOBILE,czkCardModel.CARD_NUM,@"储值卡",czkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"无折扣(%@)",czkCardModel.REMARKS],[NSString stringWithFormat:@"%@",dataArray[2]]];
    }else{
        detailArray = @[czkCardModel.USER_MOBILE,czkCardModel.CARD_NUM,@"储值卡",czkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"%@(%@)",czkCardModel.DISCOUNT,czkCardModel.REMARKS],[NSString stringWithFormat:@"%@",dataArray[2]]];
    }

    for (int i = 0; i < detailArray.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [backgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(backgroundView).offset(126 + 15);
            make.right.equalTo(backgroundView);
            make.top.equalTo(backgroundView).offset(i * 49);
        }];
    }
    
    UIView *expenditureView = [[UIView alloc]init];
    expenditureView.backgroundColor = [UIColor whiteColor];
    expenditureView.layer.borderWidth = 1;
    expenditureView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    [self addSubview:expenditureView];
    [expenditureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom).offset(12);
        make.left.right.equalTo(backgroundView);
        make.height.mas_equalTo(@96);
    }];
    
    _expenditureTF = [[UITextField alloc]init];
    _expenditureTF.placeholder = @"请输入本次消费金额";
    _expenditureTF.font = [UIFont systemFontOfSize:16];
    _expenditureTF.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self addSubview:_expenditureTF];
    [_expenditureTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expenditureView).offset(15);
        make.right.top.equalTo(expenditureView);
        make.height.mas_equalTo(@48);
    }];
    
    _countButton = [[CountButton alloc]init];
    [_countButton addTarget:self action:@selector(clickCountButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_countButton];
    [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerY.equalTo(_expenditureTF);
        make.right.equalTo(expenditureView).offset(-15);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expenditureTF.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@1);
        make.right.equalTo(expenditureView).offset(-15);
        make.left.equalTo(expenditureView).offset(15);
    }];
    
    _verificationCodeTF = [[UITextField alloc]init];
    _verificationCodeTF.placeholder = @"请输入验证码";
    _verificationCodeTF.font = [UIFont systemFontOfSize:16];
    _verificationCodeTF.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self addSubview:_verificationCodeTF];
    [_verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expenditureView).offset(15);
        make.bottom.right.equalTo(expenditureView);
        make.height.mas_equalTo(@48);
    }];
    
    
    UIButton *confirmBtn = [[UIButton alloc]init];
    [confirmBtn setTitle:@"确认扣减" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor colorWithHexString:@"01aafe"];
    confirmBtn.layer.cornerRadius = 5;
    [confirmBtn addTarget:self action:@selector(clickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenditureView.mas_bottom).offset(20);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(@48);
        make.right.equalTo(self.mas_centerX).offset(-8.5);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.layer.cornerRadius = 5;
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenditureView.mas_bottom).offset(20);
        make.left.equalTo(confirmBtn.mas_right).offset(17);
        make.height.mas_equalTo(@48);
        make.right.equalTo(self).offset(-15);
    }];

    UIView *secondBackgroundView = [[UIView alloc]init];
    secondBackgroundView.backgroundColor = [UIColor whiteColor];
    secondBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    secondBackgroundView.layer.borderWidth = 1;
    [self addSubview:secondBackgroundView];
    [secondBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(cancelBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(@244);
    }];
    
    NSArray *labelNameArray2 = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员卡级别",@"会员卡折扣"];
    
    for (int i = 0; i < labelNameArray2.count; i ++) {
        UILabel *msgNameLabel  =[[UILabel alloc]init];
        msgNameLabel.textAlignment = NSTextAlignmentLeft;
        msgNameLabel.text = labelNameArray2[i];
        msgNameLabel.textColor = [UIColor blackColor];
        msgNameLabel.font = [UIFont systemFontOfSize:15];
        [secondBackgroundView addSubview:msgNameLabel];
        [msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(secondBackgroundView).offset(15);
            make.width.mas_equalTo(@126);
            make.top.equalTo(secondBackgroundView).offset(i * 49);
        }];
    }
    
    for (int i = 0; i < 4; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [secondBackgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(secondBackgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(secondBackgroundView);
        }];
    }
    
    NSArray *detailArray2;
    if ([yhkCardModel.DISCOUNT isEqualToString:@"10"] || !yhkCardModel.DISCOUNT.length) {
        detailArray2 = @[yhkCardModel.USER_MOBILE,yhkCardModel.CARD_NUM,@"优惠卡",yhkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"%@(%@)",@"无折扣",yhkCardModel.REMARKS]];
    }else{
        detailArray2 = @[yhkCardModel.USER_MOBILE,yhkCardModel.CARD_NUM,@"优惠卡",yhkCardModel.CARD_LEVEL,[NSString stringWithFormat:@"%@(%@)",yhkCardModel.DISCOUNT,yhkCardModel.REMARKS]];
    }
    
    for (int i = 0; i < detailArray2.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray2[i];
        detailLabel.textColor = [UIColor colorWithHexString:@"888888"];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [secondBackgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(secondBackgroundView).offset(126 + 15);
            make.right.equalTo(secondBackgroundView);
            make.top.equalTo(secondBackgroundView).offset(i * 49);
        }];
    }
}

- (void)clickConfirmBtn{
    if ([self.delegate respondsToSelector:@selector(didClickConfirmButtonWithMobile:type:code:)]) {
        [self.delegate didClickConfirmButtonWithMobile:_mobile type:_type code:_verificationCodeTF.text];
    }
}

- (void)clickCountButton{
    if (!_expenditureTF.text) {
        [OMGToast showWithText:@"请输入金额"];
        [_countButton reSet];
        return;
    }
    NSString *amt;
    if ([self isPureFloat:_expenditureTF.text] || [self isPureInt:_expenditureTF.text]) {
        amt = [NSString stringWithFormat:@"%0.0f",[_expenditureTF.text floatValue] * 100];
    }else{
        [OMGToast showWithText:@"请输入正确的金额"];
        [_countButton reSet];
        return;
    }
    if ([amt isEqualToString:@"0"]) {
        [OMGToast showWithText:@"请输入正确的金额"];
        [_countButton reSet];
        return;
    }
        _AMT = [NSString stringWithFormat:@"%0.0f",[_AMT floatValue] * 100];
    if ([_AMT floatValue] < [amt floatValue]) {
        [OMGToast showWithText:@"余额不足"];
        [_countButton reSet];
        return;
    }
//    [params setObject:amt forKey:@"amt"];
    _expenditureTF.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(didClickCountButton:mobile:type:)]) {
        [self.delegate didClickCountButton:amt mobile:_mobile type:_type];
    }
}

- (void)clickCancelBtn{
    if ([self.delegate respondsToSelector:@selector(didClickCancelButton)]) {
        [self.delegate didClickCancelButton];
    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end