//
//  HongBaoCell.h
//  BusinessManager
//
//  Created by zhaojh on 16/8/9.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HongBao,
    DaZhuanPan,
    GuaGuaKa
} HongBaoType;

#pragma mark - Base
@class PartModel;
@interface HongBaoTableCell : UITableViewCell



@end

#pragma mark - 红包类型

#define HongBaoTypeH 156

@protocol HongBaoTypeDeledate <NSObject>

-(void)selectedHongBaoType:(HongBaoType)type;

@end

@interface HongBaoTypeCell : HongBaoTableCell
{
    NSInteger _lastSelectTag;
}
@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIView* backView;

@property(nonatomic,weak)id<HongBaoTypeDeledate> delegate;

@property(nonatomic,strong)PartModel* model;
@end

#pragma mark - 红包信息

#define HongBaoInfoH 171
@protocol HongBaoInfoDeledate <NSObject>

-(void)selectedImageActionWithHongBaoType:(HongBaoType)type;
-(void)userDidEndEditContent:(NSString*)content;

@end
@interface HongBaoInfoCell : HongBaoTableCell <UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray* actArry;

@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIImageView* imageV;
@property(nonatomic,strong)UILabel* keyLabel;
@property(nonatomic,strong)UITextField* valueFiled;
@property(nonatomic,assign)HongBaoType type;

@property(nonatomic,weak)id<HongBaoInfoDeledate> delegate;

@property(nonatomic,strong)PartModel* model;

@end

#pragma mark - 我的红包活动

#define MyHongBaoH 44

@interface MyHongBaoCell : HongBaoTableCell


@end