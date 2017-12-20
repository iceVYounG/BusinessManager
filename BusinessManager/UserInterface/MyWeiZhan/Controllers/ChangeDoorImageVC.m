//
//  ChangeDoorImageVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChangeDoorImageVC.h"
#import "ChangDoorImageCell.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "JMPickCollectView.h"
#import "CLImageEditor.h"
@interface ChangeDoorImageVC ()<UITableViewDelegate,UITableViewDataSource,CLImageEditorDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL isHaveReal;
@end

@implementation ChangeDoorImageVC

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更换门头";
    self.index=-1;
    [self getTheHistoryImageResult];
    
}

-(void)setModel:(PartModel *)model{
    _model = model;
//    NSArray* keys = KeysArry;
    [_model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        TemplateModel* model = (TemplateModel*)obj;
        
//        [self.datasArry addObject:model];
        
       
    }];
    
    [self tableView];
}


#pragma mark- 保存模板

-(void)requestUpload{
    
    
    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        if (AccountInfo.isTiyan) {
            model.storeId = NoNullStr(AccountInfo.tempStoreId, @"");
        }
        else{
            model.storeId = NoNullStr(AccountInfo.storeId, @"");
        }
        model.templateModelname = @"Banner图";
        model.templateModelnameCode = @"shopBanner";
        model.id = 0;
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel *templeModel=[[TemplateModel alloc]init];
        
        WZ_FloorGooodsItemModel *itemModel=[self.datasArry objectAtIndex:self.index];
        NSLog(@"%ld---%ld--%@",self.datasArry.count,self.index,itemModel.id);
        
        templeModel.id=itemModel.id;
        data.date = @[templeModel];
        model.templateModelnameDate = data;
        model.templateNo = self.tempNo;
        
    }else{
   
        if (self.index!=-1) {
            TemplateModel *templeModel=[[TemplateModel alloc]init];
            WZ_FloorGooodsItemModel *itemModel=[self.datasArry objectAtIndex:self.index];
            templeModel.id=itemModel.id;
            self.model.templateModelnameDate.date = @[templeModel];
        }
        else {
            [self.datasArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WZ_FloorGooodsItemModel *model=(WZ_FloorGooodsItemModel *)obj;
                if ( [model.real isEqualToString:@"1"]) {
                    TemplateModel *templeModel=[[TemplateModel alloc]init];
                    WZ_FloorGooodsItemModel *itemModel=[self.datasArry objectAtIndex:idx];
                    templeModel.id=itemModel.id;
                    self.model.templateModelnameDate.date = @[templeModel];                    
                    self.isHaveReal=YES;
                }
            }];
            if (!self.isHaveReal) {
                [OMGToast showWithText:@"请选择图片后保存"];
                return;
            }
        }
        
        if (AccountInfo.isTiyan) {
            self.model.storeId = NoNullStr(AccountInfo.tempStoreId, @"");
        }
        else{
            self.model.storeId = NoNullStr(AccountInfo.storeId, @"");
        }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArry.count;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* idengfier=@"ChangDoorImageCell";
    ChangDoorImageCell *cell = [tableView dequeueReusableCellWithIdentifier:idengfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChangDoorImageCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = 0;

    if (indexPath.row<3) {
        cell.deleteBtn.hidden=YES;
    }
    else{
        cell.deleteBtn.hidden=NO;
    }
    
    cell.imageBtn.tag=indexPath.row;
    cell.deleteBtn.tag=indexPath.row;
    [cell.imageBtn addTarget:self action:@selector(selectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.model=[self.datasArry objectAtIndex:indexPath.row];
    if (self.index==indexPath.row) {
        cell.rightImage.image=[UIImage imageNamed:@"bannerBtn"];
    }
    else{
        cell.rightImage.image=[UIImage imageNamed:@"bannerBtn2"];
    }
    if (self.index==-1) {
        WZ_FloorGooodsItemModel *itemModel=[self.datasArry objectAtIndex:indexPath.row];
        if ([itemModel.real isEqualToString:@"1"]) {
            cell.rightImage.image=[UIImage imageNamed:@"bannerBtn"];
        }
    }
    
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 132.0f;
}



#pragma mark- cellBtnAction

-(void)selectImageAction:(UIButton *)sender{
    
    self.index=sender.tag;

    [self.tableView reloadData];

}


-(void)deleteImageAction:(UIButton *)sender{
    
    WZ_FloorGooodsItemModel *model=[self.datasArry objectAtIndex:sender.tag];
  
    [self deleteBannerImage:model.id andArrTag:sender.tag];
    
}




- (void)uploadImage:(NSData*)imageData{
    
    NSString* imageDataStr = [imageData base64EncodedString];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(imageDataStr, @"") forKey:@"code"];
    if (AccountInfo.isTiyan) {
        [params setObject:NoNullStr(AccountInfo.tempStoreId, @"") forKey:@"storeId"];
    }
    else{
        [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    }
    
    [params setObject:@"png" forKey:@"suffix"];
    [params setObject:NoNullStr(self.tempNo, @"") forKey:@"templateNo"];
    [params setObject:@"shopBanner" forKey:@"modelNo"];
    
    [[MallNetManager share] request:API_HistoryImageUpload prams:params succeed:^(id responseObject)   {
        ImageUpLoadBackModel* rsp = [ImageUpLoadBackModel mj_objectWithKeyValues:responseObject];
        
        NSDictionary *dataDic=[[NSDictionary alloc]init];
        dataDic=(NSDictionary *)responseObject;
        if (Succeed(rsp)) {
            WZ_FloorGooodsItemModel *itemModel=[[ WZ_FloorGooodsItemModel alloc]init];
            itemModel.imgPath=rsp.data.imgPath;
            itemModel.id=rsp.data.id;            
            [self.datasArry addObject:itemModel];
            self.index=self.datasArry.count-1;
            [self.tableView reloadData];
        }
        
        else{
            [OMGToast showWithText:@"图片上传失败，请重新上传"];
        }
        
    } showHUD:(YES)];
}


#pragma mark- deleteRequest

-(void)deleteBannerImage:(NSString *)imageId andArrTag:(NSInteger )tag{
    TemplateModelData* data = [[TemplateModelData alloc] init];
    TemplateModel *templeModel=[[TemplateModel alloc]init];
    templeModel.id=imageId;
    data.date = @[templeModel];
    NSArray *dataArr=[NSArray array];
    dataArr=@[data];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if (AccountInfo.isTiyan) {
       [params setObject:NoNullStr(AccountInfo.tempStoreId, @"") forKey:@"storeId"];
    }
    else{
        [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    }
    
    [params setObject:@0 forKey:@"id"];
    [params setObject:@"Banner图" forKey:@"templateModelname"];
    [params setObject:@"shopBanner" forKey:@"templateModelnameCode"];
    [params setObject:NoNullStr(self.tempNo, @"") forKey:@"templateNo"];
    [params setObject:[dataArr jm_ArryPrams].firstObject forKey:@"templateModelnameDate"];
    
    [[MallNetManager share] request:API_DeleteImage prams:params succeed:^(id responseObject)   {
        
        NSLog(@"删除成功！");
        [self.datasArry removeObjectAtIndex:tag];
        [self.tableView reloadData];
        [OMGToast showWithText:@"删除图片成功"];
    
    } showHUD:(YES)];
    
}


-(void)getTheHistoryImageResult{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSLog(@">>%@",AccountInfo.tempStoreId);
    
    if (AccountInfo.isTiyan) {
        [params setObject:NoNullStr(AccountInfo.tempStoreId, @"") forKey:@"storeId"];
    }
    else{
        [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    
    }
    [params setObject:NoNullStr(self.tempNo, @"") forKey:@"templateNo"];
    [params setObject:@"shopBanner" forKey:@"modelNo"];
    
    [[MallNetManager share] request:API_HistoryImageGet prams:params succeed:^(id responseObject)   {
        
        NSDictionary *dataDic=[[NSDictionary alloc]init];
        dataDic=(NSDictionary *)responseObject;
        WZ_FloorGooodsModel *model=[WZ_FloorGooodsModel mj_objectWithKeyValues:[dataDic objectForKey:@"data"]];
        
        [model.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *imageDic=[[NSDictionary alloc]init];
            imageDic=(NSDictionary *)obj;
            WZ_FloorGooodsItemModel *itemModel=[WZ_FloorGooodsItemModel mj_objectWithKeyValues:obj];
            NSLog(@">>%@",itemModel.imgPath);
             [self.datasArry addObject:itemModel];
            
        }];
        NSLog(@"%ld",self.datasArry.count);
        
            [self.tableView reloadData];
    } showHUD:(YES)];

}



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
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 240)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView* addBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, KScreenWidth, 117)];
    addBackView.backgroundColor = HexColor(@"#e8e8e8");
    
    UIImageView* imagev= [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-27)/2, 35, 27, 27)];
    imagev.image = [UIImage imageNamed:@"addImage"];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagev.frame)+8, KScreenWidth, 22)];
    label.text = @"上传门头";
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment = 1;
    label.textColor = HexColor(@"#BBBBBB");
    [addBackView addSubview:imagev];
    [addBackView addSubview:label];
    [backView addSubview:addBackView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAction)];
    [addBackView addGestureRecognizer:tap];
    
    UILabel *deatailLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width/2-150, CGRectGetMaxY(addBackView.frame)+8, 300, 20)];
    deatailLabel.text=@"*图片尺寸建议：750*234(像素)";
    deatailLabel.textAlignment=1;
    deatailLabel.textColor = HexColor(@"#f15a4a");
    deatailLabel.font=[UIFont systemFontOfSize:13];
    [backView addSubview:deatailLabel];
    SaveView* saveView = [[SaveView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(deatailLabel.frame)+20, KScreenWidth, 90) tipHiden:YES block:^{
        
        [wSelf requestUpload];
    }];
    
    [backView addSubview:saveView];
    
    return backView;
}

-(void)addAction{
    
    [self showImagePickerOrPhotoCamera:234 andHeight:750];
     WS(weakSelf);
    
    self.selectedOrTailorImage = ^(NSData *imageData) {
        [weakSelf uploadImage:imageData];
    };
    

}

-(NSMutableArray *)datasArry{
    
    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}

@end
