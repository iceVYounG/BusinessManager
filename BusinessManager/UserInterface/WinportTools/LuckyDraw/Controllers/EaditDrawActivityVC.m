//
//  EaditDrawActivityVC.m
//  BusinessManager
//
//  Created by The Only on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EaditDrawActivityVC.h"
#import "EaditDrawCell.h"
#import "MPChooseUserTypeView.h"
#import "ChoosePrizeTypeView.h"
#import "LuckDrawModel.h"
#import "UIView+SDAutoLayout.h"
#import "ChoosePrizeTypeView.h"
#import "RedBagModel.h"
#import "AddNewRedBagCell.h"
#define SAVEACTIVITYTAG 34
#define DELETEACTIVITYTAG 35
@interface EaditDrawActivityVC ()<UITableViewDelegate,UITableViewDataSource,AddNewRedBagCellDelegate,EaditDrawCellDelegate,ChoosePrizeTypeViewDelegate>
{
    activityInfoItem *infoItem;
    NSInteger typeNumber;
//    NSMutableArray *prizeInfo_Array;
    
}
@property(nonatomic,strong)NSMutableArray *activityInfoArray;
@property(nonatomic,strong)NSMutableDictionary *activityInfoDic;
@property (strong,nonatomic)UILabel *chooseStrLable;
//@property (strong,nonatomic)NSMutableArray *presentArray;
@property (strong,nonatomic)NSString *priceStr;
@end

@implementation EaditDrawActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"编辑抽奖活动";
     //设置圆角
    self.saveBtn.layer.cornerRadius = 6;
    self.saveBtn.layer.masksToBounds = YES;
    self.deleteActivityBtn.layer.cornerRadius = 6;
    self.deleteActivityBtn.layer.masksToBounds = YES;
    self.continuePrizeBtn.layer.cornerRadius = 6;
    self.continuePrizeBtn.layer.masksToBounds = YES;
    
    [self requestActivityInfo];
    [self prepateData];
//    prizeInfo_Array = [NSMutableArray array];
    [self requestRechargeMomey];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
}
//-(void)textFieldDidChange
//{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.activityInfoArray.count -1 inSection:0];
//    EaditDrawCell *addCell = (EaditDrawCell *)[self.presentInfoTableView cellForRowAtIndexPath:indexPath];
//    infoItem = self.activityInfoArray[indexPath.row];
//    infoItem.redBagName = addCell.redNameTF.text;
//    infoItem.redBagNumber = addCell.redCountTF.text;
//    infoItem.redBagMoney = addCell.singleRedMoneyTF.text;
//    infoItem.redBagZJCiShu = addCell.winningCountTF.text;
//    infoItem.redBagZJGaiLv = addCell.winningChanceTF.text;
//    
//    if ([addCell.winningCountTF resignFirstResponder])
//    {
//        NSMutableDictionary *PrizeDic = [NSMutableDictionary dictionary];
//        
//        [PrizeDic setObject:@(typeNumber) forKey:@"type"];
//        [PrizeDic setObject:infoItem.redBagName forKey:@"redName"];
//        [PrizeDic setObject:infoItem.redBagMoney forKey:@"singleAmount"];
//        [PrizeDic setObject:infoItem.redBagZJGaiLv forKey:@"drawProbability"];
//        [PrizeDic setObject:infoItem.redBagNumber forKey:@"redNum"];
//        [PrizeDic setObject:infoItem.redBagZJCiShu forKey:@"singleLmLum"];
//        [prizeInfo_Array addObject:PrizeDic];
//    }
//    NSLog(@"prizeInfoArray ------ %@",prizeInfo_Array);
//}
-(void)prepateData
{
//    self.presentArray = [NSMutableArray array];
    self.activityInfoArray = [NSMutableArray array];
    [self.presentInfoTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.activityInfoArray.count)
    {
        static NSString *identifierCell = @"Cell";
        EaditDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"EaditDrawCell" owner:self options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            infoItem = self.activityInfoArray[indexPath.row];
            [cell setData:infoItem];
            cell.prizeDeleteBtn.tag = indexPath.row;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.activityInfoArray.count+1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.activityInfoArray.count) {
        
        infoItem = self.activityInfoArray[indexPath.row];
        if (infoItem.chooseDrawType == nil) {
            
            return 44;
        }
        else
        {
            if ([infoItem.chooseDrawType isEqualToString:@"singleMoney"]) {
                
                return 238;
            }
            else
            {
                return 284;
            }
        }
    }
    else
    {
        return 60;
    }
   
}

#pragma mark - EaditDrawCellDelegate
// 选择奖品类型
-(void)chooseTypeOnEaditDrawCell:(EaditDrawCell *)cell
{
    NSIndexPath *indexPath = [self.presentInfoTableView indexPathForCell:cell];
    WS(weakSelf)
    
     infoItem = self.activityInfoArray[indexPath.row];
    __weak typeof (infoItem) weakRed = infoItem;
    
    ChoosePrizeTypeView *prizeView = [[ChoosePrizeTypeView alloc] initWithFrame:CGRectMake(0, 0,KWSize.width , KWSize.height) block:^(NSString *typeBlock) {
        weakRed.btnTitle = typeBlock;
       
        if ([weakRed.btnTitle isEqualToString:@"实物奖品"]) {
            
            weakRed.chooseDrawType = @"singleMoney";
        }
        else
        {
            weakRed.chooseDrawType = @"type";
        }
        [weakSelf.presentInfoTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    prizeView.delegate = self;
    [prizeView show];
    
}
// 删除一个cell
-(void)deleteEaditDrawCell:(EaditDrawCell *)cell
{
   
    if (infoItem.InfoID != nil)
    {
        
        [self requestPrizeDeleteInfo:cell.prizeDeleteBtn.tag];
    }
    else
    {
        NSIndexPath *indexPath = [self.presentInfoTableView indexPathForCell:cell];
        infoItem = self.activityInfoArray[indexPath.row];
        [self.activityInfoArray removeObject:infoItem];
        [self.presentInfoTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.myTableViewHeight.constant = (self.activityInfoArray.count+1) *283;
        self.scrollerViewHeight.constant = 193+self.myTableViewHeight.constant;
    }
 
}
-(void)eaditDrawCell:(EaditDrawCell *)myCell redBagNameTF:(UITextField *)RName redBagCountTF:(UITextField *)RCount redBagNumberTF:(UITextField *)RNumber redBagChance:(UITextField *)RChance redBagMoney:(UITextField *)RMoney Type:(NSString *)RType
{

    NSIndexPath *indexPath = [self.presentInfoTableView indexPathForCell:myCell];
    if (self.activityInfoArray.count > 0)
    {
        infoItem = self.activityInfoArray[indexPath.row];
        infoItem.redName = RName.text;
        infoItem.redNum = RCount.text;
        infoItem.singleAmount = [NSString stringWithFormat:@"%.2f",[RMoney.text floatValue]*100];
        infoItem.singleLmLum = RNumber.text;
        infoItem.drawProbability = RChance.text;
        infoItem.type = [NSString stringWithFormat:@"%ld",typeNumber];
        
    }
//    if (![myCell.redCountTF.text isEqualToString:@""])
//    {
//        
//        if (myCell.redCountTF.text.length>6)
//        {
//            [SVProgressHUD showInfoWithStatus:@"红包数量应小于六位数"];
//            return;
//        }
//    }
//    // 判断大于0小于1
//    if (![infoItem.redBagZJGaiLv isEqualToString:@""])
//    {
//        infoItem.redBagZJGaiLv = [NSString stringWithFormat:@"%.1f",round([infoItem.redBagZJGaiLv floatValue]*100)/100];
//        if ([infoItem.redBagZJGaiLv floatValue] <= 0 || [infoItem.redBagZJGaiLv floatValue] >= 1.1)
//        {
//            [SVProgressHUD showInfoWithStatus:@"中奖概率应大于0,小于等于1"];
//            return;
//        }
//    }
//    保存活动的参数
//    if (![infoItem.redBagZJCiShu isEqualToString:@""])
//    {
//        NSMutableDictionary *PrizeDic = [NSMutableDictionary dictionary];
//        
//            [PrizeDic setObject:@(typeNumber) forKey:@"type"];
//            [PrizeDic setObject:infoItem.redBagName forKey:@"redName"];
//            [PrizeDic setObject:infoItem.redBagMoney forKey:@"singleAmount"];
//            [PrizeDic setObject:infoItem.redBagZJGaiLv forKey:@"drawProbability"];
//            [PrizeDic setObject:infoItem.redBagNumber forKey:@"redNum"];
//            [PrizeDic setObject:infoItem.redBagZJCiShu forKey:@"singleLmLum"];
//            [prizeInfo_Array addObject:PrizeDic];
//    }
    
//     NSLog(@"prizeInfo_Array %@",prizeInfo_Array);
}
#pragma mark - AddNewRedBagCellDelegate
//点击继续添加奖品按钮 添加cell
- (void)clickOnAddCell:(AddNewRedBagCell *)cell
{
    
    if (self.activityInfoArray.count >=40) {
        
        [SVProgressHUD showInfoWithStatus:@"最多只能添加40个奖品"];
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.activityInfoArray.count -1 inSection:0];
    EaditDrawCell *addCell = (EaditDrawCell *)[self.presentInfoTableView cellForRowAtIndexPath:indexPath];
    
    if ([addCell.redTypeBtn.titleLabel.text isEqualToString:@"请选择奖品类型"]) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择奖品类型"];
        return;
    }
    if ([addCell.redNameTF.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入红包名称"];
        return;
    }
    if ([addCell.redTypeBtn.titleLabel.text isEqualToString:@"现金红包"])
    {
        if ([addCell.singleRedMoneyTF.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入单个红包金额"];
            return;
        }
        
        NSInteger numberStr =  [addCell.redCountTF.text integerValue]*[addCell.singleRedMoneyTF.text integerValue];
        if (numberStr > [self.priceStr integerValue]) {
            
            [SVProgressHUD showInfoWithStatus:@"账户余额不足"];
            return;
        }
    }
        if ([addCell.redCountTF.text isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入红包个数"];
        return;
    }
    if ([addCell.winningChanceTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖概率"];
        return;
    }
    if ([addCell.winningCountTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖次数"];
        return;
    }
        // 重新创建model
    activityInfoItem *model = [[activityInfoItem alloc] init];
    //把model添加到数组
//   RedBagModel *model = [[RedBagModel alloc] init];
    
    [self.activityInfoArray addObject:model];
    // 添加cell
    [self.presentInfoTableView beginUpdates];
    [self.presentInfoTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.activityInfoArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.presentInfoTableView endUpdates];
    self.myTableViewHeight.constant = (self.activityInfoArray.count+1) *283;
    self.scrollerViewHeight.constant = 193+self.myTableViewHeight.constant;
    //获取当前的 cell 个数
    addCell.cellTags = [self.presentInfoTableView numberOfRowsInSection:0];
}
#pragma mark ChoosePrizeTypeViewDelegate
-(void)didFinishClickBtnTag:(NSInteger)tag chooseView:(ChoosePrizeTypeView *)view
{
    
    typeNumber = tag+1;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.activityInfoArray.count -1 inSection:0];
//    EaditDrawCell *addCell = (EaditDrawCell *)[self.presentInfoTableView cellForRowAtIndexPath:indexPath];
    infoItem = self.activityInfoArray[indexPath.row];
    infoItem.type = [NSString stringWithFormat:@"%ld",typeNumber];
    infoItem.InfoID = @"";
    
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
// 可参与活动的用户
- (IBAction)joinPeopleAction:(id)sender
{
    WS(weakSelf);
    MPChooseUserTypeView *view = [[MPChooseUserTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) type:AllUserShow WithBlock:^(NSString *userType, NSString *userNum) {
        
        [weakSelf.takeACtivityPeopleBtn setTitle:userType forState:UIControlStateNormal];
        [weakSelf.takeACtivityPeopleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }];
    
    [view show];
}

//// 删除单个奖品
//-(void)prizeDEleteAction:(UIButton *)btn
//{
//    [self requestPrizeDeleteInfo];
//}

// 删除活动
- (IBAction)saveAndDeleteActivityAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case SAVEACTIVITYTAG:// 保存
        {
            [self requestSaveActivityInfo];
        }
            break;
        case DELETEACTIVITYTAG://删除
        {
            [self requestActivityDelgteInfo];
        }
        default:
            break;
    }
}

-(void)requestActivityInfo
{
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:self.acItemModel.storeId forKey:@"storeId"];
    [prams setObject:self.acItemModel.ID forKey:@"id"];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [[MallNetworkEngine loginshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_ActivityInfo Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dic = [completedOperation responseDecodeToDic];
        NSMutableDictionary *dataDic = [dic objectForKey:@"data"];
        self.activityInfoDic = dataDic;
        NSLog(@"activityInfo  ====  %@",dic);
        NSLog(@"data  ====  %@",dataDic);
        if (Succeed(dic)) {
            if (![[dataDic objectForKey:@"name"] isKindOfClass:[NSNull class]]&&![[dataDic objectForKey:@"endTime"] isKindOfClass:[NSNull class]]&&![[dataDic objectForKey:@"startTime"] isKindOfClass:[NSNull class]]&&![[dataDic objectForKey:@"useDays"] isKindOfClass:[NSNull class]]&&![[dataDic objectForKey:@"singleDrawNum"] isKindOfClass:[NSNull class]])
            {
                self.myAvtivityLable.text = [dataDic objectForKey:@"name"];
                self.endTimeLable.text = [self timeFormat:[dataDic objectForKey:@"endTime"]];
                self.startTimeLable.text = [self timeFormat:[dataDic objectForKey:@"startTime"]];
                if ( [dataDic objectForKey:@"useDays"] == 0|| [[dataDic objectForKey:@"useDays"] isEqualToString:@"0"])
                {
                     self.redValidFate.text = @"长期有效";
                }
                else
                {
                     self.redValidFate.text = [dataDic objectForKey:@"useDays"];
                }
                self.redNum.text = [dataDic objectForKey:@"singleDrawNum"];
                if ([dataDic objectForKey:@"memberType"] == nil || [[dataDic objectForKey:@"memberType"] isEqual:[NSNull null]]) {
 
                    [self.takeACtivityPeopleBtn setTitle:@"所有用户" forState:UIControlStateNormal];
                }
                else
                {
                     [self.takeACtivityPeopleBtn setTitle:[dataDic objectForKey:@"memberType"] forState:UIControlStateNormal];
                }
                
            }
            
//            self.presentArray = [dataDic objectForKey:@"prizes"];
            
            // 将字典数组转成模型数组
            activityInfoModel *infoModel = [activityInfoModel mj_objectWithKeyValues:dataDic];
 
             if (infoModel.prizes.count > 0)
            {
                [self.activityInfoArray addObjectsFromArray:infoModel.prizes];
                self.myTableViewHeight.constant = (self.activityInfoArray.count+1) *283;
                
                self.scrollerViewHeight.constant = 193+self.myTableViewHeight.constant;
             }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
            [SVProgressHUD dismiss];
        }
        
        [self.presentInfoTableView reloadData];
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
    }];
    
}
// 删除单个奖品
-(void)requestPrizeDeleteInfo:(NSInteger )tag
{
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
   
    infoItem = self.activityInfoArray[tag];
    
    [prams setObject:NoNullStr(AccountInfo.storeId, @"")  forKey:@"storeId"];
    [prams setObject:infoItem.InfoID forKey:@"id"];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [[MallNetworkEngine loginshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_ActivityPrizeDelete Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
//        [SVProgressHUD dismiss];
        NSMutableDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"delete === %@",dic);
        if (Succeed(dic)) {
            
            [SVProgressHUD showInfoWithStatus:@"删除成功"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
            infoItem = self.activityInfoArray[indexPath.row];
            [self.activityInfoArray removeObject:infoItem];
            [self.presentInfoTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.myTableViewHeight.constant = (self.activityInfoArray.count+1) *283;
            self.scrollerViewHeight.constant = 193+self.myTableViewHeight.constant;

            [self.presentInfoTableView reloadData];
            
//            [self requestActivityInfo];
        }
        else if([[dic objectForKey:@"code"]isEqualToString:@"02-07"])
        {
             [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"msg"]];
        }
        else
        {
           [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
            [SVProgressHUD dismiss];
        }
        [self.presentInfoTableView reloadData];
    
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
    }];

    
}
// 删除活动
-(void)requestActivityDelgteInfo
{
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    
    [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [prams setObject:self.acItemModel.ID forKey:@"id"];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [[MallNetworkEngine loginshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_ActivityDelete Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"delete === %@",dic);
        
        if (Succeed(dic)) {
            
            [SVProgressHUD showInfoWithStatus:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if([[dic objectForKey:@"code"]isEqualToString:@"02-07"])
        {
            [SVProgressHUD showErrorWithStatus:[dic objectForKey:@"msg"]];
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
            [SVProgressHUD dismiss];
        }
        [self.presentInfoTableView reloadData];
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
    }];

}
// 保存修改活动
-(void)requestSaveActivityInfo
{
    
    if (self.activityInfoArray.count >=40) {
        
        [SVProgressHUD showInfoWithStatus:@"最多只能添加40个奖品"];
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.activityInfoArray.count -1 inSection:0];
    EaditDrawCell *addCell = (EaditDrawCell *)[self.presentInfoTableView cellForRowAtIndexPath:indexPath];
    if (addCell == nil)
    {
        [SVProgressHUD showInfoWithStatus:@"请选择奖品类型"];
        return;
        
    }
    if ([addCell.redTypeBtn.titleLabel.text isEqualToString:@"请选择奖品类型"]) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择奖品类型"];
        return;
    }
    if ([addCell.redNameTF.text isEqualToString:@""])
    {
        
        [SVProgressHUD showInfoWithStatus:@"请输入红包名称"];
        return;
    }
    if ([addCell.redTypeBtn.titleLabel.text isEqualToString:@"现金红包"])
    {
        if ([addCell.singleRedMoneyTF.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入单个红包金额"];
            return;
        }
        NSInteger numberStr =  [addCell.redCountTF.text integerValue]*[addCell.singleRedMoneyTF.text integerValue];
        if (numberStr > [self.priceStr integerValue]) {
            
            [SVProgressHUD showInfoWithStatus:@"账户余额不足"];
            return;
        }
    }
    if ([addCell.redCountTF.text isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入红包个数"];
        return;
    }
    if ([addCell.winningChanceTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖概率"];
        return;
    }
    if ([addCell.winningCountTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入中奖次数"];
        return;
    }
    if (![addCell.redCountTF.text isEqualToString:@""])
    {
        
        if (addCell.redCountTF.text.length>6)
        {
            [SVProgressHUD showInfoWithStatus:@"红包数量应小于六位数"];
            return;
        }
    }
    // 判断大于0小于1
    if (![infoItem.drawProbability isEqualToString:@""])
    {
        infoItem.drawProbability = [NSString stringWithFormat:@"%.1f",round([infoItem.drawProbability floatValue]*100)/100];
        if ([infoItem.drawProbability floatValue] <= 0 || [infoItem.drawProbability floatValue] >= 1.1)
        {
            [SVProgressHUD showInfoWithStatus:@"中奖概率应大于0,小于等于1"];
            return;
        }
    }

    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    
    [prams setObject:self.acItemModel.ID forKey:@"id"];
    [prams setObject:self.self.myAvtivityLable.text forKey:@"name"];
    [prams setObject:[self datetimeFormat:self.endTimeLable.text]  forKey:@"endTime"];
    [prams setObject:[self datetimeFormat:self.startTimeLable.text] forKey:@"startTime"];
    [prams setObject:self.redNum.text forKey:@"singleDrawNum"];
    [prams setObject:NoNullStr(AccountInfo.storeId, @"")forKey:@"storeId"];
    [prams setObject:self.redValidFate.text forKey:@"useDays"];
    if ([self.takeACtivityPeopleBtn.titleLabel.text isEqualToString:@"所有用户"]) {
        [prams setObject:@"" forKey:@"memberType"];
    }else{
        [prams setObject:self.takeACtivityPeopleBtn.titleLabel.text forKey:@"memberType"];
    }
    NSMutableArray *array = [NSObject mj_keyValuesArrayWithObjectArray:self.activityInfoArray];
    for (NSMutableDictionary *temDic in array)
    {
        [temDic removeObjectForKey:@"btnTitle"];
        [temDic removeObjectForKey:@"chooseDrawType"];
    }
    [prams setObject:array forKey:@"prizes"];
    NSLog(@"+++++++ %@",prams);
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [[MallNetworkEngine loginshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_Activitysave Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
//        [SVProgressHUD dismiss];
        NSMutableDictionary *dic = [completedOperation responseDecodeToDic];
        
        NSLog(@"save === %@",dic);
        if (Succeed(dic))
        {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([[dic objectForKey:@"code"]isEqualToString:@"02-05"])
        {
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
        else if([[dic objectForKey:@"code"]isEqualToString:@"02-05"])
        {
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
        else
        {
             [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
//            [SVProgressHUD dismiss];
        }
      
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
    }];

}
-(NSString *)timeFormat :(NSString *)time{
    
    NSString *str=[time substringToIndex:8];
    NSString *str2=[str substringToIndex:4];
    NSString *str3=[str substringWithRange:NSMakeRange(4, 2)];
    NSString *str4=[str substringFromIndex:6];
    NSString *timeStr=[time substringFromIndex:8];
    NSString *str1=[timeStr substringFromIndex:4];
    NSString *str6=[timeStr substringToIndex:2];
    NSString *str7=[timeStr substringWithRange:NSMakeRange(2, 2)];
    
    NSString *str5=[NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",str2,str3,str4,str6,str7,str1];
    
    //    NSString *str8=[NSString stringWithFormat:@"%@:%@:%@",str2,str3,str1];
    
    
    
    return str5;
}
//时间转换
- (NSString *)datetimeFormat:(NSString *)time{
    NSString *str      = [time substringToIndex:10];
    NSString *yearStr  = [str substringToIndex:4];
    NSString *monthStr = [str substringWithRange:NSMakeRange(5, 2)];
    NSString *dayStr   = [str substringFromIndex:8];
    
    
    NSString *timeStr   = [time substringFromIndex:11];
    NSString *hourStr   = [timeStr substringToIndex:2];
    NSString *minuteStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    NSString *secondStr = [timeStr substringFromIndex:6];
    
    NSString *strTime=[NSString stringWithFormat:@"%@%@%@%@%@%@",yearStr,monthStr,dayStr,hourStr,minuteStr,secondStr];
    
    return strTime;
    
}
//账户余额查询
- (void)requestRechargeMomey
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.linkPhone, @"") forKey:@"mobile"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
