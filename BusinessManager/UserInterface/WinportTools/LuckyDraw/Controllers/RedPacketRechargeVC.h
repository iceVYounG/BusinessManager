//
//  RedPacketRechargeVC.h
//  BusinessManager
//
//  Created by smile apple on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"

@interface RedPacketRechargeVC : BaseController
@property (weak, nonatomic) IBOutlet UIView *momeyView;
@property (weak, nonatomic) IBOutlet UICollectionView * redPacketCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;   //金额
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;  //立即充值
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;  //账户余额
- (IBAction)rechargeActionBtn:(id)sender;

@end
