//
//  VipPrepaidRecordView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipPrepaidRecordView.h"

@interface VipPrepaidRecordView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation VipPrepaidRecordView

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
    whiteBackgroundView.layer.borderWidth = 1;
    whiteBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    [self addSubview:whiteBackgroundView];
    [whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.bottom.equalTo(self).offset(-12);
        make.left.right.equalTo(self);
    }];
    
    UILabel *phoneNumberLabel = [[UILabel alloc]init];
    phoneNumberLabel.text = @"用户手机号";
    phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
    phoneNumberLabel.font = [UIFont systemFontOfSize:13];
    phoneNumberLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [whiteBackgroundView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBackgroundView).offset(15);
        make.top.equalTo(whiteBackgroundView);
        make.size.mas_equalTo(CGSizeMake((SCREEN_SIZE.width - 30)/4, 48));
    }];
    
    UILabel *cardNameLabel = [[UILabel alloc]init];
    cardNameLabel.text = @"会员卡名称";
    cardNameLabel.textAlignment = NSTextAlignmentCenter;
    cardNameLabel.font = [UIFont systemFontOfSize:13];
    cardNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [whiteBackgroundView addSubview:cardNameLabel];
    [cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumberLabel.mas_right);
        make.top.equalTo(phoneNumberLabel);
        make.size.equalTo(phoneNumberLabel);
    }];
    
    UILabel *prepaidMoneyLabel = [[UILabel alloc]init];
    prepaidMoneyLabel.text = @"充值金额";
    prepaidMoneyLabel.textAlignment = NSTextAlignmentCenter;
    prepaidMoneyLabel.font = [UIFont systemFontOfSize:13];
    prepaidMoneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [whiteBackgroundView addSubview:prepaidMoneyLabel];
    [prepaidMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cardNameLabel.mas_right);
        make.top.equalTo(phoneNumberLabel);
        make.size.equalTo(phoneNumberLabel);
    }];
    
    UILabel *prepaidDate = [[UILabel alloc]init];
    prepaidDate.text = @"充值时间";
    prepaidDate.textAlignment = NSTextAlignmentCenter;
    prepaidDate.font = [UIFont systemFontOfSize:13];
    prepaidDate.textColor = [UIColor colorWithHexString:@"333333"];
    [whiteBackgroundView addSubview:prepaidDate];
    [prepaidDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(prepaidMoneyLabel.mas_right);
        make.top.equalTo(phoneNumberLabel);
        make.size.equalTo(phoneNumberLabel);
    }];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.rowHeight = 49;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [whiteBackgroundView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardNameLabel.mas_bottom);
        make.left.right.equalTo(whiteBackgroundView);
        make.bottom.equalTo(whiteBackgroundView);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    VipPrepaidRecordViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[VipPrepaidRecordViewTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

@end

@implementation VipPrepaidRecordViewTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *topLineView = [[UIView alloc]init];
        topLineView.backgroundColor = [UIColor colorWithHexString:@"dadada"];
        [self addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self);
        }];
        
        UILabel *userNumber = [[UILabel alloc]init];
        userNumber.text = @"13024526515";
        userNumber.textAlignment = NSTextAlignmentCenter;
        userNumber.font = [UIFont systemFontOfSize:13];
        userNumber.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:userNumber];
        [userNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake((SCREEN_SIZE.width - 30)/4, 48));
        }];

        UILabel *cardName = [[UILabel alloc]init];
        cardName.text = @"金牌会员卡";
        cardName.textAlignment = NSTextAlignmentCenter;
        cardName.font = [UIFont systemFontOfSize:13];
        cardName.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:cardName];
        [cardName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userNumber.mas_right);
            make.top.equalTo(userNumber);
            make.size.equalTo(userNumber);
        }];
        
        UILabel *price = [[UILabel alloc]init];
        price.text = @"50.00";
        price.textAlignment = NSTextAlignmentCenter;
        price.font = [UIFont systemFontOfSize:13];
        price.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cardName.mas_right);
            make.top.equalTo(userNumber);
            make.size.equalTo(userNumber);
        }];
        
        UILabel *prepaidDate = [[UILabel alloc]init];
        prepaidDate.text = @"2016-2-3 13:22:22";
        prepaidDate.numberOfLines = 2;
        prepaidDate.textAlignment = NSTextAlignmentCenter;
        prepaidDate.font = [UIFont systemFontOfSize:13];
        prepaidDate.textColor = [UIColor colorWithHexString:@"666666"];
        [self addSubview:prepaidDate];
        [prepaidDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(price.mas_right);
            make.top.equalTo(userNumber);
            make.size.equalTo(userNumber);
        }];
    }
    return self;
}

@end
