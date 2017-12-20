//
//  RedPacketRechargeVC.m
//  BusinessManager
//
//  Created by smile apple on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "RedPacketRechargeVC.h"
#import "RechargeDetailVC.h"
#import "RedPacketRechargeCell.h"
#import "LuckDrawModel.h"
#import "UIButton+WebCache.h"
#import "MPBuySMSVC.h"

#define selectTextColor [UIColor whiteColor]
#define labelTextColor  [UIColor colorWithHexString:@"3099ff"]
#define selectBackColor [UIColor colorWithHexString:@"0099ff"]

@interface RedPacketRechargeVC ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSInteger changeColor;
    NSMutableArray *priceArray;
}

@end

@implementation RedPacketRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现金红包充值";
    
    self.priceTF.text = [NSString stringWithFormat:@"%d",50];
   
    priceArray = [NSMutableArray array];
    self.momeyView.layer.borderWidth = 1;
    self.momeyView.layer.cornerRadius = 3;
    self.momeyView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    
    self.rechargeBtn.layer.cornerRadius = 3;
    
    UIButton *recordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [recordBtn setTitle:@"充值记录" forState:UIControlStateNormal];
    [recordBtn addTarget:self action:@selector(goToRecord) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    //注册collectionView的cell
    UINib *callChargesCellNib = [UINib nibWithNibName:@"RedPacketRechargeCell" bundle:nil];
    [self.redPacketCollectionView registerNib:callChargesCellNib forCellWithReuseIdentifier:@"RedPacketRechargeCell"];
    self.redPacketCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self requestRechargeMomey];

}

//账户余额查询
- (void)requestRechargeMomey{
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
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[priceStr floatValue]/100];
        
       
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
        [SVProgressHUD dismiss];
      
    }];
    
}

//立即充值
-(void)requestRechargeImmediate{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    double payCount = [self.priceTF.text doubleValue];       //单位是 元
    long amount = (long)(payCount * 100);                    //单位是 分

    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:NoNullStr(AccountInfo.linkPhone, @"") forKey:@"mobile"];
 
    [params setObject:@(amount) forKey:@"amount"];
    
     [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckyDraw_UserRechargeImmediate Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
         NSDictionary *dic = [completedOperation responseDecodeToDic];
         NSLog(@"%@",dic);
        
         if ([[dic objectForKey:@"code"]isEqualToString:@"00-00"]) {
             NSDictionary *dics = [dic objectForKey:@"data"];
             NSString *url = [dics objectForKey:@"REDIRECT_URL"];
             
             [self turnToWebViewWith:url];
             
//             [self.rechargeBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[dics objectForKey:@"REDIRECT_URL"]] forState:UIControlStateNormal];

         }
         
     } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
         [SVProgressHUD dismiss];
         
     }];
}

-(void)goToRecord{
    RechargeDetailVC *rvc = [[RechargeDetailVC alloc]initWithNibName:@"RechargeDetailVC" bundle:nil];
    [self.navigationController pushViewController:rvc animated:YES];
}

#pragma collectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_SIZE.width - 45)/2, 48);
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RedPacketRechargeCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RedPacketRechargeCell" forIndexPath:indexPath];
    cell.layer.borderColor  = [[UIColor colorWithHexString:@"01aaef"]CGColor];
    cell.layer.borderWidth  = 1;
    cell.layer.cornerRadius = 3;
    
    [priceArray addObject:@"50"];
    [priceArray addObject:@"100"];
    [priceArray addObject:@"500"];
    [priceArray addObject:@"1000"];
    
    cell.priceLabel.text = priceArray[indexPath.row];
   
    if (changeColor == indexPath.row) {
        cell.priceLabel.textColor = selectTextColor;
        
        cell.backgroundColor = selectBackColor;
        
        cell.layer.borderWidth = 0;

    }else{
        cell.priceLabel.textColor = labelTextColor;
        
        cell.backgroundColor = selectTextColor;
        
        cell.layer.borderWidth = 1.0;

    }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.priceTF.text = priceArray[indexPath.row];
    
    if (changeColor == indexPath.row) {
        return ;
    }
    else{
        
    }
    changeColor = indexPath.row;
    [self.redPacketCollectionView reloadData];

    
}

//立即充值
- (IBAction)rechargeActionBtn:(id)sender {
    
    [self requestRechargeImmediate];
}


- (void)turnToWebViewWith:(NSString *)url {
    MPBuySMSVC *vc = [[MPBuySMSVC alloc] initWithNibName:@"MPBuySMSVC" bundle:nil];
    vc.url = url;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
