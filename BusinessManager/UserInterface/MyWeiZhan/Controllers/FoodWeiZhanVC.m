//
//  FoodWeiZhanVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FoodWeiZhanVC.h"
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
#import "FourSLoopEditVC.h"
#import "QuestionListVC.h"
#import "LunBoEditeVC.h"
@interface FoodWeiZhanVC () <UITableViewDataSource,UITableViewDelegate,LoopViewDeledate,JMViewDelegate>
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
@end

@implementation FoodWeiZhanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestWeiZhanDetail];
}

- (void)setUpSubView{
    
    self.leftTitle = @"餐饮微站配置";
    
    _keyPathArray = @[
                     @[ShopName],
                     @[FoodMenu,About,Activity,WeiNDH],
                     @[QiangHB,DaZP,GuaGK],
                     @[HotFood],
                     @[YiJFK]
                     ];


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
    PartModel* model = [[self getTempleData:ShopNameStatus] lastObject];
    [model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel* model = (TemplateModel*)obj;
        if (![keys containsObject:model.code]) {
            [self.secondArry addObject:obj];
        }
    }];
    //店铺简介数据
//    PartModel* data = [[self getTempleData:ShangHuJieshao] lastObject];
//    self.fourthlyData = [data.templateModelnameDate.date lastObject];
//    self.fourthlyData.shopFileCellH = [NSString stringWithFormat:@"%.1f",HeightForString(self.fourthlyData.content,14,KScreenWidth - 20)];
//    
    //红包
    self.thirdlyArry = [self getTempleData:HongBaoHongDongStatus].mutableCopy;
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
        case 0:
        {
            NSString* idengfier=@"ADTitleViewCell";
            ADTitleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ADViewCell" owner:nil options:nil] objectAtIndex:2];
            }
            
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
        case 1:
        {
            static NSString *indetify = @"ADImageCell";

            ADImageCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
            
            if (!cell) {

                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:3
                        ];
            }

            ADImageModel* model = [[ADImageModel alloc] init];
            model.titles = @[@"菜单",@"关于我们",@"活动信息",@"为你导航"];
            model.images = @[@"louce01",@"louce02",@"louce03",@"louce04"];
            model.isEdit = YES;

            cell.model = model;
            cell.jView.delegate = self;
            cell.selectionStyle=0;
            return cell;
            
        }
            break;
            
        case 2:
        {
            NSString* idengfier=@"HongBaoCell_ident";
            HongBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[HongBaoCell alloc]initWithStyle:0 reuseIdentifier:idengfier];
                
            }
            cell.model = [self.thirdlyArry objectAtIndex:indexPath.row];
          
            cell.cellType = HongBaoHongDong;
            cell.jView.tag = cell.cellType + 100;
            cell.jView.delegate = self;
            cell.jView2.delegate = self;
            cell.selectionStyle = 0;
            
            return cell;
            
        }
            break;
            
        case 3:
        {
            static NSString *indetify = @"ADViweCell";
            
            ADViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:1];
            }
            
            
            [self.imageArray removeAllObjects];
            for (PartModel* model in self.dataSource.data) {
                if ([model.templateModelnameCode isEqualToString:HotFood] && model.templateModelnameDate) {
                    
                    for (TemplateModel *tempModel in model.templateModelnameDate.date) {
                        
                        [self.imageArray addObject:[NSString stringWithFormat:@"%@%@",ImagePre,tempModel.imgPath]];
                        
                    }
                    TemplateModel *nameModel=[model.templateModelnameDate.date lastObject];
                    cell.title.text = nameModel.name;
                    
                }
            }   
            
            cell.jView.delegate = self;
            cell.loopView.deletate = self;
            if (self.imageArray.count==0) {
                [cell setAdImageWithArray:[NSMutableArray array]];
            }
            else{                
                [cell setAdImageWithArray:self.imageArray];
            }
            

            return cell;
        }
            break;
        case 4:
        {
            static NSString *indetify = @"ADButtonCell";
            
            ADButtonCell* cell = [tableView dequeueReusableCellWithIdentifier:indetify];
         

            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:5];
            }
            cell.jView.delegate = self;
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
            
            TemplateModel *temp = model.templateModelnameDate.date.lastObject;
            temp.status =[NSString stringWithFormat:@"%ld",(NSInteger)![temp.status boolValue]];
//            mol.HB_hidenAtIndex = [NSString stringWithFormat:@"%ld",(NSInteger)![model.HB_hidenAtIndex boolValue]];
            
            NSLog(@"%@",temp.status);
            model.templateModelnameDate.date = @[temp];
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
            return KADViewCellH;
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
           return [self getHidenWith:section] == NO ? 10:20;
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
            return [self getHidenWith:section] == YES? 10:.1f;
        }
            break;
        case 3:
        {
            return .1f;
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
    TemplateModel *temp = mol.templateModelnameDate.date.lastObject;
    return [temp.status boolValue];
}
#pragma mark - loopView delegate
- (void)userDidSelectAtIndex:(NSInteger)index{
    
    
}

#pragma mark - JMView delegate

-(void)userDidSelectIndex:(NSInteger)index inView:(UIView*)view data:(id)data{
    
}

- (void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    NSLog(@"view.tag:%ld",view.tag);
    JMView* jView = (JMView*)view;
    __weak typeof(self) wSelf = self;
    switch (view.tag) {
        case KADTitleViewTag:
        {
            BannerEditVC* vc = [[BannerEditVC alloc] initWithNibName:@"BannerEditVC" bundle:nil block:^(PartModel *model, BOOL isNewData) {
                [wSelf setTempleData:@[model] isNew:isNewData];
                [wSelf.tableView reloadData];

            }];
            vc.isBig = NO;
            vc.templateNo=CanYin;
            NSLog(@">>>%@",[[self getTempleData:ShopNameStatus] lastObject]);
            
            
            vc.model = [[self getTempleData:ShopNameStatus] lastObject];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KADImageTag:
        {
            WZ_EditActivitiesVC* vc = [[WZ_EditActivitiesVC alloc] init];
            vc.templeNo=CanYin;
            vc.dataSource = self.dataSource;
            vc.status = FourButtonStatus;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case KADButtonTag:
        {
            
            QuestionListVC *vc = [[QuestionListVC alloc]initWithNibName:@"QuestionListVC" bundle:nil];
            vc.model = [[self getTempleData:FeedBackIdeaStatus] lastObject];
            vc.isYJFK=YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 102:
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
                    vc.templeId = CanYin;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    vc.models = [self getTempleData:HongBaoHongDongStatus];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = CanYin;
                    vc.model = jView.prams;
                    vc.isEdite=NO;
                    vc.models = [self getTempleData:HongBaoHongDongStatus];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
        }
            break;
        case KADViewTag:
        {
             
            LunBoEditeVC* vc = [[LunBoEditeVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                [wSelf setTempleData:@[model] isNew:isNew];
                [wSelf.tableView reloadData];
            }];
            vc.model = [[self getTempleData:HotFoodStatus] lastObject];
            vc.modelNo=CanYin;
            vc.modelCode=@"hotFood";
            vc.modelName=@"热菜推荐";
            [self.navigationController pushViewController:vc animated:YES];
            
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
//        m.status = [NSString stringWithFormat:@"%ld",(NSInteger)isShow];
        NSMutableArray* temp = [NSMutableArray array];
        [temp addObject:m];
        model.templateModelnameDate.date = temp.copy;
    }
    m = model.templateModelnameDate.date.lastObject;
//    m.status = [NSString stringWithFormat:@"%ld",(NSInteger)isShow];
    
    [self saveTemplte:@[model].mutableCopy succeed:^(id responseObject) {
        
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

-(NSMutableArray*)getTempleData:(FoodWeiZhanStatus)type{
    
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
    [params setObject:CanYin forKey:@"templateNo"];
    
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

            
            
            [self saveTemple:CanYin andshopName:_shopName];
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
