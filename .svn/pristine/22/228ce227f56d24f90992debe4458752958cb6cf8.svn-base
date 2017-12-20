//
//  CustomRegistAlertView.m
//  BusinessManager
//
//  Created by 王启明 on 16/9/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CustomRegistAlertView.h"
#define kwidth_scale [UIScreen mainScreen].bounds.size.width/375.0
@implementation CustomRegistAlertView
- (instancetype)initWithFrame:(CGRect)frame WithBlock:(Kblock)kBlock{
    if (self=[super initWithFrame:frame]) {
        self.block=kBlock;
        CGFloat centerx=frame.size.width/2.0;
        CGFloat centery=frame.size.height/2.0;
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7];
        UIView *loginRegistView=[UIView new];
        loginRegistView.center=CGPointMake(centerx, centery);
        loginRegistView.bounds=CGRectMake(0, 0, KScreenWidth*0.9, 290);
        loginRegistView.backgroundColor=[UIColor whiteColor];
        loginRegistView.tag=30;
        loginRegistView.layer.cornerRadius=5;
        loginRegistView.layer.masksToBounds=YES;
        [self addSubview:loginRegistView];
        
        
        self.tipsLab=[UILabel new];
        self.tipsLab.frame=CGRectMake(5*kwidth_scale, 10, loginRegistView.bounds.size.width-10*kwidth_scale, 60);
        self.tipsLab.numberOfLines=0;
        self.tipsLab.text=@"保存模板需登录，您只需输入手机号码获取验证码，即可登录保存。";
        self.tipsLab.textColor=[UIColor colorWithRed:125/255.0 green:126/255.0 blue:127/255.0 alpha:1];
        [loginRegistView addSubview:self.tipsLab];
        CALayer *lineLayer=[[CALayer alloc]init];
        lineLayer.borderWidth=1;
        lineLayer.borderColor=[UIColor grayColor].CGColor;
        lineLayer.frame=CGRectMake(0, self.tipsLab.frame.size.height-1, self.tipsLab.bounds.size.width, 1);
        [self.tipsLab.layer addSublayer:lineLayer];
        
        
        UITextField *shopNameTF=[UITextField new];
        shopNameTF.frame=CGRectMake(5*kwidth_scale, 80, self.tipsLab.bounds.size.width, 40);
        shopNameTF.placeholder=@"请输入商户或企业名称";
        shopNameTF.borderStyle=UITextBorderStyleNone;
        shopNameTF.tag=22;
        [shopNameTF addTarget:self action:@selector(tfAction:) forControlEvents:UIControlEventAllEditingEvents];
        UILabel *namelab1=[UILabel new];
        namelab1.text=@"商户名称";
        namelab1.bounds=CGRectMake(0, 0, 100*kwidth_scale, 40);
        shopNameTF.leftView=namelab1;
        shopNameTF.leftViewMode=UITextFieldViewModeAlways;
        CALayer *lineLayer1=[[CALayer alloc]init];
        lineLayer1.borderWidth=1;
        lineLayer1.borderColor=[UIColor grayColor].CGColor;
        lineLayer1.frame=CGRectMake(0, shopNameTF.frame.size.height-1, shopNameTF.bounds.size.width, 1);
        [shopNameTF.layer addSublayer:lineLayer1];
        [loginRegistView addSubview:shopNameTF];
        
        UITextField *PhoneTf=[UITextField new];
        PhoneTf.frame=CGRectMake(5*kwidth_scale, 130,self.tipsLab.bounds.size.width, 40);
        PhoneTf.placeholder=@"请输入手机号码";
        PhoneTf.borderStyle=UITextBorderStyleNone;
        PhoneTf.keyboardType=UIKeyboardTypeNumberPad;
        PhoneTf.tag=20;
        [loginRegistView addSubview:PhoneTf];
        UILabel *namelab2=[UILabel new];
        namelab2.text=@"+86";
        namelab2.frame=CGRectMake(0, 0, 80*kwidth_scale, 40);
        PhoneTf.leftView=namelab2;
        PhoneTf.leftViewMode=UITextFieldViewModeAlways;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.bounds=CGRectMake(0,0,100*kwidth_scale,30);
        [button setTitleColor:[UIColor colorWithRed:77/255.0 green:171/255.0 blue:277/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        button.layer.borderWidth=1;
        button.layer.borderColor=[UIColor colorWithRed:77/255.0 green:171/255.0 blue:277/255.0 alpha:1].CGColor;
        button.layer.cornerRadius=6;
        button.layer.masksToBounds=YES;
        button.tag=10;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        PhoneTf.rightView=button;
        PhoneTf.rightViewMode=UITextFieldViewModeAlways;
        CALayer *lineLayer2=[[CALayer alloc]init];
        lineLayer2.borderWidth=1;
        lineLayer2.borderColor=[UIColor grayColor].CGColor;
        lineLayer2.frame=CGRectMake(0, shopNameTF.frame.size.height-1, shopNameTF.bounds.size.width, 1);
        [PhoneTf.layer addSublayer:lineLayer2];
        
        
        UITextField *yanZTF=[UITextField new];
        yanZTF.frame=CGRectMake(5*kwidth_scale, 180,self.tipsLab.bounds.size.width, 40);
        yanZTF.placeholder=@"请输入验证码";
        yanZTF.borderStyle=UITextBorderStyleNone;
        yanZTF.tag=21;
        yanZTF.keyboardType=UIKeyboardTypeNumberPad;
        [loginRegistView addSubview:yanZTF];
        UILabel *namelab3=[UILabel new];
        namelab3.text=@"验证码";
        namelab3.bounds=CGRectMake(0, 0, 80*kwidth_scale, 40);
        yanZTF.leftView=namelab3;
        yanZTF.leftViewMode=UITextFieldViewModeAlways;
        CALayer *lineLayer3=[[CALayer alloc]init];
        lineLayer3.borderWidth=1;
        lineLayer3.borderColor=[UIColor grayColor].CGColor;
        lineLayer3.frame=CGRectMake(0, shopNameTF.frame.size.height-1, shopNameTF.bounds.size.width, 1);
        [yanZTF.layer addSublayer:lineLayer3];
        
        
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [sureBtn setBackgroundColor:[UIColor colorWithRed:75/255.0 green:167/255.0 blue:237/255.0 alpha:1]];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        sureBtn.tag=11;
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius=2;
        sureBtn.layer.masksToBounds=YES;
        sureBtn.frame=CGRectMake(20*kwidth_scale, 240, loginRegistView.frame.size.width/2.0-30, 40);
        [sureBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [loginRegistView addSubview:sureBtn];
        
        
        UIButton *cancalBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [cancalBtn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1]];
        [cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancalBtn.tag=12;
        cancalBtn.layer.borderColor=[UIColor blackColor].CGColor;
        cancalBtn.layer.borderWidth=1;
        [cancalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancalBtn.frame=CGRectMake(CGRectGetMaxX(sureBtn.frame)+20*kwidth_scale, 240, loginRegistView.frame.size.width/2.0-30*kwidth_scale, 40);
        cancalBtn.layer.cornerRadius=3;
        cancalBtn.layer.masksToBounds=YES;
        [cancalBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [loginRegistView addSubview:cancalBtn];
        
    }
    return self;
}

- (void)tfAction:(UITextField *)textField{
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > 20)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:20];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:20];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 20)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }

}

- (void)BtnClick:(UIButton *)sender{

    self.block(sender.tag);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
