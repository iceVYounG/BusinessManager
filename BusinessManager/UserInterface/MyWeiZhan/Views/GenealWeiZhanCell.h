//
//  GenealWeiZhanCell.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMView.h"

#pragma mark - BaseCell

typedef enum : NSUInteger {
    WeiZhanName,
    WeiZhanDetail ,
    HongBaoHongDong ,
    ShangHuJieshao,
    YiJianHuJiaoFuWu
    
} JMCellType;

@interface GenealWeiZhanCell : UITableViewCell <JMViewDelegate>

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property(nonatomic,assign)JMCellType cellType;
@property(nonatomic,strong)JMView* jView;

@end

#pragma mark - 微站名称cell

#define kEditingTitleCellH 55
@interface EditingTitleCell : GenealWeiZhanCell

@property (weak, nonatomic) IBOutlet UILabel *weizhanName;

@end

#pragma mark - 微站简介cell

#define kDetailInfoCellH 48
@class TemplateModel;
@class PartModel;
@interface DetailInfoCell : GenealWeiZhanCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic,strong) TemplateModel* model;
-(void)addEditingSender;
@end

#pragma mark - 商户介绍cell

#define NumOfRow   3
#define ImageSpace 8
#define ImageH  ((KScreenWidth - ImageSpace * (NumOfRow + 1)) / NumOfRow)
#define kDetailContentH  (ImageH + 58)

@interface BusinessDetail : GenealWeiZhanCell

@property(nonatomic,strong) TemplateModel* model;
@property(nonatomic,strong)  UILabel* titleLabel;
@property(nonatomic,strong)  UIView* backView;
@property(nonatomic,strong)  UILabel* contentLabel;
@end

#pragma mark - 红包cell

#define kHongBaoCellH 80
@interface HongBaoCell : GenealWeiZhanCell

@property(nonatomic,strong)UIImageView* imagev;
@property(nonatomic,strong)PartModel* model;
@property(nonatomic,strong)JMView* jView2;
@end

#pragma mark - 一键呼叫服务cell

#define kCallSenderCellH 60
@interface CallSenderCell : GenealWeiZhanCell

@property (weak, nonatomic) IBOutlet UIButton *callSender;

@end


