//
//  VipCardViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VipCardViewController.h"
#import "VipCardManagerView.h"
#import "NewVipCardManagerViewController.h"
#import "EditCardViewController.h"
#import "VipCardModel.h"

@interface VipCardViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *vipCardTableView;

@end

@implementation VipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"电子会员卡管理";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f5fa"];
//    [self addNavRightButtonWithTitle:@"创建会员卡" icon:nil action:@selector(newVipCard) target:self];
//    [self request];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
//    [btn setTitle:@"创会员卡" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
//    [btn addTarget:self action:@selector(newVipCard) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *creatNewCardBtn = [[UIBarButtonItem alloc]initWithTitle:@"创建会员卡" style:(UIBarButtonItemStylePlain) target:self action:@selector(newVipCard)];
    self.navigationItem.rightBarButtonItem = creatNewCardBtn;
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    _vipCardTableView = [[UITableView alloc]init];
    _vipCardTableView.rowHeight = 190;
    _vipCardTableView.dataSource = self;
    _vipCardTableView.delegate = self;
    _vipCardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_vipCardTableView];
    [_vipCardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - 会员卡列表请求 -
- (void)request{
    [self.dataArray removeAllObjects];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:NoNullStr(AccountInfo.storeId, @"")  forKey:@"storeId"];

//    NSString *storeId = AccountInfo.storeId;//将字典value值替换
//    [paramDic setObject:@"900000000077" forKey:@"storeId"];

    [paramDic setObject:@"1" forKey:@"page"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_VipCardList Params:paramDic CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSArray *array = [dic objectForKey:@"data"];
        for (NSDictionary *dic in array) {
            VipCardModel *model = [[VipCardModel alloc]initWithDic:dic];
            [self.dataArray addObject:model];
        }
        if (_vipCardTableView) {
            [_vipCardTableView reloadData];
        }
        NSLog(@"%@",dic);
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
    }];
}

#pragma mark - 点击创建新的电子会员卡 -
- (void)newVipCard{
    [self.navigationController pushViewController:[[NewVipCardManagerViewController alloc]init] animated:YES];
}

//- (void)editCard:(UITapGestureRecognizer *)gr{
//    [self.navigationController pushViewController:[[EditCardViewController alloc]init] animated:YES];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    VipCardManagerTableViewCell *cell = [[VipCardManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[VipCardManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{     //如果不增加下面这个判断，tableview 再滑动后，会有重影，或者在被选中后会有重影
//        NSLog(@"cell !=nil ");
//        NSArray *views = [cell subviews];
//        for (UIView *obj in views) {
//            if (obj.tag==1000 || obj.tag==2000) {
//                NSLog(@"cell 要删除的子画面是：%@",[obj class]);
//                [obj removeFromSuperview];
//            }
//        }
    }
    cell.vipCardView.model = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VipCardManagerTableViewCell *cell = (VipCardManagerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    EditCardViewController *editCardVC = [[EditCardViewController alloc]init];
    editCardVC.ID = cell.vipCardView.model.vipCardId;
    [self.navigationController pushViewController:editCardVC animated:YES];
}


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
