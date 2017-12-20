//
//  WZ_ConfigGoodsImageViewCell.h
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"

@protocol WZ_ConfigGoodsImageViewCellDelegate <NSObject>
//点击图片时，弹出图片选择页面
- (void)WZ_ConfigGoodsImageViewCell_ChoosePhotoWithIndexPath:(NSIndexPath *)indexpath andIsAddNewImage:(BOOL)isAddNewImage;
//删除功能
- (void)WZ_ConfigGoodsImageViewCell_DeleteGoodsWithIndexPath:(NSIndexPath *)indexpath;

@end

@interface WZ_ConfigGoodsImageViewCell : UICollectionViewCell

@property (nonatomic, weak) id<WZ_ConfigGoodsImageViewCellDelegate> imageViewCellDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodsTipsLab;

- (IBAction)deleteBtnClick:(UIButton *)sender;

@property (nonatomic, strong) NSString *imgPathStr;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) TemplateModel *itemModel;
@property (nonatomic, assign) BOOL isAddNewGoodsCell;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
