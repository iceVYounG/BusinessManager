//
//  HZCaseDetailCollectionViewCell.m
//  BusinessManager
//
//  Created by 牛志胜 on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZCaseDetailCollectionViewCell.h"

NSString * const HZCaseDetailCollectionViewCellID = @"HZCaseDetailCollectionViewCellID";


@implementation HZCaseDetailCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iconNameTextF.frame) + 15 , SCREEN_SIZE.width - 20, 121)];
    _textView.placeholder = @"输入文字介绍 , 如果没有图片可不上传图片";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(3, 2, 0, 2);
    _textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 1;
    _textView.delegate = self;
    _iconNameTextF.delegate =self;
    [self.contentView addSubview:_textView];
    
    [_iconImageBtn addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    _iconImageBtn.tag = ChooseImageTAG;
    [_deleteBtn addTarget:self action:@selector(delegateModel:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.tag = DelegateTAG;
    
}
- (void)setModel:(ModelSection *)model{
    _model = model;
    [_iconImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,model.model.imgPath]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"uploadImage"]];
    _iconNameTextF.text = model.model.name;
    
    if (self.isNewTemple) {
        NSString *contentString;
        contentString=[NSString getZZwithString:model.model.content];
        _textView.text = contentString;
    }
    else{
        _textView.text=model.content;
    }
    
}




- (void)chooseImage:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(caseDetailCollectionViewCell:actionWithButton:)]) {
        [_delegate caseDetailCollectionViewCell:self actionWithButton:sender];
    }
}

- (void)delegateModel:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(caseDetailCollectionViewCell:actionWithButton:)]) {
        [_delegate caseDetailCollectionViewCell:self actionWithButton:sender];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.isNewTemple) {
         _model.model.content = textView.text;
    }
    else{
        _model.content = textView.text;
    }
   
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    _model.model.name = textField.text;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    _model.model.name = textField.text;
    return YES;
}
@end
