//
//  ChooseButtonView.h
//  BusinessManager
//
//  Created by Raven－z on 16/8/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseButtonViewDelegate <NSObject>

- (void)didClickBtn:(NSInteger)index;

@end

@interface ChooseButtonView : UIView

@property (nonatomic, weak) id<ChooseButtonViewDelegate> delegate;

- (instancetype)initWithNameArray:(NSArray *)nameArray;

@end
