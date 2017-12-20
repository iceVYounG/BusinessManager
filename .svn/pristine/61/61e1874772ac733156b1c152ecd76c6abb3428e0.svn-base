//
//  BaseController.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSingleLineView.h"

@class LeftItem;

@interface BaseController : UIViewController

@property(nonatomic,strong)LeftItem* leftItem;

@property(nonatomic,assign)BOOL backItemHiden; //返回按钮是否隐藏

@property(nonatomic,copy) NSString* leftTitle;

@property (nonatomic, strong) NSDate *requestDate;

-(void)settingBackItem;

- (void)addNavRightButtonWithTitle:(NSString *)title icon:(UIImage *)icon action:(SEL)selector target:(id)target;


@end

#pragma mark - BackItem
@interface LeftItem : UIView

-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
-(CGRect)setLeftItemTitle:(NSString*)title;



@end




