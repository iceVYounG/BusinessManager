//
//  YuyueLookRoomVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "YuyueLookRoomVC.h"
#import "JMView.h"
#import "YuyueDetailEditCell.h"
#import "WeiZhanModel.h"
#import "YuyueDefaultCell.h"
@interface YuyueLookRoomVC ()<UITableViewDelegate,UITableViewDataSource,ShopEditCellDeledate>
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation YuyueLookRoomVC

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f5fa"];

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
        NSMutableArray *codeArr=[NSMutableArray arrayWithObjects:@"yykf1",@"yykf2",@"yykf3",@"yykf4",@"yykf5",@"yykf6", nil];
        NSMutableArray *valueArr=[NSMutableArray arrayWithObjects:@"联系人姓名",@"联系人手机号码",@"面积需求",@"看房时间",@"购买预算",@"户型要求", nil];
        NSMutableArray *typeArr=[NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"2",@"1",@"1", nil];
        for (int i=0; i<6; i++) {
            TemplateModel *model=[[TemplateModel alloc]init];
            model.code=codeArr[i];
            model.name=valueArr[i];
            model.type=typeArr[i];
            [self.datasArry addObject:model];
        }
    }

    
    [self tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return self.datasArry.count-6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        NSString *cellId = @"defaultCell";
        YuyueDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YuyueDefaultCell" owner:nil options:nil] objectAtIndex:0];
        }
        return cell;

    }
    
    else{
    TemplateModel* mData = [self.datasArry objectAtIndex:indexPath.row+6];
    
    NSPredicate* predice = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"zdy[0-9]+"];
    
    if (![predice evaluateWithObject:mData.code]) {
        NSString* idengfier=@"ShopServerCell_ident";
        YuyueDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopServerCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.selectionStyle = 0;
        cell.model = mData;
        
        return cell;
    }
    NSString* idengfier=@"ShopServerEditCell_ident";
    YuyueDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
    if (!cell) {
        cell = [[YuyueDetailCell alloc]initWithStyle:0 reuseIdentifier:idengfier];
    }
    cell.selectionStyle = 0;
    cell.model = mData;
    cell.delegate = self;
    
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 260;
    }
    return 44;
}


-(void)requestUpload{
    
    for (TemplateModel* model in self.datasArry.copy) {
        
        if (model.name.length == 0) {
            
            for (TemplateModel* mod in self.datasArry) {
                if ([mod.code isEqualToString:model.code]) {
                    
                    [self.datasArry removeObject:mod];
                    break;
                }
            }
        }else if (model.name.length > 0){
            
            //buchuli...
        }else{
            [OMGToast showWithText:@"请完善栏目信息"];
            return;
        }
    }
    
    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"预约看房";
        model.templateModelnameCode = @"yykf";
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        data.date = self.datasArry.copy;
        model.templateModelnameDate = data;
        model.templateNo = FangChan;
        
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
#pragma mark - Delegate
-(void)userDidDeleteTheCell:(TemplateModel *)model{
    
    for (TemplateModel* data in self.datasArry) {
        
        if ([data.code isEqualToString:model.code]) {
            
            [self.datasArry removeObject:data];
            break;
        }
    }
    [self.tableView reloadData];
}


#pragma mark - 初始化
-(UITableView *)tableView{
    
    if (!_tableView) {
        
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH) style:0];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.backgroundColor = [UIColor clearColor];
            _tableView.separatorStyle = 0;
            _tableView.tableFooterView = [self footView];
            [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIView*)footView{
    __weak typeof(self) wSelf = self;
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 190)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView* addBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, KScreenWidth, 68)];
    addBackView.backgroundColor = HexColor(@"#e8e8e8");
    
    UIImageView* imagev= [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-27)/2, 12, 27, 27)];
    imagev.image = [UIImage imageNamed:@"addImage"];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagev.frame)+3, KScreenWidth, 22)];
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
    
    NSPredicate* predice = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"zdy[0-9]+"];
    
    TemplateModel* lastModel = [self.datasArry lastObject];
    
    TemplateModel* model = [[TemplateModel alloc]init];
    
    if (![predice evaluateWithObject:lastModel.code]) {
        
        model.code = @"zdy0";
    }else{
        
        NSInteger num = [[lastModel.code substringFromIndex:3] integerValue];
        
        model.code = [NSString stringWithFormat:@"zdy%ld",num + 1];
    }
    //    model.key = @"";
    model.name = @"";
    model.type = @"1";
    
    [self.datasArry addObject:model];
    [self.tableView reloadData];
}

-(NSMutableArray *)datasArry{
    
    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}


@end