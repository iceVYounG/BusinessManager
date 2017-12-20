//
//  ChooseDayView.h
//  BusinessManager
//
//  Created by Raven－z on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

@protocol ChooseDayViewDelegate <NSObject>

- (void)didClickButton:(NSString *)ButtonName;

@end

#import <UIKit/UIKit.h>

@interface ChooseDayView : UIView

@property (nonatomic) id<ChooseDayViewDelegate> delegate;

@end
