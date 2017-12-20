//
//  WCG_ShopServicevc.m
//  BusinessManager
//
//  Created by zhaojh on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WCG_ShopServicevc.h"
#import "JMView.h"
#import "ShopServerCell.h"
#import "WeiZhanModel.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入联想搜索的头文件
@interface WCG_ShopServicevc ()<UITableViewDelegate,UITableViewDataSource,ShopEditCellDeledate,shopAdressDelegate,BMKPoiSearchDelegate>{

    BMKPoiSearch* _poisearch;

}
@property(nonatomic,strong)UITableView* tableView;
@property(assign,nonatomic)BOOL isFirstEdit;
@property(nonatomic,strong)UITableView *addressTableView;
@property(nonatomic,strong)NSMutableArray *searchArray;
@property(nonatomic,assign)BOOL isShopAdressTableView;
@end

@implementation WCG_ShopServicevc

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户服务信息编辑";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"shopAdressSelect" object:nil];

}

-(void)setModel:(PartModel *)model{
    _model = model;
    _isFirstEdit=NO;
//    self.datasArry2=self.datasArry;
    NSArray* keys = KeysArry;
   [_model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       TemplateModel* model = (TemplateModel*)obj;
       
       [self.datasArry addObject:obj];
       
       if (![keys containsObject:model.code]) {
           
            [self.datasArry2 addObject:model];
       }
   }];
    
    
    if (self.datasArry.count==0) {
        _isFirstEdit=YES;
        NSMutableArray *codeArr=[NSMutableArray arrayWithObjects:@"bdLong",@"bdLat",@"fwsj",@"fwdh",@"dpdz",@"tsfw",@"tgfw", nil];
         NSMutableArray *keyArr=[NSMutableArray arrayWithObjects:@"bdLong",@"bdLat",@"服务时间",@"服务电话",@"店铺地址",@"特殊服务",@"提供服务", nil];
         NSMutableArray *valueArr=[NSMutableArray arrayWithObjects:@"",@"",@"8:00-20:00",@"0512",@"苏州市",@"无上门费",@"家庭保洁", nil];
        for (int i=0; i<7; i++) {
            TemplateModel *model=[[TemplateModel alloc]init];
            model.code=codeArr[i];
            model.value=valueArr[i];
            model.key=keyArr[i];
            model.type=@"1";
            [self.datasArry addObject:model];
        }
    }
    [self tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isShopAdressTableView) {
        return self.searchArray.count;
    }
    
    if (!_isFirstEdit) {
        return self.datasArry2.count;
    }
    return self.datasArry.count-2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isShopAdressTableView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@""];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.backgroundColor=[UIColor colorWithHexString:@"e5e5e5"];
        cell.selectionStyle=0;
        
        MapResultModel *model = [self.searchArray objectAtIndex:indexPath.row];
        cell.textLabel.text=model.name;
        return cell;
    }
    else{
    TemplateModel* mData;
    if (!_isFirstEdit) {
         mData= [self.datasArry2 objectAtIndex:indexPath.row];
    }
    else{
        mData= [self.datasArry objectAtIndex:indexPath.row+2];
    }
    
    
     NSPredicate* predice = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"zdy[0-9]+"];

    if (![predice evaluateWithObject:mData.code]) {
        
        NSString* idengfier=@"ShopServerCell_ident";
        ShopServerCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopServerCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.selectionStyle = 0;
        cell.model = mData;
        cell.valueFild.tag=indexPath.row;
        cell.delegate=self;
        return cell;
    }
    NSString* idengfier=@"ShopServerEditCell_ident";
    ShopServerEditCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
    if (!cell) {
        cell = [[ShopServerEditCell alloc]initWithStyle:0 reuseIdentifier:idengfier];
    }
    cell.selectionStyle = 0;
    cell.model = mData;
    cell.delegate = self;
    
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShopAdressTableView) {
        MapResultModel *model = [self.searchArray objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shopAdressSelect" object:model.name];
        
        self.addressTableView.hidden=YES;
        _isShopAdressTableView=NO;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 48;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_isShopAdressTableView) {
        return nil;
    }
    UIView* secView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    secView.backgroundColor = HexColor(@"#f6f5fa");
    
    UILabel*tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 40)];
    tipLabel.text = @"点击 “+” 新增自定义栏目";
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = HexColor(@"F15A4A");
    [secView addSubview:tipLabel];
    return secView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isShopAdressTableView) {
        return 0;
    }
    return 40;
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
-(void)requestUpload{
    
    for (TemplateModel* model in self.datasArry.copy) {
        NSLog(@"%@--%@",model.key,model.value);

        if ([model.key isEqualToString:@"bdLong"]||[model.key isEqualToString:@"bdLat"]) {
            continue;
        }
        
        if ([model.key isEqualToString:@"服务电话"]) {
            if (![self validatePhone:model.value]&&![self validateTelphone:model.value]) {
                [OMGToast showWithText:@"请输入正确的号码"];
                return;
            }
        }
        
        if (model.key.length == 0 && model.value.length == 0) {
            
            for (TemplateModel* mod in self.datasArry) {
                if ([mod.code isEqualToString:model.code]) {
                    
                    [self.datasArry removeObject:mod];
                    break;
                }
            }
        }else if (model.key.length > 0 && model.value.length > 0){
             //buchuli...
        }else{
            [OMGToast showWithText:@"请完善栏目信息"];
            return;
        }
    }
    
    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"商户服务信息";
        model.templateModelnameCode = ShopService;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        data.date = self.datasArry.copy;
        model.templateModelnameDate = data;
        model.templateNo = Tongyong;
        
    }else{
        
        self.model.templateModelnameDate.date = self.datasArry.copy;
        model = self.model;
    }
    
    NSArray* arr = @[model];
    
    __weak typeof(self) wSelf = self;
    [self saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
        
        wSelf.block(model,self.model?NO:YES);
        [wSelf.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        
    }];
    
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
                NSLog(@">>>%f",poi.pt.latitude);
                
                [self.searchArray addObject:poi];
            }
            
        }
        
        CGFloat height=48*_searchArray.count;
        if (height>SCREEN_SIZE.height-NavigationH-4*48) {
            height=SCREEN_SIZE.height-NavigationH-4*48;
        }
        _isShopAdressTableView=YES;
        self.addressTableView.backgroundColor=HexColor(@"#f6f5fa");
        self.addressTableView.frame = CGRectMake(0, 190 , KScreenWidth, SCREEN_SIZE.height-NavigationH-4*48);
        self.addressTableView.hidden=NO;
        [self.addressTableView reloadData];
    }
}

#pragma mark - Delegate

-(void)isOtherTextField{
    
    _isShopAdressTableView=NO;
    self.addressTableView.hidden=YES;
}
-(void)inputAdressDelegate:(NSString *)string{
    
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


-(void)userDidDeleteTheCell:(TemplateModel *)model{
  
    for (TemplateModel* data in self.datasArry) {
        
        if ([data.code isEqualToString:model.code]) {
            
            [self.datasArry removeObject:data];
            [self.datasArry2 removeObject:data];
            break;
        }
    }
    [self.tableView reloadData];
}


#pragma mark - 初始化
-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray=[NSMutableArray array];
    }
    return _searchArray;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
    
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:0];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = 0;
        
        _tableView.tableFooterView = [self footView];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


-(UITableView *)addressTableView{
    if (!_addressTableView) {
        _addressTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addressTableView.delegate=self;
        _addressTableView.dataSource=self;
        [self.view addSubview:_addressTableView];
    }
    return _addressTableView;

}

-(UIView*)footView{
 __weak typeof(self) wSelf = self;
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 190)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView* addBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, KScreenWidth, 68)];
    addBackView.backgroundColor = HexColor(@"#e8e8e8");
    
    UIImageView* imagev= [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-27)/2, 12, 27, 27)];
    imagev.image = [UIImage imageNamed:@"addImage"];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagev.frame)+3, KScreenWidth, 22)];
    label.text = @"点击新增";
    label.textAlignment = 1;
    label.textColor = HexColor(@"#BBBBBB");
    [addBackView addSubview:imagev];
    [addBackView addSubview:label];
    [backView addSubview:addBackView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAction)];
    [addBackView addGestureRecognizer:tap];
    
    SaveView* saveView = [[SaveView alloc]initWithFrame:CGRectMake(0, 103, KScreenWidth, 90) tipHiden:YES block:^{
        
        [wSelf requestUpload];
    }];
    
    [backView addSubview:saveView];

    return backView;
}

-(void)addAction{
    
    NSPredicate* predice = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"zdy[0-9]+"];
    
    TemplateModel* lastModel = [self.datasArry lastObject];
    
    TemplateModel* model = [[TemplateModel alloc]init];
    
    if (![predice evaluateWithObject:lastModel.code]) {
        
        model.code = @"zdy0";
    }else{
     
        NSInteger num = [[lastModel.code substringFromIndex:3] integerValue];
        
        model.code = [NSString stringWithFormat:@"zdy%ld",num + 1];
    }
    model.key = @"";
    model.value = @"";
    model.type = @"1";
    
    [self.datasArry addObject:model];
    [self.datasArry2 addObject:model];
    
    [self.tableView reloadData];
}

-(NSMutableArray *)datasArry{
    
    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}


-(NSMutableArray *)datasArry2{
    
    if (!_datasArry2) {
        _datasArry2 = [NSMutableArray array];
    }
    return _datasArry2;
}

@end
