//
//  HomeZhuangWeiZhanVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "HomeZhuangWeiZhanVC.h"
#import "WeiZhanModel.h"
#import "ADViewCell.h"
#import "JMView.h"
#import "BannerEditVC.h"
#import "WZ_TextViewPhotoVC.h"
#import "FoodDetailEditVC.h"
#import "WZ_EditActivitiesVC.h"
#import "WZ_LoopVC.h"
#import "GenealWeiZhanCell.h"
#import "EditHongBaoVC.h"
#import "HZTableViewCell.h"
#import "HZCaseDetailVC.h"
#import "HZEditActivitiesVC.h"
#import "HZYuYueDetailEditVC.h"
@interface HomeZhuangWeiZhanVC () <UITableViewDataSource,UITableViewDelegate,LoopViewDeledate,JMViewDelegate>
{
    BOOL _isHidden;
    BOOL _isHaveWNDH;
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *dataArrays;
@property (nonatomic, strong) NSArray *keyPathArray;
@property (nonatomic, strong) SearPartData* dataSource;


@property (nonatomic, strong) NSMutableArray *secondArry;
@property (nonatomic, strong) NSMutableArray *thirdlyArry;
@property (nonatomic, strong) NSMutableArray *fourthlyData;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) TemplateModel *model;

@property (nonatomic ,strong)HZIconViewFrame *frame;
@end

@implementation HomeZhuangWeiZhanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubView];
}

- (void)setUpSubView{
    
    self.leftTitle = @"家装微站配置";
    
    _keyPathArray = @[
                      @[ShopName],
                      @[ZhuangXBJ,MoreCase,WeiNDH,LiaoJWM],
                      @[QiangHB,DaZP,GuaGK],
                      @[JingDianCase],
                      @[YuYueZX]
                      ];
    
    [self requestWeiZhanDetail];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self requestWeiZhanDetail];
}

-(void)setDataSource:(SearPartData *)dataSource{
    _dataSource = dataSource;
    if (!_secondArry) {
        _secondArry = [NSMutableArray array];
    }else{
        [self.secondArry removeAllObjects];
    }
    if (!_thirdlyArry) {
        _thirdlyArry = [NSMutableArray array];
    }else{
        [self.thirdlyArry removeAllObjects];
    }
    
    //服务介绍数据
    NSArray* keys = KeysArry;
    PartModel* model = [[self getTempleData:HomeShopNameStatus] lastObject];
        [model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TemplateModel* model = (TemplateModel*)obj;
        
        if (![keys containsObject:model.code]) {
            [self.secondArry addObject:obj];
        }
    }];
    //红包
    self.thirdlyArry = [self getTempleData:HomeHuoDongStatus].mutableCopy;
    if (self.thirdlyArry.count == 0) {
        PartModel*model = [[PartModel alloc]init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelnameCode = QiangHB;
        TemplateModelData* data = [[TemplateModelData alloc]init];
        TemplateModel* item = [[TemplateModel alloc]init];
        data.date = @[item];
        model.templateModelnameDate = data;
        [self.thirdlyArry addObject:model];
    }
}
#pragma mark - placeholderData
- (NSMutableArray *)placeholderData{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    NSArray *images = [NSArray arrayWithObjects:
                              @"jianyuefengge",
                              @"dizhonghaifengge",
                              @"zhongshifengge",
                              @"gudianfengge",nil];
    NSArray *names = [NSArray arrayWithObjects:
                             @"简约风格",
                             @"地中海风格",
                             @"中式风格",
                             @"古典风格", nil];    
    
    [images enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel *model = [[TemplateModel alloc]init];
        NSString *str = names[idx];
        model.imageName = obj;
        model.name = str;
        [dataArray addObject:model];
    }];
    
    return dataArray;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.thirdlyArry.count == 0 ? 1 : self.thirdlyArry.count;
    }
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0://商店名字
        {
            NSString* idengfier=@"ADTitleViewCell";
            ADTitleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ADViewCell" owner:nil options:nil] objectAtIndex:2];
            }
            cell.iconImage.image = [UIImage imageNamed:@"jiazhuang-banner"];

            for (PartModel* model in self.dataSource.data) {
                if ([model.templateModelnameCode isEqualToString:ShopName] && model.templateModelnameDate) {
                    
                    TemplateModel *nameModel=[model.templateModelnameDate.date lastObject];
                    _shopName = nameModel.name;
                    
                    cell.model = [model.templateModelnameDate.date lastObject];
                }
            }
            cell.jView.delegate = self;
            return cell;
        }
            break;
        case 1://菜单编辑
        {
            static NSString *indetify = @"ADImageCell";
            
            ADImageCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:3
                        ];
            }
            
            ADImageModel* model = [[ADImageModel alloc] init];
            model.titles = @[@"装修报价",@"更多案例",@"为你导航",@"了解我们"];
            model.images = @[@"67",@"68",@"69",@"60"];
            model.isEdit = YES;
            
            cell.model = model;
            cell.jView.delegate = self;
            cell.selectionStyle = 0;
            return cell;
            
        }
            break;
            
        case 2://红包
        {

            /*  默认是抢红包 编辑可更改大转盘,刮刮卡。添加可添加大转盘,刮刮卡。 如果隐藏则显示另一种方式   */
            NSString* cellID=@"HongBaoCell_ident";
            HongBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[HongBaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.model = [self.thirdlyArry objectAtIndex:indexPath.row];
            cell.cellType = HongBaoHongDong;
            cell.jView.tag = cell.cellType + 100;
            cell.jView.delegate = self;
            cell.jView2.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 3://经典案例
        {
            NSArray *modelArr = [self getTempleData:HomeCaseStatus];
            PartModel *model;
            if (modelArr.count==0) {
                model=[[PartModel alloc]init];
            }
            else{
                model = [modelArr firstObject];
            }

            NSArray *dataArray = model.templateModelnameDate.date;
            HZTableViewCell *cell = [HZTableViewCell cellForTableView:tableView];
            
            if (dataArray.count == 0) {
                NSMutableArray * dataArr = [self placeholderData];
                cell.dataArray = dataArr;
            }else{
                //获取从服务器得到的数据
                cell.dataArray = dataArray;
            }
            cell.jView.delegate = self;
            return cell;
        }
            break;
        case 4://马上预约
        {
            static NSString *indetify = @"ADButtonCell";
            
            HZButtonCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:5];
            }
            [cell.ideaBtn setTitle:@"马上预约" forState:UIControlStateNormal];
            cell.jView.delegate = self;
            cell.jView.tag = HZMaShangYuYueTag;
            return cell;
        }
            break;
            
        default:
        {
            return nil;
        }
            break;
    }
}
-(void)settingHiden:(PartModel*)model{
    
    for (PartModel* mol in self.thirdlyArry) {
        
        if ([mol.templateModelnameCode isEqualToString:model.templateModelnameCode]) {
//            mol.HB_hidenAtIndex = [NSString stringWithFormat:@"%ld",(NSInteger)![model.HB_hidenAtIndex boolValue]];
            TemplateModel *temp = [model.templateModelnameDate.date lastObject];
            temp.status =[NSString stringWithFormat:@"%ld",(NSInteger)![temp.status boolValue]];
            NSLog(@"%@",temp.status);
            
            break;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return KADTitleViewCellH;
        }
            break;
            
        case 1:
        {
            return KADImageCellH;
        }
            break;
            
        case 2:{
            return [self getHidenWith:indexPath.row] == YES ? kHongBaoCellH : JMViewH;
        }
            break;
            
        case 3:
        {
            NSArray *modelArr = [self getTempleData:HomeCaseStatus];
            PartModel *model;
            if (modelArr.count==0) {
                model=[[PartModel alloc]init];
            }
            else{
                model = [modelArr firstObject];
            }
            NSArray *dataArray = model.templateModelnameDate.date;
            HZIconViewFrame *frame = [[HZIconViewFrame alloc]init];
            if (dataArray.count == 0) {
                NSMutableArray * dataArr = [self placeholderData];
                frame.dataArr = dataArr;
            }else{
                //获取从服务器得到的数据
                frame.dataArr = dataArray;
            }
            return [frame cellHeight];

        }
            break;
            
        case 4:
        {
            return KADButtonCellH;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 2:{
            return [self getHidenWith:section] == NO ? 10:.1f;
        }
            break;
        case 3:{
            return 30.f;
        }
            break;

        default:
            break;
    }
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 1:
        {
            return [self getHidenWith:section] == NO? 10:.1f;
        }
            break;
        case 3:
        {
            return 15.f;
        }
            break;
            
        default:
        {
            return 10;
        }
            break;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:{
            return nil;
        }
            break;
        case 2:{
            
            UIView* spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
            spaceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            return spaceView;
        }
            break;
        case 3:{
            
            UIView* spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
            spaceView.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, KScreenWidth, 30)];
            label.text = @"经典案例";
            [spaceView addSubview:label];
            return spaceView;
        }
            break;

            
        default:{
            UIView* spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
            spaceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            return spaceView;
        }
            break;
    }
    
}
- (BOOL)getHidenWith:(NSInteger)row{
    
    if (row >= self.thirdlyArry.count) {
        return NO;
    }
    PartModel* mol = [self.thirdlyArry objectAtIndex:row];
    TemplateModel *temp =[mol.templateModelnameDate.date lastObject];
    return [temp.status boolValue];
}
#pragma mark - loopView delegate
- (void)userDidSelectAtIndex:(NSInteger)index{
    
    
}

#pragma mark - JMView delegate

-(void)userDidSelectIndex:(NSInteger)index inView:(UIView*)view data:(id)data{
    
}

- (void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    JMView* jView = (JMView*)view;
    __weak typeof(self) wSelf = self;
    switch (jView.tag) {
        case KADTitleViewTag://banner编辑
        {
            BannerEditVC* vc = [[BannerEditVC alloc] initWithNibName:@"BannerEditVC" bundle:nil block:^(PartModel *model, BOOL isNewData) {
                
                [wSelf setTempleData:@[model] isNew:isNewData];
                
                [wSelf.tableView reloadData];
            }];
            vc.isBig = NO;
            vc.templateNo=JiaZhuang;
            
            vc.model = [[self getTempleData:HomeShopNameStatus] lastObject];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KADImageTag://菜单编辑
        {
            HZEditActivitiesVC* vc = [[HZEditActivitiesVC alloc] init];
            
            vc.dataSource = self.dataSource;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 102://红包编辑
        {
            switch (index) {
                case 0:{
                    if ([(TemplateModel*)[[[(PartModel*)jView.prams templateModelnameDate] date] lastObject] id] == nil) {
                        [self settingHiden:jView.prams];
                        return;
                    }
                    
                    [self settingHiden:jView.prams];

                    [self requestChangeShowStatu:NO data:jView.prams callBack:^{
//                        [self settingHiden:jView.prams];
                    }];
                }
                    break;
                    
                case 1:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = JiaZhuang;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    vc.models = [self getTempleData:HomeHuoDongStatus];
                     NSLog(@"vc==%@--jv==%@",vc.model.templateModelnameCode,jView.prams);
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = JiaZhuang;
                    vc.model = jView.prams;
                    vc.isEdite=NO;
                    vc.models = [self getTempleData:HomeHuoDongStatus];
                     NSLog(@"vc==%@--jv==%@",vc.model.templateModelnameCode,jView.prams);
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
        }
            break;
        case 666:{
            if ([(TemplateModel*)[[[(PartModel*)jView.prams templateModelnameDate] date] lastObject] id] == nil) {
                [self settingHiden:jView.prams];
                return;
            }
            
            [self settingHiden:jView.prams];
            
            [self requestChangeShowStatu:YES data:jView.prams callBack:^{
                
//                [self settingHiden:jView.prams];
            }];
        }
            break;
        case HZCaseDetailEdit://经典案例编辑
        {
            HZCaseDetailVC* vc =  [[HZCaseDetailVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                
                [wSelf setTempleData:@[model] isNew:isNew];
                
                [wSelf.tableView reloadData];
            }];
            vc.model = [[self getTempleData:HomeCaseStatus] lastObject];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case HZMaShangYuYueTag://马上预约编辑
        {
            HZYuYueDetailEditVC *vc=[[HZYuYueDetailEditVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                [wSelf setTempleData:wSelf.dataSource.data isNew:isNew];
                [wSelf.tableView reloadData];
            }];
            
            vc.model = [[self getTempleData:HomeNowYuyueStaus] lastObject];
            vc.templateNo=JiaZhuang;
            vc.templateCode=NowYuYue;
            vc.templatename=@"预约装修详情编辑";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    
        default:
            break;
    }
}

#pragma mark --保存模板--

-(void)requestChangeShowStatu:(BOOL)isShow data:(PartModel*)model callBack:(void(^)())callBack{
    TemplateModel* m;
    if (isShow) {
        m.status=@"1";
    }
    else{
        m.status=@"0";
    }
    if (!model) {
        model = [[PartModel alloc] init];
        m = [[TemplateModel alloc] init];
        NSMutableArray* temp = [NSMutableArray array];
        [temp addObject:m];
        model.templateModelnameDate.date = temp.copy;
    }
    m = model.templateModelnameDate.date.lastObject;
    NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:model, nil];
    [self saveTemplte:dataArr succeed:^(id responseObject) {
        
        if (callBack) {
            callBack();
        }
    } error:nil];
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
        return;
    }
    
    NSMutableArray* tempArr = [NSMutableArray array];
    [tempArr addObjectsFromArray:self.dataSource.data];
    [tempArr addObjectsFromArray:tArrData];
    
    self.dataSource.data = tempArr.copy;
}

-(NSMutableArray*)getTempleData:(HomeZhuangStatus)type{
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSArray* tArr = [_keyPathArray objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr containsObject:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    return targetArr;
}
#pragma mark - netWork request

- (void)requestWeiZhanDetail{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:JiaZhuang forKey:@"templateNo"];
    
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        
        self.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        
    } showHUD:YES];
    
}
#pragma mark - setter、getter
@synthesize tableView = _tableView,imageArray = _imageArray,dataArrays = _dataArrays,dataSource = _dataSource;

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        WS(weakSelf);
        _tableView.tableFooterView = [[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:NO block:^{
            
            for (PartModel*model in self.dataSource.data) {
                if ([model.templateModelnameCode isEqualToString:@"wndh"]) {
                    _isHaveWNDH =YES;
                    break ;
                }
                else{
                    _isHaveWNDH =NO;
                }
            }
            if (!_isHaveWNDH) {
                [OMGToast showWithText:@"请编辑为你导航后保存"];
                return ;
            }

            [weakSelf saveTemple:JiaZhuang andshopName:weakSelf.shopName];
            [self saveTemple:JiaZhuang andshopName:_shopName];
        }];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        
    }
    return _imageArray;
}

- (NSMutableArray *)dataArrays{
    
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays;
}

- (SearPartData *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[SearPartData alloc] init];
    }
    
    return _dataSource;
}
@end
