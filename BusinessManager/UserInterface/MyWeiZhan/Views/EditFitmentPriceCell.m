//
//  EditFitmentPriceVC.m
//  BusinessManager
//
//  Created by 牛志胜 on 16/9/1.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EditFitmentPriceCell.h"

@implementation EditFitmentPriceCell

- (void)awakeFromNib {
    
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10,280 +15 , KScreenWidth - 20, 121)];
    _textView.placeholder = @"输入文字介绍 , 如果没有图片可不上传图片";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(3, 2, 0, 2);
    
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1;
    [self.contentView addSubview:_textView];
    
    //collectionView
    PickPrameModel* model = [[PickPrameModel alloc] init];
    
    CGFloat y = CGRectGetMaxY(_textView.frame) + 10;
    model.frame = CGRectMake(10, y, KScreenWidth - 20, 115);
    model.numOfRow = 4;
    model.margin = 4;
    model.maxCount = 9;
    _collectionView = [JMPickCollectView creatWithPramModel:model block:^(NSMutableArray *photos, NSMutableArray *assets) {
        if (!_selectImages) {
            _selectImages = [NSMutableArray array];
        }
        self.selectImages = photos;
        //        [self upLoadImages];
    }];
    [self.contentView addSubview:_collectionView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
