//
//  WZ_AddNewFloorCollectionCell.h
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiZhanModel.h"

@protocol WZ_AddNewFloorCollectionCellDelegate <NSObject>

//- (void)WZ_AddNewFloorCollectionCellAddNewGoodsActionWith:(NSIndexPath *)indexPath;
- (void)WZ_AddNewFloorCollectionCellDeleteGoodsActionWith:(NSIndexPath *)indexPath;

@end

@interface WZ_AddNewFloorCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<WZ_AddNewFloorCollectionCellDelegate> addNewFloorCellDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *goodsAddNewImgView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgVIew;
@property (weak, nonatomic) IBOutlet UILabel *goodsMoneyTagLab;
@property (weak, nonatomic) IBOutlet UILabel *goodaNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *goodsDeleteBtn;

- (IBAction)goodsDeleteBtnClick:(UIButton *)sender;
/**是否是添加商品 cell*/
@property (nonatomic, assign) BOOL isAddNewCell;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, strong) TemplateModel *goodsItemModel;

@end
