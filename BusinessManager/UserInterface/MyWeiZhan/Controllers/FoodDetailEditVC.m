//
//  FoodDetailEditVC.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "FoodDetailEditVC.h"
#import "ADCollectionViewCell.h"
#import "JMPickCollectView.h"
#import "WeiZhanModel.h"
#import "UIButton+WebCache.h"
@interface FoodDetailEditVC () <UICollectionViewDataSource,UICollectionViewDelegate,ImageSenderDelegate>
{
    NSString* _imagePath;
    BOOL _isNew;
   
}
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIButton *saveSender;
@property (nonatomic, strong) NSMutableArray* datasArray;
@property (nonatomic, strong) NSMutableArray *originImages;
@property (nonatomic, strong) NSMutableArray* tempArr;

@property (nonatomic, strong) NSMutableArray* indexPathsArr;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSMutableArray *lastArr;
@property (nonatomic, assign) NSInteger collectionNum;
@end

@implementation FoodDetailEditVC

- (instancetype)initWithBlock:(FoodMenuBlock)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSubView];
    
}

- (void)setUpSubView{

    self.title = @"菜单详情编辑";
    [self.view addSubview:self.saveSender];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ADCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ADCollectionViewCell"];

    
    if (self.model) {
        _isNew = NO;
        [self.collectionView reloadData];
    }else{
        _isNew = YES;
    }
}

#pragma mark - colloctionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tempArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify = @"ADCollectionViewCell";

    ADCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.index=indexPath.row;

    if (indexPath.row == self.tempArr.count-1) {
        [cell.imageSender setImage:[UIImage imageNamed:@"uploadImage"] forState:UIControlStateNormal];
        cell.deleteSender.hidden = YES;
        cell.model = nil;
        cell.imageSender.userInteractionEnabled = YES;
    }else{
        cell.deleteSender.hidden = NO;
        TemplateModel *temModel=self.tempArr[indexPath.row];
        cell.model = temModel;
        
        cell.imageSender.userInteractionEnabled = NO;
    }
    if (indexPath.row==0) {
        [self.indexPathsArr removeAllObjects];
    }
    self.currentIndexPath = indexPath;
    if (self.indexPathsArr.count == 0) {
        [self.indexPathsArr addObject:indexPath];
    }else{
        
        if ([self.indexPathsArr containsObject:indexPath]) {
        
        }else{
            [self.indexPathsArr addObject:indexPath];
        }
    }
    
    cell.deleteSender.tag = indexPath.row;
    cell.tag = indexPath.row + 80;
    cell.delegate = self;

    return cell;
}

#pragma mark - collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KCollectionCellW, KCollectionCellH);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(12, 16, 12, 16);
}
#pragma mark - imageSenderDelegate

-(void)textFieldChange:(NSString *)nameStr andPrice:(NSString *)priceStr andIndex:(NSInteger)index{
    TemplateModel* model;
    if (index<self.tempArr.count) {
        model=[self.tempArr objectAtIndex:index];
        model.name=nameStr;
        model.type=priceStr;

        
    }
    else{
        model=[[TemplateModel alloc]init];
        model.name=nameStr;
        model.type=priceStr;
        [self.tempArr addObject:model];
        
    }
    
    
}

- (void)jump2ImagePickerVCsender:(UIButton *)sender{
    NSIndexPath *index=[NSIndexPath indexPathForItem:self.currentIndexPath.row-1 inSection:0];
    ADCollectionViewCell* cell=(ADCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:index];
    
    NSLog(@"%@--%@",cell.nameField.text,cell.priceField.text);
    
    if ([cell.nameField.text isEqualToString:@""]||[cell.priceField.text isEqualToString:@""]) {
        [OMGToast showWithText:@"请输入完整信息"];
        return;
    }
    
    
    [self showImagePickerOrPhotoCamera:0 andHeight:0];
    WS(weakSelf);
    
    self.selectedOrTailorImage = ^(NSData *imageData) {
        [weakSelf uploadMessage:imageData andIndex:cell.index];
    };
//    
//    [JMPickTool showPickVCWithCallBackBlock:^(UIImage *originImage, UIImage *mediaImage) {
//        if (mediaImage) {
//            [self uploadMessage:mediaImage andIndex:cell.index];
//            [self.originImages addObject:mediaImage];
//            [self.datasArray addObject:mediaImage];
//        }
//        else{
//            [self uploadMessage:originImage andIndex:cell.index];
//            [self.originImages addObject:originImage];
//            [self.datasArray addObject:originImage];
//        
//        }
//        
//    }];
}

- (void)deleteImageCell:(UIButton *)sender{
  
    [self.originImages removeObjectAtIndex:sender.tag];
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
//        [self.indexPathsArr removeObjectAtIndex:indexPath.row];
        [self.tempArr removeObjectAtIndex:indexPath.row];
        self.collectionNum=self.tempArr.count;
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}

//判断输入钱的正则表达式，可输入正负，小数点前5位，小数点后2位，位数可控
- (BOOL)checkNum:(NSString *)str
{
    NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,4}(([.]\\d{0,2})?)))?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    BOOL isMatch = [phoneTest evaluateWithObject:str];
    if (!isMatch) {
        [OMGToast showWithText:@"请输入正确的金额"];
        return NO;
    }
    return YES;
}

- (void)saveAction:(UIButton *)sender{
    PartModel* model=[[PartModel alloc]init];
    model.storeId = NoNullStr(AccountInfo.storeId, @"");
    model.templateModelname = @"菜单";
    model.templateModelnameCode = FoodMenu;
    model.templateNo = CanYin;
    if (self.indexPathsArr.count==1) {
        ADCollectionViewCell* cell = (ADCollectionViewCell*)[self.collectionView viewWithTag:0 + 80];
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel* temp = [[TemplateModel alloc] init];
        temp.name = cell.nameField.text;
        temp.type = cell.priceField.text;
        data.date = @[temp];
        model.templateModelnameDate = data;
        [OMGToast showWithText:@"请编辑后保存"];
        return;
        
    }else{
        NSMutableArray *modelArr=[NSMutableArray array];
        for (int i=0; i<self.indexPathsArr.count-1; i++) {
        NSIndexPath *index=self.indexPathsArr[i];
        ADCollectionViewCell* cell = (ADCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:index];
        if ([cell.priceField.text isEqualToString:@""] || [cell.nameField.text isEqualToString:@""]) {
            [OMGToast showWithText:@"请输入完整信息"];
            return;
        }
        if (cell.nameField.text.length>10) {
            [OMGToast showWithText:@"菜名输入过长，请重新输入"];
            return;

            }
        if (cell.priceField.text.length>10) {
            [OMGToast showWithText:@"价格输入过长，请重新输入"];
            return;
            }
            
            BOOL isRightMoney=[self checkNum:cell.priceField.text];
            if (!isRightMoney) {
                return;
            }
            else{
            TemplateModel* item = [[TemplateModel alloc]init];
            item=self.tempArr[i];
            item.name = cell.nameField.text;
            item.type = cell.priceField.text;
            [modelArr addObject:item];
            
        }                    
            if (self.model) {
                
                self.model.templateModelnameDate.date = modelArr.copy;
                model = self.model;
            }
            else{
                
                TemplateModelData* data = [[TemplateModelData alloc] init];
                TemplateModel* temp = [[TemplateModel alloc] init];
                temp.name = cell.nameField.text;
                temp.type = cell.priceField.text;
                data.date = @[temp];
                model.templateModelnameDate = data;
                
            }
        }
    }
    NSLog(@"%@",model);
    
    NSArray* arr = @[model];

    __weak typeof(self) wSelf = self;
    
    [[MallNetManager share] request:API_TemplateSave parameters:[arr jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success == %@",responseObject);
        
        if (Succeed(responseObject)) {
            
            SearPartData* rsp = [SearPartData mj_objectWithKeyValues:responseObject];
            if (rsp) {
                
                
            }
            
            wSelf.block(model,_isNew);
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [OMGToast showWithText:responseObject[@"msg"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [OMGToast showWithText:@"服务器忙，请稍后再试！"];
    }];

}

#pragma mark - upload message

- (void)uploadMessage:(NSData*)imageData andIndex:(NSInteger)index {
    NSString* imageDataStr = [imageData base64EncodedString];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(imageDataStr, @"") forKey:@"code"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:@"png" forKey:@"suffix"];
    
    [[MallNetManager share] request:API_ImageUpload prams:params succeed:^(id responseObject)   {
        
        ImageUpLoadBackModel* rsp = [ImageUpLoadBackModel mj_objectWithKeyValues:responseObject];
        
        if (Succeed(rsp)) {
            TemplateModel* model;
            if (self.collectionNum==self.tempArr.count) {
                model=[self.tempArr objectAtIndex:self.tempArr.count-1];
                model.imgPath = rsp.data.imgPath;
                TemplateModel* model2=[[TemplateModel alloc]init];
                [self.tempArr addObject:model2];
                
            }
            else{
                model=[self.tempArr objectAtIndex:self.tempArr.count-1];
                model.imgPath = rsp.data.imgPath;
            
            }
            self.collectionNum=self.tempArr.count;            
            [self.collectionView  reloadData];
            NSLog(@">>>%ld",self.tempArr.count);
            
        }
        
    } showHUD:(YES)];
}

@synthesize collectionView  = _collectionView,datasArray = _datasArray,originImages = _originImages,saveSender = _saveSender,indexPathsArr = _indexPathsArr;

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(KCollectionCellW, KCollectionCellH);
        flowLayout.minimumLineSpacing = 16.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavigationH - 55) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)datasArray{
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (void)setModel:(PartModel *)model{
    _model=model;
    if (model) {
    [self.tempArr removeAllObjects];
    [self.tempArr addObjectsFromArray: model.templateModelnameDate.date.mutableCopy];
    TemplateModel *temMolde=[[TemplateModel alloc]init];
    [self.tempArr addObject:temMolde];
    }
    else{
        TemplateModel *temMolde=[[TemplateModel alloc]init];
        [self.tempArr addObject:temMolde];
    }
    self.collectionNum=self.tempArr.count;
}

- (NSMutableArray *)originImages{
    
    if (_originImages) {
        _originImages = [NSMutableArray array];
    }
    return _originImages;
}

- (UIButton *)saveSender{
    if (!_saveSender) {
        _saveSender = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveSender.frame = CGRectMake(15, KScreenHeight - 55 - NavigationH, KScreenWidth - 15 * 2, 40);
        [_saveSender setTitle:@"保存" forState:UIControlStateNormal];
        [_saveSender addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [_saveSender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveSender.backgroundColor = [UIColor blueColor];
        _saveSender.clipsToBounds = YES;
        _saveSender.layer.cornerRadius = 5.f;
        
    }
    return _saveSender;
}
- (NSMutableArray *)indexPathsArr{
    
    if (!_indexPathsArr) {
        _indexPathsArr = [NSMutableArray array];
    }
    return _indexPathsArr;
}

- (NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr=[NSMutableArray array];
    }
    return _tempArr;
}

- (NSMutableArray *)lastArr{
    if (!_lastArr) {
        _lastArr=[NSMutableArray array];
    }
    return _lastArr;
}


@end
