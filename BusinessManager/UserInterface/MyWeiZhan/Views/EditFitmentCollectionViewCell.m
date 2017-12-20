//
//  HZCaseDetailCollectionViewCell.m
//  BusinessManager
//
//  Created by niuzs on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EditFitmentCollectionViewCell.h"

NSString * const EditFitmentCollectionViewCellID = @"EditFitmentCollectionViewCellID";

@implementation EditFitmentCollectionViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iconPriceTextF.frame) + 15 , SCREEN_SIZE.width - 20, 121)];
    
    _textView.placeholder = @"输入文字介绍 , 如果没有图片可不上传图片";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(3, 2, 0, 2);
    _textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 1;
    _textView.delegate = self;
    _iconNameTextF.delegate =self;
    _iconPriceTextF.delegate = self;
    [self.contentView addSubview:_textView];
    
    [_iconImageBtn addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    _iconImageBtn.tag = ChooseImageTAG;
    [_deleteBtn addTarget:self action:@selector(delegateModel:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.tag = DelegateTAG;
    self.iconPriceTextF.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editFitPrice_textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.iconNameTextF];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(ModelSection *)model{
    
    _model = model;
    [_iconImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,model.model.imgPath]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"uploadImage"]];
    _iconNameTextF.text = model.model.name;
    _iconPriceTextF.text = model.model.type;
    _textView.text = model.content;
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField isEqual:self.iconPriceTextF]) {
        return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:10];
    }else {
        return YES;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    _model.content = textView.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 10) {
        _model.model.name = textField.text;
    }
    if (textField.tag == 11) {
        _model.model.type = textField.text;
    }
}


- (void)editFitPrice_textFieldDidChange:(NSNotification *)notifi {
    UITextField *textField = (UITextField *)notifi.object;
    if ([textField isEqual:self.iconNameTextF]) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_EditFit_Name)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_EditFit_Name];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_EditFit_Name];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_EditFit_Name)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }

}

@end
