//
//  AddNewRedBagCell.m
//  HelpDemo
//
//  Created by NCS on 11/8/16.
//  Copyright © 2016 NCS. All rights reserved.
//

#import "AddNewRedBagCell.h"

@interface AddNewRedBagCell ()

@property (weak, nonatomic) IBOutlet UIButton *addButton;


@end

@implementation AddNewRedBagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickOnAddCell:)]) {
        [self.delegate clickOnAddCell:self];
    }
}
@end
