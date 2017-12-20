//
//  QuestionListCell.h
//  BusinessManager
//
//  Created by 朕 on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"
#import "QuetsionOptionCell.h"

@interface QuestionListCell : UITableViewCell<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *optionTableView;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property(nonatomic,strong)NSString *viewContent;
@property(nonatomic,strong)NSString *filedContent;

@property(nonatomic,strong)NSArray *keyArr;

@property(nonatomic,strong)TemplateModel *model;

- (void)initCellContentWithIndex:(NSInteger)index andModel:(TemplateModel*)model;

@end
