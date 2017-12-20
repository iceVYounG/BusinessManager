//
//  ChangDoorImageCell.m
//  BusinessManager
//
//  Created by 张心亮 on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChangDoorImageCell.h"
#import "UIButton+WebCache.h"
@implementation ChangDoorImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setModel:(WZ_FloorGooodsItemModel *)model{
    _model = model;
    if (!_model) {
        return;
    }

    NSString*  imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath];
    NSLog(@">>%@",imagePath);
    
    [self.imageBtn sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end