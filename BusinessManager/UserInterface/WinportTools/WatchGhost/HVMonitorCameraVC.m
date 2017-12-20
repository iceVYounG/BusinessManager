//
//  BedroomCameraVC.m
//  CMCCMall
//
//  Created by spring on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HVMonitorCameraVC.h"
#import "CloseliApiManager.h"
#import "FileManager.h"
#import "AppDelegate.h"

@interface HVMonitorCameraVC ()

@property (strong, nonatomic) NSTimer *currentDateUpdateTimer;
@property (assign, nonatomic) NSInteger retryToPlayCount;
@property (assign, nonatomic) BOOL speakInProgress;
@property (assign, nonatomic) BOOL isFullState;
@property (strong, nonatomic) NSString *shotsPath;

@end

@implementation HVMonitorCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _curDevice.name;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    
    [self.topView addGestureRecognizer:tap];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"hv_fullScreen"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction:)];
    self.navigationItem.rightBarButtonItems = @[spaceBtn,rightBtn];
    
    if (!_currentDateUpdateTimer) {
        _currentDateUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                                   target:self
                                                                 selector:@selector(currentDateUpdateDispose:)
                                                                 userInfo:nil
                                                                  repeats:YES];
    }
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(speakClickAction:)];
    longpress.minimumPressDuration = 0.5;
    [_speakBtn addGestureRecognizer:longpress];
    
    
    CloseliCameraExtraSettings *settings  = [[CloseliApiManager share].mySDK getCameraSettingsWithCamera:_curDevice error:nil];
    
//    NSString *prePath = [[[FileManager getDocumentsPath]stringByAppendingString:@"/HMScreenShots/"]stringByAppendingString:settings.deviceType];
    
    if ([@"C20" isEqualToString:settings.deviceType]) {
        
        self.speakWidthConstraint.constant = 0;
        [self.speakBtn setHidden:YES];
        self.speakLabelWidthConstraint.constant = 0;
        [self.speakLabel setHidden:YES];
    }
    
    NSString *prePath = [[FileManager getDocumentsPath]stringByAppendingPathComponent:@"HMScreenShots"];
 
    if (![FileManager fileExistsAtPath:prePath]) {
        
        [FileManager createAllDirectoryWithPath:prePath dictionary:YES];
    }
    _shotsPath = [prePath stringByAppendingPathComponent:settings.deviceType];
    
    if (![FileManager fileExistsAtPath:_shotsPath]) {
        
        [FileManager createAllDirectoryWithPath:_shotsPath dictionary:YES];
    }
    
    self.topBottomConstraint.constant = SCREEN_SIZE.width*9/16.0;
    self.playHeightConstraint.constant = SCREEN_SIZE.width*9/16.0;
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

}

-(void)onTap:(UITapGestureRecognizer *)ges{
    
    if (self.interfaceOrientation != UIInterfaceOrientationPortrait) {
        if (self.navigationController.navigationBar.hidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            
            
            if (IOS8) {
                [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height-64) andFrame:CGRectMake(0, 0, SCREEN_SIZE.width,SCREEN_SIZE.height-64)];
                
            }else{
                 [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width-64) andFrame:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width-64)];
                
            }
            
           
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
            
            
            if (IOS8) {
                [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) andFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
                
            }else{
                [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width) andFrame:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width)];
                
            }
            
            
        }
    }
  

}

-(void)leftDrawerButtonPress:(UIButton*)sender{
    
    if (self.interfaceOrientation != UIInterfaceOrientationPortrait) {
        [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStatusChanged:)
                                                 name:CameraPlayerStatusChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStoppedDispose:)
                                                 name:CameraPlayerStoppedNotification
                                               object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    [self prepareToPlayItem];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [[CloseliApiManager share].mySDK destoryPlayer];
//    [SVProgressHUD dismiss];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_currentDateUpdateTimer.valid) {
        [_currentDateUpdateTimer invalidate];
        _currentDateUpdateTimer = nil;
    }
    
    
}

- (void)prepareToPlayItem
{
    [[CloseliApiManager share].mySDK preparetoLivePreview:_curDevice withUI:_contentImageView];
}

- (void)currentDateUpdateDispose:(NSTimer *)timer
{
    double currentTime = [[CloseliApiManager share].mySDK playerCurrentTime];
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970: currentTime];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yy/M/d HH:mm:ss"];
 
    self.currentTimeLabel.text = [inputFormatter stringFromDate:currentDate];
}

- (void)playerStatusChanged:(NSNotification*)notification
{
    BOOL bWaiting = [[[notification userInfo] valueForKey:NSLocalizedDescriptionKey] boolValue];
    
    WS(weakSelf);
    __weak CloseliSDK *sdk = [CloseliApiManager share].mySDK;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (bWaiting) {
            [weakSelf indicatorViewShow];
        }
        else {
            weakSelf.retryToPlayCount = 0; // play started, reset retry count.
            [weakSelf indicatorViewDismiss];
            double currentTime = [sdk playerCurrentTime];
            NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentTime];
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
            [inputFormatter setDateFormat:@"yy/M/d HH:mm:ss"];
            weakSelf.currentTimeLabel.text = [inputFormatter stringFromDate:currentDate];
        }
        
    });
}

- (void)playerStoppedDispose:(NSNotification *)notification
{
    NSInteger returnCode = [[[notification userInfo] valueForKey:NSLocalizedFailureReasonErrorKey] intValue];
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        if (returnCode && strongSelf && strongSelf.retryToPlayCount < 40) { //If returnCode not zero, we have to replay.
            strongSelf.retryToPlayCount++;
            [strongSelf performSelector:@selector(prepareToPlayItem) withObject:nil afterDelay:2.];
        }
    });
}

- (void)indicatorViewShow
{
    [self.indicatorView setHidden:NO];
    [self.indicatorView startAnimating];
}

- (void)indicatorViewDismiss
{
    
    [self.indicatorView stopAnimating];
}

#pragma mark - 全屏按钮点击事件 -
- (void)rightBtnAction:(UIBarButtonItem *)sender{
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
        [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    }else{
        [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];

    }
}

//静音
- (IBAction)muteClickAction:(UIButton *)sender
{
 
    sender.selected = !sender.selected;

    [[CloseliApiManager share].mySDK playerMute:sender.selected];
    
}

//说话
- (void)speakClickAction:(UILongPressGestureRecognizer *)gesture
{
    NSError *error = nil;

    if(gesture.state==UIGestureRecognizerStateBegan){
        
        [self.speakBtn setImage:[UIImage imageNamed:@"hv_pressSpeak_selected"] forState:UIControlStateNormal];
        [[CloseliApiManager share].mySDK startAudioTalkDuringLive:&error];
    }
    else if (gesture.state==UIGestureRecognizerStateEnded || gesture.state==UIGestureRecognizerStateCancelled){
        
        [self.speakBtn setImage:[UIImage imageNamed:@"hv_pressSpeak"] forState:UIControlStateNormal];
        [[CloseliApiManager share].mySDK stopAudioTalkDuringLive:&error];
    }
    else{
        [self.speakBtn setImage:[UIImage imageNamed:@"hv_pressSpeak_selected"] forState:UIControlStateNormal];
    }
    
}

//截图
- (IBAction)screenShotClickAction:(UIButton *)sender
{
    //UIImage转换为NSData
    if (_contentImageView.image) {
        
        NSData *imageData = UIImagePNGRepresentation(_contentImageView.image);
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyyMMddHHmmss"];
//        NSString *name = [formatter stringFromDate:[NSDate date]];
//        
//        [FileManager saveToDirectory:_shotsPath data:imageData name:name];
//        
//        [OMGToast showWithText:@"截图成功"];
        [self saveImageToPhotos:_contentImageView.image];
        
    }
    
}


- (void)saveImageToPhotos:(UIImage*)savedImage
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"截图保存中..."];
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    [SVProgressHUD dismiss];

    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}




- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
//    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        self.isFullState = NO;
        
        self.silenceTopConstraint.constant = 23;
        self.speakTopConstraint.constant = 23;
        self.screenTopConstraint.constant = 23;
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [self.bottomView setBackgroundColor:[UIColor whiteColor]];
        [self.silenceView setBackgroundColor:[UIColor whiteColor]];
        [self.speakView setBackgroundColor:[UIColor whiteColor]];
        [self.screenView setBackgroundColor:[UIColor whiteColor]];
        
        [self.currentTimeLabel setHidden:NO];
        [self.screenLabel setHidden:NO];
        [self.speakLabel setHidden:NO];
        [self.silenceLabel setHidden:NO];
        
        [self.silenceBtn setImage:[UIImage imageNamed:@"hv_silence_normal_por"] forState:UIControlStateNormal];
        [self.silenceBtn setImage:[UIImage imageNamed:@"hv_silence_selected_por"] forState:UIControlStateSelected];
        [self.speakBtn setImage:[UIImage imageNamed:@"hv_pressSpeak"] forState:UIControlStateNormal];
        [self.screenShotsBtn setImage:[UIImage imageNamed:@"hv_cutImage"] forState:UIControlStateNormal];
        

        
    }
    else{
     


        self.isFullState = YES;
        self.silenceTopConstraint.constant = 60;
        self.speakTopConstraint.constant = 60;
        self.screenTopConstraint.constant = 60;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [self.bottomView setBackgroundColor:[UIColor clearColor]];
        [self.silenceView setBackgroundColor:[UIColor clearColor]];
        [self.speakView setBackgroundColor:[UIColor clearColor]];
        [self.screenView setBackgroundColor:[UIColor clearColor]];
        
        [self.currentTimeLabel setHidden:YES];
        [self.screenLabel setHidden:YES];
        [self.speakLabel setHidden:YES];
        [self.silenceLabel setHidden:YES];
        
        [self.silenceBtn setImage:[UIImage imageNamed:@"hv_full_silence_normal"] forState:UIControlStateNormal];
        [self.silenceBtn setImage:[UIImage imageNamed:@"hv_full_silence_selected"] forState:UIControlStateSelected];
        [self.speakBtn setImage:[UIImage imageNamed:@"hv_full_speak"] forState:UIControlStateNormal];
        [self.screenShotsBtn setImage:[UIImage imageNamed:@"hv_full_screenShots"] forState:UIControlStateNormal];
        
    
//
    }

 
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
        self.topBottomConstraint.constant = SCREEN_SIZE.width*9/16.0;

        self.playHeightConstraint.constant = SCREEN_SIZE.width*9/16.0;

        [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:[UIScreen mainScreen].bounds andFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.width*9/16.0)];

    }
    else{
        self.topBottomConstraint.constant = SCREEN_SIZE.height;
        if (IOS8) {
            self.playHeightConstraint.constant = SCREEN_SIZE.height-100;
        }else{
            self.playHeightConstraint.constant = SCREEN_SIZE.width-100;

        }

        if (IOS8) {
            [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) andFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];

        }else{
            [[CloseliApiManager share].mySDK resetPlayerViewWithWindow:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width) andFrame:CGRectMake(0, 0, SCREEN_SIZE.height, SCREEN_SIZE.width)];

        }

    }

}

- (void)onDeviceOrientationChange
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[CloseliApiManager share].mySDK destoryPlayer];

}

@end
