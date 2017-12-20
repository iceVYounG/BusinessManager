//
//  MessagePushMainVC.m
//  BusinessManager
//
//  Created by 周迎春 on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "MessagePushMainVC.h"
#import "PushTableViewCell.h"
#import "pushTypeChooseCell.h"
#import "MPAddNewPushVC.h"
#import "MPBuyMessageVC.h"
#import "MPMsgPushDetailVC.h"
#import "MPMsgEditVC.h"
#import "typeModel.h"  //为了记录类型选择 BOOL isSelect
#import "MsgPushModel.h"


#define kWidth self.view.frame.size.width
#define kheight self.view.frame.size.height
#define KcellHeight 48

@interface MessagePushMainVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *carrierView1;
@property (weak, nonatomic) IBOutlet UILabel *pushTypeLB;//推送类型Label
@property (weak, nonatomic) IBOutlet UIButton *addPushBtn;//添加推送消息Btn
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UITableView *pushTableview;//展示界面tableview
@property (nonatomic, strong) UITableView *pushTypeTableview;//类型选择tableview
@property (nonatomic, assign) BOOL isOpen;//判断类型选择弹框
@property (nonatomic, strong) NSMutableArray *typeModelArr;
@property (nonatomic, strong) UIView *mengcengView;
@property (nonatomic, strong) NSMutableArray *dataArray; //存贮数据
@property (nonatomic, assign) NSUInteger pageIndex;  //

@property (weak, nonatomic) IBOutlet UILabel *leaveMsgNumLB;

@end

@implementation MessagePushMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.leftTitle = @"短彩信推送管理";
    self.title = @"短彩信推送管理";
    //购买短信button
    UIBarButtonItem *buyMsgBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"购买短信" style:(UIBarButtonItemStylePlain) target:self action:@selector(buyMsgAction1)];
    self.navigationItem.rightBarButtonItem = buyMsgBarBtn;
    
    //新增推送btn
    [self.addPushBtn.layer setCornerRadius:4];
    self.addPushBtn.layer.masksToBounds = YES;
    //注册cell类型
    [self.pushTableview registerNib:[UINib nibWithNibName:@"PushTableViewCell" bundle:nil] forCellReuseIdentifier:@"pushcell"];
    self.pushTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.pushTableview.backgroundColor = [UIColor whiteColor];
    self.pushTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //创建类型选择
     [self creatPushTypeTableview];
    
    //model
    NSArray *typeArr = @[@"全部",@"未推送",@"推送中",@"已推送"];
    self.typeModelArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        typeModel *model = [[typeModel alloc]init];
        model.typeTitle = typeArr[i];
        [self.typeModelArr addObject:model];
    }
    
    self.pageIndex = 1;
    
    WS(weakSelf);
    // 添加下拉刷新头部控件
    self.pushTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1; //重置 为1；
        if ([self.pushTypeLB.text isEqualToString:@"全部"]) {
            [weakSelf requestListData:weakSelf.pageIndex sendState:@""];
        }else if ([self.pushTypeLB.text isEqualToString:@"未推送"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"1"];
        }else if ([self.pushTypeLB.text isEqualToString:@"推送中"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"2"];
        }else if ([self.pushTypeLB.text isEqualToString:@"已推送"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"3"];
        }
        
    }];
    //添加上提加载更多尾部控件
    self.pushTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++; //先加加 再使用
        
        if ([self.pushTypeLB.text isEqualToString:@"全部"]) {
            [weakSelf requestListData:weakSelf.pageIndex sendState:@""];
        }else if ([self.pushTypeLB.text isEqualToString:@"未推送"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"1"];
        }else if ([self.pushTypeLB.text isEqualToString:@"推送中"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"2"];
        }else if ([self.pushTypeLB.text isEqualToString:@"已推送"]){
            [weakSelf requestListData:weakSelf.pageIndex sendState:@"3"];
        }
    }];
    //开始刷新
//    [self.pushTableview.mj_header beginRefreshing];
    //请求剩余短信
//    [self requestLeaveMsgNumData];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开始刷新
    [self.pushTableview.mj_header beginRefreshing];
    //请求剩余短信
    [self requestLeaveMsgNumData];
    
}

#pragma mark - 请求剩余短信条数 -
- (void)requestLeaveMsgNumData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *account = NoNullStr(AccountInfo.storeId, @"");
    double storeId = [account doubleValue];
    [params setObject:@(storeId) forKey:@"storeId"];  //商户ID
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_MPBuyMessage_leaveMsgNum Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSDictionary *dataDic = dic[@"data"];
        if (Succeed(dic)) {
            self.leaveMsgNumLB.text = [NSString stringWithFormat:@"%@ 条", dataDic[@"num"]];
        }
        
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 购买短信跳转 -
-(void)buyMsgAction1{
    MPBuyMessageVC *mpBuyMessageVC = [[MPBuyMessageVC alloc]initWithNibName:@"MPBuyMessageVC" bundle:nil];
    NSString *leaveNum = self.leaveMsgNumLB.text;;
    mpBuyMessageVC.leaveNum = leaveNum;
    [self.navigationController pushViewController:mpBuyMessageVC animated:YES];
    
}

#pragma mark - 新增推送界面跳转 -
- (IBAction)addPushAction:(id)sender {
    MPAddNewPushVC *vc = [[MPAddNewPushVC alloc] initWithNibName:@"MPAddNewPushVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 推送类型选择点击事件 -
- (IBAction)pushTypeChooseAction:(id)sender {
   //什么操作都没有  简单的打开 收起选择项  单选情况下 多选逻辑需要打开注释
    if (self.isOpen) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pushTypeTableview.frame = CGRectMake(0, self.carrierView1.frame.size.height, kWidth, 0);
            self.isOpen = NO;
            //再次打开弹框 将√清除
//            for (pushTypeChooseCell *cell in self.pushTypeTableview.visibleCells) {
//                cell.selectImage.hidden = YES;
//                cell.isSelect = NO;
//            }
            //可以拿到哪些model是点击状态
            
            //将model全部置为没点击过状态
//            for (typeModel *model in self.typeModelArr)
//            {
//                if (model.isSelect) {
//                    if ([model.typeTitle isEqualToString:@"未推送"])
//                    {
//                        NSLog(@"选择未推送");
//                    }else if ([model.typeTitle isEqualToString:@"推送中"])
//                    {
//                        NSLog(@"选择推送中");
//                    }else if([model.typeTitle isEqualToString:@"已推送"])
//                    {
//                        NSLog(@"选择已推送");
//                    }else{
//                        NSLog(@"全部");
//                    }
//                }
//                model.isSelect = NO;
//            }
        }];
        
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.pushTypeTableview.frame = CGRectMake(0, self.carrierView1.frame.size.height, kWidth, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.carrierView1.frame));
            self.isOpen = YES;
            
        }];
    }
  
}
- (void)creatPushTypeTableview{
    self.pushTypeTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.carrierView1.frame.size.height, kWidth, 0) style:(UITableViewStyleGrouped)];
    self.pushTypeTableview.scrollEnabled = NO;
    self.pushTypeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pushTypeTableview.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];

    self.pushTypeTableview.delegate = self;
    self.pushTypeTableview.dataSource = self;
    [self.pushTypeTableview registerNib:[UINib nibWithNibName:@"pushTypeChooseCell" bundle:nil] forCellReuseIdentifier:@"pushtypecell"];
    [self.view addSubview:self.pushTypeTableview];
    
    //添加蒙层
    self.mengcengView = [[UIView alloc]initWithFrame:CGRectMake(0, KcellHeight * 4, KScreenWidth,CGRectGetMaxY(self.view.frame)- (KcellHeight * 4))];
//    self.mengcengView.backgroundColor = [UIColor redColor];
//    self.mengcengView.alpha = 0.1;
    [self.pushTypeTableview addSubview:self.mengcengView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.mengcengView addGestureRecognizer:tap];
   
}

- (void)tapAction{
    [UIView animateWithDuration:0.3 animations:^{
        //什么操作都没有  简单的收起选择项
        self.pushTypeTableview.frame = CGRectMake(0, self.carrierView1.frame.size.height, kWidth, 0);
        self.isOpen = NO;
        //再次打开弹框 将√清除
//        for (pushTypeChooseCell *cell in self.pushTypeTableview.visibleCells) {
//            cell.selectImage.hidden = YES;
//            cell.isSelect = NO;
//        }
        //可以拿到哪些model是点击状态
        
        //将model全部置为没点击过状态
//        for (typeModel *model in self.typeModelArr)
//        {
//            if (model.isSelect) {
//                if ([model.typeTitle isEqualToString:@"未推送"])
//                {
//                    NSLog(@"选择未推送");
//                }else if ([model.typeTitle isEqualToString:@"推送中"])
//                {
//                    NSLog(@"选择推送中");
//                }else if([model.typeTitle isEqualToString:@"已推送"])
//                {
//                    NSLog(@"选择已推送");
//                }else{
//                    NSLog(@"全部");
//                }
//            }
//            model.isSelect = NO;
//        }
    }];
}


#pragma mark - 请求数据 - 所有数据展示
- (void)requestListData:(NSInteger)index sendState:(NSString *)sendState{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *account = NoNullStr(AccountInfo.storeId, @"");
    double storeId = [account doubleValue];
    [params setObject:@(storeId) forKey:@"storeId"];  //商户ID
    [params setObject:sendState forKey:@"sendState"];   //发送状态
    [params setObject:@(index) forKey:@"currentPage"];  //当前页码
    [params setObject:@20 forKey:@"pageSize"];    //每页数量
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请稍等..."];
    
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_MessagePush_msgPushList Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
    
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            [SVProgressHUD dismiss];
            //下啦刷新
            if (index == 1) {
                if (self.dataArray) {
                    [self.dataArray removeAllObjects];
                }else {
                    self.dataArray = [NSMutableArray array];
                }
            }
            NSArray *arr = [dic objectForKey:@"data"];
            if (arr.count > 0) {
                for (NSDictionary *dictionary in arr) {
                    MsgPushManagerList *list = [MsgPushManagerList mj_objectWithKeyValues:dictionary];
                    [self.dataArray addObject:list];
                }
                
                [self.pushTableview reloadData];
                [self.pushTableview.mj_header endRefreshing];
                [self.pushTableview.mj_footer endRefreshing];
            }else {
                
                [self.pushTableview reloadData];
                [self.pushTableview.mj_header endRefreshing];
                //提示数据加载完毕并关闭上啦加载
                [self.pushTableview.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        }
        else {
            [self.pushTableview.mj_header endRefreshing];
            [self.pushTableview.mj_footer endRefreshing];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试！"];
        }
     
//        [SVProgressHUD dismiss];
//        [hud hide:YES];
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [self.pushTableview.mj_header endRefreshing];
        [self.pushTableview.mj_footer endRefreshing];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试！"];
//        [SVProgressHUD dismiss];
//        [hud hide:YES];
    }];
    
}

#pragma mark - tableview代理 -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.pushTypeTableview]) {
        return 4;
    }
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.pushTypeTableview]) {
        //类型选择tableview
        typeModel *model = self.typeModelArr[indexPath.row];
        pushTypeChooseCell *typecell = [tableView dequeueReusableCellWithIdentifier:@"pushtypecell" forIndexPath:indexPath];
        
        typecell.typeLB.text = model.typeTitle;
//        if (indexPath.row == 0) {
//            typecell.lineview.hidden = YES;
//        }
        return typecell;
    }
    PushTableViewCell *pushcell = [tableView dequeueReusableCellWithIdentifier:@"pushcell" forIndexPath:indexPath];
    pushcell.pushBtn.hidden = NO;
    pushcell.model = [self.dataArray objectAtIndex:indexPath.row];
    if (![pushcell.model.sendState isEqualToString:@"1"]) {
        pushcell.pushBtn.hidden = YES;
    }
//    pushcell.pushBtn.tag = [pushcell.model.ID integerValue];
    pushcell.pushBtn.tag = indexPath.row;
#pragma mark - 点击发送按钮接口 -
    //实现cell上button  发送btn点击事件
    WS(weakSelf);
    pushcell.block = ^(UIButton *sender){
        NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        PushTableViewCell *cell = (PushTableViewCell *)[tableView cellForRowAtIndexPath:index];
        NSInteger ID = [cell.model.ID integerValue];
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        [paras setValue:@(ID) forKey:@"id"];
        //点击发送
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"请稍等...";
        
        [[MallNetworkEngine loginshare] requestNotEncodeWithDate:weakSelf.requestDate requestWithPath:API_MessagePush_smsSend Params:paras CompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSDictionary *dic = [completedOperation responseDecodeToDic];
            [hud hide:YES];
            if (Succeed(dic)) {
                NSLog(@"%@",dic[@"msg"]);
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
                [weakSelf.pushTableview.mj_header beginRefreshing];
            }else {
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD setMinimumDismissTimeInterval:1.0];
                [SVProgressHUD showInfoWithStatus:@"对不起，您的短信(彩信)余量不足!"];
            }
            
        } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
            [hud hide:YES];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试!"];
            
        }];
        
    };
   
    
    return pushcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.pushTypeTableview]) {
        return 44;
    }
    return KcellHeight;
}
//点击cell
#pragma mark - 跳转到编辑  详情页面 -
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TICK;
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([tableView isEqual:self.pushTableview])
    {

        MsgPushManagerList *model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.sendState isEqualToString:@"3"]) {
            MPMsgPushDetailVC *msgPushDetailVC = [[MPMsgPushDetailVC alloc]initWithNibName:@"MPMsgPushDetailVC" bundle:nil];
            msgPushDetailVC.model = model;
            [self.navigationController pushViewController:msgPushDetailVC animated:YES];
        }else {
            MPMsgEditVC *msgEditVC = [[MPMsgEditVC alloc]initWithNibName:@"MPMsgEditVC" bundle:nil];
            msgEditVC.model = model;
            [self.navigationController pushViewController:msgEditVC animated:YES];
        }
 
    }else{
        //类型选择
        pushTypeChooseCell *typecell = [tableView cellForRowAtIndexPath:indexPath];
        typeModel *model = self.typeModelArr[indexPath.row];
        self.pushTypeLB.text = model.typeTitle;
        if (typecell.isSelect)
        {
//            typecell.selectImage.hidden = YES;
//            model.isSelect = NO;
//            typecell.isSelect = NO;
            
        }else{
            //没有选择过的情况下  请求对应数据
            //将cell 和model 数据全部置为初始值 没被选择
            for (pushTypeChooseCell *cell in tableView.visibleCells) {
                cell.isSelect = NO;
                cell.selectImage.hidden = YES;
            }
            for (typeModel *typemodel in self.typeModelArr) {
                typemodel.isSelect = NO;
            }
            
            //标记为选中状态
            typecell.selectImage.hidden = NO;
            model.isSelect = YES;
            typecell.isSelect = YES;
            
            //请求对应的数据
            for (typeModel *model in self.typeModelArr)
            {
                if (model.isSelect) {
                    if ([model.typeTitle isEqualToString:@"未推送"])
                    {
                    NSLog(@"选择未推送");
                        [self requestListData:self.pageIndex sendState:@"1"];
                    }else if ([model.typeTitle isEqualToString:@"推送中"])
                    {
                    NSLog(@"选择推送中");
                         [self requestListData:self.pageIndex sendState:@"2"];
                    }else if([model.typeTitle isEqualToString:@"已推送"])
                    {
                    NSLog(@"选择已推送");
                         [self requestListData:self.pageIndex sendState:@"3"];
                    }else{
                    NSLog(@"全部");
                        [self requestListData:self.pageIndex sendState:@""];
                    }
                }
            }
        }
        //如果点击全部直接收起来
//        if (indexPath.row == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.pushTypeTableview.frame = CGRectMake(0, self.carrierView1.frame.size.height, kWidth, 0);
                self.isOpen = NO;
                //取消cell√
//                typecell.selectImage.hidden = YES;
//                typecell.isSelect = NO;
            }];
//        }
    }
    TOCK;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.pushTableview]) {
        return self.headview;
    }
    return NULL;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.pushTableview]) {
        return 44;
    }
    return CGFLOAT_MIN;
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
