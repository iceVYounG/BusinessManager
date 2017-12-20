//
//  HZCaseDetailImageCell.m
//  BusinessManager
//
//  Created by niuzs on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZCaseDetailImageCell.h"
NSString *const HZCaseDetailImageCellID = @"HZCaseDetailImageCellID";
@implementation HZCaseDetailImageCell
- (void)awakeFromNib {
    
    self.imageView.layer.cornerRadius = 3;
    self.imageView.layer.masksToBounds = YES;
    [self.deleteImgBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)deleteBtnClik:(UIButton *)sender{
    if (_delegate&&[_delegate respondsToSelector:@selector(caseDetailImageCell:buttonAction:)]) {
        [_delegate caseDetailImageCell:self buttonAction:sender];
    }
}
@end
