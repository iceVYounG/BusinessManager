//
//  VMRechargeRecordView.m
//  BusinessManager
//
//  Created by KL on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VMRechargeRecordView.h"



#define headView_labelWidth  (KScreenWidth - 30)/4.0


@implementation VMRechargeRecordView

- (instancetype)init {
    if (self = [super init]) {
        self.isConnected = YES; //默认网络连通
        [self setUpViews];
        self.backgroundColor = [UIColor colorWithHexString:@"#f6f5fa"];
    }
    return self;
}

- (void)setUpViews {
    
    
    //headView
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@48);
    }];
    
    //lineView
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    [headView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    
    //用户手机号码
    UILabel *phoneNumLab = [[UILabel alloc] init];
    phoneNumLab.text = @"用户手机号";
    [phoneNumLab setFont:[UIFont boldSystemFontOfSize:13]];
    [phoneNumLab setTextAlignment:NSTextAlignmentCenter];
    [phoneNumLab setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [headView addSubview:phoneNumLab];
    [phoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(self).offset(15);
//        make.width.mas_equalTo(@92); headView_labelWidth
        make.width.mas_equalTo(headView_labelWidth);
    }];
    
    //会员卡名称
    UILabel *cardNamelab = [[UILabel alloc] init];
    cardNamelab.text = @"会员卡名称";
    [cardNamelab setFont:[UIFont boldSystemFontOfSize:13]];
    [cardNamelab setTextAlignment:NSTextAlignmentCenter];
    [cardNamelab setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [headView addSubview:cardNamelab];
    [cardNamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(phoneNumLab.mas_right);
        //        make.right.equalTo(payCountLab.mas_left);
        make.width.mas_equalTo(headView_labelWidth);
    }];
    
    
    //充值金额
    UILabel *payCountLab = [[UILabel alloc] init];
    payCountLab.text = @"充值金额";
    [payCountLab setFont:[UIFont boldSystemFontOfSize:13]];
    [payCountLab setTextAlignment:NSTextAlignmentCenter];
    [payCountLab setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [headView addSubview:payCountLab];
    [payCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(cardNamelab.mas_right);
        //        make.right.equalTo(timeLab.mas_left);
        make.width.mas_equalTo(headView_labelWidth);
    }];
    
    //充值时间
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"充值时间";
    [timeLab setFont:[UIFont boldSystemFontOfSize:13]];
    [timeLab setTextAlignment:NSTextAlignmentCenter];
    [timeLab setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [headView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
//        make.left.equalTo(payCountLab.mas_right);
//        make.width.mas_equalTo(@85);
        make.right.equalTo(self).offset(-15);
        make.width.mas_equalTo(headView_labelWidth);
    }];
    
    
    //lineView2
    UIView*lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [headView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(@1);
    }];
    
    //tableview
    self.recordTableView = [[UITableView alloc] init];
    self.recordTableView.rowHeight = 48;
    self.recordTableView.dataSource = self;
    self.recordTableView.delegate = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 1.0)];
    self.bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    self.recordTableView.tableFooterView = self.bottomLineView;
    self.recordTableView.emptyDataSetDelegate = self;
    self.recordTableView.emptyDataSetSource = self;
    //下拉刷新
    WS(weakSelf);
    self.recordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestRecordData:weakSelf.days];
    }];
    //上提加载更多
    self.recordTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf requestRecordData:weakSelf.days];
    }];
    
    
    [self addSubview:self.recordTableView];
    [self.recordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    //
    self.pageIndex = 1;
    [self.recordTableView.mj_header beginRefreshing];
    
}

#pragma mark - UITableViewDelegate, DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArry.count == 0) {
        self.bottomLineView.backgroundColor = [UIColor clearColor];
    }else {
        self.bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    }
    return self.dataArry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    recordTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordTBCell"];
    if (cell == nil) {
        cell = [[recordTBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recordTBCell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    cell.model = [self.dataArry objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - DZNEmptyView
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    //title
    NSString *string = [NSString stringWithFormat:@"暂无数据!"];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:dic];
    
    NSString *error = [NSString stringWithFormat:@"请检查网络设置!"];
    NSAttributedString *errorAttribute = [[NSAttributedString alloc] initWithString:error attributes:dic];
    
    if (self.isConnected) {
        return attribute;
    }
    return errorAttribute;
    
    
}


#pragma mark - setter
- (void)setDays:(NSString *)days {
    _days = days;
    self.pageIndex = 1;
    [self requestRecordData:days];
}

#pragma mark - 请求

- (void)requestRecordData:(NSString *)days {
    if (!days) {
        days = @"";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
//    [params setObject:@"900000000077" forKey:@"storeId"];
    [params setObject:days forKey:@"days"];
    [params setObject:@(self.pageIndex) forKey:@"page"];
    [params setObject:@(12) forKey:@"pageSize"];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"请稍等..."];
    
    [[MallNetworkEngine vipCardMGshare] requestNotEncodeWithDate:nil requestWithPath:API_VipCardManger_rechargeList Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        self.isConnected = YES;
        if (Succeed(dic)) {
            [SVProgressHUD dismiss];
            
            NSArray *arr = [dic objectForKey:@"data"];
            
            if (self.pageIndex == 1) {
                if (self.dataArry) {
                    [self.dataArry removeAllObjects];
                }else {
                    self.dataArry = [NSMutableArray array];
                    
                }
            }
            
            if (arr.count > 0) {
                
                for (NSDictionary *data in arr) {
                    VipCardRechargeRecordItemModel *model = [VipCardRechargeRecordItemModel mj_objectWithKeyValues:data];
                    double amt = [model.AMT doubleValue];
                    NSString *account = [NSString stringWithFormat:@"%.2f",(amt / 100.0)];
                    model.AMT = account;
                    [self.dataArry addObject:model];
                }
                
                [self.recordTableView reloadData];
                [self.recordTableView.mj_header endRefreshing];
                [self.recordTableView.mj_footer endRefreshing];
                
            }else {
                [self.recordTableView reloadData];
                [self.recordTableView.mj_header endRefreshing];
                [self.recordTableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            
        }else {
            [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
            [self.recordTableView.mj_header endRefreshing];
            [self.recordTableView.mj_footer endRefreshing];
        }
        
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        self.isConnected = NO;
        [self.recordTableView reloadEmptyDataSet];
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试！"];
        [self.recordTableView.mj_header endRefreshing];
        [self.recordTableView.mj_footer endRefreshing];
    }];
    
}



@end

@implementation recordTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    //PhoneNum;
    self.phoneNumLab = [[UILabel alloc] init];
    [self.phoneNumLab setFont:[UIFont systemFontOfSize:13]];
    [self.phoneNumLab setTextAlignment:NSTextAlignmentCenter];
    [self.phoneNumLab setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [self addSubview:self.phoneNumLab];
    [self.phoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
//        make.width.mas_equalTo(@92);
        make.width.mas_equalTo(@90);
    }];
    
    //cardNameLab
    self.cardNameLab = [[UILabel alloc] init];
    [self.cardNameLab setFont:[UIFont systemFontOfSize:13]];
    [self.cardNameLab setTextAlignment:NSTextAlignmentCenter];
    [self.cardNameLab setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [self addSubview:self.cardNameLab];
    [self.cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.phoneNumLab.mas_right);
        make.width.mas_equalTo(cell_width);
    }];
    
    //payCountLab
    self.payCountLab = [[UILabel alloc] init];
    [self.payCountLab setFont:[UIFont systemFontOfSize:13]];
    [self.payCountLab setTextAlignment:NSTextAlignmentCenter];
    [self.payCountLab setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [self addSubview:self.payCountLab];
    [self.payCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.cardNameLab.mas_right);
        make.width.mas_equalTo(cell_width);
    }];
    
    //timeLabel
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
    self.timeLabel.numberOfLines = 2;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self.payCountLab.mas_right);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(@75);
        make.right.equalTo(self).offset(-15);
    }];
    
    
}



#pragma mark - setter方法
- (void)setModel:(VipCardRechargeRecordItemModel *)model {
    self.phoneNumLab.text = model.MOBLE_USER;
    self.cardNameLab.text = model.CARD_NAME;
    self.payCountLab.text = model.AMT;
    self.timeLabel.text = [self transformTimeFormatWith:model.UPDATE_TIME];
    
}

- (NSString *)transformTimeFormatWith:(NSString *)timeStr {
    
    NSDate *time = [self.inputFormat dateFromString:timeStr];
    NSString *formatTime = [self.ouputFormat stringFromDate:time];
    return formatTime;
    
}

- (NSDateFormatter *)inputFormat {
    if (!_inputFormat) {
        _inputFormat = [[NSDateFormatter alloc] init];
        [_inputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_inputFormat setDateFormat:@"yyyyMMddHHmmss"];
    }
    return _inputFormat;
}

- (NSDateFormatter *)ouputFormat {
    if (!_ouputFormat) {
        _ouputFormat= [[NSDateFormatter alloc] init];
        [_ouputFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_ouputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    return _ouputFormat;
}

@end




