//
//  EC_ProductRelatedVC.m
//  BusinessManager
//
//  Created by 王启明 on 16/8/17.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EC_ProductRelatedVC.h"
#import "EC_proTabCell.h"
#import "JMView.h"
#import "WeiZhanModel.h"
@interface EC_ProductRelatedVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField *textField;

}
@property (nonatomic,strong)UITableView *myTab;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIView *footView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)EC_proTabSelect *selectCell;
@property (nonatomic,strong)NSMutableDictionary *selectDic;
@end

@implementation EC_ProductRelatedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titleName;
    [self.view addSubview:self.myTab];
    [self requestProductor];
    
    // Do any additional setup after loading the view.
}

#pragma mark-privateMethods

- (void)addArray:(UIButton *)btn{
    btn.selected=!btn.selected;
    EC_proTabSelect *cell=(EC_proTabSelect*)[[btn superview]superview];
    NSIndexPath *indexPath=[self.myTab indexPathForCell:cell];
    NSString *key=[NSString stringWithFormat:@"%@",@(indexPath.section)];
    if ([[self.selectDic allKeys]containsObject:key]) {
        if (btn.selected==NO) {
            [self.selectDic removeObjectForKey:key];
        }
    }else{
            [self.selectDic setObject:cell.model forKey:key];
}

}

- (void)requestProductor{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    WS(weakSelf)
    [[MallNetManager share]request:API_ECProductGet prams:dic succeed:^(id responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"00-00"]) {
            NSMutableArray *mutableArr=[TemplateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [weakSelf.dataArr addObjectsFromArray:mutableArr];
            [weakSelf.myTab reloadData];
        }
    } showHUD:YES];


}

#pragma mark-保存模板数据
- (void)requestSaveWithLouCeng{
    NSArray *selectArr =[self.selectDic allValues];
    PartModel* model = [[PartModel alloc] init];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    if (!self.dataSource) {
    model.id=0;
    model.templateModelname = textField.text;
    model.templateModelnameCode = self.type;
    model.templateNo = DianShang;
    model.storeId = NoNullStr(AccountInfo.storeId, @"");
    TemplateModelData* data = [[TemplateModelData alloc] init];
    [selectArr enumerateObjectsUsingBlock:^(TemplateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel* temp = [[TemplateModel alloc] init];
        temp=obj;
        temp.imgPath=obj.webPath;
        temp.type=@"1";
        [array addObject:temp];
    }];
    data.date = [array copy];
    model.templateModelnameDate = data;
    }else{
        [selectArr enumerateObjectsUsingBlock:^(TemplateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TemplateModel* temp = [[TemplateModel alloc] init];
            temp=obj;
            temp.imgPath=obj.webPath;
            temp.type=@"1";
            [array addObject:temp];
        }];
        self.dataSource.templateModelname=textField.text;
        self.dataSource.templateModelnameDate.date=[array copy];
        model=self.dataSource;
    }
    NSArray* arr = @[model];
    
    __weak typeof(self) wSelf = self;
    
    [[MallNetManager share] request:API_TemplateSave parameters:[arr jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (Succeed(responseObject)) {
            
            SearPartData* rsp = [SearPartData mj_objectWithKeyValues:responseObject];
            if (rsp) {
                NSLog(@"%@",responseObject);
                
            }
            wSelf.data(textField.text,model,self.dataSource?NO:YES);
            [wSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [OMGToast showWithText:responseObject[@"msg"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];
    
}

#pragma mark-TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isRelated) {
        EC_proTabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EC_proTabCell" forIndexPath:indexPath];
        cell.model=self.dataArr[indexPath.section];
        return cell;
    }
    EC_proTabSelect *cell=[tableView dequeueReusableCellWithIdentifier:@"EC_proTabSelect" forIndexPath:indexPath];
    cell.model=self.dataArr[indexPath.section];
    [cell.seleteBtn addTarget:self action:@selector(addArray:) forControlEvents:UIControlEventTouchUpInside];
    cell.tag=indexPath.section;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *key=[NSString stringWithFormat:@"%@",@(indexPath.section)];
    if ([[self.selectDic allKeys]containsObject:key]) {
        cell.seleteBtn.selected=YES;
    }else{
    cell.seleteBtn.selected=NO;
    }
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isRelated) {
         EC_proTabCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        self.backModel(cell.model);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
     EC_proTabSelect *cell =[tableView cellForRowAtIndexPath:indexPath];
        [self addArray:cell.seleteBtn];
    
    }

}



#pragma mark-getter&&getter
- (UITableView *)myTab{
    if (!_myTab) {
        _myTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-NavigationH) style:UITableViewStyleGrouped];
        _myTab.dataSource=self;
        _myTab.delegate=self;
        _myTab.rowHeight=67;
       [_myTab registerNib:[UINib nibWithNibName:@"EC_proTabCell" bundle:nil] forCellReuseIdentifier:@"EC_proTabCell"];
        [_myTab registerClass:[EC_proTabSelect class] forCellReuseIdentifier:@"EC_proTabSelect"];
        _myTab.sectionFooterHeight=0;
        _myTab.sectionHeaderHeight=12;
        if (!self.isRelated) {
            _myTab.tableFooterView=self.footView;
            _myTab.tableHeaderView=self.headView;
        }
        [self.view addSubview:_myTab];
    }
    return _myTab;
}

-(UIView *)headView{
    if (!_headView) {
        _headView=[UIView new];
        _headView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
        _headView.frame=CGRectMake(0, 0, KScreenWidth, 78);
        textField=[[UITextField alloc]init];
        UIView *view=[UIView new];
        view.bounds=CGRectMake(0, 0, 20, 46);
        textField.leftView=view;
        textField.leftViewMode=UITextFieldViewModeAlways;
        textField.placeholder=@"请输入栏目名称";
        textField.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
        textField.font = [UIFont systemFontOfSize:14];
        textField.returnKeyType = UIReturnKeyDone;
        textField.layer.borderWidth=1.0f;
        textField.layer.borderColor=[UIColor colorWithHexString:@"#dadada"].CGColor;
        [_headView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView).offset(15);
            make.left.equalTo(_headView).offset(-1);
            make.right.equalTo(_headView).offset(1);
            make.height.equalTo(@46);
        }];
        
    }
    return _headView;
}

- (UIView *)footView{
    if (!_footView) {
        _footView = [UIView new];
        _footView.frame=CGRectMake(0, 0, KScreenWidth, 100);
         __weak typeof(self) wSelf = self;
       SaveView *save=[[SaveView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 90) tipHiden:YES block:^{
           if(![textField.text isEqualToString:@""]){
           [wSelf requestSaveWithLouCeng];
           }else{
               [OMGToast showWithText:@"请输入标题"];
           }
           
        }];
        [_footView addSubview:save];
    
        
    }
    return _footView;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}

- (NSMutableDictionary *)selectDic{
    if (!_selectDic) {
        _selectDic=[NSMutableDictionary dictionary];
    }
    return _selectDic;
}

- (void)setDataSource:(PartModel *)dataSource{
    _dataSource=dataSource;
    if (dataSource) {
        [self.view addSubview:self.myTab];
        textField.text=dataSource.templateModelname;
    }
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
