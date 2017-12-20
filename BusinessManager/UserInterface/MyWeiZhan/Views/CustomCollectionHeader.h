//
//  CustomCollectionHeader.h
//  BusinessManager
//
//  Created by 王启明 on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMView.h"
@interface CustomCollectionHeader : UICollectionReusableView<JMViewDelegate>
@property (nonatomic,strong)UILabel *titlelab;
@property (nonatomic,strong)JMView *jview;
@property (nonatomic,assign)BOOL isDianShang;
@end
