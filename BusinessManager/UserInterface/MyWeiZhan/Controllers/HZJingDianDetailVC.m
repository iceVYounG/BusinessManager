//
//  HZJingDianDetailVC.m
//  BusinessManager
//
//  Created by 牛志胜 on 16/9/1.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZJingDianDetailVC.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "HZCaseDetailCell.h"
@interface HZJingDianDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;


@end

@implementation HZJingDianDetailVC

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"经典案例详情编辑";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self tableView];
    
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
    [self tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZCaseDetailCell *cell = [[HZCaseDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.model = self.datasArry[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.caseNumLab.text = @"案例一:";
            break;
        case 1:
            cell.caseNumLab.text = @"案例二:";
            break;
        case 2:
            cell.caseNumLab.text = @"案例三:";
            break;
        case 3:
            cell.caseNumLab.text = @"案例四:";
            break;
        case 4:
            cell.caseNumLab.text = @"案例五:";
            break;
        case 5:
            cell.caseNumLab.text = @"案例六:";
            break;
        case 6:
            cell.caseNumLab.text = @"案例七:";
            break;
        case 7:
            cell.caseNumLab.text = @"案例八:";
            break;
            
        default:
            break;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 490;
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


#pragma mark --- 添加新的案例
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
    model.key = @"";
    model.value = @"";
    model.type = @"1";
    
    [self.datasArry addObject:model];
    
    [self.tableView reloadData];
}


-(void)requestUpload{
    
    for (TemplateModel* model in self.datasArry.copy) {
        
        if (model.key.length == 0 && model.value.length == 0) {
            
            for (TemplateModel* mod in self.datasArry) {
                if ([mod.code isEqualToString:model.code]) {
                    
                    [self.datasArry removeObject:mod];
                    break;
                }
            }
        }else if (model.key.length > 0 && model.value.length > 0){
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
        model.templateModelname = @"经典案例";
        model.templateModelnameCode = JingDianCase;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        data.date = self.datasArry.copy;
        model.templateModelnameDate = data;
        model.templateNo = JiaZhuang;
        
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
