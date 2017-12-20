//
//  CLRatio.h
//  BusinessManager
//
//  Created by 张心亮 on 16/9/14.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLRatio : NSObject
@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, readonly) CGFloat ratio;
@property (nonatomic, strong) NSString *titleFormat;

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2;

@end

