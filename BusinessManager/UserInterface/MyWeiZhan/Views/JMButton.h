//
//  JMButton.h
//  ButtonDemo
//
//  Created by zhaojh on 16/6/20.
//  Copyright © 2016年 ZJH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JMButton : UIView

+(JMButton *)creatButton:(CGRect)frame;
@property(nonatomic,strong)UIImageView* jmImagev;
@property(nonatomic,strong)UILabel* jmLabel;

/** Imagev的frame，参数为“(x, y, w, h)”  */
@property(nonatomic,copy)JMButton* (^ImageEdgInsets)(float left,float top,float width,float height);
/** Title的frame，参数为“(x, y, w, h)” */
@property(nonatomic,copy)JMButton* (^TitleEdgInsets)(float left,float top,float width,float height);
/** Imagev的参数值，“(NSString* imgName,UIViewContentMode mode)” */
@property(nonatomic,copy)JMButton* (^ImagePrams)(NSString* imgName,UIViewContentMode mode);
/** Title的参数值，“(title, fountSize, textColor)” */
@property(nonatomic,copy)JMButton* (^TitlePrams)(NSString* title,NSInteger fountSize,UIColor* textColor);
/** 点击事件，“(id target, SEL clickAction)” */
@property(nonatomic,copy)JMButton* (^ClickAction)(id target, SEL clickAction);

@end

