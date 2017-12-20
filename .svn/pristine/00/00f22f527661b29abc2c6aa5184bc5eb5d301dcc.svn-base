//
//  WZ_ConfigGooodsTopTextInfoCell.m
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_ConfigGooodsTopTextInfoCell.h"

@implementation WZ_ConfigGooodsTopTextInfoCell

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WZ_NewFloorTextFieldDidChangeAction:) name:UITextFieldTextDidChangeNotification object:self.goodsPriceTF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WZ_NewFloorTextViewDidChangeAction:) name:UITextViewTextDidChangeNotification object:self.goodsDescribeTV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WZ_NewFloorTextViewDidChangeAction:) name:UITextViewTextDidChangeNotification object:self.goodsNameTV];
    self.goodsDescribeTV.delegate = self;
    self.goodsNameTV.delegate = self;
    self.goodsPriceTF.delegate = self;
    [self.goodsPriceTF setValue:[UIColor colorWithHexString:@"#CCCCCC"] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setItemModel:(TemplateModel *)itemModel {
    _itemModel = itemModel;
    
    if (itemModel) {
        [self.goodsNameTV setTextColor:[UIColor blackColor]];
        [self.goodsPriceTF setTextColor:[UIColor blackColor]];
        [self.goodsDescribeTV setTextColor:[UIColor blackColor]];
        self.goodsNameTV.text = NoNullStr(itemModel.name, @"") ;
        NSString *money = [NSString transformMoneyFormatter:itemModel.price andTransformDirection:YES];
        self.goodsPriceTF.text =[NSString stringWithFormat:@"%@", money];
        if (itemModel.content.length > 0) {
            NSString *content = [NSString WZ_FloorFilterDescribeTextFromContent:itemModel.content];
            NSString *formatContent = [NSString getZZwithString:content];
            NSLog(@"---content-->>>:%@", content);
            NSLog(@"---formatContent-->>>:%@", formatContent);
            self.goodsDescribeTV.text = formatContent;
        }
        
    }else {
        if ([self.goodsNameTV.text isEqualToString:@""]) {
            [self.goodsNameTV setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
            self.goodsNameTV.text = @"请输入商品名称";
            
        }
        if ([self.goodsDescribeTV.text isEqualToString:@""]) {
            self.goodsDescribeTV.text = @"请输入商品的详细介绍";
            [self.goodsDescribeTV setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        }
        
    }
}

#pragma mark - UITextFieldDidChangeNotifiAction / UITextViewDidChangeNotifiAction

- (void)WZ_NewFloorTextFieldDidChangeAction:(NSNotification *)notifi {
    UITextField *textField = (UITextField *)notifi.object;
    if ([textField isEqual:self.goodsPriceTF]) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_NewFloor_AddNew_Price)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Price];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Price];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_NewFloor_AddNew_Price)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }

}

- (void)WZ_NewFloorTextViewDidChangeAction:(NSNotification *)notifi {
    UITextView *textView = (UITextView *)notifi.object;
    if ([textView isEqual:self.goodsNameTV]) {
        NSString *toBeString = textView.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_NewFloor_AddNew_Name)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Name];
                if (rangeIndex.length == 1)
                {
                    textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Name];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_NewFloor_AddNew_Name)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else if ([textView isEqual:self.goodsDescribeTV]) {
        NSString *toBeString = textView.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_NewFloor_AddNew_Content)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Content];
                if (rangeIndex.length == 1)
                {
                    textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_NewFloor_AddNew_Content];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_NewFloor_AddNew_Content)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
}

#pragma mark - UITextFieldDelegate / UITextViewDelegate 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField isEqual:self.goodsPriceTF]) {
        return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:6];
    }else {
        return YES;
    }
    
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if ([textField isEqual:self.goodsPriceTF]) {
//        if ([textField.text isEqualToString:@"请输入商品价格"]) {
//            textField.text = @"";
//            [textField setTextColor:[UIColor blackColor]];
//        }else if ([textField.text isEqualToString:@""]) {
//            [textField setTextColor:[UIColor blackColor]];
//        }
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if ([textField isEqual:self.goodsPriceTF]) {
//        if ([textField.text isEqualToString:@""]) {
//            textField.text = @"请输入商品价格";
//            [textField setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
//        }
//    }
//}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
////    if ([text isEqualToString:@""]) {
////        return YES;
////    }
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
////    if ([textView isEqual:self.goodsDescribeTV]) {
////        if ([textView.text isEqualToString:@""]) {
////            textView.text = @"请输入商品的详细介绍";
////            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
////        }else {
////            [textView setTextColor:[UIColor blackColor]];
////        }
//        
////    }else if ([textView isEqual:self.goodsNameTV]) {
////        if ([textView.text isEqualToString:@""]) {
////            textView.text = @"请输入商品名称";
////            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
////        }else {
////            [textView setTextColor:[UIColor blackColor]];
////        }
////    }
//
//    return YES;
//
//}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView isEqual:self.goodsDescribeTV]) {
        if ([textView.text isEqualToString:@"请输入商品的详细介绍"]) {
            textView.text = @"";
            [textView setTextColor:[UIColor blackColor]];
        }
    }else if ([textView isEqual:self.goodsNameTV]) {
        if ([textView.text isEqualToString:@"请输入商品名称"]) {
            textView.text = @"";
            [textView setTextColor:[UIColor blackColor]];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView isEqual:self.goodsDescribeTV]) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入商品的详细介绍";
            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
        }
    }else if ([textView isEqual:self.goodsNameTV]) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"请输入商品名称";
            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
        }
    }
}

//- (void)textViewDidChange:(UITextView *)textView {
//    if ([textView isEqual:self.goodsDescribeTV]) {
//        if ([textView.text isEqualToString:@""]) {
//            textView.text = @"请输入商品的详细介绍";
//            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
//        }
//    }else if ([textView isEqual:self.goodsNameTV]) {
//        if ([textView.text isEqualToString:@""]) {
//            textView.text = @"请输入商品名称";
//            [textView setTextColor:[UIColor colorWithHexString:@"#CCCCCC"]];
//        }
//    }
//}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
