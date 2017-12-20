//
//  BedroomCameraVC.h
//  CMCCMall
//
//  Created by spring on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#if !BUILD_FOR_STATIC
#import <CloseliSDK/CloseliSDK.h>
#endif

@interface HVMonitorCameraVC : BaseController

@property (strong, nonatomic) CloseliCameraDevice *curDevice;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *speakBtn;
@property (weak, nonatomic) IBOutlet UILabel *screenLabel;
@property (weak, nonatomic) IBOutlet UILabel *silenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speakWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speakLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBottomConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *silenceBtn;
@property (weak, nonatomic) IBOutlet UIButton *screenShotsBtn;

@property (weak, nonatomic) IBOutlet UIView *silenceView;
@property (weak, nonatomic) IBOutlet UIView *speakView;
@property (weak, nonatomic) IBOutlet UIView *screenView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *silenceTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speakTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *screenTopConstraint;

@end
