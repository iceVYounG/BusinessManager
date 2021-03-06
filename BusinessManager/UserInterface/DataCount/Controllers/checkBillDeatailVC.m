//
//  checkBillDeatailVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#define topCellHeight 44
#define tableViewMaxHeight SCREEN_SIZE.height-240

#import "checkBillDeatailVC.h"
#import "billDetaliCell.h"
#import "billTopCell.h"
#import "dataCountModel.h"
@interface checkBillDeatailVC ()<UITableViewDelegate,UITableViewDataSource>{
    checkDeatalModel *mainModel;
    dataDicModel *dicModel;
    checkDeatalDataModel *dataModle;
}
@property (weak, nonatomic) IBOutlet UITableView *billDetailTableView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *dayLaebl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels1;
@property (weak, nonatomic) IBOutlet UILabel *xianshangMoney;
@property (weak, nonatomic) IBOutlet UILabel *chuzhiMoney;
@property(nonatomic,strong)UITableView *topTableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property(strong,nonatomic)NSMutableArray *topArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property(assign,nonatomic)NSInteger index;
@property(assign,nonatomic)BOOL isTopCell;
@property(strong,nonatomic)UIView *mengBanView;
@property(strong,nonatomic)NSMutableArray *dataArr;
@property(strong,nonatomic)NSMutableArray *typeArr;
@property(assign,nonatomic)NSInteger page;
@property(strong,nonatomic)UIView *naviView;
@property(strong,nonatomic)UIView *noDataView;
@end

@implementation checkBillDeatailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"对账详情";
    [self initView];
    [self addRefresh];
    _dataArr=[NSMutableArray array];
    _typeArr=[[NSMutableArray alloc]initWithObjects:@"2",@"1", nil];
    _topArr=[[NSMutableArray alloc]initWithObjects:@"按验证时间降序  ",@"按验证时间升序  ", nil];
    
    _page=1;
    [self requestCheckDeatailDatas:_date andtype:2 andPage:1];
    
}


-(void)initView{
    [_topBtn setTitle:@"按验证时间降序  " forState:UIControlStateNormal];
    [_topBtn setTitleColor:[UIColor colorWithHexString:@"#00aaee"] forState:UIControlStateNormal];
    _topBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _topBtn.titleLabel.bounds.size.width+108, 0, 0)];
    
    
    _centerView.layer.borderWidth=.5;
    _centerView.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    _mengBanView=[[UIView alloc]initWithFrame:self.view.frame];
    [_mengBanView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    
    _topTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _topTableView.delegate=self;
    _topTableView.dataSource=self;
    _topTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    for (UILabel *label in _labels1) {
        label.textColor=[UIColor colorWithHexString:@"#333333"];
        label.font=[UIFont boldSystemFontOfSize:13];
        label.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    }
    
    _xianshangMoney.textColor=[UIColor colorWithHexString:@"#333333"];
    _chuzhiMoney.textColor=[UIColor colorWithHexString:@"#333333"];
    
    
    NSString *str2=[_date substringToIndex:4];
    
    NSString *str3=[_date substringWithRange:NSMakeRange(4, 2)];
    
    NSString *str4=[_date substringFromIndex:6];
    
    NSString *str5=[NSString stringWithFormat:@"%@-%@-%@",str2,str3,str4];
    
    
    _dayLaebl.text=[NSString stringWithFormat:@"%@收入总额 : ",str5];
    
    
    _naviView=[[UIView alloc]initWithFrame:CGRectZero];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(naviAction)];
    [_naviView addGestureRecognizer:tap];
    _xianshangMoney.text=@"加载中";
    _chuzhiMoney.text=@"加载中";
    _moneyLabel.text=@"加载中";
    
    _noDataView=[[NSBundle mainBundle]loadNibNamed:@"noDataView" owner:self options:nil].firstObject;
    
    _noDataView.frame=CGRectMake(0, CGRectGetMaxY(_centerView.frame)+91, SCREEN_SIZE.width, 1000);
    _tableViewHeight.constant=45;
}



-(void)addRefresh{
    
    WS(weakSelf);
    
    self.billDetailTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestCheckDeatailDatas:_date andtype:[[_typeArr objectAtIndex:_index] integerValue] andPage:_page];
        
        [weakSelf.billDetailTableView.mj_footer endRefreshing ];
    }];
}




-(void)requestCheckDeatailDatas:(NSString *)date andtype :(NSInteger )type andPage:(NSInteger)page{
    [_noDataView removeFromSuperview];
//    参数：	storeId：商户ID(必须)
//date: 日期(必须  yyyyMMdd)
//    mobile：手机号码(非必填)
//    page：当前页数（非必传  默认第一页）
//    pageSize：：每页数据大小（非必传   默认为15）
//    sortType：排序类型（1：验证时间升序，2：验证时间降序   默认为2）
//    入口参数：{"storeId":"900000000069", "date":"20160224","mobile":"13584806632" }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];  //商户ID
    [params setObject:date forKey:@"date"];
//    [params setObject:AccountInfo.linkPhone forKey:@"mobile"];
    [params setObject:@(type)forKey:@"sortType"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(15) forKey:@"pagesize"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:.8];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_CheckBillDeatail Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
          NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
           
            mainModel=[checkDeatalModel mj_objectWithKeyValues:dic[@"data"]];
            
            
            dicModel=[dataDicModel mj_objectWithKeyValues:mainModel.totalPrice];
            
            _moneyLabel.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)dicModel.MONEY_TOTAL.integerValue/100.f];
            
            _xianshangMoney.text=@"暂无";
         
            _chuzhiMoney.text=[NSString stringWithFormat:@"%.2f",(CGFloat)(dicModel.VIPCARD_MONEY_TOTAL.integerValue)/100.f];

            NSMutableArray *dataArr2=[NSMutableArray array];
            
            for (checkDeatalDataModel *model in mainModel.data) {
                [dataArr2 addObject:model];
            }
            
            [_dataArr addObjectsFromArray:dataArr2];
            if (_dataArr.count==0) {
                [self.view addSubview:_noDataView];
            }
            
            if (_dataArr.count*48+48>tableViewMaxHeight) {
                _tableViewHeight.constant=tableViewMaxHeight;
                [self.billDetailTableView.mj_footer setHidden:NO];
            }
            else{
                _tableViewHeight.constant=_dataArr.count*48+48;
                 [self.billDetailTableView.mj_footer setHidden:YES];
                
            }
            
            [_billDetailTableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            if (mainModel.pageCount.integerValue==_page) {
                
                [self.billDetailTableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            
            _page++;
            [self.billDetailTableView.mj_footer endRefreshing];
        }
        else{
            
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
            [self.billDetailTableView.mj_footer endRefreshing];
            
        }
    
    }ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
        [self.billDetailTableView.mj_footer endRefreshing];
    }];
}

-(void)naviAction{
    
    [_topTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopCell=NO;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_topTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopCell=NO;

}



- (IBAction)topBtnAction:(id)sender {
    
    
    _topTableView.frame=CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_SIZE.width,topCellHeight*2);
    
    _mengBanView.frame=CGRectMake(0, CGRectGetMaxY(_topTableView.frame), SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    [self.view addSubview:_mengBanView];
    [self.view addSubview:_topTableView];
    _isTopCell=YES;
    
    _naviView.frame=CGRectMake(0, 0, SCREEN_SIZE.width, 64);
    [self.navigationController.view addSubview:_naviView];
    
    [_topTableView reloadData];
}


#pragma mark UITableViewdelegate--

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isTopCell) {
        return 2;
    }
    
    return _dataArr.count+1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopCell) {
        static NSString *cellIdentifier=@"billTopCell";
        billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.cellLabel.text=[_topArr objectAtIndex:indexPath.row];
        
        if ([_topBtn.titleLabel.text isEqualToString:@"按验证时间降序  "]) {
            if (indexPath.row==0) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
                
                cell.rightImage.hidden=YES;
            }
 
        }
        
        else{
        
        
            if (indexPath.row==1) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
                
                cell.rightImage.hidden=YES;
            }

        
        }
        
        return cell;
    }
    
    else{
    static NSString *cellIdentifier=@"billDetaliCell";
    billDetaliCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0) {
        cell.phoneNumber.text=@"用户手机号码";
        cell.phoneNumber.font=[UIFont boldSystemFontOfSize:13];
        cell.phoneNumber.textColor=[UIColor colorWithHexString:@"#333333"];
        cell.chuzhiLabel.text=@"交易类型";
        cell.chuzhiLabel.font=[UIFont boldSystemFontOfSize:13];
        cell.chuzhiLabel.textColor=[UIColor colorWithHexString:@"#333333"];
        cell.moneyNumber.text=@"消费金额";
        cell.moneyNumber.font=[UIFont boldSystemFontOfSize:13];
        cell.moneyNumber.textColor=[UIColor colorWithHexString:@"#333333"];
    }
    else{
        dataModle=[_dataArr objectAtIndex:indexPath.row-1];
        
        cell.phoneNumber.text=dataModle.MOBLE;
        if ([dataModle.TYPE isEqualToString:@"1"]) {
            cell.chuzhiLabel.text=@"会员卡";
        }
        else{
            cell.chuzhiLabel.text=@"红包";

        
        }
        
        cell.moneyNumber.text=[NSString stringWithFormat:@"%.2f",dataModle.AMT.integerValue/100.f];


    }
    
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_topTableView) {
        return topCellHeight;
    }
    
    return 48;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isTopCell) {
        [_topTableView removeFromSuperview];
        _isTopCell=NO;
        [_mengBanView removeFromSuperview];
        [_naviView removeFromSuperview];
        

        if (_index==indexPath.row) {
            
            return;
        }
        [_topBtn setTitle:[_topArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [_dataArr removeAllObjects];
        _page=1;
        [self requestCheckDeatailDatas:_date andtype:[[_typeArr objectAtIndex:indexPath.row] integerValue] andPage:1];
        }
        _index=indexPath.row;
    
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
