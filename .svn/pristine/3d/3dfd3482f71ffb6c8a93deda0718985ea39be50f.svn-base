//
//  WZ_AddNewFloorCollectionCell.m
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_AddNewFloorCollectionCell.h"

@implementation WZ_AddNewFloorCollectionCell

- (void)awakeFromNib {
//    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewGoodsAction:)];
//    [self.goodsAddNewImgView addGestureRecognizer:tapAction];
//    [self.goodsImgVIew addGestureRecognizer:tapAction];
    self.isAddNewCell = NO;
}


- (void)setGoodsItemModel:(TemplateModel *)goodsItemModel {
    _goodsItemModel = goodsItemModel;
    //是否是添加商品的cell
    if (self.isAddNewCell) {
        [self.goodsAddNewImgView setHidden:NO];
        [self.goodsAddNewImgView setImage:[UIImage imageNamed:@"WZ_addNewFloor_addGoods_icon"]];
        [self.goodsDeleteBtn setHidden:YES];
        [self.goodaNameLab setHidden:YES];
        [self.goodsImgVIew setHidden:YES];
        [self.goodsPriceLab setHidden:YES];
        [self.goodsMoneyTagLab setHidden:YES];
    }else {
        [self.goodsDeleteBtn setHidden:NO];
        [self.goodaNameLab setHidden:NO];
        [self.goodsImgVIew setHidden:NO];
        [self.goodsPriceLab setHidden:NO];
        [self.goodsMoneyTagLab setHidden:NO];
        [self.goodsAddNewImgView setHidden:YES];
    }
    if (goodsItemModel) {
        self.goodaNameLab.text = goodsItemModel.name;
        //分转元
        NSString *money = [NSString transformMoneyFormatter:goodsItemModel.price andTransformDirection:YES];
        self.goodsPriceLab.text = money;
        if (goodsItemModel.imgPath && goodsItemModel.imgPath.length > 0) {
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@", ImagePre, goodsItemModel.imgPath];
            NSLog(@"---imgPath-->>%@", imgPath);
            [self.goodsImgVIew sd_setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"default_img"]];
        }else {
            [self.goodsImgVIew setImage:[UIImage imageNamed:@"default_img"]];
        }
        
    }
    
}



//删除商品代理
- (IBAction)goodsDeleteBtnClick:(UIButton *)sender {
    if ([self.addNewFloorCellDelegate conformsToProtocol:@protocol(WZ_AddNewFloorCollectionCellDelegate) ]
        &&
        [self.addNewFloorCellDelegate respondsToSelector:@selector(WZ_AddNewFloorCollectionCellDeleteGoodsActionWith:)]) {
        
        [self.addNewFloorCellDelegate WZ_AddNewFloorCollectionCellDeleteGoodsActionWith:self.indexPath];
        
    }
}

//添加商品代理
//- (void)addNewGoodsAction:(UIGestureRecognizer *)gesture {
//    if (gesture.numberOfTouches == 1) {
//        if ([self.addNewFloorCellDelegate conformsToProtocol:@protocol(WZ_AddNewFloorCollectionCellDelegate) ]
//            &&
//            [self.addNewFloorCellDelegate respondsToSelector:@selector(WZ_AddNewFloorCollectionCellAddNewGoodsActionWith:)]) {
//            
//            [self.addNewFloorCellDelegate WZ_AddNewFloorCollectionCellAddNewGoodsActionWith:self.indexPath];
//            
//        }
//    }
//}

@end
