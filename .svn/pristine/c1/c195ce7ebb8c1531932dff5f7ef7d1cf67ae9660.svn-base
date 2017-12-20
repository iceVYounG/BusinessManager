//
//  WZ_ConfigGoodsInfoBottomBtnCell.m
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_ConfigGoodsInfoBottomBtnCell.h"

@implementation WZ_ConfigGoodsInfoBottomBtnCell

- (void)awakeFromNib {
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 5.0;
}

- (IBAction)saveBtnClick:(UIButton *)sender {
    if ([self.bottomBtnCellDelegate conformsToProtocol:@protocol(WZ_ConfigGoodsInfoBottomBtnCellDelegate)]
        &&
        [self.bottomBtnCellDelegate respondsToSelector:@selector(WZ_ConfigGoodsInfoBottomBtnCell_SaveAction:)]) {
        [self.bottomBtnCellDelegate WZ_ConfigGoodsInfoBottomBtnCell_SaveAction:sender];
    }
    
}
@end
