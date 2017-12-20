//
//  WC_GeneralVC.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WC_GeneralVC.h"
#import "GenealWeiZhanCell.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "LocationService.h"
#import "TY_TitleEditVC.h"
#import "WCG_ShopServicevc.h"
#import "EditHongBaoVC.h"
#import "EditShopProfileVC.h"

@interface WC_GeneralVC ()<JMViewDelegate>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* keyPathArry;
@property(nonatomic,strong)SearPartData* dataSource;
@property(nonatomic,strong)NSMutableArray* secondArry; //第二组--商铺服务信息
@property(nonatomic,strong)NSMutableArray* thirdlyArry; //第三组--红包
@property(nonatomic,strong)TemplateModel* fourthlyData;
@property(nonatomic,strong)NSString *storName;
@end

@implementation WC_GeneralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用微站配置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self requestMyWeiZhanData];
    
    _keyPathArry = @[
                     @[ShopName],
                     @[ShopService],
                     @[QiangHB,DaZP,GuaGK],
                     @[ShopDetail]
                     ];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self requestMyWeiZhanData];
}

@synthesize dataSource = _dataSource;
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
    //商户名称
    PartModel* firstData = [[self getTempleData:WeiZhanName] lastObject];
    [firstData.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel*model = (TemplateModel*)obj;
        _storName=model.name;
    
    }];

    
    
    
    //服务介绍数据
    PartModel* model = [[self getTempleData:WeiZhanDetail] lastObject];
    [model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel*model = (TemplateModel*)obj;
        if (![KeysArry containsObject:model.code]) {
            [self.secondArry addObject:obj];
        }
    }];
    if (self.secondArry.count == 0) {
        NSString* jsonStr = DefaultStr();
        NSArray* arr = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        for (NSDictionary* dic in arr) {
            TemplateModel* model = [TemplateModel mj_objectWithKeyValues:dic];
            [self.secondArry addObject:model];
        }
        
    }
    //店铺简介数据
    PartModel* data = [[self getTempleData:ShangHuJieshao] lastObject];
    self.fourthlyData = [data.templateModelnameDate.date lastObject];
    self.fourthlyData.shopFileCellH = [NSString stringWithFormat:@"%.1f",HeightForString(self.fourthlyData.content,14,KScreenWidth - 20)];
    
    //红包
    self.thirdlyArry = [self getTempleData:HongBaoHongDong].mutableCopy;
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

#pragma mark - TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 1:{
            return self.secondArry.count;
        }
            break;
        case 2:{
            return self.thirdlyArry.count == 0 ? 1 : self.thirdlyArry.count;
        }
            break;
        default:{
        
            return 1;
        }
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:{
            
            NSString* idengfier=@"EditingTitleCell_ident";
            EditingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"GenealWeiZhanCell" owner:nil options:nil] objectAtIndex:1];
            }
            cell.cellType = WeiZhanName;
            cell.jView.tag = cell.cellType + 100;
            cell.jView.delegate = self;
            
            
            cell.weizhanName.text=_storName;
            
            return cell;
        }
            break;
        case 1:{
            
            NSString* idengfier=@"DetailInfoCell_ident";
            DetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"GenealWeiZhanCell" owner:nil options:nil] objectAtIndex:2];
            }
            cell.cellType = WeiZhanDetail;
            if (indexPath.row == 0) {
                [cell addEditingSender];
                cell.jView.tag = cell.cellType + 100;
                cell.jView.delegate = self;
                cell.jView.hidden = NO;
            }else if(cell.jView){
            
                cell.jView.hidden = YES;
            }
            
            cell.model = [self.secondArry objectAtIndex:indexPath.row];
            return cell;
        }
            break;
        case 2:{
            
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
        case 3:{
            
            NSString* idengfier=@"BusinessDetail_ident";
            BusinessDetail *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[BusinessDetail alloc]initWithStyle:0 reuseIdentifier:idengfier];
            }
            cell.cellType = ShangHuJieshao;
            cell.jView.tag = cell.cellType + 100;
            cell.jView.delegate = self;
            cell.model = self.fourthlyData;
            return cell;
        }
            break;
        case 4:{
            
            NSString* idengfier=@"CallSenderCell_ident";
            CallSenderCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"GenealWeiZhanCell" owner:nil options:nil] objectAtIndex:3];
            }
            cell.cellType = YiJianHuJiaoFuWu;
            cell.jView.tag = cell.cellType + 100;
            cell.jView.delegate = self;
            
            return cell;
        }
            break;

        default:
            break;
    }

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:{
            return kEditingTitleCellH;
        }
            break;
        case 1:{
            return kDetailInfoCellH;
        }
            break;
        case 2:{
            return [self getHidenWith:indexPath.row] == YES ? kHongBaoCellH : JMViewH;
        }
            break;
        case 3:{
            return kDetailContentH + 21 + [self.fourthlyData .shopFileCellH floatValue ];
        }
            break;
        case 4:{
            return kCallSenderCellH;
        }
            break;
        default:{
            return 0;
        }
            break;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    switch (section) {
        case 0:{
            return 0;
        }
            break;
        default:{
            
            return 10;
        }
            break;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

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

#pragma mark - Request
-(void)requestMyWeiZhanData{
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [prams setObject:Tongyong forKey:@"templateNo"];
    
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:prams succeed:^(id responseObject) {
        
        self.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
        NSLog(@">>>%@",self.dataSource.data);
        
        
        [self.tableView reloadData];
        
    } showHUD:YES];
    
}
#pragma mark - 保存模板
-(void)requestSave{
    
    [self saveTemple:Tongyong andshopName:_storName];
}

-(void)requestChangeShowStatu:(BOOL)isShow data:(PartModel*)model callBack:(void(^)())callBack{

    if (!model) {
        return;
    }
    TemplateModel* m = model.templateModelnameDate.date.lastObject;
    if (isShow) {
        m.status=@"1";
    }
    else{
        m.status=@"0";
    }
//    m.status = [NSString stringWithFormat:@"%ld",(NSInteger)isShow];
    
    [self saveTemplte:@[model].mutableCopy succeed:^(id responseObject) {
        
        if (callBack) {
            callBack();
        }
    } error:nil];
}

-(NSMutableArray*)getTempleData:(JMCellType)type{
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSArray* tArr = [_keyPathArry objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr containsObject:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    return targetArr;
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
    [self setDataSource:_dataSource];
}


#pragma mark - 编辑代理
-(void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    
    JMView* jView = (JMView*)view;
    
    __weak typeof(self) wSelf = self;
    switch (view.tag - 100) {
        case WeiZhanName:{
        
        TY_TitleEditVC* vc = [[TY_TitleEditVC alloc]initWithBlock:^(PartModel* model,BOOL isNewData) {
            NSLog(@"%@--%c",model,isNewData);
            
            [wSelf setTempleData:@[model] isNew:isNewData];
//            [wSelf getTempleData:WeiZhanName];
            [wSelf.tableView reloadData];
        }];
        vc.model = [[self getTempleData:WeiZhanName] lastObject];
            NSLog(@">>>>%@",vc.model);
            
        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WeiZhanDetail:{
           
            WCG_ShopServicevc *vc = [[WCG_ShopServicevc alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                 [wSelf setTempleData:@[model] isNew:isNew];
                 [wSelf.tableView reloadData];
            }];
            vc.model = [[self getTempleData:WeiZhanDetail] lastObject];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HongBaoHongDong:{
            
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
                    
                    
                case 1:{  //编辑
                    
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = Tongyong;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    NSLog(@"vc==%@--jv==%@",vc.model.templateModelnameCode,jView.prams);
                    
                    vc.models = [self getTempleData:HongBaoHongDong];
                    [self.navigationController pushViewController:vc animated:YES];
                
                
                }
                    break;
                default:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = Tongyong;
                    vc.model = jView.prams;
                    vc.isEdite=NO;
                    NSLog(@"vc==%@--jv==%@",vc.model.templateModelnameCode,jView.prams);
                    
                    vc.models = [self getTempleData:HongBaoHongDong];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
        }
            break;
        case ShangHuJieshao:{
            
            EditShopProfileVC* vc = [[EditShopProfileVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                [wSelf setTempleData:@[model] isNew:isNew];
                [wSelf.tableView reloadData];
            }];
              vc.model = [[self getTempleData:ShangHuJieshao] lastObject];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 566:{
            if ([(TemplateModel*)[[[(PartModel*)jView.prams templateModelnameDate] date] lastObject] id] == nil) {
                [self settingHiden:jView.prams];
                return;
            }
            [self settingHiden:jView.prams];

            [self requestChangeShowStatu:YES data:jView.prams callBack:^{
                
//                 [self settingHiden:jView.prams];
            }];
        }
            break;
        default:
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
-(void)settingHiden:(PartModel*)model{
    
    for (PartModel* mol in self.thirdlyArry) {
        
        if ([mol.templateModelnameCode isEqualToString:model.templateModelnameCode]) {
            //            mol.HB_hidenAtIndex = [NSString stringWithFormat:@"%ld",(NSInteger)![model.HB_hidenAtIndex boolValue]];
            TemplateModel *temp = [model.templateModelnameDate.date lastObject];
            temp.status =[NSString stringWithFormat:@"%ld",(NSInteger)![temp.status boolValue]];
            break;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 初始化

-(UITableView *)tableView{

    if (!_tableView) {
        
        __weak typeof(self) wSelf = self;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:0];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = 0;
        _tableView.tableFooterView = [[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:NO block:^{
            
            [wSelf requestSave];
        }];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(SearPartData *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [[SearPartData alloc] init];
    }
    return _dataSource;
}

@end
