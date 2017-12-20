//
//  GiveVipCardView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "GiveVipCardChildView.h"

@implementation GiveVipCardChildView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIView *whiteBackgroundView = [[UIView alloc]init];
    whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    whiteBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    whiteBackgroundView.layer.borderWidth = 1;
    [self addSubview:whiteBackgroundView];
    [whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(12);
        make.height.equalTo(@146);
    }];
    
    self.phoneNumberTF = [[UITextField alloc]init];
    self.phoneNumberTF.placeholder = @"请输入领卡人手机号码";
    self.phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneNumberTF setValue:[UIColor colorWithHexString:@"aaaaaa"] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumberTF.font = [UIFont systemFontOfSize:14];
    [whiteBackgroundView addSubview:self.phoneNumberTF];
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBackgroundView).offset(16);
        make.top.equalTo(whiteBackgroundView);
        make.height.mas_equalTo(@48);
        make.right.equalTo(whiteBackgroundView);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [whiteBackgroundView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.right.equalTo(self.phoneNumberTF);
        make.top.equalTo(self.phoneNumberTF.mas_bottom);
    }];
    
    self.vipCardTypeButton = [[UIButton alloc]init];
    self.vipCardTypeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.vipCardTypeButton setTitle:@"请选择电子会员卡类型" forState:UIControlStateNormal];
    [self.vipCardTypeButton setTitleColor:[UIColor colorWithHexString:@"aaaaaa"] forState:UIControlStateNormal];
    self.vipCardTypeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.vipCardTypeButton addTarget:self action:@selector(clickVipCardType) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackgroundView addSubview:self.vipCardTypeButton];
    [self.vipCardTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneNumberTF);
        make.top.equalTo(lineView1.mas_bottom);
    }];
    
    UIImageView *downArrowImageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VipManager_DownArrow"]];
    [self.vipCardTypeButton addSubview:downArrowImageView1];
    [downArrowImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self.vipCardTypeButton);
        make.right.equalTo(self.vipCardTypeButton).offset(-15);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [whiteBackgroundView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.right.equalTo(self.phoneNumberTF);
        make.top.equalTo(self.vipCardTypeButton.mas_bottom);
    }];
    
    self.vipCardButton = [[UIButton alloc]init];
    self.vipCardButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.vipCardButton setTitle:@"请选择电子会员卡" forState:UIControlStateNormal];
    [self.vipCardButton setTitleColor:[UIColor colorWithHexString:@"aaaaaa"] forState:UIControlStateNormal];
    self.vipCardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.vipCardButton addTarget:self action:@selector(clickVipCard) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackgroundView addSubview:self.vipCardButton];
    [self.vipCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneNumberTF);
        make.top.equalTo(lineView2.mas_bottom);
    }];
    
    UIImageView *downArrowImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VipManager_DownArrow"]];
    [self.vipCardButton addSubview:downArrowImageView2];
    [downArrowImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self.vipCardButton);
        make.right.equalTo(self.vipCardButton).offset(-15);
    }];
    
    UIButton *giveButton = [[UIButton alloc]init];
    giveButton.backgroundColor = [UIColor colorWithHexString:@"01aaef"];
    giveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    giveButton.layer.cornerRadius = 4;
    [giveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [giveButton setTitle:@"发放" forState:UIControlStateNormal];
    [giveButton addTarget:self action:@selector(clickGiveButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:giveButton];
    [giveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(whiteBackgroundView.mas_bottom).offset(12);
        make.height.mas_equalTo(@44);
    }];
    
    self.choosedCardType = 0;
}

//卡类型
- (void)clickVipCardType{
    if ([self.giveVipDelegate conformsToProtocol:@protocol(GiveVipCardChildViewDelegate)]
        &&
        [self.giveVipDelegate respondsToSelector:@selector(GiveVipCardToChooseCardType)]) {
        [self.giveVipDelegate GiveVipCardToChooseCardType];

    }

}

//那张卡
- (void)clickVipCard{
    if ([self.giveVipDelegate conformsToProtocol:@protocol(GiveVipCardChildViewDelegate)]
        &&
        [self.giveVipDelegate respondsToSelector:@selector(GiveVipCardToChooseWhichVipCard)]) {
        [self.giveVipDelegate GiveVipCardToChooseWhichVipCard];
    }
}

- (void)clickGiveButton{
    //[self.phoneNumberTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] 
    if ([self.phoneNumberTF.text isEqualToString:@""] || ![self.phoneNumberTF.text isMobileNumber]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码！"];
        [self.phoneNumberTF becomeFirstResponder];
        return;
    }
    if (self.choosedCardType <= 0 || self.choosedCardType > 3) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请选择会员卡类型！"];
        return;
    }
    if (!self.listModel) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请选择会员卡！"];
        return;
    }
    //数据处理
    
    if ([self.giveVipDelegate conformsToProtocol:@protocol(GiveVipCardChildViewDelegate)]
        &&
        [self.giveVipDelegate respondsToSelector:@selector(GiveVipCardToSaveDataWithCardId:mobile:andCardType:)]) {
        [self.giveVipDelegate GiveVipCardToSaveDataWithCardId:self.listModel.ID mobile:self.phoneNumberTF.text   andCardType:self.choosedCardType];
    }
    
}

#pragma mark - setter
//设置卡类型 储值卡 or 优惠卡
//- (void)setChooseCardType:(NSString *)chooseCardType {
//    _chooseCardType = chooseCardType;
//    [self.vipCardTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.vipCardTypeButton setTitle:chooseCardType forState:UIControlStateNormal];
//    
//}


- (void)setChoosedCardType:(CardType)choosedCardType {
    _choosedCardType = choosedCardType;
    if (choosedCardType == CardType_ChuZhiKa) {
        [self.vipCardTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.vipCardTypeButton setTitle:@"储值会员卡" forState:UIControlStateNormal];
    }else if (choosedCardType ==CardType_YouHuiKa) {
        [self.vipCardTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.vipCardTypeButton setTitle:@"优惠会员卡" forState:UIControlStateNormal];
    }
    
}

//设置哪张卡
//- (void)setChooseVipCard:(NSString *)chooseVipCard {
//    _chooseVipCard = chooseVipCard;
//    [self.vipCardButton setTitle:chooseVipCard forState:UIControlStateNormal];
//    [self.vipCardTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//}

- (void)setListModel:(VipCardListModel *)listModel {
    _listModel = listModel;
    [self.vipCardButton setTitle:listModel.cardName forState:UIControlStateNormal];
    [self.vipCardTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

@end
