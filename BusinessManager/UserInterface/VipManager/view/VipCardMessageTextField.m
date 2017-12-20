//
//  VipCardMessageTextField.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipCardMessageTextField.h"

@implementation VipCardMessageTextField

- (id)initWithPlaceholder:(NSString *)placeholderStr tailStr:(NSString *)tailStr{
    self = [super init];
    if (self) {
        self.text = placeholderStr;
        self.font = [UIFont systemFontOfSize:16];
        
        if (tailStr.length) {
            UILabel *tailStrLabel = [[UILabel alloc]init];
            tailStrLabel.text = tailStr;
            tailStrLabel.textColor = [UIColor blackColor];
            tailStrLabel.font = [UIFont systemFontOfSize:16];
            [self addSubview:tailStrLabel];
            [tailStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-15);
                make.centerY.equalTo(self);
            }];
        }
    }
    return self;
}

- (void)addDownArrow{
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VipManager_DownArrow"]];
    [self addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

- (void)dealloc {
    NSLog(@"VipCardMessageTextField --> dealloc...");
}

@end
