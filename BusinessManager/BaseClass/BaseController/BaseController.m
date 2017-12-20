//
//  BaseController.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseController.h"
#import "LoginVC.h"
#import "BaseNavigationController.h"

#define BackBtnW 40

@interface BaseController ()<UINavigationControllerDelegate>

@end

@implementation BaseController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftItem];
    
//    self.navigationController.delegate =self;
    self.view.backgroundColor = HexColor(@"#F8F8FF");

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate =self;
}
#pragma mark -------手势控制----------------

//需要禁用手势的界面全部在这里控制
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (viewController == navigationController.viewControllers[0] || [viewController isKindOfClass:[LoginVC class]])
    {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        
        //        self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


#pragma mark - 复写返回方法获取返回事件
-(void)leftDrawerButtonPress:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置标题
-(void)setLeftTitle:(NSString *)title{
    
    self.leftItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    self.leftItem.frame = [self.leftItem setLeftItemTitle:title];
  
    [self settingBackItem];
}
-(void)settingBackItem{
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:_leftItem];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -9;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
}
-(NSDate *)requestDate{

    return [NSDate date];
}
#pragma mark -
- (void)addNavRightButtonWithTitle:(NSString *)title icon:(UIImage *)icon action:(SEL)selector target:(id)target{
    CGSize btnSize;
    if (icon) {
        btnSize = icon.size;
    }else{
        btnSize = CGSizeMake(120, 30);
    }
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, btnSize.height)];
    
    if (icon) {
        [btn setBackgroundImage:icon forState:UIControlStateNormal];
    }
    if (title.length) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

#pragma mark - 初始化
@synthesize leftItem = _leftItem, backItemHiden = _backItemHiden;

-(void)setBackItemHiden:(BOOL)backItemHiden{
    _backItemHiden = backItemHiden;
    self.leftItem.hidden = backItemHiden;
}

-(LeftItem *)leftItem{

    if (!_leftItem) {
        
        _leftItem = [[LeftItem alloc]initWithFrame:CGRectMake(0,0,BackBtnW,BackBtnW) target:self action:@selector(leftDrawerButtonPress:)];
        
        [self settingBackItem];
    }
    return _leftItem;
}

//支持旋转
-(BOOL)shouldAutorotate{
    return NO;
}

//支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)dealloc
{
    self.navigationController.delegate =nil;
}

@end


#pragma mark - 导航栏左侧view
@implementation LeftItem

-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0,0,BackBtnW,BackBtnW);
        [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [leftButton setImage:[UIImage imageNamed:@"BackSenderImage"] forState:UIControlStateNormal];
        leftButton.titleLabel.textColor = [UIColor whiteColor];
        leftButton.tag = 999;
        [self addSubview:leftButton];
    }
    return self;
}

-(CGRect)setLeftItemTitle:(NSString*)title{

    CGFloat space = 10;//label按钮的间距
    UIButton* leftBtn = [self viewWithTag:999];
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame)+space, 0, WidthForString(title,16,1000) + 5, leftBtn.height)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.userInteractionEnabled = YES;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    return  CGRectMake(0, 0, CGRectGetMaxX(titleLabel.frame), leftBtn.height);
}


@end
