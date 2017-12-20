//
//  JMView.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "JMView.h"

@interface JMView ()

@property(nonatomic,strong)NSArray* names;

@end

@implementation JMView

-(instancetype)initWithFrame:(CGRect)frame btnNames:(NSArray*)names{
    
    if (self = [super initWithFrame:frame]) {
        
        self.names = names;
        self.backgroundColor = [UIColor colorWithHexString:@"#434446"];
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setNames:(NSArray *)names{
    _names = names;

    [names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString* name = (NSString*)obj;
        static CGFloat maxX = 0.0;
        CGFloat w = [JMView getWidth:@[name]];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(maxX, 0, w, JMViewH);
        maxX = CGRectGetMaxX(btn.frame);
        btn.tag = ButtonTAGADD + idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor colorWithHexString:@"#fafafa"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(senderAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:name forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (idx == names.count - 1) {
             maxX = 0.0;
        }
    }];
}

-(void)senderAction:(UIButton*)sender{

    if (self.delegate && [self.delegate respondsToSelector:@selector(userDidSelectTitle:atIndex:inView:)]) {
        
        [self.delegate userDidSelectTitle:_names[sender.tag - ButtonTAGADD] atIndex:sender.tag - ButtonTAGADD inView:self];
    }

}

+(CGFloat)getWidth:(NSArray*)names{

    CGFloat w = 0.0;
    for (NSString* name in names) {
        
        w = WidthForString(name,15,1000) + 27 + w;
    }
    return w;
}

@end

#pragma mark - 保存按钮
@implementation SaveView

-(instancetype)initWithFrame:(CGRect)frame tipHiden:(BOOL)tipHiden block:(ComformAction)block{

    if (self = [super initWithFrame:frame]) {
        
        _block = block;
        self.backgroundColor = [UIColor clearColor];
        [self cratSubView:tipHiden];
    }
    return self;
}

-(void)cratSubView:(BOOL)tipHiden{

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(15, 0, self.width - 30, 44);
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    button.backgroundColor = HexColor(@"#01aaef");
    button.tag = 111;
    _saveBuuton = button;
    [self addSubview:button];
    
    if (tipHiden) {
        return;
    }
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+3, SCREEN_SIZE.width, 17)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = 1;
    label.text = @"*模板编辑完毕,别忘了保存一下";
    label.tag = 222;
    [self addSubview:label];
}

-(void)setSenderTitle:(NSString *)senderTitle{
    _senderTitle = senderTitle;
    UIButton* button = [self viewWithTag:111];
    [button setTitle:_senderTitle forState:UIControlStateNormal];
}

-(void)setSenderTip:(NSString *)senderTip{
    _senderTip = senderTip;
    UILabel* label = [self viewWithTag:222];
    label.text = _senderTip;
}

-(void)saveAction{

    if (self.block) {
        self.block();
    }
}


@end



