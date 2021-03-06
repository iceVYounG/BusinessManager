//
//  HouseWeiZhanVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/8/3.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HouseWeiZhanVC.h"
#import "JMView.h"
#import "ADViewCell.h"
#import "BannerEditVC.h"
#import "WZ_EditActivitiesVC.h"
#import "weizhanModel.h"
#import "EditHongBaoVC.h"
#import "GenealWeiZhanCell.h"
@interface HouseWeiZhanVC () <UITableViewDataSource,UITableViewDelegate,JMViewDelegate>{
    BOOL _isHaveWNDH;

}

@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) SearPartData* dataSource;
@property (nonatomic, strong)NSArray* keyPathArray;
@property (nonatomic, strong)NSMutableArray *thirdlyArry;
@property (nonatomic, assign)NSInteger HBrow;
@property (nonatomic, strong)UIView *footView;

@property (nonatomic, strong)NSString *shopName;
@end

@implementation HouseWeiZhanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"房产微站配置";
    _keyPathArray = @[
                      @[ShopName],
                      @[LiaoJWM,WeiNDH],
                      @[QiangHB,DaZP,GuaGK]
                      ];
    
    [self requestWeiZhanDetail];
    [self tableView];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requestWeiZhanDetail];
    [self.tableView reloadData];
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



-(NSMutableArray*)getTempleData:(HouseWeiZhanStatus)type{
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSArray* tArr = [_keyPathArray objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr containsObject:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    return targetArr;
}


#pragma mark - tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 1;
    }
    
    return self.thirdlyArry.count == 0 ? 1 : self.thirdlyArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *indetify = @"PropertyCell";
        PropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:indetify];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ADViewCell class]) owner:nil options:nil] objectAtIndex:6];
        }
        cell.selectionStyle=0;
        
        for (PartModel* model in self.dataSource.data) {
            if ([model.templateModelnameCode isEqualToString:ShopName] && model.templateModelnameDate) {
                
                NSLog(@"%@",[model.templateModelnameDate.date lastObject]);
                
                cell.model = [model.templateModelnameDate.date lastObject];
                TemplateModel *imageModel=[model.templateModelnameDate.date lastObject];
                _shopName = imageModel.name;
                if (imageModel.imgPath) {
                    NSString* imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,imageModel.imgPath];
                    
                    UIImageView *imageView=[[UIImageView alloc]init];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"house"]];
                    
                    self.tableView.backgroundView=imageView;
                    
                }
                
            }
        }
        cell.jView.delegate = self;
        cell.jView2.delegate = self;
        return cell;

    }
    else{
    
        NSString* idengfier=@"HongBaoCell_ident";
        HongBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
        if (!cell) {
            cell = [[HongBaoCell alloc]initWithStyle:0 reuseIdentifier:idengfier];
        }
        cell.backgroundColor=[UIColor clearColor];
        cell.model = [self.thirdlyArry objectAtIndex:indexPath.row];
        cell.cellType = HongBaoHongDong;
        cell.jView.tag = cell.cellType + 100;
        cell.jView.delegate = self;
        cell.jView2.delegate = self;
        cell.selectionStyle = 0;
        return cell;
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


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
        _HBrow=indexPath.row;
        return [self getHidenWith:indexPath.row] == YES ? kHongBaoCellH : JMViewH;
    }
    return KADPropertyCellH;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - JMView delegate
- (void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    
    JMView* jView = (JMView*)view;

    
    __weak typeof(self) wSelf = self;
    switch (view.tag) {
        case 899:
        {
            BannerEditVC* vc = [[BannerEditVC alloc] initWithNibName:@"BannerEditVC" bundle:nil block:^(PartModel* model,BOOL isNewData) {
                [wSelf setTempleData:@[model] isNew:isNewData];
                [wSelf.tableView reloadData];
            }];
            NSLog(@">>>%@",[[self getTempleData:HouseShopNameStatus] lastObject]);
              vc.model = [[self getTempleData:HouseShopNameStatus] lastObject];
            vc.isBig = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
            case 990:
        {
            WZ_EditActivitiesVC* vc = [[WZ_EditActivitiesVC alloc] init];
            vc.templeNo=FangChan;
            vc.dataSource = self.dataSource;
            vc.status = SixButtonStatus;
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
//                     [self settingHiden:jView.prams];
                    }];
                    
                    
                }
                    break;
                    
                case 1:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = FangChan;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    vc.models = [self getTempleData:HouseHongBaoHongDongStatus];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;

                default:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.tableView reloadData];
                    }];
                    vc.templeId = FangChan;
                    vc.model = jView.prams;
                    vc.isEdite=NO;
                    vc.models = [self getTempleData:HouseHongBaoHongDongStatus];
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


#pragma mark - netWork request

- (void)requestWeiZhanDetail{//请求房产模板下的详情
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:FangChan forKey:@"templateNo"];
    
    
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        
        self.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
        
        [self.tableView reloadData];
        
    } showHUD:YES];
}


@synthesize tableView = _tableView,dataSource = _dataSource;
-(void)setDataSource:(SearPartData *)dataSource{
    _dataSource = dataSource;
    
       if (!_thirdlyArry) {
        _thirdlyArry = [NSMutableArray array];
    }else{
        [self.thirdlyArry removeAllObjects];
    }
    //商户名称
    PartModel* firstData = [[self getTempleData:HouseShopNameStatus] lastObject];
    [firstData.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel*model = (TemplateModel*)obj;
        
        
    }];
    
    
    
    
      self.thirdlyArry = [self getTempleData:HouseHongBaoHongDongStatus].mutableCopy;
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





- (UITableView *)tableView{
    
    CGFloat tabHeight=([self getHidenWith:_HBrow] == YES ? JMViewH : kHongBaoCellH)*(self.thirdlyArry.count == 0 ? 1 : self.thirdlyArry.count)+KADPropertyCellH;
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, tabHeight+20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView.backgroundColor=[UIColor whiteColor];
//        _tableView.tableFooterView = [[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:NO block:^{
//            
//            [self saveTemple:FangChan];
//        }];
        
        UIImageView *imageView=[[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:@"house"]];
        self.tableView.backgroundView=imageView;

        _footView = [[SaveView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+25, KScreenWidth, 90) tipHiden:NO block:^{
            NSLog(@">>>%@",self.dataSource.data);
            
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

            
            [self saveTemple:FangChan andshopName:_shopName];
        }];
        [self.scrollView addSubview:_footView];

        
        
        [self.scrollView addSubview:_tableView];
    }
   CGRect frame= _tableView.frame;
    frame.size.height=tabHeight+20;
    _tableView.frame=frame;
    
    
    CGRect frame2= _footView.frame;
    frame2.origin.y=CGRectGetMaxY(_tableView.frame)+35;
    _footView.frame=frame2;
    
    if (CGRectGetMaxY(_footView.frame)+50>SCREEN_SIZE.height) {
         _scrollViewHeight.constant=CGRectGetMaxY(_footView.frame)+50-SCREEN_SIZE.height;
    }
    else{
    
     _scrollViewHeight.constant=0;
    }
   
    return _tableView;
}

- (SearPartData *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[SearPartData alloc] init];
    }
    
    return _dataSource;
}

@end
