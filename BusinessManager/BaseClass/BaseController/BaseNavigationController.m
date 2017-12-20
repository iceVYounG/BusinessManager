//
//  BaseNavigationController.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseNavigationController.h"
#import "HomeController.h"
#import "LoginVC.h"

#define NaviBarColor    HexColor(@"#3a3a3a") //导航栏背景颜色
#define TitleFont      [UIFont systemFontOfSize:18] //标题字体

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition* percentDrivenInteractiveTransition;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingMyBar];
    
    self.interactivePopGestureRecognizer.delegate = (id) self;
    
//    [self setBackGesture];
}

-(void)settingMyBar{
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:TitleFont,
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setBarTintColor:NaviBarColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"UserBG@2x.jpg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
    if(IOS7){ self.navigationBar.translucent = NO; }
}

-(void)setBackGesture{

    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全局侧滑手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    // 禁止系统侧滑手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    return YES;
}
-(void)handleNavigationTransition:(UIPanGestureRecognizer*)gesture{
  
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

//- (void)navigationController:(UINavigationController *)navigationController
//       didShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animated
//{
//    if (viewController == navigationController.viewControllers[0] || [viewController isKindOfClass:[LoginVC class]])
//    {
//        navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }else {
//        
////        self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
//        navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    //如果在红色方框内有长按手势，这里需要快速返回NO，要不然反映会很迟钝。
    return YES;
}





- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}


@end
