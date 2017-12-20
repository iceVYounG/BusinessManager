//
//  WZ_EditActivitiesVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_EditActivitiesVC.h"
#import "ADViewCell.h"
#import "WeiZhanModel.h"
#import "WZ_TextViewPhotoVC.h"
#import "BannerCell.h"
#import "FoodDetailEditVC.h"
#import "WZ_PilotVC.h"
#import "WZ_LookRoomVC.h"
#import "OMGToast.h"
#import "WZ_TextPhotoVC.h"
#import "YuyueLookRoomVC.h"
@interface WZ_EditActivitiesVC () <UITableViewDataSource,UITableViewDelegate,EditCellDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray *keyPathArray;
@property (nonatomic, strong) NSArray *keyPathArray2;
@property (nonatomic, strong) NSArray *HZPathArray;
@end

@implementation WZ_EditActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"菜单模块编辑";
    
    
    self.keyPathArray =  @[FoodMenu,About,Activity,WeiNDH];
    
    self.keyPathArray2 =  @[LouPJJ,HuXXS,WeNDH,CuXHD,YuYKF,LianXWM];
    
    self.HZPathArray = @[ZhuangXBJ,MoreCase,WeiNDH,LiaoJWM];
    
        [self tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestWeiZhanDetail];
    
}

#pragma mark - Request
- (void)requestWeiZhanDetail{//请求房产模板下的详情
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:NoNullStr(self.templeNo, @"") forKey:@"templateNo"];
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        
        self.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
        
        [self.tableView reloadData];
        
    } showHUD:YES];
}


#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetify =  @"EditCell";
    EditCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BannerCell class]) owner:nil options:nil] objectAtIndex:2];
    }
    
    ADImageModel* model = [[ADImageModel alloc] init];
   switch (self.status) {
        case FourButtonStatus:
        {
            model.titles = @[@"菜单",@"关于我们",@"活动信息",@"为你导航"];
            model.images = @[@"louce01",@"louce02",@"louce03",@"louce04"];
            model.isEdit = NO;
        }
            break;
        case SixButtonStatus:
        {   

            model.titles = @[@"楼盘简介",@"户型欣赏",@"为您导航",@"促销活动",@"预约看房",@"联系我们"];
            model.images = @[@"blue100",@"blue101",@"blue102",@"blue103",@"blue104",@"blue105"];
            model.isEdit = YES;
        }
            break;
  
            
        default:
            break;
    }
    
    cell.delegate = self;
    cell.selectionStyle=0;
   cell.model = model;
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.status == SixButtonStatus) {
        return KADImageCellH * 3 +10;
    }
    return KADImageCellH + 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, KScreenWidth - 12, 20)];
    titleLabel.text = @"我选中的菜单:";
    [headView addSubview:titleLabel];
    return headView;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - 

- (void)editSenderCilckWithBtn:(MenuView *)menuView cell:(id)cell isEdit:(BOOL)isEdit{
    __weak typeof(self) wSelf = self;
    
    if (isEdit) {
        switch (menuView.tag) {
            case 666:
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];
                
                vc.title = @"楼盘简介详情编辑";
                vc.tempName = @"楼盘简介";
                vc.nameCode = LouPJJ;
                vc.Modelname=FangChan;
                vc.placeholder = @"输入关于您的楼盘的介绍等信息，没有图片可不上传";
                vc.model = [[self getTempleData2:LouPanJJ] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 667:
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];                vc.title = @"户型欣赏详情编辑";
                vc.nameCode = HuXXS;
                vc.tempName = @"户型欣赏";
                vc.Modelname=FangChan;
                vc.placeholder = @"输入关于您的楼盘的户型介绍等信息，没有图片可不上传";
                
                vc.model = [[self getTempleData2:HuxingXS] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 668://为您导航
            {
                WZ_PilotVC* vc = [[WZ_PilotVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [self setTempleData:self.dataSource.data isNew:isNew];

                    
                }];
                vc.type = FangChan;
                vc.model = [[self getTempleData2:WeiniDH] lastObject];
                [wSelf.navigationController pushViewController:vc animated:YES];

            }
                break;
            case 669://促销活动
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];
                vc.title = @"促销活动详情编辑";
                vc.Modelname=FangChan;
                vc.tempName = @"促销活动";
                vc.placeholder = @"输入关于您的楼盘的促销活动介绍等信息，没有图片可不上传";
                vc.nameCode = CuXHD;
                vc.model = [[self getTempleData2:CuxiaoActive] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 670://预约看房
            {
                
                YuyueLookRoomVC* vc = [[YuyueLookRoomVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                }];
                NSLog(@">>>%@",[[self getTempleData2:YuyueKF] lastObject]);
                vc.leftTitle=@"预约看房";
                vc.model = [[self getTempleData2:YuyueKF] lastObject];                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 671://联系我们
            {
                
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];                vc.title = @"联系我们详情编辑";
                vc.Modelname=FangChan;
                vc.tempName = @"联系我们";
                vc.placeholder = @"输入关于您的联系方式、店铺介绍等信息，没有图片可不上传";
                vc.nameCode = LianXWM;
                vc.model = [[self getTempleData2:LianXiWM] lastObject];

                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        switch (menuView.tag) { 

            case 666:// 菜单
            {
                FoodDetailEditVC* vc = [[FoodDetailEditVC alloc] initWithBlock:^(PartModel *model, BOOL isNewData) {
                    
                    [self setTempleData:self.dataSource.data isNew:isNewData];
                }];
                NSLog(@">>>%@",[[self getTempleData:FoodMenusStatus] lastObject]);
                
                vc.model = [[self getTempleData:FoodMenusStatus] lastObject];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 667://关于我们
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];
                vc.title = @"了解我们详情编辑";
                vc.tempName = @"关于我们";
                vc.placeholder = @"输入关于您的商铺的介绍等信息，没有图片可不上传";
                vc.nameCode = About;
                vc.Modelname=CanYin;
                vc.model = [[self getTempleData:AboutStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 668:// 活动信息
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }

                
                
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:self.dataSource.data isNew:isNew];
                    
                }];

                vc.title = @"活动信息详情编辑";
                vc.tempName = @"活动信息";
                vc.placeholder = @"输入您活动信息的介绍，没有图片可不上传";
                vc.nameCode = Activity;
                vc.Modelname=CanYin;
                NSLog(@">>>%@",[[self getTempleData:ActivityStatus] lastObject]);
                
                vc.model = [[self getTempleData:ActivityStatus] lastObject];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 669:// 为您导航
            {
                WZ_PilotVC* vc = [[WZ_PilotVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [self setTempleData:self.dataSource.data isNew:isNew];
                    
                }];
                vc.type = CanYin;
                NSLog(@"%@",[[self getTempleData:WeiNDHStatus] lastObject]);
                
                vc.model = [[self getTempleData:WeiNDHStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            default:
                break;
        }
    }

}

-(void)setTempleData:(NSArray*)tArrData isNew:(BOOL)isNew{
    
    if (!isNew) {
        for (PartModel*model1 in self.dataSource.data) {
            
            for (PartModel*model2 in tArrData) {
                
                if ([model1.templateModelnameCode isEqualToString:model2.templateModelnameCode]) {
                    
                    model1.templateModelnameDate = model2.templateModelnameDate;
                }
            }
        }
        [self setDataSource:_dataSource];
        return;
    }
    
    NSMutableArray* tempArr = [NSMutableArray array];
    [tempArr addObjectsFromArray:self.dataSource.data];
    [tempArr addObjectsFromArray:tArrData];
    
    self.dataSource.data = tempArr.copy;
}
-(NSMutableArray*)getTempleData:(menuStatus)type{
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSString* tArr = [_keyPathArray objectAtIndex:type];
    
    NSLog(@">>>%@",self.dataSource);
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr isEqualToString:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    return targetArr;
}


-(NSMutableArray*)getTempleData2:(lookRoomStatus)type{
    
    NSLog(@"%@",self.dataSource.data);
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSString* tArr = [_keyPathArray2 objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr isEqualToString:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    
    
    return targetArr;
}



#pragma mark - setter、getter
@synthesize tableView = _tableView;

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end