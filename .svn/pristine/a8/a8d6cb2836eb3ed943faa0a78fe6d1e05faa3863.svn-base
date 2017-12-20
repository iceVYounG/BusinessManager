//
//  ChooseButtonView.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChooseButtonView.h"

@interface ChooseButtonView ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ChooseButtonView

- (instancetype)initWithNameArray:(NSArray *)nameArray{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        _dataArray = [[NSArray alloc]initWithArray:nameArray];
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"01aafe"];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width/_dataArray.count, 5));
            make.left.bottom.equalTo(self);
        }];
        [self setUIWithArray:nameArray];
    }
    return self;
}

- (void)setUIWithArray:(NSArray *)nameArray{
    for (int i = 0; i < nameArray.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1000 + i;
        [btn setTitle:nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"01aafe"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width/_dataArray.count,48));
//            make.top.equalTo(self);
//            make.left.equalTo(self).offset(i * (SCREEN_SIZE.width/_dataArray.count));
//        }];
        btn.frame = CGRectMake(i * (SCREEN_SIZE.width/_dataArray.count), 0, SCREEN_SIZE.width/_dataArray.count, 48);
        if (i == 0) {
            btn.selected = YES;
        }
    }
}

- (void)clickBtn:(UIButton *)btn{
    for (int i = 0; i < _dataArray.count; i ++) {
        UIButton *tBtn = (UIButton *)[self viewWithTag:(1000 + i)];
        tBtn.selected = NO;
    }
    btn.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame)-5, btn.frame.size.width, 5);
    }];
    
    if ([self.delegate respondsToSelector:@selector(didClickBtn:)]) {
        [self.delegate didClickBtn:btn.tag];
    }
}

@end
