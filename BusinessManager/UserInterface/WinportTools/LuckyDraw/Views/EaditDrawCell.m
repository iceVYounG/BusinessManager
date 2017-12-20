//
//  EaditDrawCell.m
//  BusinessManager
//
//  Created by The Only on 16/7/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EaditDrawCell.h"
#define MAX_STARWORDS_LENGTH_TEXTFIELD 10
@interface EaditDrawCell()<UITextFieldDelegate>

@end
@implementation EaditDrawCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.redNameTF.delegate = self;
    self.redNameTF.tag=10001;
    self.singleRedMoneyTF.delegate = self;
    self.redCountTF.delegate =  self;
    self.winningChanceTF.delegate =  self;
    self.winningChanceTF.tag=10000;
    self.winningCountTF.delegate =  self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityEadit_textFieldEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)ActivityEadit_textFieldEditChanged:(NSNotification *)noti
{
    UITextField *textField = (UITextField *)noti.object;
    if (textField.tag==10001) {
    if ([textField isEqual:self.redNameTF]) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_TEXTFIELD)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_TEXTFIELD];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_TEXTFIELD];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_TEXTFIELD)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    }
    if (textField.tag==10000) {
        if (textField.text.length==0) {
            return;
        }
        if (textField.text.floatValue>1) {
            textField.text=@"";
            [OMGToast showWithText:@"概率不能大于1"];
        }
       
//        if ([textField.text WZ_NewFloorIsLegalMoney:[textField.text floatValue] andFormat:2]) {
//            if ([textField.text floatValue] > 1.0) {
//                textField.text=[textField.text substringToIndex:textField.text.length-1];
//                [OMGToast showWithText:@"概率不能大于1"];
//            }
//            
//        }else{
//            textField.text=[textField.text substringToIndex:textField.text.length-1];
//            [OMGToast showWithText:@"输入字符不合法"];
//        }
    }
    
}
-(void)setDrawModel:(activityInfoItem *)DrawModel
{
     _DrawModel = DrawModel;
 
    if (DrawModel.chooseDrawType == nil) {
        
        self.infoViewHeightConstraint.constant = 0;
        // 强制布局
         [self layoutIfNeeded];
        self.presentTypeView.hidden = YES;
 
    }
    else
    {
        if ([DrawModel.chooseDrawType isEqualToString:@"singleMoney"])
        {
            self.singleMoneyHeight.constant = 0;
            self.presentTypeView.hidden = NO;
            self.infoViewHeightConstraint.constant = 194;
            
            self.deleteHeight.constant = 180;
            self.HLineViewHeight.constant = 180;
            self.singleLineView.hidden = YES;
        }
        else
        {
            
            self.infoViewHeightConstraint.constant = 240;
            self.presentTypeView.hidden = NO;
            self.singleMoneyHeight.constant = 44;
            self.deleteHeight.constant = 224;
            self.HLineViewHeight.constant = 224;
            self.singleLineView.hidden = NO;
        }
        
    }
    
    [self.redTypeBtn setTitle:DrawModel.btnTitle forState:UIControlStateNormal];
    [self.redTypeBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    
    self.redNameTF.text = DrawModel.redName;
    if ([DrawModel.singleAmountY isEqualToString:@""]||DrawModel.singleAmountY == nil)
    {
        self.singleRedMoneyTF.text = DrawModel.singleAmountY;
    }
    else
    {
         self.singleRedMoneyTF.text = DrawModel.singleAmountY;
    }
   
    self.redCountTF.text = DrawModel.redNum;
    self.winningChanceTF.text = DrawModel.drawProbability;
    self.winningCountTF.text = DrawModel.singleLmLum;
    self.prizInfoId = DrawModel.InfoID;
   
}
-(void)setData:(activityInfoItem *)infoItem
{
    if (infoItem.type == nil) {
        
         infoItem.btnTitle = infoItem.btnTitle;
    }
    else
    {
        
        if (infoItem.chooseDrawType !=nil)
        {
            infoItem.btnTitle = infoItem.btnTitle;
        }
        else
        {
            if ([infoItem.type isEqualToString:@"1"]) {
                
                infoItem.btnTitle = @"实物奖品";
                infoItem.chooseDrawType = @"singleMoney";
            }
            else if ([infoItem.type isEqualToString:@"2"])
            {
                infoItem.btnTitle = @"现金红包";
                 infoItem.chooseDrawType = @"type";
            }
            else
            {
                infoItem.btnTitle = @"商户红包";
                 infoItem.chooseDrawType = @"type";
            }
        }
    }
    self.DrawModel = infoItem;
}
- (IBAction)deleteRedBag:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteEaditDrawCell:)]) {
        
        [self.delegate deleteEaditDrawCell:self];
    }
    
}
- (IBAction)chooseType:(id)sender
{
    
    if ([self.delegate respondsToSelector:@selector(chooseTypeOnEaditDrawCell:)])
    {
        [self.delegate chooseTypeOnEaditDrawCell:self];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
 
    
    if ([self.delegate respondsToSelector:@selector(eaditDrawCell:redBagNameTF:redBagCountTF:redBagNumberTF:redBagChance:redBagMoney:Type:)]) {
        
        [self.delegate eaditDrawCell:self redBagNameTF:self.redNameTF redBagCountTF:self.redCountTF redBagNumberTF:self.winningCountTF redBagChance:self.winningChanceTF redBagMoney:self.singleRedMoneyTF Type:self.redTypeBtn.titleLabel.text];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        
        return YES;
    }
    if ([textField isEqual:self.redNameTF]) {
        
        if (textField.text.length >10) {
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
   else if ([textField isEqual:self.redCountTF]||[textField isEqual:self.winningCountTF]||[textField isEqual:self.singleRedMoneyTF]) {
        
       return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:5];
    }
    else if ([textField isEqual:self.winningChanceTF])
    {
         return [string VIPManger_isLegalInputWithText:textField.text inputString:string andLimitedLength:1];
    }
   else if ([self.winningChanceTF.text hasPrefix:@"0"]||[self.singleRedMoneyTF.text hasPrefix:@"0"])
    {
        return NO;
    }
    if ([string isValidateNumber]) {
        return YES;
    }else {
        return NO;
    }
    return YES;
}
@end
