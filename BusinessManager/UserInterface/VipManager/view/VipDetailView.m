//
//  VipDetailView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipDetailView.h"


#define labelTag 880    //Label的Tag

//businessType:非必传（卡类型，1：储值卡 2：优惠卡
#define CARDTYPE_ChuZhiKa @"1" //储值卡
//删除，充值按钮宽度
#define VIPDetail_ButtonWidth ((KScreenWidth - 47) / 2)

@implementation VipDetailView

- (id)initWithType:(VipCard)type{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
        [self setUIWithType:type];
    }
    return self;
}

- (void)setUIWithType:(VipCard)type {
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    self.backgroundView.layer.borderWidth = 1;
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.right.equalTo(self);
        //计算出的view的高
        if(type == VipCardSaving){
            make.height.mas_equalTo(440);
        }else{
            make.height.mas_equalTo(342);
        }
    }];
    
    int lineCount;
    if (type == VipCardSaving) {
        lineCount = 8;
    }else{
        lineCount = 6;
    }
    for (int i = 0; i < lineCount; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [self.backgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.backgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(self.backgroundView);
        }];
    }
    
    NSArray *labelNameArray;
    if (type == VipCardSaving) {
        labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员类卡名称",@"会员卡级别",@"会员卡折扣",@"会员卡余额",@"已消费金额",@"有效截止日期"];
    }else{
        labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员类卡名称",@"会员卡级别",@"会员卡折扣",@"有效截止日期"];
    }
    for (int i = 0; i < labelNameArray.count; i ++) {
        UILabel *msgNameLabel  =[[UILabel alloc]init];
        msgNameLabel.textAlignment = NSTextAlignmentLeft;
        msgNameLabel.text = labelNameArray[i];
        msgNameLabel.textColor = [UIColor blackColor];
        msgNameLabel.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:msgNameLabel];
        [msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(self.backgroundView).offset(15);
            make.width.mas_equalTo(@126);
            make.top.equalTo(self.backgroundView).offset(i * 49);
        }];
    }
    
    NSArray *detailArray;
    if (type == VipCardSaving) {
        detailArray = @[@"12230041591",@"1039581",@"储值卡",@"宽连钻石卡",@"钻石会员",@"6.0折酒水米除外",@"500.00元",@"200.00元",@"2017-4-29 23:59:59"];
    }else{
        detailArray = @[@"ss"];
    }
    for (int i = 0; i < detailArray.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor colorWithHexString:@"888888"];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(self.backgroundView).offset(126 + 15);
            make.right.equalTo(self.backgroundView);
            make.top.equalTo(self.backgroundView).offset(i * 49);
        }];
    }
    
    if (type == VipCardSaving) {
        UIButton *prepaidButton = [[UIButton alloc]init];
        [prepaidButton setTitle:@"充值" forState:UIControlStateNormal];
        [prepaidButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        prepaidButton.layer.cornerRadius = 4;
        prepaidButton.backgroundColor = [UIColor colorWithHexString:@"#01aaef"];
        [prepaidButton addTarget:self action:@selector(clickPrepaidButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prepaidButton];
        [prepaidButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundView).offset(15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
            make.width.mas_equalTo(VIPDetail_ButtonWidth);
//            make.right.equalTo(backgroundView.mas_centerX).offset(-15);
        }];
        
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setTitle:@"删除会员" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteButton.layer.cornerRadius = 4;
        deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        deleteButton.layer.borderWidth = 1.0;
        deleteButton.layer.masksToBounds = YES;
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundView).offset(-15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
//            make.left.equalTo(backgroundView.mas_centerX).offset(15);
            make.width.mas_equalTo(VIPDetail_ButtonWidth);
        }];
        
    }else{
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setTitle:@"删除会员" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteButton.layer.cornerRadius = 4;
        deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#000000"].CGColor;
        deleteButton.layer.borderWidth = 1.0;
        deleteButton.layer.masksToBounds = YES;
        
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundView).offset(-15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
            make.left.equalTo(self.backgroundView).offset(15);
        }];
    }
}

//----------------add by Huzy -------------------------//

#pragma mark - addByHuzy
- (instancetype)initWithType:(VipCard)type andModel:(id)model {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];

        if (type == VipCardSaving) {
            self.contentSize = CGSizeMake(SCREEN_SIZE.width, 590);
        }else {
            self.contentSize = CGSizeMake(SCREEN_SIZE.width, 490);
        }

    }
    return self;

}

#pragma mark - setter

- (void)setModel:(VipCardVipUserDetailModel *)model {
    _model = model;
    if ([model.vipCard.businessType isEqualToString:CARDTYPE_ChuZhiKa]) {
        [self setUIWithType:VipCardSaving andModel:model];
    }else {
        [self setUIWithType:VipCardCoupon andModel:model];
    }
    
}

//设置余额，用于下页面代理刷新此页面的余额值
- (void)setBalance:(NSString *)balance {
    _balance = balance;
    //tag = 6 为余额label
    for (UIView *view in self.backgroundView.subviews) {
        if (view.tag == (labelTag + 6)) {
            UILabel *label = (UILabel *)view;
            label.text = balance;
        }
    }
}


- (void)setUIWithType:(VipCard)type andModel:(VipCardVipUserDetailModel *)model {
    
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    self.backgroundView.layer.borderWidth = 1;
//    [self addSubview:self.backgroundView];
    if(type == VipCardSaving){
        self.backgroundView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 440);
    }else{
        self.backgroundView.frame = CGRectMake(0, 0, SCREEN_SIZE.width, 342);
    }
    [self addSubview:self.backgroundView];
    
    int lineCount;
    if (type == VipCardSaving) {
        lineCount = 8;
    }else{
        lineCount = 6;
    }
    for (int i = 0; i < lineCount; i ++) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [self.backgroundView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.backgroundView.mas_top).offset(48 * (i + 1) + (i - 1));
            make.right.equalTo(self.backgroundView);
        }];
    }
    
    NSArray *labelNameArray;
    if (type == VipCardSaving) {
        labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员卡名称",@"会员卡级别",@"会员卡折扣",@"会员卡余额",@"已消费金额",@"有效截止日期"];
    }else{
        labelNameArray = @[@"会员手机号码",@"会员卡号",@"会员卡类型",@"会员类卡名称",@"会员卡级别",@"会员卡折扣",@"有效截止日期"];
    }
    for (int i = 0; i < labelNameArray.count; i ++) {
        UILabel *msgNameLabel  =[[UILabel alloc]init];
        msgNameLabel.textAlignment = NSTextAlignmentLeft;
        msgNameLabel.text = labelNameArray[i];
        msgNameLabel.textColor = [UIColor blackColor];
        msgNameLabel.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:msgNameLabel];
        [msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(self.backgroundView).offset(15);
            make.width.mas_equalTo(@126);
            make.top.equalTo(self.backgroundView).offset(i * 49);
        }];
    }
    
    NSArray *detailArray;
    //卡类型
    NSString *cardType;
    if ([model.vipCard.businessType isEqualToString:CARDTYPE_ChuZhiKa]) {
        cardType = @"储值卡";
    }else {
        cardType = @"优惠卡";
    }
    //折扣
    NSString *cardDiscount;
    double discount = [model.vipCard.discount doubleValue];
    if (![self isNullString:model.vipCard.remarks]) {
        
        if (discount < 10.0) {
            cardDiscount = [NSString stringWithFormat:@"%@折,%@", model.vipCard.discount, model.vipCard.remarks];
        }else {
            cardDiscount = [NSString stringWithFormat:@"无折扣,%@", model.vipCard.remarks];
        }
        
    }else {
        if (discount < 10.0) {
            cardDiscount = [NSString stringWithFormat:@"%@折", model.vipCard.discount];
        }else {
            cardDiscount = [NSString stringWithFormat:@"无折扣"];
        }
        
    }
    
    //余额
    NSString *balance = [NSString stringWithFormat:@"%@元", model.balance];
    //已消费金额
    NSString *consume_money = [NSString stringWithFormat:@"%@元", model.consume_money];
    if (type == VipCardSaving) {
        
        detailArray = @[model.vipUser.userMobile, model.vipUser.cardNum, cardType, model.vipCard.cardName, model.vipCard.cardLevel, cardDiscount, balance, consume_money, model.validDay];
    }else{
        detailArray = @[model.vipUser.userMobile, model.vipUser.cardNum, cardType, model.vipCard.cardName, model.vipCard.cardLevel, cardDiscount, model.validDay];
    }
    for (int i = 0; i < detailArray.count; i ++) {
        UILabel *detailLabel  =[[UILabel alloc]init];
        detailLabel.tag = (labelTag + i);
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor colorWithHexString:@"888888"];
        detailLabel.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@48);
            make.left.equalTo(self.backgroundView).offset(126 + 15);
            make.right.equalTo(self.backgroundView);
            make.top.equalTo(self.backgroundView).offset(i * 49);
        }];
    }
    
    if (type == VipCardSaving) {
        UIButton *prepaidButton = [[UIButton alloc]init];
        [prepaidButton setTitle:@"充值" forState:UIControlStateNormal];
        [prepaidButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        prepaidButton.layer.cornerRadius = 4;
        prepaidButton.backgroundColor = [UIColor colorWithHexString:@"01aaef"];
        [prepaidButton addTarget:self action:@selector(clickPrepaidButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prepaidButton];
        [prepaidButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundView).offset(15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
//            make.right.equalTo(backgroundView.mas_centerX).offset(-15);
            make.width.mas_equalTo(VIPDetail_ButtonWidth);
        }];
        
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setTitle:@"删除会员" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteButton.layer.cornerRadius = 4;
        deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
        deleteButton.layer.borderWidth = 1.0;
        deleteButton.layer.masksToBounds = YES;
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundView).offset(-15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
//            make.left.equalTo(backgroundView.mas_centerX).offset(15);
            make.width.mas_equalTo(VIPDetail_ButtonWidth);
        }];
        
    }else{
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setTitle:@"删除会员" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteButton.layer.cornerRadius = 4;
        deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#e5e5e5"].CGColor;
        deleteButton.layer.borderWidth = 1.0;
        deleteButton.layer.masksToBounds = YES;
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundView).offset(-15);
            make.top.equalTo(self.backgroundView.mas_bottom).offset(17);
            make.height.mas_equalTo(@44);
            make.left.equalTo(self.backgroundView).offset(15);
        }];
    }
}

#pragma mark - Action

- (void)clickPrepaidButton{
    if ([self.viewDelegate respondsToSelector:@selector(didClickPrepaidButton)]) {
        [self.viewDelegate didClickPrepaidButton];
    }
}

- (void)clickDeleteButton{
    if ([self.viewDelegate respondsToSelector:@selector(didClickDeleteButton)]) {
        [self.viewDelegate didClickDeleteButton];
    }
}


- (BOOL)isNullString:(NSString *)str {
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

@end
