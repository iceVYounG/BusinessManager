//
//  WZ_PilotVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_PilotVC.h"
#import "LocationService.h"
#import "WeiZhanModel.h"
#import "JMView.h"
@interface WZ_PilotVC ()<BMKPoiSearchDelegate,BMKMapViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BMKPoiSearch* _poisearch;
    UIView* addFieldView;
    
}
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) UITextField *addressField;
@property (nonatomic, strong) UITextField *subWayField;
@property (nonatomic, strong) NSMutableArray *busPoiArray;
@property (nonatomic, strong) UITableView *addressTableView;
@end

@implementation WZ_PilotVC

- (instancetype)initWithBlock:(PiolitBlock)block{
    
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _mapView.delegate = self;
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    self.title = @"为您导航详情编辑";
    [self creatSubViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    [super viewWillAppear:YES];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = nil;
}
- (void)creatSubViews{
    
    if (self.model) {
        
        TemplateModel* temp = [self.model.templateModelnameDate.date lastObject];
        
        _userCoord.latitude = [temp.bdLat floatValue];
        
        _userCoord.longitude = [temp.bdLong floatValue];
        self.addressField.text = temp.address;
        self.subWayField.text = temp.busline;
    }else{
//        [LocationService getAdressWithBlock:^(LocationModel *model) {
//            
//            _userCoord = model.coord;
//        }];
        
        [LocationService getCoordWithBlock:^(CLLocationCoordinate2D coord) {
            
            _userCoord = coord;
        }];
    }
    
    //    UIView* addFieldView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_mapView.frame) + 12, KScreenWidth - 30, 36)];
    
    addFieldView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, KScreenWidth - 30, 36)];
    addFieldView.backgroundColor = [UIColor whiteColor];
    [addFieldView addSubview:self.addressField];
    addFieldView.clipsToBounds = YES;
    addFieldView.layer.cornerRadius = 3.f;
    [self.view addSubview:addFieldView];
    
    
    _addressTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _addressTableView.delegate=self;
    _addressTableView.dataSource=self;
    _addressTableView.hidden=YES;
    [self.view addSubview:_addressTableView];
    
    UIView* subFieldView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(addFieldView.frame) + 12, KScreenWidth - 30, 36)];
    subFieldView.backgroundColor = [UIColor whiteColor];
    [subFieldView addSubview:self.subWayField];
    subFieldView.clipsToBounds = YES;
    subFieldView.layer.cornerRadius = 3.f;
    [self.view addSubview:subFieldView];
    
    
    //定位
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //初始化BMKLocationService
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    //地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(subFieldView.frame) + 12, KScreenWidth - 30, KScreenHeight - NavigationH - 200)];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.showMapScaleBar = YES;
    _mapView.mapScaleBarPosition = CGPointMake(KScreenWidth - 60 - 30, _mapView.frame.size.height - 46);//比例尺
    _mapView.delegate = self;
    _mapView.zoomLevel = 18;
    _mapView.scrollEnabled = YES;
    [self.view addSubview:_mapView];
    

    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.locationViewImgName= @"66";//定位图标名称
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_mapView updateLocationViewWithParam:displayParam];


    
    SaveView* sView = [[SaveView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mapView.frame)+5, KScreenWidth, 50) tipHiden:YES block:^{
        NSLog(@"saveAction");
        
        [self saveTemplteAction];
    }];
    
    [self.view addSubview:sView];
    
    [self.view addSubview:self.addressTableView];

}

#pragma mark - 地理编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    _userCoord = result.location;
    NSLog(@"%@",result);
    
}
#pragma mark - 设置地图中心点
- (void)settingCenterCooed:(CLLocationCoordinate2D)coord{
    
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = coord;//中心点
    region.span.latitudeDelta = 0.008;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.008;//纬度范围
    [_mapView setRegion:region animated:YES];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
   
    [self settingCenterCooed:_userCoord];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
 
    CLLocation *location = userLocation.location;
//        location.coordinate = _userCoord;
    
    [_mapView updateLocationData:userLocation];
    //获取编码位置信息
    BMKReverseGeoCodeOption* option = [[BMKReverseGeoCodeOption alloc]init];
    _userCoord = userLocation.location.coordinate;

    [_geoCoder reverseGeoCode:option];
    
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
}
//开始拖动
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    _mapView.scrollEnabled = YES;
    
}
//停止拖动
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    BMKReverseGeoCodeOption* option = [[BMKReverseGeoCodeOption alloc]init];

    [_geoCoder reverseGeoCode:option];

}
#pragma mark - uitabviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.busPoiArray.count);
    
    return self.busPoiArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    MapResultModel *model = [_busPoiArray objectAtIndex:indexPath.row];
    cell.textLabel.text=model.name;
    cell.selectionStyle=0;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     MapResultModel *model = [_busPoiArray objectAtIndex:indexPath.row];
    
    self.addressField.text=model.name;
    
    self.addressTableView.hidden=YES;

}


#pragma mark - saveAction

- (void)saveTemplteAction{
    
    PartModel* model = [[PartModel alloc] init];
    
    if (self.addressField.text.length == 0 || [self.subWayField.text isEqualToString:@""] || self.subWayField.text.length == 0) {
        [OMGToast showWithText:@"请确认您的输入是否完整！"];
        return;
    }
    
    model.templateModelname = @"为您导航";
    model.templateModelnameCode = @"wndh";
    model.templateNo = self.type;
    model.storeId = NoNullStr(AccountInfo.storeId, @"");
    
    
    if (!self.model) {// 第一次创建
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel* temp = [[TemplateModel alloc] init];
        temp.address = self.addressField.text;
        temp.busline = self.subWayField.text;
        temp.bdLat = [NSString stringWithFormat:@"%f",_userCoord.latitude];
        temp.bdLong = [NSString stringWithFormat:@"%f",_userCoord.longitude];
        data.date = @[temp];
        model.templateModelnameDate = data;
        
        
    }else{
        model.id = self.model.id;
        
        TemplateModel* tModel = self.model.templateModelnameDate.date.lastObject;
        tModel.address = self.addressField.text;
        tModel.busline = self.subWayField.text;
        tModel.bdLat = [NSString stringWithFormat:@"%f",_userCoord.latitude];
        tModel.bdLong = [NSString stringWithFormat:@"%f",_userCoord.longitude];
        self.model.templateModelnameDate.date = @[tModel];
        
        model = self.model;
        
    }
    
    NSArray* arr = @[model];
    __weak typeof(self) wSelf = self;
    
    [[MallNetManager share] request:API_TemplateSave parameters:[arr jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success == %@",responseObject);
        
        if (Succeed(responseObject)) {
            
            SearPartData* rsp = [SearPartData mj_objectWithKeyValues:responseObject];
            if (rsp) {

            }
            
            wSelf.block(model,self.model?NO:YES);
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [OMGToast showWithText:responseObject[@"msg"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];

}

-(void)lianXiangSearch:(NSString *)string{

    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    
    citySearchOption.pageIndex = 0;
    
    citySearchOption.pageCapacity = 20;
    
    citySearchOption.city= @"苏州市";
    
    citySearchOption.keyword = string;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
        
        
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark- textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self lianXiangSearch:textField.text];

    return YES;

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
   
    [self lianXiangSearch:textField.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self lianXiangSearch:textField.text];
    
    return YES;
}

#pragma mark - 联想搜索代理方法
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKPoiInfo* poi = nil;
        [_busPoiArray removeAllObjects];
        for (NSInteger i = 0; i < result.poiInfoList.count; i++) {
            poi = [result.poiInfoList objectAtIndex:i];
            if ((poi.epoitype == 0 || poi.epoitype == 1 || poi.epoitype == 3 )&& [poi.city contains:@"苏州市"]) {
                [_busPoiArray addObject:poi];
            }
            
        }
        
        CGFloat height=44*self.busPoiArray.count;
        if (height>SCREEN_SIZE.height-NavigationH-(CGRectGetMaxY(addFieldView.frame)+5)) {
            height=SCREEN_SIZE.height-NavigationH-(CGRectGetMaxY(addFieldView.frame)+5);
        }
        
        self.addressTableView.frame = CGRectMake(15, CGRectGetMaxY(addFieldView.frame)+5 , KScreenWidth-30, height);
        self.addressTableView.hidden=NO;
        [self.addressTableView reloadData];
    }
}


@synthesize subWayField = _subWayField,addressField = _addressField;

-(NSMutableArray *)busPoiArray{
    if (!_busPoiArray) {
        _busPoiArray=[NSMutableArray array];
    }
    
    
    return _busPoiArray;

}

- (UITextField *)subWayField{
    
    if (!_subWayField) {
        _subWayField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, KScreenWidth - 40, 36)];
        _subWayField.font = [UIFont systemFontOfSize:15.f];
        [_subWayField setValue:[UIColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
        
        [_subWayField setValue:[UIFont boldSystemFontOfSize:15.f] forKeyPath:@"_placeholderLabel.font"];
        _subWayField.placeholder = @"请输入能到达的公交、地铁等,中间用“,”隔开";
    }
    return _subWayField;
}

- (UITextField *)addressField{
    if (!_addressField) {
        _addressField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, KScreenWidth - 40, 36)];
        _addressField.delegate=self;
        [_addressField setValue:[UIColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
        
        [_addressField setValue:[UIFont boldSystemFontOfSize:15.f] forKeyPath:@"_placeholderLabel.font"];

        _addressField.font = [UIFont systemFontOfSize:15.f];
    
        _addressField.placeholder = @"请输入您详细地址";
    }
    return _addressField;
}

@end
