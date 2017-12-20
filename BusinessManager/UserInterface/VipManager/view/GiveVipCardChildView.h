//
//  GiveVipCardView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardModel.h"

//卡类型
typedef NS_ENUM(NSUInteger, CardType) {
    CardType_ChuZhiKa = 1,
    CardType_YouHuiKa
};

@protocol GiveVipCardChildViewDelegate <NSObject>

- (void)GiveVipCardToChooseCardType;  //卡类型：储值卡 or 优惠卡
- (void)GiveVipCardToChooseWhichVipCard; // 用户自定义的卡的类型/名称
- (void)GiveVipCardToSaveDataWithCardId:(NSString *)cardId mobile:(NSString *)mobile andCardType:(CardType)cardType;

@end

@interface GiveVipCardChildView : UIView

@property (nonatomic, weak) id<GiveVipCardChildViewDelegate> giveVipDelegate;

//@property (nonatomic, strong) NSString *chooseCardType; // 卡类型：储值卡 or 优惠卡
//@property (nonatomic, strong) NSString *chooseVipCard;  // 用户自定义的卡的类型/名称
@property (nonatomic, assign) CardType choosedCardType;   // 卡类型：储值卡 or 优惠卡
@property (nonatomic, strong) VipCardListModel *listModel; // 用户自定义的卡的类型/名称


@property (nonatomic, strong) UIButton *vipCardTypeButton;  //选择卡类型
@property (nonatomic, strong) UIButton *vipCardButton;  //选择那张卡
@property (nonatomic, strong) UITextField *phoneNumberTF; //文本框

- (id)init;


@end
