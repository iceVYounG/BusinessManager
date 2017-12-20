//
//  PrepaidSavingCardView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedButton.h"

@interface PrepaidSavingCardView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) SelectedButton *button50;
@property (nonatomic, strong) SelectedButton *button100;
@property (nonatomic, strong) SelectedButton *button500;
@property (nonatomic, strong) SelectedButton *button1000;
@property (nonatomic, strong) UITextField *moneyTF;
@property (nonatomic, strong) UIButton *perpaidButton;
@property (nonatomic, strong) UILabel *moneyLabel;  //余额

- (id)init;
//移除通知
//- (void)removeNotifiFromPrepaidSavingCardView;

@end
