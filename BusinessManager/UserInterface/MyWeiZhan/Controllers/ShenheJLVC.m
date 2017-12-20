//
//  ShenheJLVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ShenheJLVC.h"
#import "ShenheCell.h"
#import "WeiZhanModel.h"
#import "WC_GeneralVC.h"
#import "E_Commerce.h"
#import "FourSWeiZhanVC.h"
#import "FoodWeiZhanVC.h"
#import "HouseWeiZhanVC.h"
@interface ShenheJLVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong,nonatomic) NSMutableArray *dataArr;
@end

@implementation ShenheJLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"上传12580客户端审核记录";
    _dataArr=[NSMutableArray array];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    _tableViewHeight.constant=44*(_dataArr.count+2);
    [self dataRequest];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count+1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indetifier=@"ShenheCell";
    
    ShenheCell *cell=[tableView dequeueReusableCellWithIdentifier:indetifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:indetifier owner:self options:nil].firstObject;
    }
    cell.selectionStyle=0;
    
    if (indexPath.row==0) {
        cell.staus.font=[UIFont boldSystemFontOfSize:14];
        cell.staus.textColor=[UIColor blackColor];
        
        cell.yijian.font=[UIFont boldSystemFontOfSize:14];
        cell.yijian.textColor=[UIColor blackColor];
        
        cell.deel.font=[UIFont boldSystemFontOfSize:14];
        cell.deel.textColor=[UIColor blackColor];
    
    }
    else{
        ShenHeDataModel *model=[self.dataArr objectAtIndex:indexPath.row-1];
        if ([model.auditStatus isEqualToString:@"1"]) {
            cell.staus.text=@"审核中";
            cell.deel.text=@"";
        }
        if ([model.auditStatus isEqualToString:@"2"]) {
            cell.staus.text=@"审核成功";
            cell.deel.text=@"";
        }
        if ([model.auditStatus isEqualToString:@"3"]) {
            cell.staus.text=@"审核失败";
            cell.deel.hidden=YES;
            cell.editBtn.hidden=NO;
            [cell.editBtn addTarget:self action:@selector(deelAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        cell.yijian.text=model.auditContent;
     }
    
    return cell;
}

-(void)deelAction{
    
    if ([self.templeNo isEqualToString: @"ws_base"]) {
        WC_GeneralVC* vc = [[WC_GeneralVC alloc]init];//通用
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.templeNo isEqualToString: @"ws001"]) {
        E_Commerce* vc = [[E_Commerce alloc]init];//电商
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.templeNo isEqualToString: @"ws002"]) {
        FourSWeiZhanVC* vc = [[FourSWeiZhanVC alloc]init];//4s
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.templeNo isEqualToString: @"ws003"]) {
        FoodWeiZhanVC* vc = [[FoodWeiZhanVC alloc]init];//餐饮
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.templeNo isEqualToString: @"ws004"]) {
        WC_GeneralVC* vc = [[WC_GeneralVC alloc]init];//家装
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.templeNo isEqualToString: @"ws005"]) {
        HouseWeiZhanVC * vc = [[HouseWeiZhanVC alloc]init];//房产
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
    view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_SIZE.width-30, 24)];    
    label.textColor=[UIColor redColor];
    label.text=@"审核记录按照时间倒序排序，最新的记录展示在最上面";
    label.font=[UIFont systemFontOfSize:12];
    [view addSubview:label];
    return view;
}


#pragma mark - request

-(void)dataRequest{

    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];    
    [prams setObject:@(self.weiZhanId) forKey:@"id"];
    [[MallNetManager share] request:API_shenHeJL prams:prams succeed:^(id responseObject) {
        ShenHeModel *model =[ShenHeModel mj_objectWithKeyValues:responseObject];
        self.dataArr=model.data.mutableCopy;
        _tableViewHeight.constant=44*(_dataArr.count+2);
        [self.myTableView reloadData];
    } showHUD:YES];

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