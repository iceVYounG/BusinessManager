//
//  HomePageView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HomePageView.h"

@implementation HomePageView

- (id)initWithTitleStr:(NSString *)titleStr{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        _iconView = [[UIImageView alloc]init];
//        _iconView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = titleStr;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(@30);
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
