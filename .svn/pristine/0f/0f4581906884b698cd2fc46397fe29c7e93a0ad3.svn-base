//
//  WatchGhostCameraCell.h
//  BusinessManager
//
//  Created by KL on 16/7/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchGhostCameraView.h"

#define cameraViewWidth 60.0
#define cameraViewHight 65.0

typedef void(^ChooseMonitorToView)(NSInteger index, NSInteger section);

@interface WatchGhostCameraCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *cameraScrollView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger section;//哪一个Section
@property (nonatomic, assign) NSInteger index;  //第几个监控

@property (copy, nonatomic) ChooseMonitorToView chooseMonitorToView;

@end
