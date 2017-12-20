//
//  ChooseVipLevelView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChooseVipLevelView.h"

@interface ChooseVipLevelView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *dataArry;//装有model
@property (nonatomic, strong) NSString *chooseLevelBtnName;
@property (nonatomic, strong) NSString *titleName;

@end

@implementation ChooseVipLevelView

- (id)initWithVipLevelNameArray:(NSArray *)array btnName:(NSString *)btnName{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
        [self setUIWithArray:array];
        self.array = array;
        self.chooseLevelBtnName = btnName;
    }
    return self;
}


- (void)setUIWithArray:(NSArray *)array{
    NSInteger count = array.count;
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.cornerRadius = 8;
    background.layer.masksToBounds = YES;
    [self addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(@300);
        if (array.count <= 4) {
            make.height.mas_equalTo(@(((count+1) *48)+count));
        }else{
            make.height.mas_equalTo(@244);
        }
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请选择会员等级";
    titleLabel.textColor = [UIColor colorWithHexString:@"00aaee"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [background addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 48));
        make.centerX.equalTo(background);
        make.top.equalTo(background);
    }];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setImage:[UIImage imageNamed:@"VipCardManager_CancelImage"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(background).offset(-6);
    }];
    
    if (array.count <= 4) {
        for (int i = 0; i < count; i ++) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithHexString:@"dadada"];
            [background addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(background.mas_top).offset(48 * (i + 1) + i);
                make.height.mas_equalTo(@1);
                make.right.left.equalTo(background);
            }];
        }
        
        for (int j = 0; j < count; j ++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = j;
            [btn setTitle:array[j] forState:UIControlStateNormal];
            if ([array[j] isEqualToString:self.chooseLevelBtnName]) {
                [btn setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(clickLevelName:) forControlEvents:UIControlEventTouchUpInside];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [background addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(background).offset(20);
                make.right.equalTo(background);
                make.top.equalTo(background.mas_top).offset(48* (j + 1) + j +1);
                make.height.mas_equalTo(@48);
            }];
        }
    }else{
        _tableView = [[UITableView alloc]init];
        _tableView.rowHeight = 49;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius = 8;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(background).offset(20);
            make.left.equalTo(background);
            make.right.equalTo(background);
            make.top.equalTo(titleLabel.mas_bottom);
            make.bottom.equalTo(background);
        }];
    }
}

#pragma mark - init
////================================================================================================////

- (id)initWithVipLevelNameArray:(NSArray *)array btnName:(NSString *)btnName title:(NSString *)title {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
        
        self.dataArry = array;
        self.chooseLevelBtnName = btnName;
        self.titleName = title;
        [self setUpViewsWithArray:array];
    }
    return self;
}

- (void)setUpViewsWithArray:(NSArray *)array{
    NSInteger count = array.count;
    UIView *background = [[UIView alloc]init];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.cornerRadius = 8;
    background.layer.masksToBounds = YES;
    [self addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(@300);
        if (array.count <= 4) {
            make.height.mas_equalTo(@(((count+1) *48)+count));
        }else{
            make.height.mas_equalTo(@244);
        }
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.titleName;
    titleLabel.textColor = [UIColor colorWithHexString:@"00aaee"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [background addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 48));
        make.centerX.equalTo(background);
        make.top.equalTo(background);
    }];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setImage:[UIImage imageNamed:@"VipCardManager_CancelImage"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(background).offset(-12);
    }];
    
    if (array.count <= 4) {
        for (int i = 0; i < count; i ++) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithHexString:@"dadada"];
            [background addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(background.mas_top).offset(48 * (i + 1) + i);
                make.height.mas_equalTo(@1);
                make.right.left.equalTo(background);
            }];
        }
        
        for (int j = 0; j < count; j ++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = j;
            VipCardListModel *model = [array objectAtIndex:j];
            
            [btn setTitle:model.cardName forState:UIControlStateNormal];
            if ([model.cardName isEqualToString:self.chooseLevelBtnName]) {
                [btn setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(clickLevelName:) forControlEvents:UIControlEventTouchUpInside];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [background addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(background).offset(20);
                make.right.equalTo(background);
                make.top.equalTo(background.mas_top).offset(48* (j + 1) + j +1);
                make.height.mas_equalTo(@48);
            }];
        }
    }else{
        _tableView = [[UITableView alloc]init];
        _tableView.rowHeight = 49;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius = 8;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(background).offset(20);
            make.left.equalTo(background);
            make.right.equalTo(background);
            make.top.equalTo(titleLabel.mas_bottom);
            make.bottom.equalTo(background);
        }];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.array && self.array.count > 0) {
        return self.array.count;
    }else if (self.dataArry && self.dataArry.count > 0) {
        return self.dataArry.count;
    }else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    ChooseVipLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ChooseVipLevelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID chooseBtnName:self.chooseLevelBtnName];
    }else{
        [cell.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(clickLevelName:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btn.tag = cell.tag;

    if (self.array && self.array.count > 0) {
        cell.cardLevel = [self.array objectAtIndex:indexPath.row];
        
    }else if (self.dataArry && self.dataArry.count > 0) {
        cell.model = [self.dataArry objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)cancel{
    [self removeFromSuperview];
}

- (void)clickLevelName:(UIButton *)button {
    NSInteger tag = button.tag;
    VipCardListModel *model;
    
    if (self.dataArry && self.dataArry.count > 0) {
        model = [self.dataArry objectAtIndex:tag];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(didClickCardLevel:)]) {
        [self.delegate didClickCardLevel:button.titleLabel.text];
    }
    //传Model
    if ([self.delegate conformsToProtocol:@protocol(ChooseVipLevelViewDelegate)]
        &&
        [self.delegate respondsToSelector:@selector(chooseVipCardWithModel:)]) {
        [self.delegate chooseVipCardWithModel:model];
    }
    [self cancel];
}

@end

@interface ChooseVipLevelTableViewCell ()

@property (nonatomic, strong) NSString *chooseBtnName;
//@property (nonatomic, strong) UIButton *btn;

@end

@implementation ChooseVipLevelTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chooseBtnName:(NSString *)btnName{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"dadada"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.height.mas_equalTo(@1);
            make.right.equalTo(self);
            make.left.equalTo(self).offset(-20);
        }];
        
        self.chooseBtnName = btnName;
        _btn = [[UIButton alloc]init];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(1);
            make.height.mas_equalTo(@48);
        }];
    }
    return self;
}

- (void)setCardLevel:(NSString *)cardLevel{
    if ([cardLevel isEqualToString:self.chooseBtnName]) {
        [_btn setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
    }
    [_btn setTitle:cardLevel forState:UIControlStateNormal];
}

#pragma mark - setter model
- (void)setModel:(VipCardListModel *)model {
    if ([model.cardName isEqualToString:self.chooseBtnName]) {
        [_btn setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
    }
    
    [_btn setTitle:model.cardName forState:UIControlStateNormal];
    
}


@end