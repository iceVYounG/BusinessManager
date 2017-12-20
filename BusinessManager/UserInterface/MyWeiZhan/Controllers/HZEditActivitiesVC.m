//
//  HZEditActivitiesVC.m
//  BusinessManager
//
//  Created by niuzs on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#import "WZ_EditActivitiesVC.h"
#import "HZEditActivitiesVC.h"
#import "ADViewCell.h"
#import "WeiZhanModel.h"
#import "WZ_TextViewPhotoVC.h"
#import "BannerCell.h"
#import "FoodDetailEditVC.h"
#import "WZ_PilotVC.h"
#import "WZ_LookRoomVC.h"
#import "EditUnderstandUsVC.h"
#import "EditMoreCaseVC.h"
#import "EditFitmentPriceVC.h"
@interface HZEditActivitiesVC ()<UITableViewDataSource,UITableViewDelegate,EditCellDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray *keyPathArray;
@end

@implementation HZEditActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"菜单模块编辑";
    
    self.keyPathArray =  @[ZhuangXBJ,MoreCase,WeiNDH,LiaoJWM];
    
    [self tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestWeiZhanDetail];
}

- (void)requestWeiZhanDetail{//请求房产模板下的详情
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:JiaZhuang forKey:@"templateNo"];
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
    model.titles = @[@"装修报价",@"更多案例",@"为你导航",@"了解我们"];
    model.images = @[@"67",@"68",@"69",@"60"];
    model.isEdit = NO;
    cell.delegate = self;
    cell.selectionStyle = 0;
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
            case 666:// 装修报价
            {
                EditFitmentPriceVC *vc = [[EditFitmentPriceVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:@[model] isNew:isNew];
                    [wSelf.tableView reloadData];
                    
                }];
                vc.model = [[self getTempleData:FitPriceStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            case 667://更多案例
            {
                EditMoreCaseVC *vc = [[EditMoreCaseVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:@[model] isNew:isNew];
                    [wSelf.tableView reloadData];
                    
                }];
                vc.model = [[self getTempleData:MoreCaseStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 668:// 为你导航
            {
                WZ_PilotVC* vc = [[WZ_PilotVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                    [self setTempleData:self.dataSource.data isNew:isNew];
                    
                }];
                vc.type = JiaZhuang;
                
                vc.model = [[self getTempleData:ForYouNavStatus] lastObject];
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            case 669:// 了解我们
            {
                
                EditUnderstandUsVC *vc = [[EditUnderstandUsVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                    [wSelf setTempleData:@[model] isNew:isNew];
                    [wSelf.tableView reloadData];

                }];
                vc.model = [[self getTempleData:UnderstandUsStatus] lastObject];
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
-(NSMutableArray*)getTempleData:(menuStatu)type{
    
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
