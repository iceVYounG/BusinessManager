//
//  MySettingVC.m
//  BusinessManager
//
//  Created by 朕  on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MySettingVC.h"
#import "MySettingCell.h"
#import "PersonalInfoVC.h"
#import "SolveProblemVC.h"
#import "AbountUsVC.h"
#import "SIAlertView.h"
#import "LoginVC.h"
#import "BaseNavigationController.h"
#import "NewLoginVC.h"

@interface MySettingVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mySettingTableView;
@property(nonatomic,strong) NSArray *setArr;
@end

@implementation MySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的设置";
    // 字典 数组 混合
    self.setArr = @[
                            @{@"image": @"message",@"note":@"个人信息"},
                            @{@"image": @"question",@"note":@"常见问题解答"},
                            @{@"image": @"clear",@"note":@"清除缓存"},
                            @{@"image": @"about",@"note":@"关于我们"}
                            ];
    self.mySettingTableView.scrollEnabled = NO;
    [self.mySettingTableView registerNib:[UINib nibWithNibName:@"MySettingCell" bundle:nil] forCellReuseIdentifier:@"MySettingCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 20;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString*ID=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"退出登录";
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
    static NSString*ID=@"MySettingCell";
    MySettingCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[MySettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic;
    if (indexPath.section == 1) {
        dic = self.setArr[indexPath.row + 2];
    }
    else
    {
        dic = self.setArr[indexPath.row];
    }
    cell.iconImgView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    cell.nameLabel.text = [dic objectForKey:@"note"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonalInfoVC *vc = [[PersonalInfoVC alloc]initWithNibName:@"PersonalInfoVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            SolveProblemVC *vc = [[SolveProblemVC alloc]initWithNibName:@"SolveProblemVC" bundle:nil];
            vc.title = @"常见问题解答";
            vc.url = @"http://183.207.110.93:8085/bfsh-ws-inter/static/html/FAQ/faq-list.html";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section == 1)
    {
        if (indexPath.row == 1) {
            AbountUsVC *vc = [[AbountUsVC alloc]initWithNibName:@"AbountUsVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"是否要清理缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
    else
    {
//        //已登录
        SIAlertView *alertView = [[SIAlertView alloc]initWithTitle:@"提示" andMessage:@"您确定要退出登录吗"];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            
        }];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            AccountInfo.storeId = @"";
            AccountInfo.storeName = @"";
//            AccountInfo.linkPhone = @"";
            AccountInfo.isLogin = NO;
            
            NewLoginVC *newVC=[[NewLoginVC alloc]initWithNibName:@"NewLoginVC" bundle:nil];
//            
            UIViewController *vc = [[BaseNavigationController alloc]initWithRootViewController:newVC];
            UIWindow *topWindow = [[UIApplication sharedApplication].delegate window];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              topWindow.rootViewController=vc;
            });
            
//            LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//            [self.navigationController pushViewController:newVC animated:YES];
            
            //            //            注销登陆
//            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            
            
            
//            AccountInfo.accountInfo.huiNum=@"0";
//            ACCOUNT.accountInfo.isLogin = [NSNumber numberWithBool:NO];
//            //            ACCOUNT.accountInfo.isAutoLogin= [NSNumber numberWithBool:NO];
//            
//            
//            [[UnitMetiodManager share]saveTheIsAutoLoginKey:NO];
//            
//            ACCOUNT.accountInfo.password = @"";
//            //话费购 账户退出需清除下area_code accountModel
//            ACCOUNT.accountInfo.area_code = @"";
//            ACCOUNT.accountInfo.terminalId = @"";
//            ACCOUNT.accountInfo.mALL_U_ID = @"";
//            [UnitMetiodManager share].md39Uid = @"";
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud removeObjectForKey:@"SCORE"];
//            [ud removeObjectForKey:@"CITYCOIN"];
//            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

        }];
        [alertView show];
    }
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        //        清理缓存
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[SDImageCache sharedImageCache] clearMemory];
        
        [OMGToast showWithText:@"清理完成"];
        
    }
}

@end
