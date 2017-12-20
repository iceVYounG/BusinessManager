//
//  activeCountVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//
#define tableViewMaxHeight SCREEN_SIZE.height-122
#import "activeCountVC.h"
#import "activeCell.h"
#import "billTopCell.h"
#import "activeCountDeatailVC.h"
#import "dataCountModel.h"
@interface activeCountVC ()<UITableViewDataSource,UITableViewDelegate>{

    activeCountModel *mainModel;
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (strong,nonatomic)UITableView *dropTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (assign,nonatomic)BOOL isTopTableView;
@property (strong,nonatomic)NSMutableArray *topArr;
@property (strong,nonatomic)UIView *mengBanView;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *typeArr;
@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)UIView *naviView;
@property (assign,nonatomic)NSInteger index;
@property (strong,nonatomic)UIView *noDataView;
@end

@implementation activeCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"活动统计";
    [self initView];
    _topArr=[NSMutableArray arrayWithObjects:@"按活动开始时间降序  ",@"按活动结束时间降序  ", nil];
    _typeArr=[NSMutableArray arrayWithObjects:@"1",@"2", nil];
    _dataArr=[NSMutableArray array];
    _page=1;
    [self addRefresh];
    [self requestActiveDatas:1 andPage:1];
    self.tableView.showsVerticalScrollIndicator=NO;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    
    [_topBtn setTitle:@"按活动开始时间降序  " forState:UIControlStateNormal];
    [_topBtn setTitleColor:[UIColor colorWithHexString:@"#00aaee"] forState:UIControlStateNormal];
    [_topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 135, 0, 0)];

    
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    _isTopTableView=NO;
    _dropTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _dropTableView.delegate=self;
    _dropTableView.dataSource=self;
    _mengBanView=[[UIView alloc]initWithFrame:CGRectZero];
    [_mengBanView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    
    _naviView=[[UIView alloc]initWithFrame:CGRectZero];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(naviAction)];
    [_naviView addGestureRecognizer:tap];
    
    _noDataView=[[NSBundle mainBundle]loadNibNamed:@"noDataView" owner:self options:nil].firstObject;
    _noDataView.frame=CGRectMake(0, 105, SCREEN_SIZE.width, 1000);


}

-(void)addRefresh{
    
    WS(weakSelf);
    
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSLog(@"%ld",_page);
        
        [weakSelf requestActiveDatas:[[_typeArr objectAtIndex:_index] integerValue] andPage:_page];
        
    }];
}



- (IBAction)topAction:(id)sender {
    _isTopTableView=YES;
    _dropTableView.frame=CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_SIZE.width, 2*44);
    [self.view addSubview:_dropTableView];
    
    [_dropTableView reloadData];
    
    _mengBanView.frame=CGRectMake(0, CGRectGetMaxY(_dropTableView.frame), SCREEN_SIZE.width, 1000);
    [self.view addSubview:_mengBanView];
    
    _naviView.frame=CGRectMake(0, 0, SCREEN_SIZE.width, 64);
    [self.navigationController.view addSubview:_naviView];
    
    
}


-(void)naviAction{

    [_dropTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopTableView=NO;

}


-(void)requestActiveDatas:(NSInteger)type andPage:(NSInteger)page{
    [_noDataView removeFromSuperview];
    
//    参数：  storeId：商户ID(必须) sort：非必传（默认1：表示开始时间降序  2：表示结束时间降序）    page：非必传 （默认1，表示第一页）    pagesize:非必传（默认20，表示每页20条） activeId：非必传     activeName：非必传  startTime：非必传(格式：20160505000000)   endTime：非必传 (格式：20160505000000)
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];  //商户ID
    [params setObject:@(type) forKey:@"sort"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(20) forKey:@"pagesize"];
    
    //    [params setObject:@(10) forKey:@"startDate"];
    //    [params setObject:@(10) forKey:@"endData"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:.8];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_ActiveCount Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
             NSMutableArray *dataArr2=[NSMutableArray array];
            NSMutableArray *dicArr=dic[@"data"];
            
            for (NSDictionary *dic in dicArr) {
                mainModel=[activeCountModel mj_objectWithKeyValues:dic];
                [dataArr2 addObject:mainModel];
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_dropTableView removeFromSuperview];
    [_mengBanView removeFromSuperview];
    [_naviView removeFromSuperview];
    _isTopTableView=NO;
    
}



#pragma mark UITableViewDataSource--

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isTopTableView) {
        return 2;
    }

    return _dataArr.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isTopTableView) {
        static NSString *cellIdentifier=@"billTopCell";
        billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.cellLabel.text=[_topArr objectAtIndex:indexPath.row];
       
        if ([_topBtn.titleLabel.text isEqualToString:@"按活动开始时间降序  "]) {
            if (indexPath.row==0) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
  
        }
        
        
      else  if ([_topBtn.titleLabel.text isEqualToString:@"按活动结束时间降序  "]) {
            if (indexPath.row==1) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
            
        }
        return cell;

    }
    
    static NSString *identifier=@"activeCell";
    activeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil].firstObject;
    }
        
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.activeNum.text=@"活动编号";
        cell.activeNum.font=[UIFont boldSystemFontOfSize:13];
        cell.activeNum.textColor=[UIColor colorWithHexString:@"#333333"];
        cell.activeName.text=@"活动名称";
        cell.activeName.font=[UIFont boldSystemFontOfSize:13];
        cell.activeName.textColor=[UIColor colorWithHexString:@"#333333"];
        cell.start.text=@"开始时间";
        cell.start.font=[UIFont boldSystemFontOfSize:13];
        cell.start.textColor=[UIColor colorWithHexString:@"#333333"];
        cell.over.text=@"结束时间";
        cell.over.font=[UIFont boldSystemFontOfSize:13];
        cell.over.textColor=[UIColor colorWithHexString:@"#333333"];
    }
    else{
        cell.activeNum.textColor=[UIColor colorWithHexString:@"#666666"];
        cell.activeName.textColor=[UIColor colorWithHexString:@"#666666"];
        cell.startTime.textColor=[UIColor colorWithHexString:@"#666666"];
        cell.startTime2.textColor=[UIColor colorWithHexString:@"#666666"];
        cell.overTime.textColor=[UIColor colorWithHexString:@"#666666"];
        cell.overTime2.textColor=[UIColor colorWithHexString:@"#666666"];
        mainModel=[_dataArr objectAtIndex:indexPath.row-1];
    
        cell.activeNum.text=mainModel.activId;
        cell.activeName.text=mainModel.name;
        
        cell.startTime.text=[self timeFormat:mainModel.startTime];
        cell.startTime2.text=[self secondFormat:mainModel.startTime];
        
        cell.overTime.text=[self timeFormat:mainModel.endTime];
        cell.overTime2.text=[self secondFormat:mainModel.endTime];
        
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopTableView) {
        return 44;
    }
    return 48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTopTableView) {
        [_dropTableView removeFromSuperview];
        [_mengBanView removeFromSuperview];
        _isTopTableView=NO;
        [_naviView removeFromSuperview];
        
        if (_index==indexPath.row) {
            
            return;
        }
       
        [_dataArr removeAllObjects];
        _page=1;
        [self requestActiveDatas:[[_typeArr objectAtIndex:indexPath.row] integerValue] andPage:1];
        [_topBtn setTitle:[_topArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        _index=indexPath.row;
        
    }
    else{
        mainModel=[_dataArr objectAtIndex:indexPath.row-1];
        
      
        activeCountDeatailVC *vc=[[activeCountDeatailVC alloc]initWithNibName:nil bundle:nil];
        
       vc.activeId = mainModel.activId;

        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

#pragma mark  ---转换日期格式---

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