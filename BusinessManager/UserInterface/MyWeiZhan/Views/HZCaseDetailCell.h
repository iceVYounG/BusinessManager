//
//  HZCaseDetailCell.h
//  BusinessManager
//
//  Created by niuzs on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"
#import "JMPickCollectView.h"
#import "UIPlaceHolderTextView.h"
@class HZCaseDetailCell ;
@protocol HZCaseDetailCellDelegate <NSObject>

@end

@interface HZCaseDetailImageView : UIView
@property (strong, nonatomic)UIButton *attachment;
@property (strong, nonatomic)UIButton *deleteSender;
@end

@interface HZCaseBottomView : UIView
@property (strong, nonatomic)HZCaseDetailImageView *caseIconView;
@property (strong, nonatomic)HZCaseDetailImageView *iconView;
@property (strong, nonatomic)UIButton *addBtn;

@property (strong, nonatomic)TemplateModel *model;
@property (assign, nonatomic)CGFloat height;
@end


@interface HZCaseDetailCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,strong) UIPlaceHolderTextView* textView;
@property(nonatomic,strong)NSMutableArray* selectImages;
@property(nonatomic,strong)NSMutableArray* imagePaths;
@property(nonatomic,strong)JMPickCollectView* collectionView;
@property(nonatomic,strong)NSMutableArray* lastImageArr;
@property(nonatomic,assign)BOOL isImageUpload;

@property (weak, nonatomic) IBOutlet UILabel *caseNumLab;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *iconNameTextF;
@property (strong, nonatomic)TemplateModel *model;

@end




