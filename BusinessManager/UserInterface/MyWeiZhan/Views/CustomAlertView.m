//
//  CustomAlertView.m
//  BusinessManager
//
//  Created by 王启明 on 16/9/7.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7];
        UIView *warnningView=[UIView new];
        warnningView.center=CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        warnningView.bounds=CGRectMake(0, 0, frame.size.width-40, 120);
        warnningView.backgroundColor=[UIColor whiteColor];
        warnningView.layer.cornerRadius=5;
        warnningView.layer.masksToBounds=YES;
        [self addSubview:warnningView];
        UILabel *lab=[UILabel new];
        lab.text=@"提示";
        lab.textColor=[UIColor blueColor];
        lab.frame=CGRectMake(0, 0, warnningView.bounds.size.width, 40);
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:20];
        lab.layer.cornerRadius=5;
        lab.layer.masksToBounds=YES;
        CALayer *lineLayer=[[CALayer alloc]init];
        lineLayer.borderWidth=1;
        lineLayer.borderColor=[UIColor blackColor].CGColor;
        lineLayer.frame=CGRectMake(0, lab.frame.size.height-2, lab.frame.size.width, 1);
        [lab.layer addSublayer:lineLayer];
        [warnningView addSubview:lab];
        self.hittLab=[UITextView new];
        self.hittLab.backgroundColor=[UIColor whiteColor];
        self.hittLab.editable=NO;
        self.hittLab.scrollEnabled=NO;
        self.hittLab.delegate=self;
        self.hittLab.text=@"电商模板功能目前只支持商城商户，如果需要入驻商城请致电：";
        self.PhoneStr=@"4001-511-511";
        NSString *str=[NSString stringWithFormat:@"%@%@",self.hittLab.text,self.PhoneStr];
        NSMutableAttributedString *mutableStr=[[NSMutableAttributedString alloc]initWithString:str];
        NSRange range=NSMakeRange(self.hittLab.text.length, self.PhoneStr.length);
      [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    [mutableStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        [mutableStr addAttribute:  NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, mutableStr.length)];
        [mutableStr addAttribute:NSLinkAttributeName
                                     value:@"tel://4001-511-511"
                                      range:[[mutableStr string] rangeOfString:@"4001-511-511"]];
         self.hittLab.frame=CGRectMake(20, 40, warnningView.bounds.size.width-40, 80);
        self.hittLab.font=[UIFont boldSystemFontOfSize:18];
        self.hittLab.attributedText=mutableStr;
        [warnningView addSubview:self.hittLab];
        
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    [[UIApplication sharedApplication]openURL:URL];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end