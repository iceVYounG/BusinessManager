//
//  E_CommerceCell.h
//  BusinessManager
//
//  Created by 王启明 on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMView.h"
#import "SDCycleScrollView.h"
typedef enum : NSUInteger {
    WeiZhanName,
    WeiZhanDetail ,
    HongBaoHongDong ,
    ShangHuJieshao,
    YiJianHuJiaoFuWu
    
} JMCellType;


@class TemplateModel;
@class PartModel;
@interface E_CommerceCell : UICollectionViewCell<JMViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,assign)JMCellType cellType;
@property(nonatomic,strong)JMView* jView;
@end

#pragma mark-店铺cell

@interface ECShopNameCell : E_CommerceCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)UILabel* shopNameLab;
@property (nonatomic,strong)UILabel* phoneNumberLab;
@property (nonatomic, strong) TemplateModel *model;

@end

#pragma mark-btnCell
@class ADImageModel;
@interface ECBtnCell : E_CommerceCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)ADImageModel *model;
@end

#define 轮播cell

@interface ECImageCell : E_CommerceCell//<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView *scroV;
@property (nonatomic,strong)NSMutableArray *imgeArr;


@end

#define 商品cell
#define ECProductorCellHeight 169
@class ECProductModel;
@interface ECProductorCell : E_CommerceCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)UILabel *detailLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)TemplateModel *model;
@end

#define 活动Cell

#define kHongBaoCellH 80
@interface ECHongBaoCell : E_CommerceCell
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)PartModel *model;
@property(nonatomic,strong)JMView* jView2;

@end
