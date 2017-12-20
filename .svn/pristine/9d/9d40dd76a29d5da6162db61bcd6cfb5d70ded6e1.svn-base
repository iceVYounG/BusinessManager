//
//  VerifyRecordView.m
//  BusinessManager
//
//  Created by Raven－z on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "VerifyRecordView.h"
#import "VerifyRecordModel.h"

@interface VerifyRecordView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation VerifyRecordView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headView];
        headView.layer.borderWidth = 1;
        headView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(@48);
        }];
        
        UILabel *phoneLabel = [[UILabel alloc]init];
        phoneLabel.text = @"手机号";
        phoneLabel.textColor = [UIColor blackColor];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [headView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(headView).offset(15);
//            make.top.bottom.equalTo(headView);
//            make.width.mas_equalTo(@88);
            make.top.bottom.left.equalTo(headView);
            make.width.mas_equalTo((KScreenWidth/4)+10);
        }];
        
        UILabel *cardTypeLabel = [[UILabel alloc]init];
        cardTypeLabel.text = @"卡类型";
        cardTypeLabel.textColor = [UIColor blackColor];
        cardTypeLabel.textAlignment = NSTextAlignmentCenter;
        cardTypeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [headView addSubview:cardTypeLabel];
        [cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneLabel.mas_right);
            make.top.bottom.equalTo(headView);
            make.width.mas_equalTo(((KScreenWidth/2)/3));
        }];
        
        UILabel *saleLabel = [[UILabel alloc]init];
        saleLabel.text = @"折扣";
        saleLabel.textColor = [UIColor blackColor];
        saleLabel.textAlignment = NSTextAlignmentCenter;
        saleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [headView addSubview:saleLabel];
        [saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cardTypeLabel.mas_right);
            make.top.bottom.equalTo(headView);
            make.width.mas_equalTo(((KScreenWidth/2)/3)-10);
        }];
        
        UILabel *moneyLabel = [[UILabel alloc]init];
        moneyLabel.text = @"消费记录";
        moneyLabel.textColor = [UIColor blackColor];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [headView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(saleLabel.mas_right);
            make.top.bottom.equalTo(headView);
            make.width.mas_equalTo(((KScreenWidth/2)/3));
        }];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"时间";
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [headView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(moneyLabel.mas_right);
            make.top.bottom.equalTo(headView);
            make.right.equalTo(headView);
        }];
        
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 48;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(headView.mas_bottom);
        }];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    VerifyRecordViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[VerifyRecordViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = nil;
    _dataArray = dataArray;
    [_tableView reloadData];
}

@end

@interface VerifyRecordViewTableViewCell ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *cardTypeLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation VerifyRecordViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"13026948573";
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo((KScreenWidth/4) + 10);
        }];
        
        _cardTypeLabel = [[UILabel alloc]init];
        _cardTypeLabel.text = @"储值卡";
        _cardTypeLabel.textColor = [UIColor blackColor];
        _cardTypeLabel.textAlignment = NSTextAlignmentCenter;
        _cardTypeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_cardTypeLabel];
        [_cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_phoneLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(((KScreenWidth/2)/3));
        }];
        
        _saleLabel = [[UILabel alloc]init];
        _saleLabel.text = @"8.0";
        _saleLabel.textColor = [UIColor blackColor];
        _saleLabel.textAlignment = NSTextAlignmentCenter;
        _saleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_saleLabel];
        [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cardTypeLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(((KScreenWidth/2)/3)-10);
        }];
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.text = @"1000";
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont systemFontOfSize:12];
        _moneyLabel.numberOfLines = 2;
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_saleLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(((KScreenWidth/2)/3));
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2019-10-20  12:24:52";
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.numberOfLines = 2;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_moneyLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.right.equalTo(self);
        }];

    }
    return self;
}

- (void)setModel:(VerifyRecordModel *)model{
    _model = model;
    _phoneLabel.text = model.MOBLE;
    if ([model.TYPE isEqualToString:@"1"]) {
        _cardTypeLabel.text = @"储值卡";
    }else if ([model.TYPE isEqualToString:@"2"]){
        _cardTypeLabel.text = @"红包";
    }else{
        _cardTypeLabel.text = @"优惠卡";
    }
    if([model.DISCOUNT isEqualToString:@"10"]||!model.DISCOUNT.length){
        _saleLabel.text = @"无折扣";
    }else{
        _saleLabel.text = model.DISCOUNT;
    }
    if ([model.TYPE isEqualToString:@"3"]) {
        _moneyLabel.text = [NSString stringWithFormat:@"%@次",model.AMT];
    }else{
        _moneyLabel.text = [NSString stringWithFormat:@"%0.2f元",(double)[model.AMT intValue]/100];
    }
    _timeLabel.text = [self getTime:model.CREATE_TIME];
}

- (NSString *)getTime:(NSString *)str{
    NSString *yearStr = [str substringWithRange:(NSMakeRange(0, 4))];
    NSString *monthStr = [str substringWithRange:NSMakeRange(4, 2)];
    NSString *dayStr = [str substringWithRange:NSMakeRange(6, 2)];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:yearStr,monthStr,dayStr,nil];
    NSString *timeStr1 =[arr1 componentsJoinedByString:@"-"];
    
    NSString *hourStr = [str substringWithRange:NSMakeRange(8, 2)];
    NSString *minStr = [str substringWithRange:NSMakeRange(10, 2)];
    NSString *secStr = [str substringWithRange:NSMakeRange(12, 2)];
    NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:hourStr,minStr,secStr,nil];
    NSString *timeStr2 =[arr2 componentsJoinedByString:@":"];
    NSString *timeRStr = [timeStr1 stringByAppendingString:[NSString stringWithFormat:@" %@",timeStr2]];
    return timeRStr;
}

@end