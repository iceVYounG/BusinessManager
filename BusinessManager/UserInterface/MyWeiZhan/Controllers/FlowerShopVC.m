//
//  FlowerShopVC.m
//  BusinessManager
//
//  Created by 王启明 on 16/9/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FlowerShopVC.h"
#import "JMView.h"
#import "FlowerShopCell.h"
#import "E_CommerceCell.h"
#import "WZ_AddNewFloorVCViewController.h"
#import "EditHongBaoVC.h"
#import "CustomCollectionHeader.h"
#import "ChangeDoorImageVC.h"
#import "LunBoEditeVC.h"
#import "CustomRegistAlertView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入联想搜索的头文件
#import "StringHelper.h"
#import "MyWeiZhanVC.h"
#define kWidth_scale [UIScreen mainScreen].bounds.size.width/375.0
@interface FlowerShopVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMViewDelegate,getAdressPtDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate>
{
    BMKPoiSearch* _poisearch;
    CLLocationCoordinate2D cllpt;
    NSString *isNewData;
    dispatch_source_t timer;
    int dIndex;

    /*是否正在保存默认数据*/
    BOOL isSavingMoRenData;
    /*是否正在查找默认数据*/
    BOOL isSearchMoRenData;
    
    NSString *ISTEXTData;

}

@property (nonatomic,strong)UICollectionView *myCo;
@property (nonatomic,strong)SaveView *saveV;
@property (nonatomic,strong)SearPartData *dataSource;
@property (nonatomic,strong)NSArray *keypathArray;
@property (nonatomic,strong)NSMutableArray *activityArr;
@property (nonatomic,assign)NSInteger Section;
@property (nonatomic,strong)NSMutableArray *rowCountArray;
@property (nonatomic,strong)NSMutableArray *sectionTitleArr;
@property (nonatomic,strong)CustomRegistAlertView *Alert;
@property (nonatomic,strong)NSMutableArray *searchArray;
@property (nonatomic,strong)UITableView *addressTableView;
@property (nonatomic,strong)NSString *getSMSCode;
@property (nonatomic,strong)NSString *linkPhone;
@property (nonatomic,strong)FlowerAddressModel *tempModel;
@property (nonatomic,strong)NSString *bannerImagePath;
@end

@implementation FlowerShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keboardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quick:) name:@"MainVC" object:nil];
    self.title=self.titleStr;
    _keypathArray=@[@[DianPBanner],@[DianPMessage],@[ReMTJ],@[QiangHB,DaZP,GuaGK],@[LOUC]];
    [self myCo];
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate=self;
    isNewData=@"0";
    isSavingMoRenData = NO;
    isSearchMoRenData = NO;
     ISTEXTData=@"0";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _poisearch.delegate = self;

    [self requestWeiZhanDetail];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _poisearch.delegate = nil;

    if (timer) {
         dispatch_source_cancel(timer);
    }
}
#pragma mark-privateMethod

- (void)quick:(NSNotification *)note{
    int index=[note.object intValue];
    switch (index) {
        case 0:{
         
        }
            break;
        case 1:{
           self.isFlower=@"1";
            [self ShopInfoDataupload:self.tempModel];
        }
            break;
        default:
            break;
    }


}

- (void)keboardShow{
    if (self.Alert) {
        UIView *view=[self.Alert viewWithTag:30];
        WS(weakSelf)
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            view.center=CGPointMake(weakSelf.Alert.centerX, weakSelf.Alert.centerY-120);
            view.bounds=CGRectMake(0, 0,KScreenWidth*0.9, 290);
        } completion:nil];
    }

}

- (void)keyboardHide{
    if (self.Alert) {
        UIView *view=[self.Alert viewWithTag:30];
        WS(weakSelf)
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            view.center=CGPointMake(weakSelf.Alert.centerX, weakSelf.Alert.centerY);
            view.bounds=CGRectMake(0, 0,KScreenWidth*0.9, 290);
        } completion:nil];
    }

}

//验证商户



//发送验证码
-(void)sendSmsCode:(UITextField *)textField :(UIButton *)btn{
    WS(weakSelf)
    //判断11位手机号码
    if ([textField.text length] == 11 && [textField.text judgeTelephone]) {
        [self beginTimer:btn];
        NSMutableDictionary *manger = [NSMutableDictionary dictionary];
        [manger setObject:textField.text forKey:@"linkPhone"];
        self.linkPhone=textField.text;
        [[MallNetManager share]request:API_SmsCodeHost parameters:manger success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"00-00"]) {
                [OMGToast showWithText:@"发送成功！"];
                weakSelf.getSMSCode=responseObject[@"data"][@"smsCode"];
            }
            
            else{
                
                [OMGToast showWithText:@"发送失败！"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
           [OMGToast showWithText:@"服务器忙，请稍后再试！"];
        }];        
    }
    
    else{
        
        [OMGToast showWithText:@"请输入正确的11位手机号码"];
    }
    
}


-(NSMutableArray*)getTempleData:(FlowerShopStatus)type{
    
    NSMutableArray* targetArr = [NSMutableArray array];
    
    NSArray* tArr = [_keypathArray objectAtIndex:type];
    
    for (PartModel*model in self.dataSource.data) {
        
        if ([tArr containsObject:model.templateModelnameCode]) {
            
            [targetArr addObject:model];
        }
    }
    return targetArr;
}

//获取总共区的个数和每个楼层的row个数
- (void)getSectionCount{
    WS(weakSelf)

    PartModel *model=[[self getTempleData: floorStatus] lastObject];
    if (model) {
        if ([model.templateModelnameDate.date count]!=0) {
           self.Section=model.templateModelnameDate.date.count+4;
            [self.rowCountArray removeAllObjects];
            [model.templateModelnameDate.date enumerateObjectsUsingBlock:^(TemplateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakSelf.rowCountArray addObject:obj.items];
            }];
        }else{
            self.Section=5;
        }
    }
    [self.rowCountArray removeAllObjects];
    [model.templateModelnameDate.date enumerateObjectsUsingBlock:^(TemplateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.rowCountArray addObject:obj.items];
    }];
    
    
    
    
}

- (BOOL)getHidenWith:(int)row{
    if (row>=self.activityArr.count) {
        return NO;
    }
    PartModel* mol = [self.activityArr lastObject];
    TemplateModel *temp =[mol.templateModelnameDate.date lastObject];
    return [temp.status boolValue];
}

-(void)settingHiden:(PartModel*)model{
    TemplateModel *temp = [model.templateModelnameDate.date lastObject];
    temp.status =[NSString stringWithFormat:@"%ld",(NSInteger)![temp.status boolValue]];
    [self.myCo reloadData];
}


#pragma mark-responseClick
//弹窗点击
- (void)alertClick:(NSInteger)index{
    UIButton *btn=[self.Alert viewWithTag:10];//获取验证码按钮
    UITextField *phoneText=[self.Alert viewWithTag:20];//获取验证码的手机输入框
    UITextField *YanZText=[self.Alert viewWithTag:21];//验证码输入框
    UITextField *shopName=[self.Alert viewWithTag:22];
    switch (index) {
        case 10:{//发送验证码
            [self sendSmsCode:phoneText:btn];
        }
            break;
        case 11:{//快速注册
            if (![shopName.text isEqualToString:@""]) {
                if ([YanZText.text isEmpty]||![self.getSMSCode isEqualToString:YanZText.text]) {
                    [OMGToast showWithText:@"验证码不正确"];
                  
                }else{
                if (timer) {
                    dispatch_source_cancel(timer);
                }
                 [self.Alert removeFromSuperview];
      [self quickRegister:self.linkPhone smsCode:[YanZText.text md5] store:shopName.text withHongBao:NO withTempNo:self.type];
                }
            }else{
                [OMGToast showWithText:@"店铺名不能为空"];
            
            }
                    }
            break;
        case 12:{//取消
            
            if (timer) {
                dispatch_source_cancel(timer);
            }
            [self.Alert removeFromSuperview];
        
        }
            break;
        default:
            break;
    }


}

- (void)beginTimer:(UIButton *)btn{
    __block int time=59;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (time<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
                btn.userInteractionEnabled=YES;
            });
        }else{
            int seconds=time%60;
            NSString *str=[NSString stringWithFormat:@"%.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@秒",str] forState: UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled=NO;
            });
            time --;
        }
    });
    dispatch_resume(timer);
}


#pragma mark-requestData
- (void)requestWeiZhanDetail{
    WS(weakSelf);
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if (!AccountInfo.isTiyan) {
       [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    }
    else
    {
        [params setObject:NoNullStr(AccountInfo.tempStoreId, @"") forKey:@"storeId"];
    }
    
    
    [params setObject:self.type forKey:@"templateNo"];
    [[MallNetManager share] request:API_Storecenter_TemplateSearch prams:params succeed:^(id responseObject) {
        if([responseObject[@"code"]isEqualToString:@"00-00"]){
            if (responseObject) {
                weakSelf.dataSource = [SearPartData mj_objectWithKeyValues:responseObject];
                if (weakSelf.dataSource) {
                    if ([ISTEXTData isEqualToString:@"0"]) {
                        [weakSelf saveFirstFloorDatas];
                    }
                    NSArray *array=responseObject[@"data"];
                    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj[@"templateModelnameCode"]isEqualToString:DianPMessage]) {
                            NSString *str=obj[@"templateModelnameDate"];
                            NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            if ([dic count]!=0) {
                            FlowerAddressModel *model=[FlowerAddressModel mj_objectWithKeyValues:[dic[@"date"] lastObject]];
                                if([isNewData isEqualToString:@"0"]){
                                    weakSelf.tempModel=model;
                                    }
                                isNewData=@"1";
                            PartModel *model1=[[self getTempleData:shopInfoStatus]lastObject];
                            model1.templateModelnameDate.date=@[model];
                            [weakSelf setTempleData:@[model1] isNew:NO];
                            }else{
                                [weakSelf tempModel];
                    
                            
                            }
                        }
                    }];
                 [weakSelf getSectionCount];
                    
                
                }
                
                [weakSelf.myCo reloadData];
            }
        }
    } showHUD:YES];
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

#pragma mark-更新数据
-(void)setTempleData:(NSArray*)tArrData isNew:(BOOL)isNew{
    
    if (!isNew) {
        for (PartModel*model1 in self.dataSource.data) {
            
            for (PartModel*model2 in tArrData) {
                
                if ([model1.templateModelnameCode isEqualToString:model2.templateModelnameCode]) {
                    
                    model1.templateModelnameDate = model2.templateModelnameDate;
                }
            }
        }
        [self getSectionCount];
        return;
    }
    NSMutableArray* tempArr = [NSMutableArray array];
    [tempArr addObjectsFromArray:self.dataSource.data];
    [tempArr addObjectsFromArray:tArrData];
    self.dataSource.data = tempArr.copy;
   [self getSectionCount];
}

#pragma mark-删除数据
- (void)deleteData:(int)index{
    PartModel *model = [[self getTempleData:floorStatus]lastObject];
    if (model) {
       
        if ([model.templateModelnameDate.date count] != 1) {
            //要上传的数据Model
            PartModel *myModel = [self getDataFromModel:model selectedIndex:index];
            //调用删除接口

            if (AccountInfo.isTiyan) {
                myModel.storeId = NoNullStr(AccountInfo.tempStoreId, @"");
            }else {
                myModel.storeId = NoNullStr(AccountInfo.storeId, @"") ;
            }
            //删除传 -1
            myModel.id = -1;
            WS(weakSelf);
            NSArray* arr = @[myModel];
            [self saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
                NSLog(@"---成功删除楼层数据-->>:%@", responseObject);
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showSuccessWithStatus:@"删除楼层成功！"];
//                //重新获取数据
//                [weakSelf requestWeiZhanDetail];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:model.templateModelnameDate.date];
                [tempArr removeObjectAtIndex:(NSUInteger)index];
                [weakSelf.sectionTitleArr removeObjectAtIndex:(NSUInteger)index];
                model.templateModelnameDate.date = tempArr.copy;
                [weakSelf setTempleData:@[model] isNew:NO];
                [weakSelf.myCo reloadData];
            } error:^(NSError *error) {
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showErrorWithStatus:@"删除楼层失败！"];
            }];
            
        }else{
            [OMGToast showWithText:@"至少有一个楼层"];
        
        }
    }
   
}

- (PartModel *)getDataFromModel:(PartModel *)partModel selectedIndex:(NSInteger)index {
    PartModel *model = [[PartModel alloc] init];
    model.storeId = partModel.storeId;
    model.templateModelname = partModel.templateModelname;
    model.templateModelnameCode = partModel.templateModelnameCode;
    model.templateNo = partModel.templateNo;
    
    TemplateModelData *templateData = [[TemplateModelData alloc] init];
    templateData = partModel.templateModelnameDate;
    TemplateModel *date = [[TemplateModel alloc] init];
    if (index < templateData.date.count) {
        date = [templateData.date objectAtIndex:index];
        //删除 id = -1； 保存 id = 0
        //应为删除和保存走的是同一个接口，所以这个值要赋值一下（返回的数据中这个字段的值为 nil）
        date.preCode = @"0";
    }else {
         PartModel *nullModel = [[PartModel alloc] init];
        return nullModel;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithObject:date];
    TemplateModelData *templateData2 = [[TemplateModelData alloc] init];
    templateData2.date = arr.copy;
    model.templateModelnameDate = templateData2;
    return model;
}

#pragma mark-shopInfo数据上传
- (void)ShopInfoDataupload:(FlowerAddressModel *)model{
    PartModel *model1=[[self getTempleData:shopInfoStatus]lastObject];
    if(!model1){
        model1=[[PartModel alloc]init];
        model1.templateModelnameDate=[[TemplateModelData alloc]init];
        model1.id=0;
        model1.templateModelnameCode=DianPMessage;
        model1.templateNo=self.type;
    }
    if (cllpt.latitude==0) {
         model.address.bdLong=@"";
    }
    else{
    
        model.address.bdLong=[NSString stringWithFormat:@"%@",@(cllpt.longitude)];
    }
    if (cllpt.longitude==0) {
        model.address.bdLat=@"";
    }
    else{
    
        model.address.bdLat=[NSString stringWithFormat:@"%@",@(cllpt.latitude)];

    }
    NSMutableArray *array=[NSMutableArray array];
    if(AccountInfo.isTiyan){
    model1.storeId=NoNullStr(AccountInfo.tempStoreId, @"");
    }else{
    model1.storeId=NoNullStr(AccountInfo.storeId, @"");
    }
    model1.templateModelname=@"店铺信息";
    [array addObject:model];
    __weak typeof(self) wSelf = self;
    model1.templateModelnameDate.date=[array copy];
    NSArray* arr = @[model1];
    
    [[MallNetManager share] request:API_TemplateSave parameters:[arr jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (Succeed(responseObject)) {
            
            SearPartData* rsp = [SearPartData mj_objectWithKeyValues:responseObject];
            if (rsp) {
                if (AccountInfo.isTiyan) {
     [wSelf updateStoreInforRequest:AccountInfo.tempStoreId targetId:AccountInfo.storeId withTempNo:wSelf.type withHongBao:NO];
            }else{
              [wSelf saveTemple:wSelf.type andshopName:wSelf.tempModel.name];
                }
            }
        }else{
            [OMGToast showWithText:responseObject[@"msg"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];


}



- (BOOL)validatePhone:(NSString *) textString
{
    NSString* number=@"^[0-9]{11}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
    
}

- (BOOL) validateTelphone:(NSString *)telphone
{
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{8}|[0-9]{4}-[0-9]{7}|[0-9]{4}-[0-9]{8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:telphone];
}




-(void)getTheAdressPt:(NSString *)adressString{

    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    
    citySearchOption.pageIndex = 0;
    
    citySearchOption.pageCapacity = 20;
    
    citySearchOption.city= @"苏州市";
    
    citySearchOption.keyword = adressString;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
        
        
    }
    else
    {
        NSLog(@"城市内检索发送失败");
        self.addressTableView.hidden=YES;
    }
}



#pragma mark - 联想搜索代理方法
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKPoiInfo* poi = nil;
        [self.searchArray removeAllObjects];
        for (NSInteger i = 0; i < result.poiInfoList.count; i++) {
            poi = [result.poiInfoList objectAtIndex:i];
            if ((poi.epoitype == 0 || poi.epoitype == 1 || poi.epoitype == 3 )&& [poi.city contains:@"苏州市"]) {
                [self.searchArray addObject:poi];
            }
            
        }
        self.addressTableView.backgroundColor=HexColor(@"#f6f5fa");
        self.addressTableView.frame = CGRectMake(0, 270 , KScreenWidth, SCREEN_SIZE.height-270-NavigationH);
        if (self.searchArray.count==0) {
            self.addressTableView.hidden=YES;
        }
        else{
            self.addressTableView.hidden=NO;
        }
        
        [self.addressTableView reloadData];
    }
    else{
        self.addressTableView.hidden=YES;
        cllpt.latitude=0;
        cllpt.longitude=0;
//        [OMGToast showWithText:@"未获取到当前地址经纬度"];
    
    }
    
    
}


#pragma mark-UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.searchArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=0;
    BMKPoiInfo* poi = [self.searchArray objectAtIndex:indexPath.row];
    cell.textLabel.text=poi.name;
    cell.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BMKPoiInfo* poi = [self.searchArray objectAtIndex:indexPath.row];
    self.addressTableView.hidden=YES;
    cllpt.latitude=poi.pt.latitude;
    cllpt.longitude=poi.pt.longitude;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"flowerAdressSelect" object:poi.name];
    self.tempModel.address.name=poi.name;

}



#pragma mark-CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        case 1:
        case 2:
            return 1;
        case 3:
            return [self getHidenWith:0]==0?0:1;
    }

    return [[self.rowCountArray objectAtIndex:section-4] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return self.Section;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PartModel *model;
    switch (indexPath.section) {
        case 0:{
            FlowerShopCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FlowerShopCell" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor redColor];
            cell.view.delegate=self;
//            model=[[self getTempleData:BannerPictureStatus] lastObject];
//            cell.model=model;
            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,self.bannerImagePath]] placeholderImage:[UIImage imageNamed:@"dianshang-lunbo"]];                        
            return cell;
        }
        case 1:{
            FlowerShopSectionTwoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FlowerShopSectionTwoCell" forIndexPath:indexPath];
             __weak typeof(self) wSelf = self;
            cell.block=^(FlowerAddressModel *model){
                wSelf.tempModel=model;
    
            };
            cell.model=self.tempModel;
            cell.delegate=self;
            return cell;
        }
        case 2:{
            FlowerShopLunBoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FlowerShopLunBoCell" forIndexPath:indexPath];
            cell.view.delegate=self;
            model=[[self getTempleData:hotStatus] lastObject];
            cell.model=model;
            return cell;
        
        }
        case 3:{
            FlowerHongBaoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FlowerHongBaoCell" forIndexPath:indexPath];
            cell.model = [self.activityArr lastObject];;
            cell.cellType=1;
            cell.jView.tag = 103;
            cell.jView.delegate=self;
            return cell;
        }
            break;
        default:{
            FlowerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FlowerCell" forIndexPath:indexPath];
            model=[[self getTempleData:floorStatus]lastObject];
            if (model.templateModelnameDate.date.count>0) {
                TemplateModel *model1=model.templateModelnameDate.date[indexPath.section-4];
                TemplateModel  *model2=model1.items[indexPath.row];
                cell.model=model2;
               
            }
            return cell;
    }
     break;
    }
    return nil;
}

#pragma mark-UIALertViewDelete
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1000) {
    switch (buttonIndex) {
        case 0:
            return;
            break;
        case 1:{
         [self deleteData:dIndex];
       }
        default:
            break;
    }
    }else{
[[NSNotificationCenter defaultCenter]postNotificationName:@"MainVC" object:@(buttonIndex)];

    }
}

#pragma mark-CollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(KScreenWidth, FlowerShopCellHeight);
        case 1:
             return CGSizeMake(KScreenWidth, FlowerShopSectionTwoCellHeight);
        case 2:
            return CGSizeMake(KScreenWidth, FlowerShopLunBoCellHeight);
        case 3:
            return [self getHidenWith:0]==0?CGSizeZero:CGSizeMake(KScreenWidth, FlowerHongBaoCellHeight);
    }
 return CGSizeMake((KScreenWidth-flowerShopSpace)/2.0,ECProductorCellHeight);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==self.Section-1) {
        return CGSizeMake(KScreenWidth, 90);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section!=0&&section!=1&&section!=3) {
        return CGSizeMake(KScreenWidth, 40);
    }
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==self.Section-1) {
        return UIEdgeInsetsMake(0, 0, 20, 0);
    }
    if (section==3) {
        if ([self getHidenWith:0]==0) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return UIEdgeInsetsMake(0, 0, 15, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section>=4) {
        return flowerShopSpace;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section>=4) {
        return flowerShopSpace;
    }
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionHeader *head=nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        head =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        head.backgroundColor=[UIColor whiteColor];
        head.jview.delegate=self;
    }else{
        UICollectionReusableView *foot=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        [foot addSubview:self.saveV];
        return foot;
        
    }
    ;
    head.titlelab.text=self.sectionTitleArr[indexPath.section];
    if (indexPath.section!=2) {
        head.jview.hidden=NO;
    }else{
        head.jview.hidden=YES;
    }
   head.jview.tag=indexPath.section+100;
    return head;
}

#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.myCo) {
        [self.addressTableView setHidden:YES];
    }

}



#pragma mark-JMViewDelegate
-(void)userDidSelectIndex:(NSInteger)index inView:(UIView*)view data:(id)data{
    
}

- (void)userDidSelectTitle:(NSString *)title atIndex:(NSInteger)index inView:(UIView *)view{
    NSLog(@"view.tag:%ld",view.tag);
    int d=(int)view.tag-104;
    JMView* jView = (JMView*)view;
    __weak typeof(self) wSelf = self;
    switch (view.tag) {
        case 100://更换门头
        {
            ChangeDoorImageVC* vc = [[ChangeDoorImageVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                [wSelf setTempleData:@[model] isNew:isNew];
                [wSelf.myCo reloadData];
            }];
            vc.tempNo=self.type;
            vc.model = [[self getTempleData:BannerPictureStatus] lastObject];
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 102:
        {
            switch (index) {
                case 0:{//轮播图
                    LunBoEditeVC* vc = [[LunBoEditeVC alloc] initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.myCo reloadData];
                    }];
                    vc.isNewTemple=YES;
                    vc.modelNo=self.type;
                    vc.modelCode=ReMTJ;
                    vc.model = [[self getTempleData: hotStatus] lastObject];

                    [self.navigationController pushViewController:vc animated:YES];
                
                }
                    break;
                case 1:{//新增活动
                    if (self.activityArr.count==0) {
                        if ([self JuageTheMessage]) {
                        EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                            [wSelf setTempleData:@[model] isNew:isNew];
                            [wSelf.myCo reloadData];
                        }];
                        vc.templeId = self.type;
                        vc.model = jView.prams;
                        vc.isEdite=NO;
                        vc.isKFlower=YES;
                        vc.models = [self getTempleData:FlowerShopHongBaoStatus];
                        vc.TemModel=self.tempModel;
                        [self.navigationController pushViewController:vc animated:YES];
                        [self.myCo reloadSections:[NSIndexSet indexSetWithIndex:3]];
                            }
                    }else{
                        PartModel *model=[[self getTempleData:FlowerShopHongBaoStatus]lastObject];
                        TemplateModel *temp=[model.templateModelnameDate.date lastObject];
                        if ([temp.status boolValue]==0) {
                            temp.status =@"1";
                            model.templateModelnameDate.date=@[temp];
                            [self requestChangeShowStatu:YES data:model callBack:nil];
                            [self setTempleData:@[model] isNew:NO];
                            [self.myCo reloadSections:[NSIndexSet indexSetWithIndex:3]];

                        }else{
                            [OMGToast showWithText:@"只能配置一个活动"];
                        }
                     
                    
                    }
  
                }
                    break;
                default:{
                
                
                }
                    break;
            }
            
        }
            break;
            
        case 103:
        {
            switch (index) {
                    
                case 0:{  //编辑
                    EditHongBaoVC* vc = [[EditHongBaoVC alloc]initWithBlock:^(PartModel *model, BOOL isNew) {
                        [wSelf setTempleData:@[model] isNew:isNew];
                        [wSelf.myCo reloadData];
                    }];
                    vc.templeId = self.type;
                    vc.model = jView.prams;
                    vc.isEdite=YES;
                    vc.isKFlower=YES;
                    vc.models = [self getTempleData:FlowerShopHongBaoStatus];
                    vc.TemModel=self.tempModel;
                    [self.navigationController pushViewController:vc animated:YES];
                
                }
                    break;
                    
                case 1:{//删除
                    if (self.activityArr.count!=0) {
                        PartModel *model=[[self getTempleData:FlowerShopHongBaoStatus]lastObject];
                        TemplateModel *temp=[model.templateModelnameDate.date lastObject];
                         temp.status =@"0";
                        model.templateModelnameDate.date=@[temp];
                        [self requestChangeShowStatu:NO data:model callBack:nil];
                        [self setTempleData:@[model] isNew:NO];
                        [self.myCo reloadSections:[NSIndexSet indexSetWithIndex:3]];
                    }
                    
                }
                    break;
                    
                    
            default:{
             
        }
            break;
            }
            break;
   
        default:{
            switch (index) {
                case 1:{//删除
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否确认删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                    alert.tag=1000;
                    [alert show];
                    dIndex=d;
                   
                }
                    break;
                    
                case 2:{//新增楼层
                    WZ_AddNewFloorVCViewController *addFloorVC = [[WZ_AddNewFloorVCViewController alloc] initWithNibName:@"WZ_AddNewFloorVCViewController" bundle:nil];
                    addFloorVC.templateNo = self.type;
                    PartModel *model = [[self getTempleData:floorStatus] lastObject];
                    TemplateModel *templateModel = [model.templateModelnameDate.date objectAtIndex:d];
                    addFloorVC.isTioYanAccount = AccountInfo.isTiyan;
                    //floorCode = -1 为默认展示模板数据，在默认模板保存失败的情况下，在这处理，以避免出错
                    if ([templateModel.floorCode isEqualToString:@"-1"]) {
                        addFloorVC.preCode = [NSString stringWithFormat:@"0"];
                        addFloorVC.floorCode = [NSString stringWithFormat:@"1"];
                    }else {
                        NSInteger floorCode = [self getMaxFloorCode:model];
                        addFloorVC.preCode = [NSString stringWithFormat:@"%@", templateModel.floorCode];
                        addFloorVC.floorCode = [NSString stringWithFormat:@"%d", (floorCode + 1)];
                    }
                    
                    [self.navigationController pushViewController:addFloorVC animated:YES];
                    
                }
                    break;
                default:{//编辑
                    WZ_AddNewFloorVCViewController *addFloorVC = [[WZ_AddNewFloorVCViewController alloc] initWithNibName:@"WZ_AddNewFloorVCViewController" bundle:nil];
                    addFloorVC.templateNo = self.type;
                    PartModel *model = [[self getTempleData:floorStatus] lastObject];
                    TemplateModel *templateModel = [model.templateModelnameDate.date objectAtIndex:d];
                    addFloorVC.goodsModel = templateModel;
                    addFloorVC.isTioYanAccount = AccountInfo.isTiyan;
                    //floorCode = -1 为默认展示模板数据，在默认模板保存失败的情况下，在这处理，以避免出错
                    if ([templateModel.floorCode isEqualToString:@"-1"]) {
                        addFloorVC.preCode = [NSString stringWithFormat:@"0"];
                        addFloorVC.floorCode = [NSString stringWithFormat:@"1"];
                    }else {
                        addFloorVC.preCode = [NSString stringWithFormat:@"%@", templateModel.floorCode];
                        addFloorVC.floorCode = [NSString stringWithFormat:@"%@", templateModel.floorCode];
                    }
                    
                    [self.navigationController pushViewController:addFloorVC animated:YES];
                    
                }
                    break;
        
            }
            
        }
            break;
        }
    }
    
}

//获取最大的floorCode
- (NSInteger)getMaxFloorCode:(PartModel *)partModel {
    NSArray *dataArry = partModel.templateModelnameDate.date;
    if (dataArry.count > 1) {
        TemplateModel *temp = [dataArry objectAtIndex:0];
        NSInteger floorCode = [temp.floorCode integerValue];
        for (TemplateModel *tempModel in dataArry) {
            if ([tempModel.floorCode integerValue] > floorCode) {
                floorCode = [tempModel.floorCode integerValue];
            }
            
        }
//        NSInteger floor = [floorCode integerValue];
        return floorCode;
    }else if (dataArry.count == 1){
        TemplateModel *temp = [dataArry objectAtIndex:0];
        return [temp.floorCode integerValue];
    }else {
        return 0;
    }
    
}

#pragma mark-setterORgetter

- (UICollectionView *)myCo{
    if(!_myCo){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        _myCo=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-NavigationH) collectionViewLayout:layout];
        _myCo.backgroundColor=[UIColor whiteColor];
        [_myCo registerClass:[FlowerShopCell class] forCellWithReuseIdentifier:@"FlowerShopCell"];
        [_myCo registerClass:[FlowerShopSectionTwoCell class] forCellWithReuseIdentifier:@"FlowerShopSectionTwoCell"];
        [_myCo registerClass:[FlowerShopLunBoCell class] forCellWithReuseIdentifier:@"FlowerShopLunBoCell"];
        [_myCo registerClass:[FlowerCell  class] forCellWithReuseIdentifier:@"FlowerCell"];
        [_myCo registerClass:[FlowerHongBaoCell class] forCellWithReuseIdentifier:@"FlowerHongBaoCell"];
        [_myCo registerClass:[CustomCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_myCo registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        _myCo.backgroundColor=[UIColor colorWithHexString:@"#f5f4f9"];
        _myCo.delegate=self;
        _myCo.dataSource=self;
        [self.view addSubview:_myCo];
    
    }
    return _myCo;
}

- (BOOL)JuageTheMessage{
    NSString *temp1 = self.tempModel.name.trim;
    NSString *temp2 = self.tempModel.shopPhone.trim;
    NSString *temp3 = self.tempModel.address.name.trim;
    
    BOOL isYes2 = temp2.length==0?YES:NO;
    BOOL isYes3 = temp3.length==0?YES:NO;
    BOOL isYes1 = temp1.length==0?YES:NO;
    if (isYes1) {
        [OMGToast showWithText:@"店铺信息不全"];
        return NO;
    }
    if (temp1.length>20) {
        [OMGToast showWithText:@"店铺名称不能超过20位"];
        return NO;
    }
    
    if (isYes2) {
        [OMGToast showWithText:@"商户电话不全"];
        return NO;
    }
    if(isYes3){
        [OMGToast showWithText:@"店铺地址不全"];
        return NO;
    }
    
    
    if (![self validatePhone:temp2]&&![self validateTelphone:temp2]) {
        [OMGToast showWithText:@"请输入正确的电话"];
        return NO;
    }
    
//    BOOL isRightPhong= [self validatePhone:temp2];
//    if (!isRightPhong) {
//        [OMGToast showWithText:@"请输入正确的号码"];
//        return NO;
//    }
    return YES;
}

- (SaveView *)saveV{
    if (!_saveV) {
    __weak typeof(self) wSelf = self;
        _saveV=[[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:NO block:^{
      

            if (![wSelf JuageTheMessage]) {
               
            }else{
                if (AccountInfo.isTiyan) {
                    UIWindow *win=[[UIApplication sharedApplication].delegate window];
                    wSelf.Alert=[[CustomRegistAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds WithBlock:^(NSInteger index) {
                        [wSelf alertClick:index];
                    }];
                    [win addSubview:wSelf.Alert];
                }else{
                   
                     [wSelf ShopInfoDataupload:wSelf.tempModel];
                }
            
            }
        }];
    }
    return _saveV;
}

- (void)setDataSource:(SearPartData *)dataSource{
    WS(weakSelf)
    _dataSource = dataSource;
    if (!_activityArr) {
        _activityArr = [NSMutableArray array];
    }else{
        [self.activityArr removeAllObjects];
    }
    
    self.activityArr = [self getTempleData: FlowerShopHongBaoStatus];
    [self.sectionTitleArr removeAllObjects];
    NSArray *array=@[@"banner图",@"商店信息",@"热门推荐",@"活动"];
    [self.sectionTitleArr addObjectsFromArray:array];
    [dataSource.data enumerateObjectsUsingBlock:^(PartModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.templateModelnameCode isEqualToString:ReMTJ]) {
            if (![obj.templateModelname isEmpty]) {
          [weakSelf.sectionTitleArr replaceObjectAtIndex:2 withObject:obj.templateModelname];
            }
        }
        if ([obj.templateModelnameCode isEqualToString:LOUC]) {
           [obj.templateModelnameDate.date enumerateObjectsUsingBlock:^(TemplateModel *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                   [weakSelf.sectionTitleArr addObject:obj1.floorName];
            }];
        }
        if ([obj.templateModelnameCode isEqualToString:DianPBanner]) {
            [obj.templateModelnameDate.date enumerateObjectsUsingBlock:^(TemplateModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.real isEqualToString:@"1"]) {
                    weakSelf.bannerImagePath=obj.imgPath;
                }
            }];
        }
        
    }];    
}

#pragma mark - 保存默认模板数据

- (void)saveFirstFloorDatas {
    WS(weakSelf)
    //是否正在 查找、请求保存 默认数据
    if (isSavingMoRenData == NO && isSearchMoRenData == NO) {
        isSavingMoRenData = YES;
        isSearchMoRenData = YES;
    }else {
        return;
    }
    PartModel *model = [[self getTempleData:floorStatus]lastObject];
    NSArray *temArr=model.templateModelnameDate.date;
    [temArr enumerateObjectsUsingBlock:^(TemplateModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.floorCode isEqualToString:@"-1"]) {
            if (AccountInfo.isTiyan) {
                model.storeId = NoNullStr(AccountInfo.tempStoreId, @"");
            }else {
                model.storeId = NoNullStr(AccountInfo.storeId, @"") ;
            }
            model.id = 0;
            obj.floorCode = @"1";
            obj.preCode = @"0";
            NSArray* arr = @[model];
            [weakSelf saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
                NSLog(@"---成功保存默认模板数据-->>:%@", responseObject);
                isSavingMoRenData = NO;
                ISTEXTData=@"1";
            } error:^(NSError *error) {
                isSavingMoRenData = NO;
            }];
          
        }
        if (idx == temArr.count - 1) {
            isSearchMoRenData = NO;
        }
        
    }];
    
    
}


- (NSMutableArray *)sectionTitleArr{
    if (!_sectionTitleArr) {
        _sectionTitleArr=[[NSMutableArray alloc]initWithObjects:@"banner图",@"商店信息",@"热门推荐",@"活动" ,nil];
    }
    return _sectionTitleArr;
}

- (NSMutableArray *)rowCountArray{
    if (!_rowCountArray) {
        _rowCountArray=[NSMutableArray array];
    }
    return _rowCountArray;
}

- (NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray=[NSMutableArray array];
    }
    return _searchArray;
}

-(UITableView *)addressTableView{
    if (!_addressTableView) {
        _addressTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addressTableView.hidden=YES;
        _addressTableView.delegate=self;
        _addressTableView.dataSource=self;
        [self.view addSubview:_addressTableView];
    }
       return _addressTableView;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FlowerAddressModel *)tempModel{
    if (!_tempModel) {
        _tempModel=[[FlowerAddressModel alloc]init];
        _tempModel.address=[[TemplateModel alloc]init];
        _tempModel.name=@"";
        _tempModel.shopPhone=@"";
        _tempModel.address.name=@"";
    }
    return _tempModel;
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
