//
//  VerifyRecordViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VerifyRecordViewController.h"
#import "ChooseDayView.h"
#import "VerifyRecordView.h"
#import "VerifyRecordModel.h"

@interface VerifyRecordViewController ()<ChooseDayViewDelegate>

@property (nonatomic, strong) VerifyRecordView *chooseBtnView;
@property (nonatomic, strong) UIButton *chooseButton;
@property (nonatomic, strong) ChooseDayView *chooseDayView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *day;
@property (nonatomic) NSInteger page;

@end

@implementation VerifyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"验证纪录";
    _page = 1;
    _chooseBtnView = [[VerifyRecordView alloc]init];
    [self.view addSubview:_chooseBtnView];
    [_chooseBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(15);
    }];
    _dataArray = [NSMutableArray array];
    
    [self request:@""];
    
    _chooseButton = [[UIButton alloc]init];
    [_chooseButton setTitle:@"全部" forState:UIControlStateNormal];
    [_chooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _chooseButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _chooseButton.frame = CGRectMake(SCREEN_SIZE.width - 80, 5, 60, 30);
    [_chooseButton addTarget:self action:@selector(chooseTime) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_chooseButton];
    
    WS(weakSelf);
    
    _chooseBtnView.tableView.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
//        [weakSelf requestActiveDeatailDatas:_days andPage:_page zhongjiang:[_zjArr objectAtIndex:_index] ];
        [weakSelf request:_day];
        _page ++;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_chooseButton removeFromSuperview];
}

- (void)request:(NSString *)day{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    _day = day;
    if(day.length){
        [params setObject:day forKey:@"days"];
    }
    [params setObject:[NSString stringWithFormat:@"%ld",_page] forKey:@"page"];
    
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:nil requestWithPath:API_VerifyList Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"%@",dic);
        NSArray *dicArray = [[dic objectForKey:@"data"]objectForKey:@"data"];
        for (NSDictionary *tDic in dicArray) {
            VerifyRecordModel *model = [[VerifyRecordModel alloc]initWithDic:tDic];
            [_dataArray addObject:model];
        }
        if (dicArray.count == 0) {
            [OMGToast showWithText:@"没有更多数据"];
        }
        
        _chooseBtnView.dataArray = _dataArray;
        [_chooseBtnView.tableView.mj_footer endRefreshing];
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"%@",dic);
    }];
}

- (void)chooseTime{
    if(_chooseDayView){
        [_chooseDayView removeFromSuperview];
        _chooseDayView = nil;
    }else{
        _chooseDayView = [[ChooseDayView alloc]init];
        _chooseDayView.delegate = self;
        _chooseDayView.frame = CGRectMake(_chooseButton.frame.origin.x - 10, 0, 80,  160);
        [self.view addSubview:_chooseDayView];
    }
}

- (void)didClickButton:(NSString *)ButtonName{
    _chooseDayView = nil;
    NSLog(@"%@",ButtonName);
    if ([ButtonName isEqualToString:@"全部"]) {
        _dataArray = [NSMutableArray array];
        _page = 1;
        [self request:@""];
    }else if ([ButtonName isEqualToString:@"最近7日"]){
        _dataArray = [NSMutableArray array];
        _page = 1;
        [self request:@"7"];
    }else if ([ButtonName isEqualToString:@"最近15日"]){
        _dataArray = [NSMutableArray array];
        _page = 1;
        [self request:@"15"];
    }else{
        _dataArray = [NSMutableArray array];
        _page = 1;
        [self request:@"30"];
    }
}

@end
