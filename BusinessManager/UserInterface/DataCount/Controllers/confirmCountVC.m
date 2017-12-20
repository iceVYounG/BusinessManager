//
//  confirmCountVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#define tableViewMaxHeight SCREEN_SIZE.height-206

#import "confirmCountVC.h"
#import "checkBillCell.h"
#import "KxMenu.h"
#import "confirmCountDeatailVC.h"
#import "billTopCell.h"
#import "dataCountModel.h"
@interface confirmCountVC ()<UITableViewDelegate,UITableViewDataSource>{        dataMainModel *mainModel;
    dataMoneyModel *dataModel;
    dataDicModel *dicModel;
    UIView *naviView;
    UIButton *titleBtn;
    UIView *mengbanView;

}
@property (weak, nonatomic) IBOutlet UILabel *topMomey;
@property (weak, nonatomic) IBOutlet UIView *topBGView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *chuzhiLabel;
@property (weak, nonatomic) IBOutlet UILabel *redBagLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *chuzhiNum;
@property (weak, nonatomic) IBOutlet UILabel *redBagNum;
@property (weak, nonatomic) IBOutlet UILabel *discoutNum;
@property (strong, nonatomic)UITableView *dropTabelView;
@property (assign,nonatomic)BOOL isTopcell;
@property (strong,nonatomic)NSMutableArray *topArr;
@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)NSMutableArray *days;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (assign,nonatomic)NSInteger index;
@property (strong,nonatomic)NSMutableArray *topLabelArr;
@end

@implementation confirmCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"验证统计";
    [self initView];
    _page=1;
    _dataArr=[NSMutableArray array];
    _days=[NSMutableArray arrayWithObjects:@"7",@"30",@"365", nil];
    _topArr=[NSMutableArray arrayWithObjects:@"最近7天    ",@"最近30天    ",@"最近一年    ", nil];
    _topLabelArr=[NSMutableArray arrayWithObjects:@"最近7天验证总量 : ",@"最近30天验证总量 : ",@"最近一年验证总量 : ", nil];
    [self requestConfirmCountDatas:7 andPage:1];
    [self addRefresh];
    
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
    
    _topView.layer.borderWidth=.5;
    _topView.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;
   
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    _chuzhiLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    _chuzhiLabel.font=[UIFont boldSystemFontOfSize:13];
    
    _redBagLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    _redBagLabel.font=[UIFont boldSystemFontOfSize:13];
    
    _discountLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    _discountLabel.font=[UIFont boldSystemFontOfSize:13];
    
    _chuzhiNum.textColor=[UIColor colorWithHexString:@"#666666"];
    _redBagNum.textColor=[UIColor colorWithHexString:@"#666666"];
    _discoutNum.textColor=[UIColor colorWithHexString:@"#666666"];
    
    _topBGView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    _topLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    _topMomey.textColor=[UIColor colorWithHexString:@"#f15a4a"];
    
    _dropTabelView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _dropTabelView.delegate=self;
    _dropTabelView.dataSource=self;
    _dropTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    mengbanView=[[UIView alloc]initWithFrame:CGRectZero];
    mengbanView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.6];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(naviAction)];
    naviView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [naviView addGestureRecognizer:tap];
}

-(void)naviAction{

    [_dropTabelView removeFromSuperview];
    [mengbanView removeFromSuperview];
    [naviView removeFromSuperview];
    _isTopcell=NO;
}

-(void)addRefresh{
    
    WS(weakSelf);
    
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestConfirmCountDatas:[[_days objectAtIndex:_index] integerValue] andPage:_page];
        
    }];
}


-(void)requestConfirmCountDatas:(NSInteger)day andPage:(NSInteger )page{
    
    
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
    [SVProgressHUD showWithStatus:@"数据请求中.."];
    
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_ConfirmCount Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
  
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        
        if (Succeed(dic)) {
            
            mainModel=[dataMainModel mj_objectWithKeyValues:dic[@"data"]];
            
            dicModel=[dataDicModel mj_objectWithKeyValues:mainModel.moneyTotalInfo];
            _topMomey.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)dicModel.MONEY_TOTAL.integerValue/100.f];
            _chuzhiNum.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)dicModel.VIPCARD_MONEY_TOTAL.integerValue/100.f];
            _redBagNum.text=[NSString stringWithFormat:@"￥%.2f",(CGFloat)dicModel.HB_MONEY_TOTAL.integerValue/100.f];
            _discoutNum.text=dicModel.YHK_NUM_TOTAL;
            NSMutableArray *dataArr2=[NSMutableArray array];
            
            for (dataMoneyModel *model in mainModel.data) {
                [dataArr2 addObject:model];
            }
            
            [_dataArr addObjectsFromArray:dataArr2];

            if (_dataArr.count*48>tableViewMaxHeight) {
                _tableViewHeight.constant=tableViewMaxHeight;
               self.tableView.mj_footer.hidden=NO;
            }
            else{
                 self.tableView.mj_footer.hidden=YES;
                _tableViewHeight.constant=_dataArr.count*48;
                
            }
            [_tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            if (mainModel.pageCount.integerValue==_page) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            
            
             [self.tableView.mj_footer endRefreshing];
            _page++;
//            [self.tableView.mj_footer resetNoMoreData];
            
        }
        
        else{
            
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙"];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_dropTabelView removeFromSuperview];
    [mengbanView removeFromSuperview];
    [naviView removeFromSuperview];
}


-(void)selectDay{
    _isTopcell=YES;
    _dropTabelView.frame=CGRectMake(0, 0, SCREEN_SIZE.width, 3*44);
    mengbanView.frame=CGRectMake(0, CGRectGetMaxY(_dropTabelView.frame), SCREEN_SIZE.width, 1000);
    [self.view addSubview:mengbanView];
    
    [self.view addSubview:_dropTabelView];
    
    _isTopcell=YES;
    
    naviView.frame=CGRectMake(0, 0, SCREEN_SIZE.width, 64);
    [self.navigationController.view addSubview:naviView];
    [_dropTabelView reloadData];
    
    NSLog(@"%f",titleBtn.frame.origin.x);
    
}

#pragma mark  UITableViewdelegate--

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_isTopcell) {
        return 3;
    }
    
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isTopcell) {
        static NSString *cellIdentifier=@"billTopCell";
        billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.cellLabel.text=[_topArr objectAtIndex:indexPath.row];
        
        if ([titleBtn.titleLabel.text isEqualToString:@"最近7天    "]) {
            if (indexPath.row==0) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
                
                cell.rightImage.hidden=YES;
            }
        }
        if ([titleBtn.titleLabel.text isEqualToString:@"最近30天    "]) {
            if (indexPath.row==1) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
                
                cell.rightImage.hidden=YES;
            }
        }
        
        if ([titleBtn.titleLabel.text isEqualToString:@"最近一年    "]) {
            if (indexPath.row==2) {
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
    static NSString *cellIdentifier=@"checkBillCell";
    checkBillCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
            }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        dataModel =[_dataArr objectAtIndex:indexPath.row];
        NSString *str=dataModel.STATISTIC_DATE;
        
        NSString *str2=[str substringToIndex:4];
        
        NSString *str3=[str substringWithRange:NSMakeRange(4, 2)];
        
        NSString *str4=[str substringFromIndex:6];
        
        NSString *str5=[NSString stringWithFormat:@"%@-%@-%@",str2,str3,str4];
        
        cell.timeNumber.text=str5;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopcell) {
        return 44;
    }
    return 48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopcell) {
        
        _isTopcell=NO;
        [_dropTabelView removeFromSuperview];
        [mengbanView removeFromSuperview];
        [naviView removeFromSuperview];

        if (_index==indexPath.row) {
            
            return;
        }
        
        _topLabel.text=[_topLabelArr objectAtIndex:indexPath.row];
        [titleBtn setTitle:[_topArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [_dataArr removeAllObjects];
        _page=1;
        [self requestConfirmCountDatas:[[_days objectAtIndex:indexPath.row] integerValue] andPage:1];
        _index=indexPath.row;
        
        
    }
    else{
    
    confirmCountDeatailVC *vc=[[confirmCountDeatailVC alloc]initWithNibName:nil bundle:nil];
        dataModel=[_dataArr objectAtIndex:indexPath.row];
        vc.date=dataModel.STATISTIC_DATE;
        

    [self.navigationController pushViewController:vc animated:YES];
        
    }
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
