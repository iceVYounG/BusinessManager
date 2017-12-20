//
//  TY_TitleEditVC.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "TY_TitleEditVC.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "OMGToast.h"
@interface TY_TitleEditVC ()
{
    UITextField* textFild;
}
@property(nonatomic,copy) ShopNB block;

@end

@implementation TY_TitleEditVC

-(instancetype)initWithBlock:(ShopNB)nameBlock{

    if (self = [super init]) {
        
        self.block = nameBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"店铺名称编辑";
    
    
    [self ui];
}


-(void)requestUpload{

    if ([textFild.text isEqualToString:@""]) {
        [OMGToast showWithText:@"请填写店铺名称后保存"];
        return;
    }
    if (textFild.text.length>20) {
        [OMGToast showWithText:@"名称输入过长，请重新输入"];
        return;
    }
    
    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"店铺名称";
        model.templateModelnameCode = ShopName;
        model.id = 0;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel* temp = [[TemplateModel alloc] init];
        temp.name = textFild.text;
        data.date = @[temp];
        model.templateModelnameDate = data;
        model.templateNo = Tongyong;
        NSLog(@"%ld---%@",temp.status,temp.name);
        
    }else{
        TemplateModel* tModel = self.model.templateModelnameDate.date.lastObject;
        tModel.name = textFild.text;
        self.model.templateModelnameDate.date = @[tModel];
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

-(void)ui{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView* fildBackV = [[UIView alloc]initWithFrame:CGRectMake(0, 25, KScreenWidth, 48)];
    fildBackV.backgroundColor = [UIColor whiteColor];
    
    textFild = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, KScreenWidth - 40, 48)];
    textFild.placeholder = @"请输入微站名称";
    textFild.font = [UIFont systemFontOfSize:14];
    textFild.returnKeyType = UIReturnKeyDone;
    textFild.borderStyle = UITextBorderStyleNone;
    
    [self.view addSubview:fildBackV];
    [fildBackV addSubview:textFild];
    
    SaveView* saveView = [[SaveView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textFild.frame)+30, KScreenWidth, 35) tipHiden:YES block:^{
        
        [self requestUpload];
    }];
    
    [self.view addSubview:saveView];
}



@end
