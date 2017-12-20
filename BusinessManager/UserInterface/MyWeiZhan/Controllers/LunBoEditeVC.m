//
//  LunBoEditeVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/9/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "LunBoEditeVC.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "JMPickCollectView.h"
#import "HZCaseDetailCollectionViewCell.h"
#import "HZCaseDetailFooterCell.h"
#import "HZCaseDetailImageCell.h"
#import "TZImagePickerController.h"
#define ItemCount 4
#define ItemSpace 10.0
#define MaxImageCount 15
#define FooterHeight 158
#define DefaultCellHeight 370
@interface LunBoEditeVC ()<HZCaseDetailFooterCellDelegate,HZCaseDetailCollectionViewCellDelegate,HZCaseDetailImageCellDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    UITextField *_textFild;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *indexPath;
//@property (nonatomic, strong) UITextField *textFild;
@property (nonatomic, strong) NSString *textString;
@end

@implementation LunBoEditeVC

-(instancetype)initWithBlock:(CallBack)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮播图编辑";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textFild=[[UITextField alloc]init];
    _textFild.frame=CGRectMake(10, 10, 250, 35);
    _textFild.delegate=self;
    _textFild.placeholder=@"请输入轮播栏目名称";
    _textFild.borderStyle=UITextBorderStyleLine;
    _textFild.text=self.textString;
    [self initSubViews];
}
-(void)setModel:(PartModel *)model{
    _model = model;
    self.textString=model.templateModelname;
    NSArray* keys = KeysArry;
    [_model.templateModelnameDate.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TemplateModel* model = (TemplateModel*)obj;
        if (![keys containsObject:model.code]) {
            
            ModelSection *modelSec = [[ModelSection alloc]init];
            if (![model.content isEqualToString:@""]||model.content) {
                NSArray *stringArray = [NSString filterTheImageUrlArrFromFatherString:model.content];
                //截取字符串
                modelSec.content = [[model.content componentsSeparatedByString:@"<"] firstObject];
                [stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *string = (NSString *)obj;
                    [modelSec.itemsArray insertObject:[NSString stringWithFormat:@"%@%@",ImagePre,string] atIndex:modelSec.itemsArray.count -1];
                }];
            }
            modelSec.model=model;
            modelSec.type = ModelSectionTypeNomal;
            [self.dataArray insertObject:modelSec atIndex:self.dataArray.count-1];
        }
    }];
}- (void)initSubViews{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-NavigationH) collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    if (self.dataArray.count <= 1) {
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    _collectionView.bounces = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HZCaseDetailCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:HZCaseDetailCollectionViewCellID];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HZCaseDetailFooterCell class]) bundle:nil] forCellWithReuseIdentifier:HZCaseDetailFooterCellID];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HZCaseDetailImageCell class]) bundle:nil] forCellWithReuseIdentifier:HZCaseDetailImageCellID];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];

    [self.view addSubview:_collectionView];
    
}
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [self.dataArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section + 1 == [self.dataArray count]) {
        return 1;
    }
    ModelSection *model = self.dataArray[section];
    return [model.itemsArray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ModelSection *model = self.dataArray[indexPath.section];
    if (model.type == ModelSectionTypeNomal) {
        if (indexPath.item == 0) {
            HZCaseDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HZCaseDetailCollectionViewCellID forIndexPath:indexPath];
            NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
            formater.numberStyle = kCFNumberFormatterRoundHalfDown;
            NSString *stringNumber = [formater stringFromNumber:[NSNumber numberWithInteger:indexPath.section + 1]];
            cell.caseNum.text = [NSString stringWithFormat:@"轮播%@ :",stringNumber];
            cell.isNewTemple=self.isNewTemple;
            cell.model = self.dataArray[indexPath.section];
            cell.indexPath = indexPath;
            cell.delegate = self;
            cell.iconNameTextF.hidden=YES;
            cell.sizeLabel.text=@"*图片尺寸建议:750*278(像素）";
            return cell;
        }
        
        HZCaseDetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HZCaseDetailImageCellID forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.delegate =self;
        if (indexPath.item + 1 == model.itemsArray.count) {
            cell.imageView.image = [UIImage imageNamed:@"jiahao"];
            cell.deleteImgBtn.hidden = YES;
            cell.labelBottom.hidden = NO;
        }
        else{
            
            if ([model.itemsArray[indexPath.row] isKindOfClass:[NSString class]]) {
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.itemsArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"106"]];
            }
            else{
                cell.imageView.image = model.itemsArray[indexPath.row];
            }
            cell.deleteImgBtn.hidden = NO;
            cell.labelBottom.hidden = YES;
            
        }
        return cell;
    }
    else{
        
        HZCaseDetailFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HZCaseDetailFooterCellID forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ModelSection *model = self.dataArray[indexPath.section];
    
    if (model.type == ModelSectionTypeFooter) {
        return;
    }
    if (model.type == ModelSectionTypeNomal){
        if (model.itemsArray.count == 17) {
            [OMGToast showWithText:@"最多只能15张"];
            return;
        }
        if (indexPath.item + 1  == [model.itemsArray count]) {
            
            [JMPickTool showPickVCMaxImageCount:MaxImageCount CallBackBlock:^(NSMutableArray *photos, NSMutableArray *assets) {
                [SVProgressHUD showWithStatus:@"照片上传中..."];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [self upLoadPhotos:photos withSectionModel:model];
            }];
            
            
        }
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView=nil;
   
    
    
    
    if (self.isNewTemple&&indexPath.section==0) {
         headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];

        [headerView addSubview:_textFild];

    }else {
//        [_textFild removeFromSuperview];
        headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
        
        
        
    }
    return headerView;

}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section + 1 == self.dataArray.count) {
        return CGSizeMake(KScreenWidth, FooterHeight);
    }
    if (indexPath.item == 0) {
        return CGSizeMake(KScreenWidth, DefaultCellHeight);
    }
    CGFloat itemW = (KScreenWidth - ((ItemCount + 1) * ItemSpace)) / ItemCount;
    
    return CGSizeMake(itemW, itemW + 25);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section + 1 == self.dataArray.count) {
        return CGSizeMake(KScreenWidth, 0);
    }
    if (self.isNewTemple&&section==0) {
        return CGSizeMake(KScreenWidth, 55);
    }
    return CGSizeMake(KScreenWidth, 15);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section + 1 == self.dataArray.count) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(ItemSpace, ItemSpace, ItemSpace, ItemSpace);
}

#pragma mark --HZcaseDetailImageCellDelegate
- (void)caseDetailImageCell:(HZCaseDetailImageCell *)cell buttonAction:(UIButton *)sender;{
    if (self.dataArray.count <= 1) {
        return;
    }
    ModelSection *model = self.dataArray [cell.indexPath.section];
    if (cell.indexPath.item == model.itemsArray.count) {
        return;
    }
    [model.itemsArray removeObjectAtIndex:cell.indexPath.item];
    
    [self.collectionView reloadData];
}



#pragma mark HZCaseDetailFooterCellDelegate
- (void)footerCellDidClickNewBtn
{
    if (self.dataArray.count < 1) {
        return;
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    NSInteger count = [self.dataArray count];
    if (count == 9) {
        [OMGToast showWithText:@"最多添加8个"];
        return;
    }
    
    ModelSection *newModel = [[ModelSection alloc]init];
    newModel.type = ModelSectionTypeNomal;
    TemplateModel *newTem = [[TemplateModel alloc]init];
    newTem.type = @"1";
    newTem.key = @"";
    newTem.value = @"";
    newModel.model = newTem;
    [self.dataArray insertObject:newModel atIndex:count-1];
    [self.collectionView reloadData];
    
}
- (void)footerCellDidClickSaveBtn{
    
    [self requestUpload];
}


#pragma mark- UITextField delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{

    

}



#pragma mark -HZCaseDetailCollectionViewCellDelegate
- (void)caseDetailCollectionViewCell:(HZCaseDetailCollectionViewCell *)cell actionWithButton:(UIButton *)sender{
    
    NSInteger section = cell.indexPath.section;
    if (sender.tag == ChooseImageTAG) {//上传图片的按钮
//        [JMPickTool showPickVCWithCallBackBlock:^(UIImage *originImage, UIImage *mediaImage) {
        
//            STPhotoKitController *photoVC = [STPhotoKitController new];
//            [photoVC setDelegate:self];
//            if (originImage) {
//                [photoVC setImageOriginal:originImage];
//            }
//            else{
//                [photoVC setImageOriginal:mediaImage];
//            }
//            self.indexPath=cell.indexPath;
//            CGFloat width=372/750.f*KScreenWidth;
//            [photoVC setSizeClip:CGSizeMake(width, width*250/372.f)];
//            [self presentViewController:photoVC animated:YES completion:nil];
     
//        }];
        self.indexPath=cell.indexPath;
        [self showImagePickerOrPhotoCamera:750 andHeight:278];
        WS(weakSelf);
        self.selectedOrTailorImage = ^(NSData *imageData) {
            [weakSelf uploadImage:imageData withIndexPath:weakSelf.indexPath];
        };

        
    }
    if (sender.tag == DelegateTAG) {
        if (self.dataArray.count == 1) return;
        [self.dataArray removeObjectAtIndex:section];
        if (self.dataArray.count == 1) self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.collectionView reloadData];
    }
}

- (void)uploadImage:(NSData*)imageData withIndexPath:(NSIndexPath *)indexPath{
    // 上传图片
//    CGFloat offSet = 1;
//    if (image.size.height > 372) {
//        offSet = image.size.height / 372;
//    }
    
//    NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(image, CGSizeMake(image.size.width/offSet,image.size.height/offSet)), 1.0);
    
//    NSData* imageData = UIImagePNGRepresentation(image);
//    if (imageData.length>=600*1024)
//    {
//        imageData=UIImageJPEGRepresentation(image, 1.0);
//        NSLog(@"__befor___%lu",(unsigned long)imageData.length/1024);
//        
//        if (imageData.length>=600*1024)
//        {
//            
//            imageData=UIImageJPEGRepresentation(image, 0.99);
//        }
//    }

    NSString* imageDataStr = [imageData base64EncodedString];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(imageDataStr, @"") forKey:@"code"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:@"png" forKey:@"suffix"];
    [[MallNetManager share] request:API_ImageUpload prams:params succeed:^(id responseObject)   {
        
        ImageUpLoadBackModel* rsp = [ImageUpLoadBackModel mj_objectWithKeyValues:responseObject];
        if (Succeed(rsp)) {
            
            [OMGToast showWithText:@"图片上传成功"];
            ModelSection *model = self.dataArray[indexPath.section];
            model.model.imgPath = rsp.data.imgPath;
            [self.collectionView reloadData];
        }
        else{
            [OMGToast showWithText:@"图片上传失败，请重新上传"];
        }
        
    } showHUD:(YES)];
}
-(void)requestUpload{
    
    for (ModelSection* model in self.dataArray.copy) {
        if (model.type == ModelSectionTypeNomal) {
            NSLog(@"%@",model.model.content);
           
            if (self.isNewTemple) {
                
                if (model.model.content.length == 0) {
                    [OMGToast showWithText:@"请完善栏目信息"];
                    return;
                }
                
            }
            else{
                if (model.content.length == 0) {
                    [OMGToast showWithText:@"请完善栏目信息"];
                    return;
                }
            }
            if (model.model.imgPath.length==0) {
                [OMGToast showWithText:@"请上传图片"];
                return;
            }
            if (self.isNewTemple) {
                if (_textFild.text.length==0) {
                    [OMGToast showWithText:@"请输入轮播栏目名称"];
                    return;
                }                
            }
            
            if (_textFild.text.length>20) {
                [OMGToast showWithText:@"标题不能超过20个字"];
                return;
            }
        }
    }
     PartModel* model;
    NSMutableArray *dataArray = [NSMutableArray array];
    if (self.isNewTemple) {
        for (ModelSection *model in self.dataArray.copy) {
            if (model.type == ModelSectionTypeNomal) {
                TemplateModel *templateModel = model.model;
                if (model.itemsArray.count <=2 ) {
                    templateModel.content = model.model.content;
                }
                __block NSString *contentString = model.model.content;
                contentString=[NSString getZZwithString:contentString];
                __block NSString*contString= [contentString replace:@"\n" withString:@"<br>"];
                
                [model.itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSString class]]) {
                        
                        if ([(NSString*)obj contains:ImagePre]) {
                            NSString *imageStr = [(NSString*)obj substringFromIndex:ImagePre.length];
                            
                            NSString *htmlString = [NSString stringWithFormat:@"<img src=\"/storeimg/%@\" alt=\"\" />",imageStr];
                            
                            contString = [contString stringByAppendingString:htmlString];
                        }
                    }
                }];
                
                templateModel.content = contString;
                [dataArray addObject:templateModel];
            }
            
        }
    }
    else{
        for (ModelSection *model in self.dataArray.copy) {
            if (model.type == ModelSectionTypeNomal) {
                TemplateModel *templateModel = model.model;
                if (model.itemsArray.count <=2 ) {
                    templateModel.content = model.content;
                }
                
                __block NSString *contentString = model.content;
                [model.itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSString class]]) {
                        
                        if ([(NSString*)obj contains:ImagePre]) {
                            NSString *imageStr = [(NSString*)obj substringFromIndex:ImagePre.length];
                            
                            NSString *htmlString = [NSString stringWithFormat:@"<img src=\"/storeimg/%@\" alt=\"\" />",imageStr];
                            
                            contentString = [contentString stringByAppendingString:htmlString];
                        }
                    }
                }];
                templateModel.content = contentString;
                [dataArray addObject:templateModel];
            }
            
        }
    }
       if (!self.model) {
        model = [[PartModel alloc] init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        if (self.isNewTemple) {
          model.templateModelname = _textFild.text;
        }
        else{
         model.templateModelname = self.modelName;
        }
        model.templateModelnameCode = self.modelCode;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        model.templateModelnameDate = data;
        model.templateNo = self.modelNo;
        data.date = dataArray.copy;
        
    }else{
        if (self.isNewTemple) {
             self.model.templateModelname = _textFild.text;
        }
        
        if (AccountInfo.isTiyan) {
            self.model.storeId= NoNullStr(AccountInfo.tempStoreId, @"");
        }
        else{
            self.model.storeId=NoNullStr(AccountInfo.storeId, @"");
        }
       

        self.model.templateModelnameDate.date = dataArray.copy;
        
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

-(void)upLoadPhotos:(NSMutableArray *)photos withSectionModel:(ModelSection *)model{
    
    if (model.type == ModelSectionTypeFooter) {
        return;
    }
    __block NSInteger requestIndex = 0;
    [photos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImage* image = (UIImage*)obj;
        NSData* imageData= [self transformImageToDataLimited:image];
//        
//        CGFloat offSet = 1;
//        if (image.size.height > 150) {
//            offSet = image.size.height / 150;
//        }
//        NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(image, CGSizeMake(image.size.width/offSet,image.size.height/offSet)), 1.0);
        
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        [params setObject:NoNullStr([imageData base64EncodedString], @"") forKey:@"code"];
        [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
        [params setObject:@"png" forKey:@"suffix"];
        [[MallNetManager share] request:API_ImageUpload parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (Succeed(responseObject)) {
                
                if ([responseObject objectForKey:@"data"]) {
                    
                    NSDictionary* data = [responseObject objectForKey:@"data"];
                    if ([data objectForKey:@"imgPath"]) {
                        
                        [model.itemsArray insertObject:[NSString stringWithFormat:@"%@%@",ImagePre,[data objectForKey:@"imgPath"]] atIndex:model.itemsArray.count -1];
                    }
                }
            }
            requestIndex++;
            [self judgeFinish:requestIndex fromePhotos:photos];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            requestIndex++;
            [self judgeFinish:requestIndex fromePhotos:photos];
        }];
    }];
}
-(void)judgeFinish:(NSInteger)index fromePhotos:(NSArray *)photos{
    
    if (index == photos.count) {
        [SVProgressHUD dismiss];
        [OMGToast showWithText:@"上传成功"];
        [self.collectionView reloadData];
    }
}

//-(UITextField *)textFild{
//    if (!_textFild) {
//        _textFild=[[UITextField alloc]init];
//        _textFild.frame=CGRectMake(10, 10, 250, 35);
//        _textFild.delegate=self;
//        _textFild.placeholder=@"请输入轮播栏目名称";
//        _textFild.borderStyle=UITextBorderStyleLine;
//        
//    }
//
//    return _textFild;
//}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
        ModelSection *footerModel = [[ModelSection alloc] init];
        footerModel.type = ModelSectionTypeFooter;
        [_dataArray addObject:footerModel];
    }
    return _dataArray;
}
@end
