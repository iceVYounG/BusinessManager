//
//  ChooseVipCardTypeView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseVipCardTypeViewDelegate <NSObject>

- (void)didClickTheButton:(NSString *)buttonTitle;

@end

@interface ChooseVipCardTypeView : UIView

@property (nonatomic, strong) NSString *selectedStr;

- (id)initWtihTypeStr:(NSString *)typeStr;

@property (nonatomic) id<ChooseVipCardTypeViewDelegate> delegate;

@end
