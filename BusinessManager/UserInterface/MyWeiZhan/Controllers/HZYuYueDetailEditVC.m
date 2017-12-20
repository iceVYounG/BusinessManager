//
//  HZYuYueDetailEditVC.m
//  BusinessManager
//
//  Created by niuzs on 16/8/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZYuYueDetailEditVC.h"
#import "JMView.h"
#import "YuyueDetailEditCell.h"
#import "WeiZhanModel.h"

@interface HZYuYueDetailEditVC ()<UITableViewDelegate,UITableViewDataSource,HZYuYueDetailCellDelegate>
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation HZYuYueDetailEditVC

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约装修详情编辑";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
-(void)setModel:(PartModel *)model{
    
    _model = model;
    
    NSArray* keys = KeysArry;
    [_model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel* model = (TemplateModel*)obj;
        if (![keys containsObject:model.code]) {
            
            [self.datasArry addObject:obj];
        }
    }];
    
    if (self.datasArry.count==0) {
        NSMutableArray *codeArr=[NSMutableArray arrayWithObjects:@"yyzx1",@"yyzx2",@"yyxz3",@"yyxz4",@"yyxz5", nil];
        NSMutableArray *valueArr=[NSMutableArray arrayWithObjects:@"联系人姓名",@"联系人手机号码",@"装修面积",@"装修预算",@"装修时间",nil];
        NSMutableArray *typeArr=[NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"2", nil];
        for (int i=0; i<5; i++) {
            TemplateModel *model=[[TemplateModel alloc]init];
            model.code=codeArr[i];
            model.name=valueArr[i];
            model.type=typeArr[i];
            [self.datasArry addObject:model];
        }
    }
    
    [self tableView];
}

-(void)requestUpload{
    
    for (TemplateModel *model in self.datasArry) {
        if ([model.name isEqualToString:@""]|!model.name) {
            [OMGToast showWithText:@"请完善栏目信息"];
            return;
        }
    }
    PartModel* model;
    
    if (!self.model) {
        model = [[PartModel alloc] init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"预约装修详情编辑";
        model.templateModelnameCode = YuYueZX;
        model.id = self.model.id;
        TemplateModelData* data = [[TemplateModelData alloc] init];
        model.templateModelnameDate = data;
        model.templateNo = JiaZhuang;
        data.date = self.datasArry.copy;

    }else{
        
        self.model.templateModelnameDate.date = self.datasArry.copy;
        model = self.model;
    }
    
    NSArray* arr = @[model];
    
    __weak typeof(self) wSelf = self;
    [self saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
        
        wSelf.block(model,self.model?NO:YES);
        [wSelf.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        
    }];
    
}

#pragma mark - 初始化
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:0];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView = [self footView];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


-(NSMutableArray *)datasArry{
    
    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}

#pragma mark - tableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.datasArry.count - 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSString *cellId = @"defaultCell";
        HZYuYueDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YuyueDetailEditCell" owner:nil options:nil] objectAtIndex:1];
        }
        return cell;
        
    }else{
        
        NSString *cellID = @"cell";
        TemplateModel* templateModle = [self.datasArry objectAtIndex:indexPath.row + 5];
        HZYuYueDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HZYuYueDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.model = templateModle;
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 270;
    }else{
        return 60;
    }
}
#pragma mark - HZYuYueDetailCellDelegate
- (void)yuYueDetailCell:(HZYuYueDetailCell *)cell didDeleteCellWithModel:(TemplateModel *)model{
    for (TemplateModel* data in self.datasArry) {
        if ([data.code isEqualToString:model.code]) {
            [self.datasArry removeObject:data];
            break;
        }
    }
    [self.tableView reloadData];

}

#pragma mark - 初始化
-(UIView*)footView{
    __weak typeof(self) wSelf = self;
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 190)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView* addBackView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth - 30, 68)];
    addBackView.backgroundColor = HexColor(@"#e8e8e8");
    
    
    UIImageView* imagev= [[UIImageView alloc]initWithFrame:CGRectMake(addBackView.center.x -27, 12, 27, 27)];
    
    imagev.image = [UIImage imageNamed:@"addImage"];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagev.frame)+3, KScreenWidth - 30, 22)];
    label.text = @"点击新增";
    label.textAlignment = 1;
    label.textColor = HexColor(@"#BBBBBB");
    [addBackView addSubview:imagev];
    [addBackView addSubview:label];
    
    [backView addSubview:addBackView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAction)];
    [addBackView addGestureRecognizer:tap];
    
    SaveView* saveView = [[SaveView alloc]initWithFrame:CGRectMake(0, 103, KScreenWidth, 90) tipHiden:YES block:^{
        
        [wSelf requestUpload];
    }];
    
    [backView addSubview:saveView];
    
    return backView;
}

-(void)addAction{
    
    TemplateModel *lastModel = [self.datasArry lastObject];
    TemplateModel* model = [[TemplateModel alloc]init];
    NSInteger num = [[lastModel.code substringFromIndex:4] integerValue];
    model.code = [NSString stringWithFormat:@"yyzx%ld",num + 1];
    model.key = @"";
    model.value = @"";
    model.type = @"1";
    [self.datasArry addObject:model];
    
    [self.tableView reloadData];
}

@end
