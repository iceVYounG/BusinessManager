//
//  HZCaseDetailCollectionViewCell.h
//  BusinessManager
//
//  Created by niuzs on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "WeiZhanModel.h"
#import "UIButton+WebCache.h"
#define ChooseImageTAG 900
#define DelegateTAG 800
//名称字数限制
#define MAX_STARWORDS_LENGTH_EditFit_Name 40

extern NSString *const EditFitmentCollectionViewCellID;
@class EditFitmentCollectionViewCell;
@protocol EditFitmentCollectionViewCellDelegate <NSObject>

- (void)caseDetailCollectionViewCell:(EditFitmentCollectionViewCell *)cell actionWithButton:(UIButton *)sender;

@end

@interface EditFitmentCollectionViewCell : UICollectionViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *caseNum;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *iconNameTextF;
@property (weak, nonatomic) IBOutlet UITextField *iconPriceTextF;

@property (nonatomic,strong) UIPlaceHolderTextView* textView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign) id < EditFitmentCollectionViewCellDelegate >delegate;
@property (nonatomic,assign) ModelSection *model;
@end
