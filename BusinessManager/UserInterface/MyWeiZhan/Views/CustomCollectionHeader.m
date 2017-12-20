//
//  CustomCollectionHeader.m
//  BusinessManager
//
//  Created by 王启明 on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CustomCollectionHeader.h"
#define kWidth_scale [UIScreen mainScreen].bounds.size.width/375.0
@implementation CustomCollectionHeader
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titlelab = [[UILabel alloc]init];
        self.titlelab.frame =CGRectMake(15*kWidth_scale, 0, KScreenWidth-15*kWidth_scale,44);
        self.titlelab.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.titlelab];
        [self addEditingSender];
      } 
    
    return self;
   
}


- (void)addEditingSender{
    if (!self.isDianShang) {
        CGFloat w1= [JMView getWidth:@[@"编辑",@"删除",@"新增楼层"]];
        self.jview= [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w1,0, w1, JMViewH) btnNames:@[@"编辑",@"删除",@"新增楼层"]];
    }else{
        CGFloat w1 = [JMView getWidth:@[@"编辑"]];
        self.jview = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w1,0, w1, JMViewH) btnNames:@[@"编辑"]];
    }
    
    [self addSubview:self.jview];
}

@end
