//
//  QuetsionOptionCell.m
//  BusinessManager
//
//  Created by 朕 on 16/9/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "QuetsionOptionCell.h"

@implementation QuetsionOptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.optionTF.delegate = self;
}

- (void)initCellContentWithIndex:(NSInteger)index andModel:(TemplateModel*)model
{
    self.model = model;
    self.index = index;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.optionStr = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    TemplateModel *newModel;
    if (self.model) {
       newModel = self.model;
    }
    else{
        newModel=[[TemplateModel alloc]init];
    
    }
    if ([self.optionStr isEqualToString:textField.text]) {
        //无变化
        return;
    }
    else
    {
        //有变化
        TemplateModel *replaceModel = [[TemplateModel alloc]init];
        replaceModel.title = textField.text;
        NSArray *beforeArr=[NSArray array];
        beforeArr = newModel.tabs;
        NSMutableArray *afterArr = [NSMutableArray arrayWithArray:beforeArr];
        
        if(newModel.tabs.count > textField.tag)
        {
            //替换
            [afterArr replaceObjectAtIndex:textField.tag withObject:replaceModel];
        }
        else
        {
            //添加
            [afterArr addObject:replaceModel];
        }
        newModel.tabs = [afterArr copy];
        
    }

    NSDictionary *noteDic = @{@"model":newModel,
                              @"index":@(self.index)
                              };
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OPTIONCHANGE" object:noteDic];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
