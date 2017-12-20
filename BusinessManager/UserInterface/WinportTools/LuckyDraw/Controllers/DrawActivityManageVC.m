//
//  DrawActivityManageVC.m
//  BusinessManager
//
//  Created by smile apple on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "DrawActivityManageVC.h"
#import "RedPacketRechargeVC.h"
#import "DrawActivityCell.h"
#import "CreateActivityVC.h"
#import "DrawAvtivityHeader.h"
#import "EaditDrawActivityVC.h"
#import "billTopCell.h"
#import "LuckDrawModel.h"
 
@interface DrawActivityManageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    DrawAvtivityHeader *headerCell;
    
}
@property(nonatomic,strong)UITableView *sortTableView;// 排序的tableView
@property(nonatomic,strong)NSMutableArray *sortArray;
@property (nonatomic,assign)BOOL isSortTabeView;// 判断是否是排序的tableview
@property (strong,nonatomic)UIView *mengBanView;//
@property (nonatomic,strong)NSMutableArray *activityListArray;//抽奖活动Array
@property(nonatomic,assign)NSInteger pageIndex;
@property (strong,nonatomic)NSMutableArray *typeArr;
@property(nonatomic,assign)NSInteger Index;
@end

@implementation DrawActivityManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"抽奖活动管理";
    UIButton *cashRedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cashRedBtn.frame = CGRectMake(0, 0, 100, 20);
    cashRedBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    cashRedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 1, 0);
    [cashRedBtn setTitle:@"现金红包充值" forState:UIControlStateNormal];
    [cashRedBtn addTarget:self action:@selector(redCashACtion) forControlEvents:UIControlEventTouchUpInside];
    [cashRedBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [cashRedBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];

    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:cashRedBtn];
//    rightBarBtn.imageInsets = UIEdgeInsetsMake(0, 0, 2, 0);
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.addActivityButton.layer.cornerRadius = 5;
    self.addActivityButton.layer.masksToBounds = YES;
    
    self.drawActivityTableView.tableFooterView = [[UIView alloc] init];
     self.typeArr=[NSMutableArray arrayWithObjects:@"1",@"2", nil];
     self.sortArray =[NSMutableArray arrayWithObjects:@"按活动开始时间降序排列",@"按活动结束时间降序排列", nil];
    [self initViews];
    
    self.pageIndex = 1;
    
    WS(weakSelf);
    // 添加下拉刷新头部控件
    self.drawActivityTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestLuckDrawActivityList:weakSelf.pageIndex activitySort:1  ];
    }];
    //添加上提加载更多尾部控件
    self.drawActivityTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf requestLuckDrawActivityList:weakSelf.pageIndex activitySort:1];
    }];
    
//    //开始刷新
//    [self.drawActivityTableView.mj_header beginRefreshing];
//

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestLuckDrawActivityList:1 activitySort:1];
    //开始刷新
    [self.drawActivityTableView.mj_header beginRefreshing];
}
-(void)initViews
{
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    self.isSortTabeView=NO;
    self.sortTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
     self.sortTableView.delegate=self;
     self.sortTableView.dataSource=self;
    self.mengBanView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.mengBanView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    
//    for (UIView *view in _lineViews) {
//        view.backgroundColor=[UIColor colorWithHexString:@"#dadada"];
//    }
    
}
// 现金红包充值按钮
-(void)redCashACtion
{
    RedPacketRechargeVC *vc = [[RedPacketRechargeVC alloc] initWithNibName:@"RedPacketRechargeVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSortTabeView == YES) {
        
        return self.sortArray.count;
    }
    else
    {
       return self.activityListArray.count;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSortTabeView) {
        static NSString *cellIdentifier=@"billTopCell";
        billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.cellLabel.text=[self.sortArray objectAtIndex:indexPath.row];
         cell.cellLabel.font = [UIFont systemFontOfSize:14];
//         cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
        if ([self.sortButton.titleLabel.text isEqualToString:@"按活动开始时间降序排列"]) {
            if (indexPath.row==0) {
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#00aaee"];
                
            }
            else{
                cell.rightImage.hidden=YES;
                cell.cellLabel.textColor=[UIColor colorWithHexString:@"#333333"];
            }
            
        }
        else  if ([self.sortButton.titleLabel.text isEqualToString:@"按活动结束时间降序排列"]) {
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
    else
    {
        static NSString *indentifierCell = @"Cell";
        DrawActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifierCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DrawActivityCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        avtivityListItem *listItem = self.activityListArray[indexPath.row];
        cell.orderNumberLable.text = listItem.ID;
        cell.activityName.text = listItem.name;
        cell.startActivityTimeLable.text = [self timeFormat:listItem.startTime] ;
        cell.endActivityTimeLable.text = [self timeFormat:listItem.endTime];
        return cell;
    }

    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isSortTabeView) {
        
        return nil;
    }
    else
    {
        headerCell = [[[NSBundle mainBundle] loadNibNamed:@"DrawAvtivityHeader" owner:self options:nil] lastObject];
        return headerCell;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isSortTabeView) {
        
        return -1;
    }
    else
    {
        return 44;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSortTabeView)
    {
//        if (indexPath.row==1) {
//            
//            // exchangeObjectAtIndex 交换元素
//            [self.sortArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
//            [self.typeArr exchangeObjectAtIndex:0 withObjectAtIndex:1];
//            
//        }
        
        [self.sortTableView removeFromSuperview];
        [_mengBanView removeFromSuperview];
        self.isSortTabeView=NO;
        if (self.Index ==indexPath.row)
        {
            return;
        }
        [self.sortButton setTitle:[self.sortArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [self requestLuckDrawActivityList:1 activitySort:[[ self.typeArr objectAtIndex:indexPath.row] integerValue]];
        self.Index = indexPath.row;
        
    }
    else
    {
        
        if (self.FromVC == 0) {
            
            if (self.callBack)
            {
                self.callBack(self.activityListArray[indexPath.row]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            EaditDrawActivityVC *vc = [[EaditDrawActivityVC alloc] initWithNibName:@"EaditDrawActivityVC" bundle:nil];
            vc.acItemModel = self.activityListArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}
- (IBAction)addAvtivityAction:(id)sender {
    
    CreateActivityVC *vc = [[CreateActivityVC alloc] initWithNibName:@"CreateActivityVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
// 排序事件
- (IBAction)sortACtion:(id)sender
{
    
    self.isSortTabeView=YES;
    self.sortTableView.frame=CGRectMake(0, CGRectGetMaxY(self.sortButton.frame), SCREEN_SIZE.width, 2*44);
    [self.view addSubview:self.sortTableView];
    
    [self.sortTableView reloadData];

    _mengBanView.frame=CGRectMake(0, CGRectGetMaxY(self.sortTableView.frame), SCREEN_SIZE.width, 1000);
    [self.view addSubview:_mengBanView];
 
}
#pragma  marck requestInfo

-(void)requestLuckDrawActivityList:(NSInteger)pageIndex activitySort:(NSInteger)sort
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@"12" forKey:@"pagesize"];
    [params setObject:@(sort) forKey:@"sort"];
    
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_ActivityList Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic))
        {
         activityListModel *acListModel = [activityListModel mj_objectWithKeyValues:dic];
            //下啦刷新
            if (pageIndex == 1) {
                if (self.activityListArray) {
                    [self.activityListArray removeAllObjects];
                }else {
                    self.activityListArray = [NSMutableArray array];
                }
            }
         
            if (acListModel.data.count > 0)
            {

                [self.activityListArray addObjectsFromArray:acListModel.data];
            }
            else
            {
                //提示数据加载完毕并关闭上啦加载
                [self.drawActivityTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
           [self.drawActivityTableView reloadData];
           [self.drawActivityTableView.mj_header endRefreshing];
            [self.drawActivityTableView.mj_footer endRefreshing];
        }
        else
        {
            
            [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
            [self.drawActivityTableView.mj_header endRefreshing];
            [self.drawActivityTableView.mj_footer endRefreshing];
            
        }
 
        NSLog(@"acticityList ======  %@",dic);
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [self.drawActivityTableView.mj_header endRefreshing];
        [self.drawActivityTableView.mj_footer endRefreshing];
        
        
    }];
    

}

-(NSString *)timeFormat :(NSString *)time{
    
    NSString *str=[time substringToIndex:8];
    NSString *str2=[str substringToIndex:4];
    NSString *str3=[str substringWithRange:NSMakeRange(4, 2)];
    NSString *str4=[str substringFromIndex:6];
    NSString *timeStr=[time substringFromIndex:8];
    NSString *str1=[timeStr substringFromIndex:4];
    NSString *str6=[timeStr substringToIndex:2];
    NSString *str7=[timeStr substringWithRange:NSMakeRange(2, 2)];
    
    NSString *str5=[NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",str2,str3,str4,str6,str7,str1];
    
//    NSString *str8=[NSString stringWithFormat:@"%@:%@:%@",str2,str3,str1];
    
    

    return str5;
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
