//
//  YuyueDetailEditCell.h
//  BusinessManager
//
//  Created by 张心亮 on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@class TemplateModel;

@interface YuyueDetailEditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *valueFild;
@property (nonatomic,strong) TemplateModel* model;

@end

@protocol ShopEditCellDeledate <NSObject>

-(void)userDidDeleteTheCell:(TemplateModel*)model;


@end

@interface YuyueDetailCell : UITableViewCell <UITextViewDelegate>
@property(nonatomic,strong)UIPlaceHolderTextView* valueTextV;
@property(nonatomic,strong)UIButton* deleteSender;
@property (nonatomic,strong) TemplateModel* model;
@property(nonatomic,weak)id<ShopEditCellDeledate> delegate;

@end





@class HZYuYueDetailCell;
@protocol HZYuYueDetailCellDelegate <NSObject>
- (void)yuYueDetailCell:(HZYuYueDetailCell *)cell didDeleteCellWithModel:(TemplateModel *)model;
@end

@interface HZYuYueDetailCell : UITableViewCell < UITextFieldDelegate >
@property (nonatomic,strong)UITextField *textView;
@property (nonatomic,strong)UIButton* deleteSender;
@property (nonatomic,strong)TemplateModel* model;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)id < HZYuYueDetailCellDelegate > delegate;

@end

@interface HZYuYueDefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *fitmentTime;
@property (weak, nonatomic) IBOutlet UIButton *contactName;
@property (weak, nonatomic) IBOutlet UIButton *contactPhone;
@property (weak, nonatomic) IBOutlet UIButton *fitmentArea;
@property (weak, nonatomic) IBOutlet UIButton *fitmentPrice;

@end
