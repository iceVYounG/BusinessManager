//
//  JMButton.m
//  ButtonDemo
//
//  Created by zhaojh on 16/6/20.
//  Copyright © 2016年 ZJH. All rights reserved.
//

#import "JMButton.h"

@interface JMButton ()

@end

@implementation JMButton

+(JMButton *)creatButton:(CGRect)frame{

    return [[self alloc]initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        
     
    }
    return self;
}

@synthesize ImageEdgInsets = _ImageEdgInsets,TitleEdgInsets = _TitleEdgInsets,ClickAction = _ClickAction,ImagePrams = _ImagePrams, TitlePrams = _TitlePrams;

-(JMButton *(^)(float, float, float, float))ImageEdgInsets{

    return ^JMButton* (float left,float top,float width,float height){
        
        self.jmImagev.frame = CGRectMake(left, top, width, height);
        
        return self;
    };
}
-(JMButton *(^)(float, float, float, float))TitleEdgInsets{

    return ^JMButton* (float left,float top,float width,float height){
        
        self.jmLabel.frame = CGRectMake(left, top, width, height);
        
        return self;
    };
}

-(JMButton *(^)(id, SEL))ClickAction{

    return ^JMButton* (id target, SEL clickAction){
        
        if (!clickAction) {
            return self;
        }
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:clickAction];
        
        [self addGestureRecognizer:tap];
        
        return self;
    };
}

-(JMButton *(^)(NSString *, UIViewContentMode))ImagePrams{
    
    return ^JMButton* (NSString* imgName,UIViewContentMode mode){
    
        self.jmImagev.image = [UIImage imageNamed:imgName];
        self.jmImagev.contentMode = mode;
        
        return self;
    };
}

-(JMButton *(^)(NSString *, NSInteger, UIColor *))TitlePrams{

    return ^JMButton* (NSString* title, NSInteger fountSize,UIColor* textColor){
        
        self.jmLabel.text = title;
        self.jmLabel.font = [UIFont systemFontOfSize:fountSize];
        self.jmLabel.textColor = textColor;
        
        return self;
    };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.jmLabel.alpha = .6;
    self.jmImagev.alpha = .6;
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.jmLabel.alpha = 1;
    self.jmImagev.alpha = 1;
}

@synthesize jmImagev = _jmImagev,jmLabel = _jmLabel;

-(UIImageView *)jmImagev{

    if (!_jmImagev) {
        _jmImagev = [[UIImageView alloc]init];
        [self addSubview:_jmImagev];
    }
    return _jmImagev;
}

-(UILabel *)jmLabel{
    
    if (!_jmLabel) {
        _jmLabel = [[UILabel alloc]init];
        _jmLabel.textAlignment = 1;
         [self addSubview:_jmLabel];
    }
    return _jmLabel;
}

@end
