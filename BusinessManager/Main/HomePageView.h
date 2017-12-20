//
//  HomePageView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageView : UIView

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) UIImageView *iconView;

- (id)initWithTitleStr:(NSString *)titleStr;

- (void)addTapGRWithTarget:(id)taget Sel:(SEL)seleter;

@end
