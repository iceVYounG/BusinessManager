//
//  VMRechargeRecordView.h
//  BusinessManager
//
//  Created by KL on 16/8/15.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipCardModel.h"
#import "UIScrollView+EmptyDataSet.h"

@class recordTBCell;

@interface VMRechargeRecordView : UIView<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *recordTableView; //tabelView;
@property (nonatomic, strong) NSMutableArray *dataArry;     //数据源
@property (nonatomic, assign) NSInteger pageIndex;      //请求页码
@property (nonatomic, strong) NSString *days;   //查询不同的日期
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) BOOL isConnected; //网络是否连通

- (instancetype)init;

@end

//-----------cell---------------------//

#define cell_width  (KScreenWidth - 30 - 75 - 90)/2.0

@interface recordTBCell : UITableViewCell

@property (nonatomic, strong) UILabel *phoneNumLab;
@property (nonatomic, strong) UILabel *cardNameLab;
@property (nonatomic, strong) UILabel *payCountLab;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) VipCardRechargeRecordItemModel *model;   //数据model
@property (nonatomic, strong) NSDateFormatter *inputFormat;
@property (nonatomic, strong) NSDateFormatter *ouputFormat;


@end

