//
//  QuestionListCell.m
//  BusinessManager
//
//  Created by 朕 on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "QuestionListCell.h"

@implementation QuestionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
    self.textView.layer.borderWidth = 0.5;
    [self.textView.layer masksToBounds];
    self.textView.layer.cornerRadius = 3;
    self.textView.delegate = self;
    _keyArr = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    
    self.optionTableView.delegate = self;
    self.optionTableView.dataSource = self;
    [self.optionTableView registerNib:[UINib nibWithNibName:@"QuetsionOptionCell" bundle:nil] forCellReuseIdentifier:@"QuetsionOptionCell"];
}

- (void)initCellContentWithIndex:(NSInteger)index andModel:(TemplateModel*)model
{
    self.model = model;
    self.textView.text = model.title;
    if (self.textView.text != nil) {
        self.placeholderLabel.hidden = YES;
    }
    [self.optionTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID=@"QuetsionOptionCell";
    QuetsionOptionCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[QuetsionOptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSLog(@"---%ld",(long)indexPath.row);

    if (indexPath.row +1 > self.model.tabs.count) {
        cell.optionTF.text = @"";
    }
    else
    {
       cell.optionTF.text =  [self.model.tabs[indexPath.row] title];
    }
    cell.optionTF.tag = indexPath.row;
    cell.optionLabel.text = _keyArr[indexPath.row];
    [cell initCellContentWithIndex:self.deleteBtn.tag andModel:self.model];

    return cell;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //变化--修改模型
    if ([self.textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO;
    }
    TemplateModel *newModel;
    if (self.model) {
        newModel = self.model;
    }
    else{
    
        newModel=[[TemplateModel alloc]init];
    }
    newModel.title = textView.text;
    NSLog(@">>>>>>%@--%@",newModel.title,textView.text);
    
    NSDictionary *noteDic = @{@"model":newModel,
                              @"index":@(self.deleteBtn.tag)
                              };
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OPTIONCHANGE" object:noteDic];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
