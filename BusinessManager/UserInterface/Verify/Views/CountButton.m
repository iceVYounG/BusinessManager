//
//  CountButton.m
//  BusinessManager
//
//  Created by Raven－z on 16/9/19.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CountButton.h"

@interface CountButton ()

@property (nonatomic) NSInteger downtimer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CountButton

- (instancetype)init{
    self = [super init];
    if (self) {
        self.enabled = YES;
        self.backgroundColor = [UIColor clearColor];
        [self setTitle:@"发送短信验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"01aaef"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"01aaef"].CGColor;
        self.layer.cornerRadius = 3;
    }
    return self;
}

- (void)click{
    _downtimer = 60;
    self.enabled = NO;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(count) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

}

- (void)count{
    _downtimer = _downtimer - 1;
    
    if (_downtimer <= 0) {
        [self setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
        self.enabled = YES;
    }else {
        NSLog(@">>>>>>>>>剩余%ld",(long)_downtimer);
        NSString *title = [NSString stringWithFormat:@"重新获取(%lds)", (long)_downtimer];
        [self setTitle:title forState:UIControlStateNormal];
    }
}

- (void)reSet{
    if([self.titleLabel.text  isEqual: @"发送短信验证码"]){
        [self setTitle:@"发送短信验证码" forState:UIControlStateNormal];
    }else{
        [self setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    }
    [_timer invalidate];
    _timer = nil;
    self.enabled = YES;
}

@end
