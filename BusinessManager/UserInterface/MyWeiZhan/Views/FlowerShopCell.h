//
//  FlowerShopCell.h
//  BusinessManager
//
//  Created by 王启明 on 16/9/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "E_CommerceCell.h"
#import "Masonry.h"
#import "WeiZhanModel.h"
#import "JMView.h"
#import "SDCycleScrollView.h"
#import "StringHelper.h"

#define kWidth_scale [UIScreen mainScreen].bounds.size.width/375.0
#define flowerShopSpace 3
#define FlowerShopCellHeight 117



@interface FlowerShopCell : UICollectionViewCell
@property (nonatomic,strong)PartModel *model;
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)JMView *view;
@end

@protocol getAdressPtDelegate <NSObject>

-(void)getTheAdressPt:(NSString *)adressString;
-(void)judgeIsInputRight:(NSString *)inputString;

@end
#define FlowerShopSectionTwoCellHeight 170
typedef void(^KHblock)(FlowerAddressModel *model);
@interface FlowerShopSectionTwoCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic,strong)FlowerAddressModel *model;
@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *addressTF;
@property (nonatomic,strong)KHblock block;
@property (nonatomic,strong)FlowerAddressModel *temModel;
@property (nonatomic,weak)id<getAdressPtDelegate>delegate;
@end

#define FlowerShopLunBoCellHeight 139
@interface FlowerShopLunBoCell : UICollectionViewCell
@property (nonatomic,strong)SDCycleScrollView *myScro;
@property (nonatomic,strong)PartModel *model;
@property (nonatomic,strong)JMView *view;
@end

#define FlowerHongBaoCellHeight 80
@interface FlowerHongBaoCell :E_CommerceCell
@property(nonatomic,strong)UIImageView* imagev;
@property(nonatomic,strong)PartModel* model;
@property(nonatomic,strong)JMView* jView2;
@end

@interface FlowerCell : E_CommerceCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)UILabel *detailLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)TemplateModel *model;
@end
