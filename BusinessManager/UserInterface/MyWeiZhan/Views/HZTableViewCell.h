//
//  HZTableViewCell.h
//  BusinessManager
//
//  Created by 牛志胜 on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMView.h"
#import "WeiZhanModel.h"
#define KADButtonTag        101
#define KADImageTag         112
#define KADTitleViewTag     103
#define KADViewTag          104
#define KADBannerTag        105


#define KADPropertyTag      106
#define KADFourSTag         107

#define KADImageCellH       70
#define KADTitleViewCellH   130
#define KADViewCellH        192
#define KADButtonCellH      60
#define KADPropertyCellH    300

//家装
#define ICONFONT            13
#define HZCaseDetailEdit    400
#define TAG                 1000
#define HZMaShangYuYueTag   404
#define HZImageH 151
#define HZImageGap 3
#define HZImageW  ([UIScreen mainScreen].bounds.size.width-3) /2;


@interface HZView : UIView
@property (nonatomic, strong)UIImageView *iconImageV;
@property (nonatomic, strong)UILabel *iconName;
@end

@interface HZTableViewCell : UITableViewCell
@property (nonatomic, strong)JMView *jView;
@property (nonatomic ,strong)HZView *iconView;
@property (nonatomic ,strong)NSArray *dataArray;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
