//
//  VerifyDetailView.h
//  BusinessManager
//
//  Created by Raven－z on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//
@class VerifyVipCardModel;
@protocol VerifyDetailViewDelegate <NSObject>

- (void)didClickConfirmButtonWithMobile:(NSString *)mobile type:(NSString *)type code:(NSString *)code;
- (void)didClickCountButton:(NSString *)money mobile:(NSString *)mobile type:(NSString *)type;
- (void)didClickCancelButton;

@end

#import <UIKit/UIKit.h>
@interface VerifyDetailView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic) id<VerifyDetailViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame;

@end
