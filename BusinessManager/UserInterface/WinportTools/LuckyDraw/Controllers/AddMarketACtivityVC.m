//
//  AddMarketACtivityVC.m
//  BusinessManager
//
//  Created by The Only on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "AddMarketACtivityVC.h"
#import "UIView+SDAutoLayout.h"
#import "AddDrawCell.h"
#import "RedBagModel.h"
#import "AddNewRedBagCell.h"
#import "DrawActivityManageVC.h"
#import "ChoosePrizeTypeView.h"


#define PRIZETYPETAG 301 // 奖品类型
#define CHOOSEPRIZETYPE 302// 选择奖品类型

@interface AddMarketACtivityVC ()<UITableViewDelegate,UITableViewDataSource,AddDrawCellDelegate,AddNewRedBagCellDelegate,ChoosePrizeTypeViewDelegate>
{
    NSInteger typeNumber;
    NSIndexPath * _indexPath;
//    NSMutableArray *prizeInfo_Array;
}

@property (strong,nonatomic)NSMutableArray *addPrizeArray;
@property (strong,nonatomic)NSString *priceStr;// 总金额
@end

@implementation AddMarketACtivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新增营销活动";
    
    self.addPrizeArray = [NSMutableArray array];
//    prizeInfo_Array = [NSMutableArray array];
    
    if (self.addPrizeArray.count == 0)
    {
        // 重新创建model
        RedBagModel *model = [[RedBagModel alloc] init];
        
        model.btnTitle = @"请选择奖品类型";
        //把model添加到数组
        [self.addPrizeArray addObject:model];
        NSLog(@"self.addPrizeArray === %@",self.addPrizeArray);
    }
    
    [self requestRechargeMomey];
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
      return self.addPrizeArray.count+1;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.addPrizeArray.count) {
        
        static NSString *identifierCell = @"Cell";
        AddDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddDrawCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        RedBagModel *model = self.addPrizeArray[indexPath.row];
        cell.model = model;
        cell.delegate = self;
        return cell;
    }
    else
    {
        static NSString *identifierCell = @"AddCell";
        AddNewRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AddNewRedBagCell" owner:self options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.delegate = self;
        
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row <self.addPrizeArray.count)
    {
        RedBagModel *model = self.addPrizeArray[indexPath.row];
        if (model.heightType == nil) {
            
            return 44;
        }
        else
        {
            if ([model.heightType isEqualToString:@"singleMoney"])
            {
                return 240;
            }
            else
            {
                return 284;
            }
        }
    }else
    {
        return 44;
    }
}

#pragma mark AddDrawCellDetegate
-(void)choosePresentTypeOfAddDrawCell:(AddDrawCell *)cell
{
    NSIndexPath *indexPath = [self.addPrizeTableView indexPathForCell:cell];
    WS(weakSelf)
    RedBagModel *model = self.addPrizeArray[indexPath.row];
    __weak typeof (model) weakRed = model;
    
     ChoosePrizeTypeView *prizeView = [[ChoosePrizeTypeView alloc] initWithFrame:CGRectMake(0, 0,KWSize.width , KWSize.height) block:^(NSString *typeBlock) {
        weakRed.btnTitle = typeBlock;
         if ([weakRed.btnTitle isEqualToString:@"实物奖品"])
         {
             model.heightType = @"singleMoney";
         }
         else
         {
             model.heightType = @"type1";
         }
        
        [weakSelf.addPrizeTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    prizeView.delegate = self;
    [prizeView show];

}
-(void)addDrawCell:(AddDrawCell *)myCell prizeNameTF:(UITextField *)PName prizeCountTF:(UITextField *)PCount prizeNumberTF:(UITextField *)PNumber prizeChance:(UITextField *)PChance prizeMoney:(UITextField *)PMoney type:(NSInteger)PTypep
{
    NSIndexPath *indexPath = [self.addPrizeTableView indexPathForCell:myCell];
    RedBagModel *model = self.addPrizeArray[indexPath.row];
    model.redNum = PCount.text;
    model.redName = PName.text;
    model.singleLmLum = PNumber.text;
    model.drawProbability = PChance.text;
    model.singleAmount = [NSString stringWithFormat:@"%.2f",[PMoney.text floatValue]*100];
    model.type = typeNumber;
}
#pragma mark AddNewRedBagCellDelegate
// 继续添加奖品
- (void)clickOnAddCell:(AddNewRedBagCell *)cell
{
    
    if (self.addPrizeArray.count >=40) {
        
        [SVProgressHUD showInfoWithStatus:@"最多只能添加40个奖品"];
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.addPrizeArray.count -1 inSection:0];
    AddDrawCell *addCell = (AddDrawCell *)[self.addPrizeTableView cellForRowAtIndexPath:indexPath];
    if ([addCell.redBagBtn.titleLabel.text isEqualToString:@"请选择奖品类型"]) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择奖品类型"];
        return;
    }
    if ([addCell.prizeNameTF.text isEqualToString:@""])
    {
        
        [SVProgressHUD showInfoWithStatus:@"请输入奖品名称"];
        return;
    }
    if ([addCell.redBagBtn.titleLabel.text isEqualToString:@"现金红包"])
    {
        if ([addCell.prizeSingeMoneyTF.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入单个红包金额"];
            return;
        }
        NSInteger numberStr =  [addCell.prizeCount.text integerValue]*[addCell.prizeSingeMoneyTF.text integerValue];
        if (numberStr > [self.priceStr integerValue]) {
            
            [SVProgressHUD showInfoWithStatus:@"账户余额不足"];
            return;
        }

    }
    if ([addCell.prizeCount.text isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入奖品数量"];
        return;
    }
    if ([addCell.prizeChance.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖概率"];
        return;
    }
    if ([addCell.prizeNumber.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖次数"];
        return;
    }
    // 重新创建model
    RedBagModel *model = [[RedBagModel alloc] init];
    model.btnTitle = @"请选择奖品类型";
    //把model添加到数组
    [self.addPrizeArray addObject:model];
    
    // 添加cell
    [self.addPrizeTableView beginUpdates];
    [self.addPrizeTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.addPrizeArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.addPrizeTableView endUpdates];
    
}

#pragma mark ChoosePrizeTypeViewDelegate
-(void)didFinishClickBtnTag:(NSInteger)tag chooseView:(ChoosePrizeTypeView *)view
{
    typeNumber = tag+1;
    
    if ([view.shiWuPrizeButton.titleLabel.text isEqualToString:@"实物奖品"]) {
        
        [view.shiWuPrizeButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateNormal];
        
    }
    if ([view.dianZiQuanPrizeButton.titleLabel.text isEqualToString:@"商户红包"]) {
        
        [view.dianZiQuanPrizeButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateNormal];
        
    }
    
    if ([view.xianJinCashButton.titleLabel.text isEqualToString:@"现金红包"]) {
        
        [view.xianJinCashButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateNormal];
        
    }
}
   //保存奖品
- (IBAction)savePrizeAction:(id)sender
{
    [self requestSaveAddActivityInfo];
    
}
-(void)requestSaveAddActivityInfo
{
    
//    @"http://112.4.27.9/bfsh-ws_inter/storecenter/activeSave.chtml"
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.addPrizeArray.count -1 inSection:0];
    AddDrawCell *addCell = (AddDrawCell *)[self.addPrizeTableView cellForRowAtIndexPath:indexPath];
    if ([addCell.redBagBtn.titleLabel.text isEqualToString:@"请选择奖品类型"]) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择奖品类型"];
        return;
    }
    if ([addCell.prizeNameTF.text isEqualToString:@""])
    {
        
        [SVProgressHUD showInfoWithStatus:@"请输入奖品名称"];
        return;
    }
    if ([addCell.prizeCount.text isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入奖品数量"];
        return;
    }
    if ([addCell.redBagBtn.titleLabel.text isEqualToString:@"现金红包"])
    {
        if ([addCell.prizeSingeMoneyTF.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入单个红包金额"];
            return;
        }
        
        NSInteger numberStr =  [addCell.prizeCount.text integerValue]*[addCell.prizeSingeMoneyTF.text integerValue];
        if (numberStr > [self.priceStr integerValue]) {
            
            [SVProgressHUD showInfoWithStatus:@"账户余额不足"];
            return;
        }
    }
    if ([addCell.prizeChance.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖概率"];
        return;
    }
    if ([addCell.prizeNumber.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖次数"];
        return;
    }
    if (![addCell.prizeCount.text isEqualToString:@""])
    {
        
        if (addCell.prizeCount.text.length>6)
        {
            [SVProgressHUD showInfoWithStatus:@"红包数量应小于六位数"];
            return;
        }
    }
    if (![addCell.prizeChance.text isEqualToString:@""])
    {
//        addCell.prizeChance.text = [NSString stringWithFormat:@"%.1f",round([addCell.prizeChance.text floatValue]*100)/100];
        if ([addCell.prizeChance.text floatValue] <= 0 || [addCell.prizeChance.text floatValue] >= 1.0)
        {
            [SVProgressHUD showInfoWithStatus:@"中奖概率应大于0,小于等于1"];
            return;
        }
    }
    
    NSMutableDictionary *prams =
       [NSMutableDictionary dictionary];
    [prams setObject:self.ID forKey:@"id"];
    [prams setObject:self.activityName forKey:@"name"];
    [prams setObject:self.startTime forKey:@"startTime"];
    [prams setObject:self.endTime forKey:@"endTime"];
    [prams setObject:self.singleDrawNum forKey:@"singleDrawNum"];
    [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [prams setObject:self.useDays forKey:@"useDays"];
    
    NSArray *array = [NSObject mj_keyValuesArrayWithObjectArray:self.addPrizeArray];
    for (NSMutableDictionary *temDic in array)
    {
        [temDic removeObjectForKey:@"btnTitle"];
        [temDic removeObjectForKey:@"heightType"];
    }
    
    [prams setObject:array forKey:@"prizes"];
    NSLog(@"Array --------- %@",array);
    NSLog(@"prams ...... %@",prams);
  
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_Activitysave Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation)
     {
        NSMutableDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            
            BOOL isContain = NO;
            for (UIViewController* vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[DrawActivityManageVC class]]) {
                   [self.navigationController popToViewController:vc animated:YES];
                    isContain = YES;
                    break;
                }
            }
            if (!isContain) {
                    NSArray *arr = self.navigationController.childViewControllers;
                    DrawActivityManageVC *vc = arr[2];
                    [self.navigationController popToViewController:vc animated:YES];
            }
        }
        else if ([[dic objectForKey:@"code"]isEqualToString:@"02-05"])
        {
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
        else
        {
             [SVProgressHUD showErrorWithStatus:@"请填写正确的信息"];
        }
        NSLog(@"save ====%@",dic);
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
         [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
    }];
}
//账户余额查询
- (void)requestRechargeMomey
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.linkPhone, @"")  forKey:@"mobile"];
    //    [params setObject:@"13913175811" forKey:@"mobile"];
    [SVProgressHUD show];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckyDraw_RechargeMoney Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"%@",dic);
        
        NSDictionary *dicx = [dic objectForKey:@"data"];
        NSString *priceStr = [NSString stringWithFormat:@"%@",[dicx objectForKey:@"balance"]];
        self.priceStr = [NSString stringWithFormat:@"%.2f",[priceStr floatValue]/100];
        
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
