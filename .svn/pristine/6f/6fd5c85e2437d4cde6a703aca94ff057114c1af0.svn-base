//
//  ShopServerCell.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@protocol shopAdressDelegate <NSObject>
-(void)inputAdressDelegate:(NSString *)string;
-(void)isOtherTextField;
@end

@class TemplateModel;

@interface ShopServerCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueFild;
@property (nonatomic,strong) TemplateModel* model;
@property (weak,nonatomic)id<shopAdressDelegate>delegate;
@end

@protocol ShopEditCellDeledate <NSObject>

-(void)userDidDeleteTheCell:(TemplateModel*)model;


@end

@interface ShopServerEditCell : UITableViewCell <UITextViewDelegate>
@property(nonatomic,strong)UIPlaceHolderTextView* keyTextV;
@property(nonatomic,strong)UIPlaceHolderTextView* valueTextV;
@property(nonatomic,strong)UIButton* deleteSender;
@property (nonatomic,strong) TemplateModel* model;

@property(nonatomic,weak)id<ShopEditCellDeledate> delegate;

@end
