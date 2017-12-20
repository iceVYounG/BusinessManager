//
//  MenuView.h
//  BusinessManager
//
//  Created by Niuyp on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^menuViewBlock)(id sender);
@interface MenuView : UIView

@property (nonatomic, copy) NSString *imageStr;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, copy) menuViewBlock block;


- (instancetype)initWithFrame:(CGRect)frame block:(menuViewBlock)block;

@end
