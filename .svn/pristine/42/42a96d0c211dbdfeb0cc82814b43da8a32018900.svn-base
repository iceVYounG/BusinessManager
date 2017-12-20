//
//  ChooseDayView.m
//  BusinessManager
//
//  Created by Raven－z on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChooseDayView.h"

@implementation ChooseDayView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 8;
        UIButton *allButton = [[UIButton alloc]init];
        [allButton setTitle:@"全部" forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        allButton.backgroundColor = [UIColor whiteColor];
        allButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [allButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        allButton.frame = CGRectMake(0, 0, 80, 40);
        [self addSubview:allButton];
        
        UIButton *weekButton = [[UIButton alloc]init];
        [weekButton setTitle:@"最近7日" forState:UIControlStateNormal];
        [weekButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        weekButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [weekButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        weekButton.frame = CGRectMake(0, 40, 80, 40);
        [self addSubview:weekButton];
        
        UIButton *halfMonthButton = [[UIButton alloc]init];
        [halfMonthButton setTitle:@"最近15日" forState:UIControlStateNormal];
        [halfMonthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        halfMonthButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [halfMonthButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        halfMonthButton.frame = CGRectMake(0, 80, 80, 40);
        [self addSubview:halfMonthButton];
        
        UIButton *monthButton = [[UIButton alloc]init];
        [monthButton setTitle:@"最近30日" forState:UIControlStateNormal];
        [monthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        monthButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [monthButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        monthButton.frame = CGRectMake(0, 120, 80, 40);
        [self addSubview:monthButton];
    }
    return self;
}

- (void)clickButton:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(didClickButton:)]) {
        [self.delegate didClickButton:btn.titleLabel.text];
    }
    [self removeFromSuperview];
}

@end
