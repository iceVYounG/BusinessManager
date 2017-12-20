//
//  QuetsionOptionCell.h
//  BusinessManager
//
//  Created by 朕 on 16/9/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"

@interface QuetsionOptionCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) IBOutlet UITextField *optionTF;
@property(nonatomic,strong)NSString *optionStr;

@property(nonatomic,strong)TemplateModel *model;
@property(nonatomic,assign)NSInteger index;

- (void)initCellContentWithIndex:(NSInteger)index andModel:(TemplateModel*)model;

@end
