//
//  VipCardManagerView.h
//  BusinessManager
//
//  Created by Raven－z on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VipCardModel;

@interface VipCardManagerView : UIView

- (id)init;

@property (nonatomic, strong) VipCardModel *model;

@end

@interface VipCardManagerTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) VipCardManagerView *vipCardView;

@end