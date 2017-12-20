//
//  HomeVideoMainVC.m
//  CMCCMall
//
//  Created by 朱青 on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HomeVideoMainVC.h"
#import "HVMonitorCameraVC.h"
#import "HVMainCell.h"
#import "HVMainSectionView.h"
#import "HVMainFootView.h"
#import "CloseliApiManager.h"
#import "WinportToolsVC.h"

@interface HomeVideoMainVC ()<UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *signArray;
@property (strong, nonatomic) NSMutableArray *cameraArray;
@property (assign, nonatomic) BOOL getThumbnailInProgess;

@end

@implementation HomeVideoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手机看店";
    UIButton * switchAccountBtn= [UIButton buttonWithType:UIButtonTypeCustom];

    switchAccountBtn.frame = CGRectMake(10,2.0,60,30);

    [switchAccountBtn addTarget:self action:@selector(changeClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [switchAccountBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    switchAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:switchAccountBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"HVMainCell" bundle:nil] forCellReuseIdentifier:@"HVMainCell"];
    self.mainTableView.canCancelContentTouches = NO;
    
    _signArray = [NSMutableArray array];
    
    [self getCameraListInMain];
}

#pragma mark CloseLiSdk
-(void)getCameraListInMain
{

    //Get camera list
    WS(weakSelf);
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];

    __weak CloseliSDK *sdk = [CloseliApiManager share].mySDK;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        weakSelf.cameraArray = [sdk getCameraListError:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.cameraArray.count == 0) {
                
                [weakSelf.nothingView setHidden:NO];
                [weakSelf.view bringSubviewToFront:weakSelf.nothingView];
            }
            else{
                
                [weakSelf.nothingView setHidden:YES];
                [weakSelf.view sendSubviewToBack:weakSelf.nothingView];
                [weakSelf reloadDeviceTableView];
            }
            
            [SVProgressHUD dismiss];
            [weakSelf reloadDeviceTableView];
       
        });
    });

}

- (NSMutableArray *)getSignArrayWithDeviceArray:(NSMutableArray *)deviceArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    BOOL isFirstShow = NO;
    for (NSInteger i = 0;i < deviceArray.count; i++) {
        
        CloseliCameraDevice *device = deviceArray[i];
        if (device.bIsConnect && !isFirstShow) {
            
            [array addObject:@"1"];
            isFirstShow = YES;
        }
        else{
            [array addObject:@"0"];
        }
    }
    
    return array;
}

- (void)reloadDeviceTableView
{
    self.signArray = [self getSignArrayWithDeviceArray:self.cameraArray];
    [self.mainTableView reloadData];
    
}

//关闭与开启摄像头
- (void)turnOnOffCameraWithDevice:(CloseliCameraDevice *)device
{
    WS(weakSelf);
    __weak CloseliSDK *sdk = [CloseliApiManager share].mySDK;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSError *error = nil;
        CloseliCameraExtraSettings *settings = [[CloseliCameraExtraSettings alloc] init];
        settings.bTurnOn = (device.cameraState != DeviceState_On);
        BOOL bRet = [sdk setCameraSettingsWithCamera:device
                                              toSetting:CLOSELICAMERA_SETTINGS_TURNON
                                           withSettings:settings
                                                  error:&error];
        if (weakSelf) {
            if (bRet) {
                weakSelf.cameraArray = [sdk getCameraListError:NULL];
            }
            else {
                NSLog(@"Turn on error %ld, %@", (long)error.code, [error.userInfo objectForKey: NSLocalizedFailureReasonErrorKey]);
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf showAlertOfError:error];
                });
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [weakSelf reloadDeviceTableView];
        });
    });
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _signArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *signStr = [_signArray objectAtIndex:section];
    if ([@"1" isEqualToString:signStr]) {
   
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    HVMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HVMainCell"];

    CloseliCameraDevice *device = self.cameraArray[indexPath.section];
    
    BOOL isOpenDevice = device.bIsConnect ? ((device.cameraState == DeviceState_On) ? YES : NO) : NO;
    
    if (isOpenDevice) {
        [cell.switchImageView setImage:[UIImage imageNamed:@"hv_switch_icon"]];
    }
    else{
        [cell.switchImageView setImage:[UIImage imageNamed:@"hv_switch_icon_off"]];
    }
    
    WS(weakSelf);
    cell.mainBlock = ^(NSInteger index){
        
        switch (index) {
            case 0:{
                //开关
                if (device.bIsConnect) {
                    
                    [weakSelf turnOnOffCameraWithDevice:device];
                }
                else{
                    [OMGToast showWithText:@"请先插上电源插头"];
                }
                
            }
                break;
                
            case 1:{
                //实时监控
                if (device.bIsConnect) {
                    
                    if (device.cameraState == DeviceState_On) {
                        
                        HVMonitorCameraVC *vc = [[HVMonitorCameraVC alloc]initWithNibName:@"HVMonitorCameraVC" bundle:nil];
                        vc.curDevice = device;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                    else{
                        [OMGToast showWithText:@"请先打开设备"];
                    }
                }
                else{
                    [OMGToast showWithText:@"请先插上电源插头"];
                }

            }
                break;
                
           
                
            default:
                break;
        }
    };
  
        
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifier = @"HVMainSectionView";
    HVMainSectionView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (headerView == nil) {
        headerView = [[HVMainSectionView alloc]initWithReuseIdentifier:identifier];
        [headerView setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 60)];
        HVMainFootView *view = (HVMainFootView *)[[[NSBundle mainBundle] loadNibNamed:@"HVMainFootView" owner:self options:nil]lastObject];
        [view setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, view.frame.size.height)];
        [headerView addSubview:view];
        headerView.footView = view;
    }
    
    WS(weakSelf);
    
    __weak HVMainFootView *weakView = headerView.footView;
     headerView.footView.arrowBlock = ^{
        
        NSString *str = [weakSelf.signArray objectAtIndex:section];
     
        NSMutableArray *array=[NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:section]];
        
        if ([str isEqualToString:@"0"]) {
            [weakSelf.signArray replaceObjectAtIndex:section withObject:@"1"];
            
            [weakSelf.mainTableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
            
            [UIView animateWithDuration:0.3 animations:^{
                weakView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
                
            }];
        }
        else{
            [weakSelf.signArray replaceObjectAtIndex:section withObject:@"0"];
            
            [weakSelf.mainTableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
            
            [UIView animateWithDuration:0.3 animations:^{
                weakView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
                
            }];
            
        }

    };

    CloseliCameraDevice *device = self.cameraArray[section];
    if (device) {
     
        headerView.footView.nameLabel.text = device.name;
        
//        headerView.footView.statusLabel.text = device.bIsConnect ? ((device.cameraState == DeviceState_On) ? @"在线" : @"离线") : @"离线";
        
        headerView.footView.statusLabel.text = device.bIsConnect ? @"在线" : @"离线";

        NSError *error = nil;
        CloseliCameraExtraSettings *settings  = [[CloseliApiManager share].mySDK getCameraSettingsWithCamera:device error:&error];
       
        headerView.footView.typeLabel.text = settings.deviceType;
        
        [headerView.footView.typeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hv_device_%@",settings.deviceType]]];
    }
   

    NSString *signStr = [_signArray objectAtIndex:section];
    if ([@"0" isEqualToString:signStr]) {
        
        headerView.footView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
        
    }
    else{
        
        headerView.footView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }

    return headerView;
    
}


#pragma mark btnClickAction
- (IBAction)changeClickAction:(UIButton *)sender
{
  
    
    UIAlertView *alter =  [[UIAlertView alloc] initWithTitle:nil message:@"您确定要退出当前账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];


}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[CloseliApiManager share].mySDK logout];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)leftDrawerButtonPress:(UIButton*)sender{
    
    UIViewController *findVC;
    for (UIViewController *vc  in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[WinportToolsVC class]]) {
            findVC = vc;
            break;
        }
    }
    if (findVC) {
        [self.navigationController popToViewController:findVC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end