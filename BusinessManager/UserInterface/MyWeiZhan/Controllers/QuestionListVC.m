//
//  QuestionListVC.m
//  BusinessManager
//
//  Created by 朕 on 16/9/5.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "QuestionListVC.h"
#import "QuestionListCell.h"
#import "QuestionListBottomcell.h"


@interface QuestionListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property(nonatomic,assign)NSInteger sectionNum; //tableview段数

@end

@implementation QuestionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isYJFK) {
        self.title = @"意见反馈详情编辑";
    }
    else{
        self.title = @"调查问卷详情编辑";
    }
    
    
    if (!self.model) {
        self.model=[[PartModel alloc]init];
        NSMutableArray *dateArray=[[NSMutableArray alloc]init];
        self.model.id=0;
        if (_isYJFK) {
            self.model.templateModelname = @"意见反馈";
            self.model.templateModelnameCode = YiJFK;
            self.model.templateNo = CanYin;
        }
        else{
            self.model.templateModelname = @"调查报告";
            self.model.templateModelnameCode = DiaochaWJ;
            self.model.templateNo = SiSDian;
        }
        
        self.model.storeId = NoNullStr(AccountInfo.storeId, @"");
        TemplateModelData* data = [[TemplateModelData alloc] init];

        data.date = [dateArray copy];
        self.model.templateModelnameDate = data;
        [self saveData];
    }
    
    if (self.model.templateModelnameDate.date.count==0) {
        [self saveData];
    }
    
    self.model.templateModelnameDate.other = @"其他意见";
    self.model.templateModelnameDate.customerMoble = @"调查人手机号码";
    self.model.templateModelnameDate.customerName = @"调查人姓名";
        
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.mainTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"QuestionListCell" bundle:nil] forCellReuseIdentifier:@"QuestionListCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"QuestionListBottomcell" bundle:nil] forCellReuseIdentifier:@"QuestionListBottomcell"];
    
    //接收模型变化通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(optionChange:) name:@"OPTIONCHANGE" object:nil];
    
}

- (void)optionChange:(NSNotification*)noti
{
    NSLog(@"通知---%@",noti.object);
    TemplateModel *newModel = [noti.object objectForKey:@"model"];
    int index = [[noti.object objectForKey:@"index"]intValue];
    NSArray *oldArr;
    if (!self.model.templateModelnameDate.date) {
         oldArr = self.model.templateModelnameDate.date;
    }
    else{
        oldArr=[[NSArray alloc]init];
    
    }
   
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:oldArr];
    if (newArr.count==0) {
        return;
    }
    
    [newArr replaceObjectAtIndex:index withObject:newModel];
    
    self.model.templateModelnameDate.date = [newArr copy];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.model.templateModelnameDate.date count]>0) {
        _sectionNum = [self.model.templateModelnameDate.date count]+1;
    }else
    {
        _sectionNum = 2;
    }
    return _sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _sectionNum - 1) {
        return 374;
    }
    return 414;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == _sectionNum - 1) {
        static NSString*ID=@"QuestionListBottomcell";
        QuestionListBottomcell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[QuestionListBottomcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        [cell.addBtn addTarget:self action:@selector(deleteOrAddClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.saveBtn addTarget:self action:@selector(saveRequest) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else
    {
        static NSString*ID=@"QuestionListCell";
        QuestionListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[QuestionListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        [cell initCellContentWithIndex:indexPath.section andModel:self.model.templateModelnameDate.date[indexPath.section]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.deleteBtn.tag = indexPath.section;
        
        [cell.deleteBtn addTarget:self action:@selector(deleteOrAddClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
 
}

- (void)deleteOrAddClick:(UIButton*)btn
{
    if (btn.tag == -1) {
        [self saveData];
    }else if(_sectionNum == 2)
    {
        [OMGToast showWithText:@"只剩下一个问题了！"];
        return;
    }
    else
    {
        NSArray *oldArr = self.model.templateModelnameDate.date;
        NSMutableArray *newArr = [NSMutableArray arrayWithArray:oldArr];
        [newArr removeObjectAtIndex:btn.tag];
        
        self.model.templateModelnameDate.date = newArr;
    }
     _sectionNum = [self.model.templateModelnameDate.date count]+1;
    [self.mainTableView reloadData];
}

//添加Model
- (void)saveData
{
    [self deleteEnptyOptionDic];

    NSMutableArray *optionArr = [NSMutableArray array];
    TemplateModel *dateModel = [[TemplateModel alloc]init];
    dateModel.title = @"";
    dateModel.id = @"";
    
    
    TemplateModel *titleModel = [[TemplateModel alloc]init];
    titleModel.title = @"";
    [optionArr addObject:titleModel];
    
    
    dateModel.tabs = [optionArr copy];
    NSArray *oldArr = self.model.templateModelnameDate.date;
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:oldArr];
    [newArr addObject:dateModel];
    self.model.templateModelnameDate.date = newArr;

}

- (void)saveRequest
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    //删除tabs空字典
    [self deleteEnptyOptionDic];
    
    //判断是否问题为空  选项至少一个
    for (TemplateModel  *obj in self.model.templateModelnameDate.date) {
        TemplateModel  *tabsModel = [obj.tabs lastObject];
        if ([obj.title isEqualToString:@""]) {

            [OMGToast showWithText:@"问题不能为空！"];
            return;
        }else if ([tabsModel.title isEqualToString:@""] || tabsModel.title == nil)
        {
            [OMGToast showWithText:@"至少填写一个选项！"];
            return;
        }
    }
    NSLog(@">>>%@",self.model);
    
    NSArray *modelArr;
    if (self.model) {
        modelArr= @[self.model];
    }
    else{
        modelArr=[NSArray array];
    
    }
    
    [SVProgressHUD showWithStatus:@"数据处理中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [[MallNetManager share] request:API_TemplateSave parameters:[modelArr jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
        if (Succeed(responseObject)) {
           
           [OMGToast showWithText:@"保存成功"];
            
           [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [OMGToast showWithText:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
       
    }];
}

//删除问题选项空字典
- (void)deleteEnptyOptionDic
{
   __weak typeof(self) wSelf = self;
    [wSelf.model.templateModelnameDate.date enumerateObjectsUsingBlock:^(TemplateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *beforeArr = obj.tabs;
        NSMutableArray *afterArr = [NSMutableArray arrayWithArray:beforeArr];
        for (TemplateModel *item in obj.tabs) {
            if ([item.title isEqualToString:@""]) {
                [afterArr removeObject:item];
            }
            
        }
        obj.tabs = [afterArr copy];
    }];
}

@end
