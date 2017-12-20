//
//  activeCell.h
//  BusinessManager
//
//  Created by 张心亮 on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface activeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *activeNum;
@property (weak, nonatomic) IBOutlet UILabel *activeName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *startTime2;
@property (weak, nonatomic) IBOutlet UILabel *overTime;
@property (weak, nonatomic) IBOutlet UILabel *overTime2;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *over;

@end
