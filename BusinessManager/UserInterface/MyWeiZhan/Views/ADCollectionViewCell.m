//
//  ADCollectionViewCell.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ADCollectionViewCell.h"
#import "JMPickCollectView.h"
#import "WeiZhanModel.h"
#import "UIButton+WebCache.h"

@implementation ADCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameField.delegate=self;
    self.nameField.tag=10;
    self.priceField.tag=20;
    self.priceField.delegate=self;
}

- (void)setModel:(TemplateModel *)model{
    _model = model;

    NSLog(@"%@--%@",model.name,model.imgPath);
    
    if (!_model) {
        _nameField.text = @"";
        _priceField.text = @"";
        
        return;
    }
    _nameField.text = _model.name;
    _priceField.text = _model.type;
    NSString* imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath];
    
    [self.imageSender sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img"]];
    
}


- (IBAction)imageSenderClick:(UIButton *)sender {
    
    if (self.delegate) {
        [self.delegate jump2ImagePickerVCsender:sender];
    }
}
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate deleteImageCell:sender];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==10) {
        self.nameField.text=textField.text;
    }
    else if(textField.tag==20){
        self.priceField.text=textField.text;
    
    }
    
    if (self.delegate) {
        [self.delegate textFieldChange:self.nameField.text andPrice:self.priceField.text andIndex:self.index];
    }
}

@end
