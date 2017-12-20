//
//  JMLoopView.h
//  ScrollLoopView
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 apple-Mac-ZJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoopViewDeledate <NSObject>

-(void)userDidSelectAtIndex:(NSInteger)index;

@end

@interface JMLoopView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray* imageNames;

@property(nonatomic,assign)float time;

@property(nonatomic,weak)id<LoopViewDeledate> deletate;


//-(id)initWithFrame:(CGRect)frame ImageName:(NSArray*)imageNames;

@end
