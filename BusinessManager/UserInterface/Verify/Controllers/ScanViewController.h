//
//  ScanViewController.h
//  BusinessManager
//
//  Created by Raven－z on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#import <AVFoundation/AVFoundation.h>

@protocol ScanViewControllerDelegate <NSObject>

- (void)didScan:(NSString *)str;

@end

@interface ScanViewController : BaseController

@property (nonatomic, weak) id<ScanViewControllerDelegate> delegate;

@end
