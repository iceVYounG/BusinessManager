//
//  JMView.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JMViewH 41
#define ThreeBtns     @[@"隐藏",@"编辑",@"添加"]
#define OneBtnsEdit   @[@"编辑"]
#define OneBtnsShow   @[@"显示活动"]
#define ButtonTAGADD  98
@protocol JMViewDelegate <NSObject>
@optional
-(void)userDidSelectTitle:(NSString*)title atIndex:(NSInteger)index inView:(UIView*)view;
-(void)userDidSelectIndex:(NSInteger)index inView:(UIView*)view data:(id)data;
@end

@interface JMView : UIView

-(instancetype)initWithFrame:(CGRect)frame btnNames:(NSArray*)names;

+(CGFloat)getWidth:(NSArray*)names; //获取宽度

@property(nonatomic,strong)id prams; 

@property(nonatomic,weak)id<JMViewDelegate> delegate;

@end

#pragma mark - 保存按钮
typedef void(^ComformAction)();
@interface SaveView : UIView

-(instancetype)initWithFrame:(CGRect)frame tipHiden:(BOOL)tipHiden block:(ComformAction)block;

@property(nonatomic,copy)NSString* senderTitle;

@property(nonatomic,copy)NSString* senderTip;
@property(nonatomic,strong)UIButton *saveBuuton;
@property(nonatomic,copy)ComformAction block;


@end