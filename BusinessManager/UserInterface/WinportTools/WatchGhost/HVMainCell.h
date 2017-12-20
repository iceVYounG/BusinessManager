//
//  HVMainCell.h
//  CMCCMall
//
//  Created by 朱青 on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HVMainBlock)(NSInteger tag);

@interface HVMainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *switchImageView;

@property (copy, nonatomic) HVMainBlock mainBlock;


@end
