//
//  WZ_LookRoomVC.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/12.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanBaseController.h"

@class PartModel;
typedef void(^LookRoomBlock)(PartModel* model,BOOL isNewData);

@interface WZ_LookRoomVC : WeiZhanBaseController
@property (nonatomic,strong)PartModel *model;

@property (nonatomic, copy) LookRoomBlock block;

- (instancetype)initWithBlock:(LookRoomBlock)block;

@end




@class WZ_AddItemView;

@protocol deleteBtnDelegate <NSObject>
-(void)clickdeleteBtn:(UIButton *)index;
@property(strong,nonatomic)WZ_AddItemView *view;
@end

@interface WZ_AddItemView : UIView<UITextFieldDelegate>
-(instancetype)initWithFrame:(CGRect)frame;
@property(strong,nonatomic)UIButton *deleteBtn;
@property(strong,nonatomic)UITextField *addTextFiled;
@property(assign,nonatomic)NSInteger btnTag;
@property(weak,nonatomic)id<deleteBtnDelegate>delegate;
@property(strong,nonatomic)NSString *textString;
@end