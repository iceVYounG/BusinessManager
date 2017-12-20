//
//  ChooseVipCardTypeView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChooseVipCardTypeView.h"

@interface ChooseVipCardTypeView ()

@property (nonatomic, strong) UIButton *savingCardButton;
@property (nonatomic, strong) UIButton *couponCardButton;

@end

@implementation ChooseVipCardTypeView

- (id)initWtihTypeStr:(NSString *)typeStr{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UITapGestureRecognizer *tagGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
    tagGr.numberOfTapsRequired = 1;
    tagGr.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tagGr];
    
    UIView *whiteBackgroundView = [[UIView alloc]init];
    whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    whiteBackgroundView.layer.cornerRadius = 8;
    [self addSubview:whiteBackgroundView];
    [whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 110));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"选择会员类型";
    titleLabel.textColor = [UIColor colorWithHexString:@"00aaee"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [whiteBackgroundView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@36);
        make.centerX.equalTo(whiteBackgroundView);
        make.width.mas_equalTo(@150);
        make.top.equalTo(whiteBackgroundView);
    }];
    
    UIButton *cancenButton = [[UIButton alloc]init];
    [cancenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancenButton setImage:[UIImage imageNamed:@"VipCardManager_CancelImage.png"] forState:UIControlStateNormal];
    [cancenButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackgroundView addSubview:cancenButton];
    [cancenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(whiteBackgroundView);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [whiteBackgroundView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0.5);
        make.left.right.equalTo(whiteBackgroundView);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    _savingCardButton = [[UIButton alloc]init];
    [_savingCardButton setTitle:@"储值会员卡" forState:UIControlStateNormal];
    [_savingCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _savingCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -130, 0, 0);
    [_savingCardButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackgroundView addSubview:_savingCardButton];
    [_savingCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.left.right.equalTo(whiteBackgroundView);
        make.height.mas_equalTo(@36);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [whiteBackgroundView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0.5);
        make.left.right.equalTo(whiteBackgroundView);
        make.top.equalTo(_savingCardButton.mas_bottom);
    }];
    
    _couponCardButton = [[UIButton alloc]init];
    [_couponCardButton setTitle:@"优惠会员卡" forState:UIControlStateNormal];
    [_couponCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _couponCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -130, 0, 0);
    [_couponCardButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackgroundView addSubview:_couponCardButton];
    [_couponCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom);
        make.left.right.equalTo(whiteBackgroundView);
        make.height.mas_equalTo(@36);
    }];
    
}

- (void)setSelectedStr:(NSString *)selectedStr{
    if ([selectedStr isEqualToString:_couponCardButton.titleLabel.text]) {
        [_couponCardButton setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
        [_savingCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if([selectedStr isEqualToString:_savingCardButton.titleLabel.text]){
        [_savingCardButton setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
        [_couponCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)cancel{
    [self removeFromSuperview];
}

- (void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickTheButton:)]) {
        [self.delegate didClickTheButton:button.titleLabel.text];
    }
    [self cancel];
}

@end