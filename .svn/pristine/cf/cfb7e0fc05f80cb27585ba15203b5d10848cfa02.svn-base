//
//  EC_ProductActivityVC.m
//  BusinessManager
//
//  Created by 王启明 on 16/8/17.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EC_ProductActivityVC.h"
#import "ADViewCell.h"
#import "WeiZhanModel.h"
#import "WZ_TextViewPhotoVC.h"
#import "BannerCell.h"
#import "FoodDetailEditVC.h"
#import "WZ_PilotVC.h"
#import "WZ_LookRoomVC.h"
#import "WZ_TextPhotoVC.h"
@interface EC_ProductActivityVC ()<UITableViewDataSource,UITableViewDelegate,EditCellDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray *keyPathArray;
@end

@implementation EC_ProductActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"菜单模块编辑";
    
    self.keyPathArray =  @[LiaoJWM,WeiNTJ, LianXWM,WeiNDH];
    
    [self tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestWeiZhanDetail];
}

- (void)requestWeiZhanDetail{//请求电商模板下的详情
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:DianShang forKey:@"templateNo"];
    WS(weakSelf)
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        
        weakSelf.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
        
        [weakSelf.tableView reloadData];
        
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
            model.titles = @[@"了解我们",@"为您推荐",@"联系我们",@"为你导航"];
            model.images = @[@"60",@"65",@"61",@"66"];
            model.isEdit = NO;
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
    
    return KADImageCellH + 35;
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
    if (!isEdit) {
     
        switch (menuView.tag) {
                
            case 666:// 了解我们
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:wSelf.dataSource.data isNew:isNew];
                    
                }];
                vc.title = @"了解我们详情编辑";
                vc.tempName = @"了解我们";
                vc.placeholder = @"输入关于您的商铺的介绍等信息，没有图片可不上传";
                vc.nameCode = LiaoJWM;
                vc.Modelname=DianShang;
                vc.model = [[self getTempleData:FoodMenusStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            
            }
                break;
            case 667://为你推荐
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:wSelf.dataSource.data isNew:isNew];
                    
                }];
                vc.title = @"为您推荐详情编辑";
                vc.tempName = @"为您推荐";
                vc.placeholder = @"输入关于您的商铺的介绍等信息，没有图片可不上传";
                vc.nameCode = WeiNTJ;
                vc.Modelname=DianShang;
                vc.model = [[self getTempleData:AboutStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 668:// 联系我们
            {
                if (self.dataSource.temPlate.source==1) {
                    [OMGToast showWithText:@"为了保持该模块样式统一，请在网站上编辑该模块"];
                    return;
                }
                WZ_TextPhotoVC* vc = [[WZ_TextPhotoVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:wSelf.dataSource.data isNew:isNew];
                    
                }];
                vc.title = @"联系我们详情编辑";
                vc.tempName = @"联系我们";
                vc.placeholder = @"输入关于您的商铺的介绍等信息，没有图片可不上传";
                vc.nameCode = LianXWM;
                vc.Modelname=DianShang;
                vc.model = [[self getTempleData:ActivityStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 669:// 为您导航
            {
                WZ_PilotVC* vc = [[WZ_PilotVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:wSelf.dataSource.data isNew:isNew];
                    
                }];
                vc.type = DianShang;
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

