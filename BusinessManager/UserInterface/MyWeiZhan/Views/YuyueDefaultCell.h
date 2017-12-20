//
//  YuyueDefaultCell.h
//  BusinessManager
//
//  Created by 张心亮 on 16/9/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuyueDefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *roomName;
@property (weak, nonatomic) IBOutlet UIButton *roomPhone;
@property (weak, nonatomic) IBOutlet UIButton *mianjiLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookRoomLabel;
@property (weak, nonatomic) IBOutlet UIButton *yusuanLabel;
@property (weak, nonatomic) IBOutlet UIButton *huxingLabel;

@end



@interface YuyueShiJiaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *shijiaCar;
@property (weak, nonatomic) IBOutlet UIButton *carName;
@property (weak, nonatomic) IBOutlet UIButton *carType;
@property (weak, nonatomic) IBOutlet UIButton *carTime;

@end



@interface YuyueBaoYangCell : UITableViewCell


@end