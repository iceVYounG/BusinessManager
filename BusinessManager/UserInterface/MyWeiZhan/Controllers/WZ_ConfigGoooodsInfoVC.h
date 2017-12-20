//
//  WZ_ConfigGoooodsInfoVC.h
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
#import "WeiZhanModel.h"

@protocol WZ_ConfigGoooodsInfoVCDelegate <NSObject>

- (void)WZ_ConfigGoooodsInfoVCPopActionWithModel:(TemplateModel *)goodsModel andSelectedIndexPath:(NSIndexPath *)selectedIndexPath;

@end

@interface WZ_ConfigGoooodsInfoVC : WeiZhanBaseController
@property (weak, nonatomic) IBOutlet UICollectionView *gooodsCollectionView;
@property (nonatomic, weak) id<WZ_ConfigGoooodsInfoVCDelegate> delegate;

//@property (nonatomic, strong) TemplateModel *mainModel;
@property (nonatomic, strong) NSString *goodsID;
/*选中跳转过来的IndexPath*/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/*是否体验账号*/
@property (nonatomic, assign) BOOL isTiYanAccount;

@end