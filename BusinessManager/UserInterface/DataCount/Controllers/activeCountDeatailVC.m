//
//  activeCountDeatailVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#define tableViewMaxHeight SCREEN_SIZE.height-217
#import "activeCountDeatailVC.h"
#import "activeDeatailCell.h"
#import "KxMenu.h"
#import "billTopCell.h"
#import "dataCountModel.h"
@interface activeCountDeatailVC ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *titleBtn;
    activeDeatailDataModel *dataModel;
    activeDeatailModel *mainModel;
}
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels1;
@property (weak, nonatomic) IBOutlet UIView *centerBgView;
@property (weak, nonatomic) IBOutlet UILabel *canyuNum;
@property (weak, nonatomic) IBOutlet UILabel *zhongjiangNum;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UILabel *addActiveNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong,nonatomic)NSMutableArray *topArr;
@property (strong,nonatomic)UIView *mengBanView;
@property (strong,nonatomic)UITableView *topTableView;
@property (assign,nonatomic)BOOL isTopTabelView;

@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)NSMutableArray *zjArr;
@property (assign,nonatomic)NSInteger days;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)UIView *naviView;
@property (strong,nonatomic)UIView *noDataView;
@property (assign,nonatomic)NSInteger index;
@end

@implementation activeCountDeatailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"活动详情统计";
    _topArr=[NSMutableArray arrayWithObjects:@"全部",@"已中奖",@"未中奖", nil];
    _zjArr=[NSMutableArray arrayWithObjects:@"",@"1",@"0", nil];
    _dataArr=[NSMutableArray array];
    _days=7;
    _page=1;
   
    [self initView];
    [self addRefresh];
    [self requestActiveDeatailDatas:_days andPage:1 zhongjiang:@""];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{

    titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame=CGRectMake(self.leftItem.width+5, 0, 90, self.leftItem.height);
    [titleBtn setTitle:@"最近7天    " forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    titleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [titleBtn setImage:[UIImage imageNamed:@"DataCount_dropArrow3"] forState:UIControlStateNormal];
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -titleBtn.imageView.size.width, 0, 0)];
    [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleBtn.titleLabel.bounds.size.width+10, 0, 0)];

    [titleBtn addTarget:self action:@selector(selectDay) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rect = self.leftItem.frame;
    
    rect.size.width = self.leftItem.width + titleBtn.width;
    
    self.leftItem.frame = rect;
    
    [self.leftItem addSubview:titleBtn];

    
    _topLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topAction)];
    [_btnView addGestureRecognizer:tap];
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    _centerBgView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    for (UILabel *label in _labels1) {
        label.textColor=[UIColor colorWithHexString:@"#333333"];
        label.font=[UIFont boldSystemFontOfSize:13];
    }
    
    _canyuNum.textColor=[UIColor colorWithHexString:@"#666666"];
    _zhongjiangNum.textColor=[UIColor colorWithHexString:@"#666666"];
    _addActiveNum.textColor=[UIColor colorWithHexString:@"#666666"];
    
    _centerView.layer.borderWidth=.5;
    _centerView.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;
    
    _mengBanView=[[UIView alloc]initWithFrame:CGRectZero];
    [_mengBanView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    
    _topTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _topTableView.delegate=self;
    _topTableView.dataSource=self;
    _topTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    _naviView=[[UIView alloc]initWithFrame:CGRectZero];
    UITapGestureRecognizer *naviTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(naviAction)];
     [_naviView addGestureRecognizer:naviTap];
    
    _noDataView=[[NSBundle mainBundle]loadNibNamed:@"noDataView" owner:self options:nil].firstObject;
    
    _noDataView.frame=CGRectMake(0, CGRectGetMaxY(_centerView.frame)+71, SCREEN_SIZE.width, 1000);
    
}
#pragma mark ---点击空白隐藏事件---

-(void)naviAction{
    
    [_topTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopTabelView=NO;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_topTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopTabelView =NO;
    
}


-(void)topAction{

    _isTopTabelView=YES;
    _topTableView.frame=CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_SIZE.width,44*3);
    _mengBanView.frame=CGRectMake(0, CGRectGetMaxY(_topTableView.frame), SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    [self.view addSubview:_mengBanView];
    [self.view addSubview:_topTableView];
    
    _naviView.frame=CGRectMake(0, 0, SCREEN_SIZE.width, 64);
    [self.navigationController.view addSubview:_naviView];

    
    [_topTableView reloadData];
    
}


-(void)addRefresh{
    
    WS(weakSelf);
    
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        [weakSelf requestActiveDeatailDatas:_days andPage:_page zhongjiang:[_zjArr objectAtIndex:_index] ];
        
    }];
}

#pragma mark ---数据请求---

-(void)requestActiveDeatailDatas:(NSInteger)days andPage:(NSInteger)page zhongjiang:(NSString *)zjNum{
    
    [_noDataView removeFromSuperview];
//    /storecenter/activeStatisticsInfo.chtml
//    参数：   storeId：商户ID(必须)  id：必传     state：非必传，传空表示全部    days:1：今日  7：最近7天  30:最近30天  必传   page：非必传 （默认1，表示第一页）    pagesize:非必传（默认20，表示每页20条）  mobile:非必传   startTime：非必传(当传时，endTime也必传，并days传空,格式：20160505000000)   endTime：非必传 (当传时，startTime也必传，并days传空,格式：20160505000000)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"")  forKey:@"storeId"];
    [params setObject:@(_activeId.integerValue) forKey:@"id"];//商户ID
    [params setObject:zjNum forKey:@"state"];
    [params setObject:@(days) forKey:@"days"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(20) forKey:@"pagesize"];
//    [params setObject:@(AccountInfo.linkPhone.integerValue) forKey:@"mobile"];
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:.8];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_ActiveCountDeatail Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        
        if (Succeed(dic)) {
            mainModel=[activeDeatailModel mj_objectWithKeyValues:dic[@"data"]];
            _canyuNum.text=mainModel.joinUsers;
            _zhongjiangNum.text=mainModel.winUsers;
            if (mainModel.addUsers.integerValue<0) {
                _addActiveNum.text=0;
            }
            else{
                _addActiveNum.text=mainModel.addUsers;
            
            }
            
             NSMutableArray *dataArr2=[NSMutableArray array];
            for (NSDictionary *dic in mainModel.winList) {
                dataModel = [activeDeatailDataModel mj_objectWithKeyValues:dic];
                
                [dataArr2 addObject:dataModel];
            }
             [_dataArr addObjectsFromArray:dataArr2];
           
            if (_dataArr.count==0) {
                [self.view addSubview:_noDataView];
            }
            
            if (_dataArr.count*48+48>tableViewMaxHeight) {
                _tableViewHeight.constant=tableViewMaxHeight;
                self.tableView.mj_footer.hidden=NO;
            }
            else{
                
                self.tableView.mj_footer.hidden=YES;
                _tableViewHeight.constant=_dataArr.count*48+48;
                
            }
            [_tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            
            if (dataArr2.count<20) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            
            [self.tableView.mj_footer endRefreshing];
            _page++;
        }
        
        else{
            
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
            [self.tableView.mj_footer endRefreshing];
            
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

-(void)selectDay{
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"最近30日"
                                          image:nil
                                         target:self
                                         action:@selector(recent30Btn)],
                           [KxMenuItem menuItem:@"最近7日"
                                          image:nil
                                         target:self
                                         action:@selector(recent7Btn)],
                           [KxMenuItem menuItem:@"今日"
                                          image:nil
                                         target:self
                                         action:@selector(todayBtn)],
                           ];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:11]];
    
    //    first.foreColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0];
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:CGRectMake(CGRectGetMinX(titleBtn.frame)+28, self.navigationController.navigationBar.frame.origin.y-25, 40, 60)
                 menuItems:menuItems];
    
    
}

#pragma mark  KxMenuItemAction--

-(void)recent30Btn
{
    _days=30;
    _page=1;
    [_dataArr removeAllObjects];
    [titleBtn setTitle:@"最近30天  " forState:UIControlStateNormal];
    [self requestActiveDeatailDatas:_days andPage:1 zhongjiang:[_zjArr objectAtIndex:_index] ];
    
}


-(void)recent7Btn
{
    _days=7;
    _page=1;
    [_dataArr removeAllObjects];
    [titleBtn setTitle:@"最近7天  " forState:UIControlStateNormal];
    [self requestActiveDeatailDatas:_days andPage:1 zhongjiang:[_zjArr objectAtIndex:_index] ];
    
}

-(void)todayBtn
{
    _days=1;
    _page=1;
    [_dataArr removeAllObjects];
    [titleBtn setTitle:@"今天  " forState:UIControlStateNormal];
    [self requestActiveDeatailDatas:_days andPage:1 zhongjiang:[_zjArr objectAtIndex:_index]];
    
}



#pragma mark  UITableViewDelegate--

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isTopTabelView) {
        return _topArr.count;
    }
    return _dataArr.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isTopTabelView) {
        
        static NSString *cellIdentifier=@"billTopCell";
        billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.cellLabel.text=[_topArr objectAtIndex:indexPath.row];
        if ([_topLabel.text isEqualToString:@"全部"]) {
           
            if (indexPath.row==0) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
            
        }
        
        else if ([_topLabel.text isEqualToString:@"已中奖"])
        {
            if (indexPath.row==1) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
        
        
        }
        
        else if ([_topLabel.text isEqualToString:@"未中奖"])
        {
            if (indexPath.row==2) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
            
            
        }
        return cell;
}
    
    else{
    static NSString *identifier=@"activeDeatailCell";
    
    activeDeatailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil].firstObject;
    }
    cell.selectionStyle=0;
    
        if (indexPath.row==0) {
            cell.phoneNum.text=@"用户手机号码";
            cell.phoneNum.font=[UIFont boldSystemFontOfSize:13];
            cell.phoneNum.textColor=[UIColor colorWithHexString:@"#333333"];
            cell.isZj.text=@"是否中奖";
            cell.isZj.font=[UIFont boldSystemFontOfSize:13];
            cell.isZj.textColor=[UIColor colorWithHexString:@"#333333"];
            cell.jiangPin.text=@"奖品";
            cell.jiangPin.font=[UIFont boldSystemFontOfSize:13];
            cell.jiangPin.textColor=[UIColor colorWithHexString:@"#333333"];
            
            cell.join.text=@"参与时间";
            cell.join.font=[UIFont boldSystemFontOfSize:13];
            cell.join.textColor=[UIColor colorWithHexString:@"#333333"];
            
            
        }
        else{
            cell.phoneNum.textColor=[UIColor colorWithHexString:@"#666666"];
            cell.isZj.textColor=[UIColor colorWithHexString:@"#666666"];
            cell.jiangPin.textColor=[UIColor colorWithHexString:@"#666666"];
            cell.joinTime2.textColor=[UIColor colorWithHexString:@"#666666"];
            cell.jionTime.textColor=[UIColor colorWithHexString:@"#666666"];

            dataModel=[_dataArr objectAtIndex:indexPath.row-1];
            cell.phoneNum.text=dataModel.mobile;
            if ([dataModel.state isEqualToString:@"0"]) {
                 cell.isZj.text=@"否";
            }
            else if([dataModel.state isEqualToString:@"1"]){
            cell.isZj.text=@"是";
            
            }
            cell.jiangPin.text=dataModel.prizeName;
            cell.jionTime.text=[self timeFormat:dataModel.updateTime];

            cell.joinTime2.text=[self secondFormat:dataModel.updateTime];
            
            
        }
    
    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopTabelView) {
        return 44;
    }
    return 48;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopTabelView) {
        [_topTableView removeFromSuperview];
        _isTopTabelView=NO;
        [_naviView removeFromSuperview];
        [_mengBanView removeFromSuperview];
        
        if (_index==indexPath.row) {
            return;
        }
        _page=1;
        [_dataArr removeAllObjects];
        [self requestActiveDeatailDatas:_days andPage:1 zhongjiang:[_zjArr objectAtIndex:indexPath.row]];
        
        _topLabel.text=[_topArr objectAtIndex:indexPath.row];
        _index=indexPath.row;
        
    }
}



-(NSString *)timeFormat :(NSString *)time{
    NSString *str=[time substringToIndex:8];
    NSString *str2=[str substringToIndex:4];
    
    NSString *str3=[str substringWithRange:NSMakeRange(4, 2)];
    
    NSString *str4=[str substringFromIndex:6];
    
    NSString *str5=[NSString stringWithFormat:@"%@-%@-%@",str2,str3,str4];
    
    
    return str5;
}


-(NSString *)secondFormat :(NSString *)time{
    NSString *timeStr=[time substringFromIndex:8];
    NSString *str1=[timeStr substringFromIndex:4];
    NSString *str2=[timeStr substringToIndex:2];
    NSString *str3=[timeStr substringWithRange:NSMakeRange(2, 2)];
    NSString *str4=[NSString stringWithFormat:@"%@:%@:%@",str2,str3,str1];
    
    return str4;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
