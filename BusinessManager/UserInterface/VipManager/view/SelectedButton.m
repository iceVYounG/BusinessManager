//
//  SelectedButton.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "SelectedButton.h"

@implementation SelectedButton

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.layer.borderColor = [UIColor colorWithHexString:@"00aaee"].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.selected = NO;
//        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        //Tag
        NSInteger tag = [title integerValue];
        self.tag = tag;
        
    }
    return self;
}

- (void)click{
    self.selected = !self.selected;
    if (self.selected == YES) {
        self.backgroundColor = [UIColor colorWithHexString:@"00aaee"];
    }else if(self.selected == NO){
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
