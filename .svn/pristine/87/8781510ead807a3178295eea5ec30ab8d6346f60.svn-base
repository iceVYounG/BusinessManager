//
//  VipMangerView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipMangerView.h"

@implementation VipMangerView

- (id)initWithTitle:(NSString *)titleStr image:(UIImage *)image iconColor:(UIColor *)iconColor{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        
        UIView *iconView = [[UIView alloc]init];
        iconView.backgroundColor = iconColor;
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_width).multipliedBy(1/3.5);
        }];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithImage:image];
        [iconView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.center.equalTo(iconView);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = titleStr;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:23];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self);
            make.left.equalTo(iconView.mas_right).offset(24);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VipManager_RightArrow"]];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-12);
        }];
    }
    return self;
}

- (void)addTapGRWithTarget:(id)taget Sel:(SEL)seleter{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:taget action:seleter];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGR];
}

@end
