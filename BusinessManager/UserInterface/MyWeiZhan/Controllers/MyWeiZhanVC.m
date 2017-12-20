//
//  MyWeiZhanVC.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MyWeiZhanVC.h"
#import "WeiZhanModel.h"
#import "MyWeiZhanCell.h"
#import "WeiZhanMainVC.h"
#import "WebViewController.h"
#import "WC_GeneralVC.h"
#import "HomeZhuangWeiZhanVC.h"

#import "FoodWeiZhanVC.h"
#import "HouseWeiZhanVC.h"
#import "ShenheJLVC.h"
#import "YuyueRecordVC.h"
#import "FourSWeiZhanVC.h"
#import "E_Commerce.h"
#import "FlowerShopVC.h"
#import "HomeController.h"
#import "BaseNavigationController.h"
@interface MyWeiZhanVC ()<MyWeiZhanDelegate>
{
    MyWeiZhanModel *weizhanModel;

}

@property(nonatomic,strong)UITableView* tableView;
@property (strong, nonatomic) IBOutlet UIView *popView;
@property (strong, nonatomic)UIView *mengbanView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *btnViews;
@property (strong, nonatomic) IBOutlet UIView *changeView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFielf;
@property (weak, nonatomic) IBOutlet UIView *yuyueView;
@property (weak, nonatomic) IBOutlet UILabel *weizhanName;

@end

@implementation MyWeiZhanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的微站";
    
    [self initView];
    
    
    [self creatRightBtn];
    
    [self requestMyWeiZhanDatas];
    
    __weak typeof(self) wSelf = self;
    self.refreshBlock = ^{ [wSelf requestMyWeiZhanDatas];};
}

-(void)initView{

    _mengbanView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    _mengbanView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.75];
    
    UITapGestureRecognizer *mengTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mengbanTap)];
    
    [_mengbanView addGestureRecognizer:mengTap];
    
    
    NSInteger i=0;
    for (UIView *view in _btnViews) {
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        view.tag =i;
        [view addGestureRecognizer:tap];
        i++;
    }
    
    _changeView.layer.borderWidth=0.5;
    _changeView.layer.cornerRadius=8;
    _changeView.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;

}

-(void)mengbanTap{

    [_popView removeFromSuperview];
    [_mengbanView removeFromSuperview];
    [_changeView removeFromSuperview];
}

- (IBAction)closePopAction:(id)sender {
    
    [_mengbanView removeFromSuperview];
    [_popView removeFromSuperview];
    
    
}

-(void)leftDrawerButtonPress:(UIButton*)sender{    
        HomeController* homeVC = [[HomeController alloc]init];
        UIViewController *vc = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
        UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
        topWindow.rootViewController=vc;
}


#pragma mark changeViewAction--
- (IBAction)cancelBtn:(id)sender {
    [_changeView removeFromSuperview];
    [_mengbanView removeFromSuperview];
    
}
- (IBAction)sureChange:(id)sender {
    if (_nameTextFielf.text.length==0) {
        [OMGToast showWithText:@"请输入新的微站名称"];
        return;
    }
    if (_nameTextFielf.text.length>20) {
        [OMGToast showWithText:@"名称输入过长，请重新输入"];
        return;
    }
    
    [_changeView removeFromSuperview];
    [_mengbanView removeFromSuperview];

    if (![_nameTextFielf.text isEqualToString:@""]) {
         [self saveTemple:weizhanModel.templateNo andshopName:_nameTextFielf.text];
    }else{
        [OMGToast showWithText:@"微站名称不能为空"];
    }
}

#pragma mark -删除 预约 审核
-(void)tapAction:(UIGestureRecognizer *)gesture{
    switch (gesture.view.tag) {
        case 0: //删除

        {
            NSMutableDictionary *prams = [NSMutableDictionary dictionary];
                        [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
            
                        [prams setObject:weizhanModel.templateNo forKey:@"templateNo"];
            
                        [[MallNetManager share] request:API_storeTemplateDelete prams:prams succeed:^(id responseObject) {
            
                            [OMGToast showWithText:@"模板删除成功"];
                            for (MyWeiZhanModel* mol in self.datasArry) {
            
                                if ([weizhanModel.templateNo isEqualToString:mol.templateNo]) {
                                    [self.datasArry removeObject:mol];
                                    break;
                                }
                            }
                            [self.tableView reloadData];
                            [self requestMyWeiZhanDatas];
                        } showHUD:YES];
        }
            break;
        case 1:  //预约记录
        {
            YuyueRecordVC *vc=[[YuyueRecordVC alloc]init];
            vc.templateNo=weizhanModel.templateNo;
            if ([weizhanModel.templateNo isEqualToString:@"ws004"]) {
                vc.modelNo=@"yyzx";
                vc.rightArrayNum=3;
            }
            if ([weizhanModel.templateNo isEqualToString:@"ws005"]) {
                vc.modelNo=@"yykf";
                vc.rightArrayNum=2;
            }
            if ([weizhanModel.templateNo isEqualToString:@"ws002"]) {
                vc.modelNo=@"yysj,yyby";
                vc.rightArrayNum=1;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:  //审核记录
        {

            ShenheJLVC *vc=[[ShenheJLVC alloc]init];
            vc.weiZhanId=weizhanModel.wzId;
            vc.templeNo=weizhanModel.templateNo;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    [_mengbanView removeFromSuperview];
    [_popView removeFromSuperview];
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* idengfier = @"MyWeiZhanCell_ident";
    MyWeiZhanCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyWeiZhanCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = 0;
    }
    cell.delegate = self;
    cell.model = [self.datasArry objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return MyWeiZhanCellH;
}


#pragma mark - Request
-(void)requestMyWeiZhanDatas{
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];


    [[MallNetManager share] request:API_Storecenter prams:prams succeed:^(id responseObject) {
        
        MyWeiZhans* rsp = [MyWeiZhans mj_objectWithKeyValues:responseObject];

        self.datasArry = rsp.data.mutableCopy;
        [self.tableView reloadData];
        
    } showHUD:YES];
  
}



#pragma mark - Action
-(void)creatRightBtn{

    UIButton* sender = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 40)];
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
    sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sender setTitle:@"创建新的微站" forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sender];
}
-(void)pushAction{
    WeiZhanMainVC* vc = [[WeiZhanMainVC alloc]init];
   AccountInfo.isTiyan=NO;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ----修改微站名称----

-(void)xiugaiAction:(MyWeiZhanModel *)model{

    _changeView.frame=CGRectMake(30, SCREEN_SIZE.height/2-140, SCREEN_SIZE.width-60, 140);
    [self.view addSubview:_mengbanView];
    [self.view addSubview:_changeView];
    weizhanModel =model;
    self.nameTextFielf.text=model.shopName;
}

#pragma mark - 提交审核

-(void)tijiaoAction:(MyWeiZhanModel *)model{
    
    NSLog(@">>>>%@",model.auditStatus);
    
    if ([weizhanModel.auditStatus isEqualToString:@"1"]) {
        [OMGToast showWithText:@"已提交审核，请勿重新提交"];
    }
//    else if([weizhanModel.auditStatus isEqualToString:@"2"]){
//        [OMGToast showWithText:@"已审核成功，请勿重新提交"];
//    }
    else {//审核失败
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"需要提交审核后才能在“12580和生活客户端”中展示，确定提交审核？" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self tijiaoRequest:model];
            
            NSLog(@"注意学习");
        }];
        // 创建按钮
        // 注意取消按钮只能添加一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            // 点击按钮后的方法直接在这里面写
            NSLog(@"注意学习");
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
         [self presentViewController:alertController animated:YES completion:nil];
    }
}


-(void)tijiaoRequest:(MyWeiZhanModel *)model{
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:@(model.wzId) forKey:@"id"];
    [[MallNetManager share] request:API_TijiaoSH prams:prams succeed:^(id responseObject) {

        [OMGToast showWithText:@"提交审核成功"];
        
    } showHUD:YES];
    
}


-(void)selectedBottomSender:(NSInteger)tag model:(MyWeiZhanModel *)model{
    switch (tag) {
        case 0:{
            
            if ([model.templateNo isEqualToString: @"ws_base"]) {
                WC_GeneralVC* vc = [[WC_GeneralVC alloc]init];//通用
                
                [self.navigationController pushViewController:vc animated:YES];
            }
           else if ([model.templateNo isEqualToString: @"ws001"]) {
                E_Commerce* vc = [[E_Commerce alloc]init];//电商
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: @"ws002"]) {
                FourSWeiZhanVC* vc = [[FourSWeiZhanVC alloc]init];//4s
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: @"ws003"]) {
                FoodWeiZhanVC* vc = [[FoodWeiZhanVC alloc]init];//餐饮
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: @"ws004"]) {
                HomeZhuangWeiZhanVC* vc = [[HomeZhuangWeiZhanVC alloc]init];//家装
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: @"ws005"]) {
                HouseWeiZhanVC * vc = [[HouseWeiZhanVC alloc]init];//房产
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: FlowerShop]) {
                FlowerShopVC * vc = [[FlowerShopVC alloc]init];//房产
                vc.titleStr=@"鲜花店详情配置";
                vc.type=FlowerShop;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: FruitShop]) {
                FlowerShopVC * vc = [[FlowerShopVC alloc]init];//房产
                vc.titleStr=@"水果店详情配置";
                vc.type=FruitShop;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.templateNo isEqualToString: BreadShop]) {
                FlowerShopVC * vc = [[FlowerShopVC alloc]init];//房产
                vc.titleStr=@"面包店详情配置";
                vc.type=BreadShop;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1:{
            
            WebViewController* webVC = [[WebViewController alloc]initWithUrl:model.frontPageUrl];
                        
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 2:{
            if ([model.templateNo isEqualToString:@"ws002"]||[model.templateNo isEqualToString:@"ws004"]||[model.templateNo isEqualToString:@"ws005"]) {
                self.yuyueView.hidden=NO;
            }
            else{
                self.yuyueView.hidden=YES;
            
            }
            
            _popView.frame=CGRectMake(0, SCREEN_SIZE.height-135-NavigationH, SCREEN_SIZE.width, 135);
            [self.view addSubview:_mengbanView];
            [self.view addSubview: _popView];
           
            
            weizhanModel=model;
            self.weizhanName.text=[NSString stringWithFormat:@"微站名称：%@",model.shopName];
        }
            break;
            
            
        default:
            break;
    }

}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [_mengbanView removeFromSuperview];
//    [_popView removeFromSuperview];
//}

#pragma mark - 初始化
@synthesize datasArry = _datasArry, tableView = _tableView;

-(NSMutableArray *)datasArry{
    
    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:0];
        _tableView.separatorStyle = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}





@end
