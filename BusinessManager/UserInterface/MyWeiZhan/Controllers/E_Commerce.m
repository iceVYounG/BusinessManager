//
//  E_Commerce.m
//  BusinessManager
//
//  Created by 王启明 on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "E_Commerce.h"
#import "E_CommerceCell.h"
#import "WeiZhanModel.h"
#import "EC_TitleEdtitng.h"
#import "EC_ProductRelatedVC.h"
#import "BannerEditVC.h"
#import "EC_ProductActivityVC.h"
#import "EditHongBaoVC.h"
#import "EC_HeadReuseableView.h"
#define kWidth_scale [UIScreen mainScreen].bounds.size.width/375.0
@interface E_Commerce ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMViewDelegate>{
  
}
@property (nonatomic,strong)UICollectionView *myCo;
@property (nonatomic,strong)NSArray *keyPathArray;
@property (nonatomic,strong)NSMutableArray *sectionHTitleArr;//区头标题
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)ADImageModel *imageModel;
@property (nonatomic,strong)SearPartData *dataSource;
@property (nonatomic,strong)SaveView *saveV;
@property (nonatomic,strong)NSMutableArray *activityArr;
@property (nonatomic,strong)TemplateModel *tempModel;
@property (nonatomic,assign)  BOOL isHaveWNDH;
@property (nonatomic,strong)NSString *shopName;


@end

@implementation E_Commerce

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"电商微站配置";
    _keyPathArray=@[
                    @[ShopName],
                    @[LiaoJWM,WeiNTJ,LianXWM,WeiNDH],
                    @[LunBT],
                    @[QiangHB,DaZP,GuaGK],
                    @[LouCY],
                    @[LouCE]
                    ];
   
    [self.view addSubview:self.myCo];
    [self requestWeiZhanDetail];

 
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark-privateMethods


- (BOOL)getRowCount:(EC_commerceStatue)type{
    
    NSArray* tArr = [_keyPathArray objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr containsObject:model.templateModelnameCode]) {
            return YES;
          
        }
    }
    return NO;
}

-(void)settingHiden:(PartModel*)model{
    
    for (PartModel* mol in self.activityArr) {
        
        if ([mol.templateModelnameCode isEqualToString:model.templateModelnameCode]) {
            //            mol.HB_hidenAtIndex = [NSString stringWithFormat:@"%ld",(NSInteger)![model.HB_hidenAtIndex boolValue]];
            TemplateModel *temp = [model.templateModelnameDate.date lastObject];
            temp.status =[NSString stringWithFormat:@"%ld",(NSInteger)![temp.status boolValue]];
            break;
        }
    }
    [self.myCo reloadData];
}

- (BOOL)getHidenWith:(NSInteger)row{
    
    if (row >= self.activityArr.count) {
        return NO;
    }
    PartModel* mol = [self.activityArr objectAtIndex:row];
    TemplateModel *temp =[mol.templateModelnameDate.date lastObject];
    return [temp.status boolValue];
}

#pragma mark-collectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    PartModel *model=nil;
    switch (section) {
        case 0:
        case 2:
        case 1:
            return 1;
        case 3:
            return self.activityArr.count==0?1:self.activityArr.count;
        case 4:{
            model=[[self getTempleData:LouYStatus] lastObject];
            return model.templateModelnameDate.date.count>0?model.templateModelnameDate.date.count:4;
        }
    
        case 5:{
            model=[[self getTempleData:LouEStatus] lastObject];
            return model.templateModelnameDate.date.count>0?model.templateModelnameDate.date.count:2;
        }
           
        default:
            return 0;
    }
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PartModel *model=nil;
    switch (indexPath.section) {
        case 0:{
            ECShopNameCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ECShopNameCell" forIndexPath:indexPath];
//            model=[[self getTempleData:BannerStatus] lastObject];
//            cell.model=[model.templateModelnameDate.date lastObject];
            
            
            for (PartModel* model in self.dataSource.data) {
                if ([model.templateModelnameCode isEqualToString:ShopName] && model.templateModelnameDate) {
                    TemplateModel *nameModel=[model.templateModelnameDate.date lastObject];
                    _shopName = nameModel.name;
                    cell.model = [model.templateModelnameDate.date lastObject];
                    
                }
            }
            cell.jView.delegate=self;
            return cell;
            
        }
        case 1:{
            ECBtnCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ECBtnCell" forIndexPath:indexPath];
            cell.model=self.imageModel;
            cell.jView.delegate=self;
            return cell;
        }
        case 2:{
            ECImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ECImageCell" forIndexPath:indexPath];
            model=[[self getTempleData:LunBoStatus] lastObject];
            if (model.templateModelnameDate.date.count > 0) {
            cell.imgeArr=[model.templateModelnameDate.date mutableCopy];
            }
            cell.jView.delegate=self;
            return cell;
        }
        case 4:{
            ECProductorCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ECProductorCell" forIndexPath:indexPath];
            model=[[self getTempleData:LouYStatus] lastObject];
            if (model.templateModelnameDate.date.count>0) {
                cell.model=model.templateModelnameDate.date[indexPath.row];
            }else{
            
                cell.model=self.tempModel;
            }
            return cell;
        }
            
        case 5:{
            ECProductorCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ECProductorCell" forIndexPath:indexPath];
            model=[[self getTempleData:LouEStatus] lastObject];
            if (model.templateModelnameDate.date.count>0) {
                cell.model=model.templateModelnameDate.date[indexPath.row];
            }else{
                cell.model=self.tempModel;
            }
            return cell;
        }
        case 3:{
           
            ECHongBaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ECHongBaoCell" forIndexPath:indexPath];
            cell.model = self.activityArr[indexPath.row] ;
            cell.cellType=1;
            cell.jView.tag = 103;
            cell.jView.delegate = self;
            cell.jView2.delegate = self;
            return cell;
        
        
        
        }
        default:
            break;
    }

    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    EC_HeadReuseableView *head=nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        head =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        head.backgroundColor=[UIColor whiteColor];
        head.jview.delegate=self;
    }else{
        UICollectionReusableView *foot=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
      
        [foot addSubview:self.saveV];
        return foot;

    }
    head.titlelab.text=self.sectionHTitleArr[indexPath.section];
    head.jview.tag=indexPath.section+100;
    return head;
}
#pragma mark-collectionDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==2||section==4||section==5) {
        return CGSizeMake(KScreenWidth, 40*kWidth_scale);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==5) {
         return CGSizeMake(KScreenWidth, 90*kWidth_scale);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
           return CGSizeMake(KScreenWidth, KShopNameCellHeight);
        case 1:
            return CGSizeMake(KScreenWidth, KBtnCellHeight);
        case 2:
            return CGSizeMake(KScreenWidth, KImageCellHeight);
        case 3:{
            switch (indexPath.row) {
                case 0:
                    return CGSizeMake(KScreenWidth, [self getHidenWith:indexPath.row]==YES?kHongBaoCellH:JMViewH);
                 case 1:
                    return CGSizeMake(KScreenWidth, [self getHidenWith:indexPath.row]==YES?kHongBaoCellH:JMViewH);
                 case 2:
                    return CGSizeMake(KScreenWidth, [self getHidenWith:indexPath.row]==YES?kHongBaoCellH:JMViewH);
                default:
                    break;
            }
//            return [CGSizeMake(KScreenWidth, [self getHidenWith:indexPath]);
            
                    }
        case 5:
        case 4:
            return CGSizeMake((KScreenWidth-KSpace)/2.0, KProductorCellHeight);
        
    }
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section==4||section==5) {
        return KSpace;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==5||section==4) {
        return KSpace;
    }
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==5) {
        return UIEdgeInsetsMake(0, 0, 20*kWidth_scale, 0);
    }
    return UIEdgeInsetsMake(0, 0, 15*kWidth_scale, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
   
}

-(void)userDidSelectIndex:(NSInteger)index inView:(UIView*)view data:(id)data{
    
}

- (void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    NSLog(@"view.tag:%ld",view.tag);
    JMView* jView = (JMView*)view;
    __weak typeof(self) wSelf = self;
    switch (view.tag) {
        case 100:
        {
            BannerEditVC* vc = [[BannerEditVC alloc] initWithNibName:@"BannerEditVC" bundle:nil block:^(PartModel *model, BOOL isNewData) {
                [wSelf setTempleData:@[model] isNew:isNewData];
                [wSelf.myCo reloadSections:[NSIndexSet indexSetWithIndex:0]];
                
            }];
            vc.isDianShang=YES;
            vc.templateNo=DianShang;
            vc.model = [[self getTempleData:BannerStatus] lastObject];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 101:
        {
            EC_ProductActivityVC* vc = [[EC_ProductActivityVC alloc] init];
            vc.dataSource = self.dataSource;
            vc.status = FourButtonStatus;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
    
        case 102:
        {
            NSLog(@"%@",@(102));
            EC_TitleEdtitng *vc=[[EC_TitleEdtitng alloc]init];
             __weak typeof(self) wSelf = self;
            vc.dataBack=^(NSString *str,PartModel *model,BOOL isNewData){
            [wSelf.sectionHTitleArr replaceObjectAtIndex:2 withObject:str];
            [wSelf setTempleData:@[model] isNew:isNewData];
            [wSelf.myCo reloadSections:[NSIndexSet indexSetWithIndex:2]];
            };
            vc.dataSource=[[self getTempleData:LunBoStatus] lastObject];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 103:
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
                    
                case 1:{  //编辑
                    
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.myCo reloadData];
                    }];
                    vc.templeId = DianShang;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    vc.models = [self getTempleData:HongBaoStatus];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                    break;
                default:{
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.myCo reloadData];
                    }];
                    vc.templeId = DianShang;
                    vc.model = jView.prams;
                    vc.isEdite=NO;;
                    vc.models = [self getTempleData:HongBaoStatus];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }

        }
            break;
            
        case 104:{
             NSLog(@"%@",@(104));
            __weak typeof(self) wSelf = self;
            EC_ProductRelatedVC *vc=[[EC_ProductRelatedVC alloc]init];
            vc.titleName=@"商品配置";
            vc.isRelated=NO;
            vc.type=LouCY;
            vc.data=^(NSString *title,PartModel *model,BOOL isNewData){
            [wSelf.sectionHTitleArr replaceObjectAtIndex:4 withObject:title];
                [wSelf setTempleData:@[model] isNew:isNewData];
                [wSelf.myCo reloadSections:[NSIndexSet indexSetWithIndex:4]];
            };
            vc.dataSource=[[self getTempleData:LouYStatus] lastObject];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 105:{
             NSLog(@"%@",@(105));
            EC_ProductRelatedVC *vc=[[EC_ProductRelatedVC alloc]init];
            vc.titleName=@"商品配置";
            vc.isRelated=NO;
            vc.type=LouCE;
            vc.data=^(NSString *title,PartModel *model,BOOL isNewData){
                [wSelf.sectionHTitleArr replaceObjectAtIndex:5 withObject:title];
                [wSelf setTempleData:@[model] isNew:isNewData];
                [wSelf.myCo reloadSections:[NSIndexSet indexSetWithIndex:5]];
            };
              vc.dataSource=[[self getTempleData:LouEStatus] lastObject];
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
        default:
            break;
    }
}

#pragma mark-保存模板
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

-(NSMutableArray*)getTempleData:(EC_commerceStatue)type{
    
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
    WS(weakSelf)
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:DianShang forKey:@"templateNo"];
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        if([responseObject[@"code"]isEqualToString:@"00-00"]){
            if (responseObject) {
                weakSelf.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
                [weakSelf.myCo reloadData];
            }
        }
    } showHUD:YES];
    
}



#pragma mark-getter&&setter
- (UICollectionView *)myCo{
    if (!_myCo) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        _myCo=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-NavigationH) collectionViewLayout:layout];
        [_myCo registerClass:[ECShopNameCell class] forCellWithReuseIdentifier:@"ECShopNameCell"];
        [_myCo registerClass:[ECBtnCell class] forCellWithReuseIdentifier:@"ECBtnCell"];
        [_myCo registerClass:[ECImageCell class] forCellWithReuseIdentifier:@"ECImageCell"];
        [_myCo registerClass:[ECProductorCell  class] forCellWithReuseIdentifier:@"ECProductorCell"];
        [_myCo registerClass:[ECHongBaoCell class] forCellWithReuseIdentifier:@"ECHongBaoCell"];
        [_myCo registerClass:[EC_HeadReuseableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_myCo registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        _myCo.backgroundColor=[UIColor colorWithHexString:@"#f5f4f9"];
        _myCo.delegate=self;
        _myCo.dataSource=self;
    }
    return _myCo;
}

- (NSMutableArray *)sectionHTitleArr{
    if (!_sectionHTitleArr) {
        _sectionHTitleArr=[[NSMutableArray alloc]init];
        for (int i=0; i<6; i++) {
            [_sectionHTitleArr addObject:@"配置标题"];
        }
    }
    return _sectionHTitleArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    return _dataArr;
}


- (SaveView *)saveV{
    if (!_saveV) {
        WS(weakSelf)
        _saveV=[[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:NO block:^{


            for (PartModel*model in weakSelf.dataSource.data) {
                if ([model.templateModelnameCode isEqualToString:@"wndh"]) {
                   weakSelf.isHaveWNDH =YES;
                    break ;
                }
                else{
                    weakSelf.isHaveWNDH =NO;
                }
            }
            if (!weakSelf.isHaveWNDH) {
                [OMGToast showWithText:@"请编辑为你导航后保存"];
                return ;
            }
 
            PartModel *model=[[weakSelf getTempleData: BannerStatus]lastObject];
            NSString *name=[[model.templateModelnameDate.date lastObject] name];
            [weakSelf saveTemple:DianShang andshopName:_shopName];
        }];
    }
    return _saveV;
}

- (ADImageModel *)imageModel{
    if (!_imageModel) {
        _imageModel=[[ADImageModel alloc]init];
        _imageModel.images=@[@"60",@"65",@"61",@"66"];
        _imageModel.titles=@[@"了解我们",@"为您推荐",@"联系我们",@"为您导航"];
        _imageModel.isEdit=YES;
    }
    return _imageModel;
}



- (void)setDataSource:(SearPartData *)dataSource{
    _dataSource = dataSource;

    //红包
    if (!_activityArr) {
        _activityArr = [NSMutableArray array];
    }else{
        [self.activityArr removeAllObjects];
    }
   
    self.activityArr = [self getTempleData: HongBaoStatus];
    if (self.activityArr.count == 0) {
        
        PartModel*model = [[PartModel alloc]init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelnameCode = QiangHB;
        TemplateModelData* data = [[TemplateModelData alloc]init];
        TemplateModel* item = [[TemplateModel alloc]init];
        data.date = @[item];
        model.templateModelnameDate = data;
        [self.activityArr addObject:model];
    }
    WS(weakSelf)
    [dataSource.data enumerateObjectsUsingBlock:^(PartModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.templateModelnameCode isEqualToString:LunBT]) {
            [weakSelf.sectionHTitleArr replaceObjectAtIndex:2 withObject:obj.templateModelname];
        }
        if ([obj.templateModelnameCode isEqualToString:LouCE]) {
            [weakSelf.sectionHTitleArr replaceObjectAtIndex:5 withObject:obj.templateModelname];
        }
        if ([obj.templateModelnameCode isEqualToString:LouCY]) {
            [weakSelf.sectionHTitleArr replaceObjectAtIndex:4 withObject:obj.templateModelname];
        }
    }];
  
}

- (void)dealloc{
    NSLog(@"asdasda");
}

- (TemplateModel *)tempModel{
    if (!_tempModel) {
        _tempModel=[[TemplateModel alloc]init];
        _tempModel.imgPath=nil;
        _tempModel.shopPrice=@"15.9";
        _tempModel.shortName=@"三只松鼠_小贱牛肉粒100克";
    }
    return _tempModel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end