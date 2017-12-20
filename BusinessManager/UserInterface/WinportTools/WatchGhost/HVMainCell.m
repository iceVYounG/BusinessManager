//
//  HVMainCell.m
//  CMCCMall
//
//  Created by 朱青 on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HVMainCell.h"

@implementation HVMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tableClickAction:(UIButton *)sender
{
    if (self.mainBlock) {
        self.mainBlock(sender.tag);
    }
}

@end
