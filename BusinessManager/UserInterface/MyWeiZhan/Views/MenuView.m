//
//  MenuView.m
//  BusinessManager
//
//  Created by Niuyp on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame block:(menuViewBlock)block{
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.block = block;
        
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - width)*0.5, 5, width, height)];
    imageView.tag = 665;
    [self addSubview:imageView];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+5, self.width, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.f];
    label.textColor=[UIColor colorWithHexString:@"#666666"];
    label.tag = 686;
    [self addSubview:label];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 3.f;
    button.frame = CGRectMake((self.width - 63)*0.5, CGRectGetMaxY(label.frame)+5, 63, 29);
    button.backgroundColor = [UIColor colorWithHexString:@"#01aaef"];
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    UILabel* label = [self viewWithTag:686];
    label.text = _title;
}

- (void)setImageStr:(NSString *)imageStr{
    
    _imageStr = imageStr;
    
    UIImageView* imageView = [self viewWithTag:665];
    
    imageView.image = [UIImage imageNamed:_imageStr];
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    
    UIButton* but = [self viewWithTag:848];
    [but setTitle:_buttonTitle forState:UIControlStateNormal];
}

- (void)buttonAction:(UIButton*)sender{
    if (self.block) {
        self.block(self);
    }
}
@end