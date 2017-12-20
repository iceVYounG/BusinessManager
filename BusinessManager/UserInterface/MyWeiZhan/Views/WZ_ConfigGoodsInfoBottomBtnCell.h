//
//  WZ_ConfigGoodsInfoBottomBtnCell.h
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZ_ConfigGoodsInfoBottomBtnCellDelegate <NSObject>

- (void)WZ_ConfigGoodsInfoBottomBtnCell_SaveAction:(UIButton *)saveBtn;

@end

@interface WZ_ConfigGoodsInfoBottomBtnCell : UICollectionViewCell

@property (nonatomic, weak) id<WZ_ConfigGoodsInfoBottomBtnCellDelegate> bottomBtnCellDelegate;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveBtnClick:(UIButton *)sender;

@end
