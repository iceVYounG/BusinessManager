//
//  YuyueDetailVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/10/9.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "YuyueDetailVC.h"
#import "YuyueDeatailCell.h"
#import "WeiZhanModel.h"
@interface YuyueDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *yuyueTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *vlaueArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabelViewHeight;
@end

@implementation YuyueDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle=@"记录详情";
    self.tabelViewHeight.constant=0;
    [self requestMyWeiZhanDatas:self.yuyueId];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -request
-(void)requestMyWeiZhanDatas:(NSString *)yuyueId{
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:yuyueId forKey:@"id"];
    [[MallNetManager share] request:API_appointRecordDeatail prams:prams succeed:^(id responseObject) {
        YuyueDeatailModel* rsp = [YuyueDeatailModel mj_objectWithKeyValues:responseObject];
        self.vlaueArray = rsp.data.mutableCopy;
        self.tabelViewHeight.constant=44*self.vlaueArray.count;
        [self.yuyueTableView reloadData];
    } showHUD:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.vlaueArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"YuyueDeatailCell";
    YuyueDeatailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"YuyueDeatailCell" owner:nil options:nil].firstObject;
        cell.selectionStyle=0;
        
    }
    YueyueDeatailData *model=[self.vlaueArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=model.key;
    cell.valueLabel.text=model.value;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;

}

-(NSMutableArray *)vlaueArray{
    if (!_vlaueArray) {
        _vlaueArray=[NSMutableArray array];
    }
    return _vlaueArray;
}


@end
