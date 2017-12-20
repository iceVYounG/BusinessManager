//
//  checkBillVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#define tableViewMaxHeight SCREEN_SIZE.height-CGRectGetMaxY(_centerView.frame)-15-64-15

#import "checkBillVC.h"
#import "checkBillCell.h"
#import "checkBillDeatailVC.h"
#import "KxMenu.h"
#import "dataCountModel.h"

@interface checkBillVC ()<UITableViewDataSource,UITableViewDelegate>{
    dataMainModel *dataModel;
    dataMoneyModel *dataModel2;
    dataDicModel *dataModel3;
    UIButton *titleBtn;
}
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITableView *billTabelView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels2;
@property (weak, nonatomic) IBOutlet UILabel *topLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *chuzhiNum;
@property (weak, nonatomic) IBOutlet UILabel *xianshangNum;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (assign,nonatomic)NSInteger page;
@property (assign,nonatomic)NSInteger day;

@end

@implementation checkBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr=[NSMutableArray array];
    _page=1;
    _day=30;
    [self initView];
    
    [self addRefresh];
    [self requestCheckBillDatas:30 page:1];

}


-(void)addRefresh{
    
    WS(weakSelf);
    
    self.billTabelView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestCheckBillDatas:_day page:_page];
    
    }];
}

-(void)initView{
    _topLable.text=@"最近30天收入总额 : ";
    _moneyLabel.text=@"加载中";
    _xianshangNum.text=@"加载中";
    _chuzhiNum.text=@"加载中";
    self.leftTitle=@"对账";
    titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    titleBtn.frame=CGRectMake(self.leftItem.width+5, 0, 90, self.leftItem.height);
    [titleBtn setTitle:@"最近30日  " forState:UIControlStateNormal];
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

    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];

    _moneyLabel.textColor=[UIColor colorWithHexString:@"#f15a4a"];
    _centerView.layer.borderWidth=.5;
    _centerView.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;
    
    for (UILabel *label in _labels) {
        label.textColor=[UIColor colorWithHexString:@"#333333"];
        label.font=[UIFont boldSystemFontOfSize:13];
        label.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    }
    
    for (UILabel *label in _labels2) {
        label.textColor=[UIColor colorWithHexString:@"#666666"];
    }
    
    _topLable.textColor=[UIColor colorWithHexString:@"#333333"];
    _tableViewHeight.constant=0;
    
}



#pragma mark --数据请求--

-(void)requestCheckBillDatas:(NSInteger)day page:(NSInteger )page{
//    storeId：商户ID(必须)
//    days：最近天数（当type为1时，必须）
//    page：当前页数（非必传  默认第一页）
//    pageSize：：每页数据大小（非必传   默认为15）
//type:日期类型（非必须，1为最近天数，2为时间段，不传默认为1）
//startDate:开始时间（当type为2时，必须  yyyyMMddhhmmss）
//endDate:开始时间（当type为2时，必须  yyyyMMddhhmmss）
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];  //商户ID
    [params setObject:@(day) forKey:@"days"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(15) forKey:@"pagesize"];
//    [params setObject:@(1) forKey:@"type"];
//    [params setObject:@(10) forKey:@"startDate"];
//    [params setObject:@(10) forKey:@"endData"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:.8];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_CheckBill Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
         dataModel =[[dataMainModel alloc]init];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        
        if (Succeed(dic)) {
            
             dataModel=[dataMainModel mj_objectWithKeyValues:dic[@"data"]];
            
            NSMutableArray *dataArr2=[NSMutableArray array];
            
            for (dataMoneyModel *model in dataModel.data) {
                [dataArr2 addObject:model];
            }
            
            [_dataArr addObjectsFromArray:dataArr2];
            
            dataModel3=[dataDicModel mj_objectWithKeyValues:dataModel.moneyTotalInfo];
            _xianshangNum.text=@"暂无";
            _moneyLabel.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)dataModel3.MONEY_TOTAL.integerValue/100.f];
        
            _chuzhiNum.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)(dataModel3.VIPCARD_MONEY_TOTAL.integerValue)/100.f];
            
            if (_dataArr.count*48>tableViewMaxHeight) {
                _tableViewHeight.constant=tableViewMaxHeight;
                [self.billTabelView.mj_footer setHidden:NO];

            }
            else{
                
                _tableViewHeight.constant=_dataArr.count*48;
                [self.billTabelView.mj_footer setHidden:YES];
            
            }
            
            [_billTabelView reloadData];
            
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            
           
            NSInteger pageCount=dataModel.pageCount.integerValue;
            
            if (_page==pageCount) {
                
                [self.billTabelView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            _page++;
            [self.billTabelView.mj_footer endRefreshing];
           
        }
        
        else{
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];            
            [self.billTabelView.mj_footer endRefreshing];
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
        [self.billTabelView.mj_footer endRefreshing];

        
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
                  fromRect:CGRectMake(CGRectGetMinX(titleBtn.frame)+35, self.navigationController.navigationBar.frame.origin.y-25, 40, 60)
                 menuItems:menuItems];
}

#pragma mark  KxMenuItemAction--

-(void)recent30Btn
{
    [_dataArr removeAllObjects];
    _topLable.text=@"最近30天收入总额 : ";
    [titleBtn setTitle:@"最近30日  " forState:UIControlStateNormal];
    [self requestCheckBillDatas:30 page:1];
    _day=30;
    _page=1;
}


-(void)recent7Btn
{
    [_dataArr removeAllObjects];
    _topLable.text=@"最近7天收入总额 : ";
    [titleBtn setTitle:@"最近7日" forState:UIControlStateNormal];
    [self requestCheckBillDatas:7 page:1];
    _day=7;
    _page=1;
}

-(void)todayBtn
{
    [_dataArr removeAllObjects];
    _topLable.text=@"最近1天收入总额 : ";
    [titleBtn setTitle:@"今日" forState:UIControlStateNormal];
    [self requestCheckBillDatas:1 page:1];
    _day=1;
    _page=1;
    
}


#pragma mark  UITableViewdelegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *cellIdentifier=@"checkBillCell";
        checkBillCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        dataModel2=[_dataArr objectAtIndex:indexPath.row];
    
    NSString *str=dataModel2.STATISTIC_DATE;
    
    NSString *str2=[str substringToIndex:4];
    
    NSString *str3=[str substringWithRange:NSMakeRange(4, 2)];
    
    NSString *str4=[str substringFromIndex:6];
    
    NSString *str5=[NSString stringWithFormat:@"%@-%@-%@",str2,str3,str4];
    
    cell.timeNumber.text=str5;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    checkBillDeatailVC *vc=[[checkBillDeatailVC alloc]initWithNibName:nil bundle:nil];
    dataModel2=[_dataArr objectAtIndex:indexPath.row];
    
    vc.date=dataModel2.STATISTIC_DATE;
    
    [self.navigationController pushViewController:vc animated:YES];

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
