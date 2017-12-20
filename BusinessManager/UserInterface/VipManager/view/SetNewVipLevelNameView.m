//
//  SetNewVipLevelNameView.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "SetNewVipLevelNameView.h"

@interface SetNewVipLevelNameView ()

@property (nonatomic, strong) UITextField *vipCardLevelNameTF;

@end

@implementation SetNewVipLevelNameView

- (id)init{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *removeViewGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
        removeViewGr.numberOfTapsRequired = 1;
        removeViewGr.numberOfTouchesRequired =1;
        [self addGestureRecognizer:removeViewGr];
        self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.7];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    backgroundView.layer.cornerRadius = 16;
    backgroundView.layer.masksToBounds = YES;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(311, 156));
        make.center.equalTo(self);
    }];
    
    _vipCardLevelNameTF = [[UITextField alloc]init];
    _vipCardLevelNameTF.placeholder = @"请输入卡级别名称";
    _vipCardLevelNameTF.font = [UIFont systemFontOfSize:16];
    _vipCardLevelNameTF.layer.cornerRadius = 4;
    _vipCardLevelNameTF.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    _vipCardLevelNameTF.layer.borderWidth = 1;
    [backgroundView addSubview:_vipCardLevelNameTF];
    [_vipCardLevelNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(15);
        make.right.equalTo(backgroundView).offset(-15);
        make.top.equalTo(backgroundView).offset(30);
        make.height.mas_equalTo(@48);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"dadada"];
    [backgroundView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backgroundView);
        make.height.mas_equalTo(@1);
        make.bottom.equalTo(backgroundView.mas_bottom).offset(-48);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"dadada"];
    [backgroundView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@1);
        make.centerX.equalTo(lineView1);
        make.top.equalTo(lineView1.mas_bottom);
        make.bottom.equalTo(backgroundView);
    }];
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backgroundView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(backgroundView);
        make.top.equalTo(lineView1.mas_bottom);
        make.right.equalTo(lineView2.mas_left);
    }];
    
    UIButton *confirmButton = [[UIButton alloc]init];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithHexString:@"00aaee"] forState:UIControlStateNormal];
    [backgroundView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(backgroundView);
        make.top.equalTo(lineView1.mas_bottom);
        make.left.equalTo(lineView2.mas_right);
    }];
}

- (void)cancel{
    [self removeFromSuperview];
}

- (void)confirm{
    if (!_vipCardLevelNameTF.text.length){
        [OMGToast showWithText:@"输入为空"];
        return;
    }
    [self requestAddNewCardLevelDataWithLevelName:self.vipCardLevelNameTF.text];
    if ([self.delegate respondsToSelector:@selector(didClickAddLevelNameBtn:)]) {
        [self.delegate didClickAddLevelNameBtn:_vipCardLevelNameTF.text];
    }
    [self cancel];
}
//zyc
#pragma mark - 增加会员卡页面  点击新增会员卡级别 确定按钮后请求 -
//新增会员卡级别数据接口
- (void)requestAddNewCardLevelDataWithLevelName:(NSString *)levelName{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSString *storeId = NoNullStr(AccountInfo.storeId, @"");
    [params setObject:storeId forKey:@"storeId"];
    
//    [params setObject:@"900000000077" forKey:@"storeId"];

    [params setObject:levelName forKey:@"levelName"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"正在保存..."];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:nil requestWithPath:API_VipCardManger_SaveVipCardLevel Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            NSLog(@"%@",dic);
            [SVProgressHUD showInfoWithStatus:@"新增级别成功"];
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"新增级别失败"];
    }];
    
}
@end
