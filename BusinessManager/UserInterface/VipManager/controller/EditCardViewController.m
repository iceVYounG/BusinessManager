//
//  EditCardViewController.m
//  BusinessManager
//
//  Created by Raven－z on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EditCardViewController.h"
#import "EditCardView.h"
#import "VipCardModel.h"
#import "ChooseVipLevelView.h"
#import "SetNewVipLevelNameView.h"
#import "AppDelegate.h"
@interface EditCardViewController ()<EditCardViewDeleagte,ChooseVipLevelViewDelegate,SetNewVipLevelNameViewDelegate>

@property (nonatomic, strong) EditCardView *editCardView;
@property (nonatomic, strong) NSString *chooseBtnName;

@end

@implementation EditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑电子会员卡";
    [self requestCardDetail];
//  [self setUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUIWithModel:(VipCardModel *)model{
    _editCardView = [[EditCardView alloc]initWithType:VipCardCoupon Bymodel:model];
    _editCardView.delegate = self;
    [self.view addSubview:_editCardView];
    
    [_editCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark-------request

- (void)requestCardDetail{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [params setObject:@"900000000077" forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    
    [params setObject:self.ID forKey:@"id"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中"];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_VipCardDetail Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        VipCardModel *model = [[VipCardModel alloc]initWithDic:[dic objectForKey:@"data"]];
        
        [self setUIWithModel:model];

        NSLog(@"%@",dic);
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"%@",dic);
    }];
}

#pragma mark - 选择会员接口 -
- (void)requestCardLevel{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
//    [params setObject:@"900000000077" forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    

//    [params setObject:self.ID forKey:@"id"];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_memberCardLevelList Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            VipCardLevelListModel *listModel = [VipCardLevelListModel mj_objectWithKeyValues:dic];
            NSMutableArray *array = [NSMutableArray array];
            for (VipCardLevelItemModel * model in listModel.data) {
                [array addObject:model.levelName];
            }
            [self showChooseVipLevelWithArray:array];
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
       [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
    }];
}
#pragma mark - 新增会员级别接口 -
//添加会员等级
//没调用
- (void)addCardLevel:(NSString *)cardLevenName{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@"900000000077" forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:self.ID forKey:@"id"];
    [params setObject:cardLevenName forKey:@"levelName"];
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"正在保存..."];
    
    [[MallNetworkEngine loginshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_AddCardLevel Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {

        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            NSLog(@"%@",dic);
            [SVProgressHUD showInfoWithStatus:@"新增级别成功"];
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"新增级别失败"];
//        NSDictionary *dic = [completedOperation responseDecodeToDic];
//        NSLog(@"%@",dic);
    }];
}


#pragma mark - 删除会员卡接口 -
//删除会员卡
- (void)deleteCardResquest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    
//    [params setObject:@"900000000077" forKey:@"storeId"];

    [params setObject:self.ID forKey:@"id"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"正在删除..."];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_DeleteVipCard Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
//        [OMGToast showWithText:[dic objectForKey:@"msg"]];
        if (Succeed(dic)) {
            [SVProgressHUD showInfoWithStatus:@"删除成功"];
            [self.navigationController popViewControllerAnimated:
             YES];
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         [SVProgressHUD showInfoWithStatus:@"删除失败"];
        [SVProgressHUD showInfoWithStatus:@"删除失败"];
    }];
}

#pragma mark - 保存会员接口 -
//保存会员卡
- (void)saveCardResquest:(VipCardModel *)model{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];

    
//    [params setObject:@"900000000077" forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    

    [params setObject:self.ID forKey:@"id"];
    [params setObject:model.businessType forKey:@"businessType"];
    [params setObject:model.cardName forKey:@"cardName"];
    [params setObject:model.cardLevel forKey:@"cardLevel"];
    //折扣四舍五入设置
    model.discount = [NSString stringWithFormat:@"%.1f", [model.discount floatValue]];
    if ([model.discount floatValue] <= 0 || [model.discount floatValue] > 10.0) {
        [SVProgressHUD showErrorWithStatus:@"折扣应大于0,小于等于10"];
        return;
    }
    
    [params setObject:model.discount forKey:@"discount"];
    [params setObject:model.validityTime forKey:@"validityTime"];
//    if([model.businessType isEqualToString:@"1"]){
//        [params setObject:model.initialAmount forKey:@"initialAmount"];
//    }
    
    [params setObject:NoNullStr(model.initialAmount,@"") forKey:@"initialAmount"];
    [params setObject:model.cardLevelValue forKey:@"cardLevelValue"];
    if (model.remarks.length) {
        [params setObject:model.remarks forKey:@"remarks"];
    }
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"正在保存..."];
    
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_VipCardManger_SaveVipCard Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];

        if (Succeed(dic)) {
            [SVProgressHUD showInfoWithStatus:@"保存成功"];
            NSLog(@"%@",dic);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@,请重新填写信息",dic[@"msg"]);
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
        }

        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSDictionary *dic = [completedOperation responseDecodeToDic];
//        NSLog(@"%@",dic);
        [SVProgressHUD showInfoWithStatus:@"保存失败"];
    }];
}

#pragma mark ---- delegate
//选择会员卡 btn
//点击选择会员卡级别 代理方法得到选择的会员卡 名字
- (void)didClickChooseVipLevelBtn:(NSString *)btnName{
    self.chooseBtnName = btnName;
    [self requestCardLevel];

}
- (void)showChooseVipLevelWithArray:(NSMutableArray *)array{
    ChooseVipLevelView *chooseViewLevelView = [[ChooseVipLevelView alloc]initWithVipLevelNameArray:array btnName:self.chooseBtnName];
    chooseViewLevelView.delegate = self;
    [self.view addSubview:chooseViewLevelView];
    [chooseViewLevelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (void)didClickCardLevel:(NSString *)str{
    [_editCardView.vipCardLevel setTitle:str forState:UIControlStateNormal];
}
//保存会员卡 btn
- (void)didClickSaveBtnWithModel:(VipCardModel *)model{
    [self saveCardResquest:model];
}
//删除会员卡 btn
- (void)didClickDeleteBtn{
    [self deleteCardResquest];
}
//点击新增会员卡级别 btn
- (void)didClickAddVipLevelBtn{
    
    SetNewVipLevelNameView *setNewVipLevelNameView = [[SetNewVipLevelNameView alloc]init];
    setNewVipLevelNameView.delegate = self;
    [self.view addSubview:setNewVipLevelNameView];
    [setNewVipLevelNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

//选择会员卡名字
//- (void)didClickAddLevelNameBtn:(NSString *)name{
//    [self addCardLevel:name];
//}


@end