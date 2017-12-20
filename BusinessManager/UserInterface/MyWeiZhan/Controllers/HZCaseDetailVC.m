//
//  HZCaseDetailVC.m
//  BusinessManager
//
//  Created by 牛志胜 on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZCaseDetailVC.h"
#import "JMView.h"
#import "WeiZhanModel.h"
#import "JMPickCollectView.h"
#import "HZCaseDetailCollectionViewCell.h"
#import "HZCaseDetailFooterCell.h"
#import "HZCaseDetailImageCell.h"
#import "TZImagePickerController.h"
#import "CLImageEditor.h"
#define ItemCount 4
#define ItemSpace 10.0
#define MaxImageCount 15
#define FooterHeight 158
#define DefaultCellHeight 355
@interface HZCaseDetailVC ()<HZCaseDetailFooterCellDelegate,HZCaseDetailCollectionViewCellDelegate,HZCaseDetailImageCellDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CLImageEditorDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *indexpath;
@end

@implementation HZCaseDetailVC

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
    
    [self initSubViews];
}
-(void)setModel:(PartModel *)model{
    _model = model;
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
            modelSec.model = model;
            modelSec.type = ModelSectionTypeNomal;
            [self.dataArray insertObject:modelSec atIndex:self.dataArray.count-1];
        }
    }];
}
- (void)initSubViews{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
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
            cell.caseNum.text = [NSString stringWithFormat:@"案例%@ :",stringNumber];
            cell.model = self.dataArray[indexPath.section];
            cell.indexPath = indexPath;
            cell.delegate = self;
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
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.itemsArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_img"]];
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
        if (model.itemsArray.count >= 17) {
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
    headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    return headerView;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section + 1 == self.dataArray.count) {
        return CGSizeMake(KScreenWidth, FooterHeight);
    }
    if (indexPath.item == 0) {
        
        return CGSizeMake(KScreenWidth - 15, DefaultCellHeight);
    }
    CGFloat itemW = (KScreenWidth - ((ItemCount + 1) * ItemSpace)) / ItemCount;
    return CGSizeMake(itemW, itemW+25);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section + 1 == self.dataArray.count) {
        return CGSizeMake(KScreenWidth, 0);
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

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    [editor dismissViewControllerAnimated:YES completion:nil];
    
    [self uploadImage:image withIndexPath:self.indexpath];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark -HZCaseDetailCollectionViewCellDelegate
- (void)caseDetailCollectionViewCell:(HZCaseDetailCollectionViewCell *)cell actionWithButton:(UIButton *)sender{
    
    NSInteger section = cell.indexPath.section;
    if (sender.tag == ChooseImageTAG) {//上传图片的按钮
        [JMPickTool showPickVCWithCallBackBlock:^(UIImage *originImage, UIImage *mediaImage) {
            
            self.indexpath=cell.indexPath;
            CLRatio *ratio = [[CLRatio alloc] initWithValue1:372 value2:250];
            ratio.isLandscape = YES;
            CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:originImage delegate:self ratio:ratio];
            CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLHueEffect" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLAdjustmentTool" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLBlurTool" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLDrawTool" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLEffectTool" recursive:YES];
            tool.available = NO;
            
            tool = [editor.toolInfo subToolInfoWithToolName:@"CLFilterTool" recursive:YES];
            tool.available = NO;
            
            [self presentViewController:editor animated:YES completion:nil];
        }];
    }
    if (sender.tag == DelegateTAG) {
        if (self.dataArray.count == 1) return;
        [self.dataArray removeObjectAtIndex:section];
        if (self.dataArray.count == 1) self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.collectionView reloadData];
    }
}

- (void)uploadImage:(UIImage*)image withIndexPath:(NSIndexPath *)indexPath{
//    NSData *imageData = UIImagePNGRepresentation(image);
//    if (imageData.length>=600*1024)
//    {
//        imageData=UIImageJPEGRepresentation(image, 1.0);
//        NSLog(@"__befor___%lu",(unsigned long)imageData.length/1024);
//        
//        if (imageData.length>=600*1024)
//        {
//            
//            imageData=UIImageJPEGRepresentation(image, 0.5);
//        }
//    }
    
    NSData* imageData=[self transformImageToDataLimited:image];
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
            if (model.model.name.length <= 0 | model.content.length <= 0 |model.model.imgPath <= 0) {
                [OMGToast showWithText:@"请完善栏目信息"];
                return;
            }
        }
    }
    PartModel* model;
    NSMutableArray *dataArray = [NSMutableArray array];
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
    if (!self.model) {
        
        model = [[PartModel alloc] init];
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"经典案例";
        model.templateModelnameCode = JingDianCase;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        model.templateModelnameDate = data;
        model.templateNo = JiaZhuang;
        data.date = dataArray.copy;

    }else{
        
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
//        CGFloat offSet = 1;
//        if (image.size.height > 150) {
//            offSet = image.size.height / 150;
//        }
//        NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(image, CGSizeMake(image.size.width/offSet,image.size.height/offSet)), 1.0);
        NSData* imageData=[self transformImageToDataLimited:image];        
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