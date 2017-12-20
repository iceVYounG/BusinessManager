//
//  EditShopProfileVC.m
//  BusinessManager
//
//  Created by zhaojh on 16/8/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EditShopProfileVC.h"
#import "UIPlaceHolderTextView.h"
#import "JMPickCollectView.h"
#import "JMView.h"
#import "WeiZhanModel.h"


#define BottomH 68

@interface EditShopProfileVC ()
{
    BOOL _isImageUpload;
}
@property(nonatomic,strong) UIPlaceHolderTextView* textView;
@property(nonatomic,strong)NSMutableArray* selectImages;
@property(nonatomic,strong)NSMutableArray* imagePaths;
@property(nonatomic,strong)JMPickCollectView* collectionView;
@property(nonatomic,strong)NSMutableArray* lastImageArr;
@end

@implementation EditShopProfileVC

-(instancetype)initWithBlock:(CallBacked)block{

    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户介绍编辑";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _lastImageArr=[NSMutableArray array];
    [self UI];
}

-(void)UI{

    //textView
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth - 30, 222)];
    _textView.placeholder = @"请输入您店铺的详细地址,原景,详细服务等,以便消费者更加了解你的店铺,如果没有图片,可不上传";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(3, 2, 0, 2);
    _textView.text = NoNullStr([(TemplateModel*)_model.templateModelnameDate.date.lastObject content],@"");
    
    [self.view addSubview:_textView];
    
    //collectionView
    PickPrameModel* model = [[PickPrameModel alloc] init];
    CGFloat y = CGRectGetMaxY(_textView.frame) + 10;
    model.frame = CGRectMake(10, y, KScreenWidth - 20, KScreenHeight  - y - BottomH - NavigationH);
    model.numOfRow = 4;
    model.margin = 4;
    model.maxCount = 9;
    _collectionView = [JMPickCollectView creatWithPramModel:model block:^(NSMutableArray *photos, NSMutableArray *assets) {
        
        if (!_selectImages) {_selectImages = [NSMutableArray array];}
         self.selectImages = photos;
        
        [self upLoadImages];
    }];
    
    if (self.model) {
        NSMutableArray* tempArr = [NSMutableArray array];
        TemplateModel* datas = [self.model.templateModelnameDate.date lastObject];
        [datas.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ImagePathModel* model = (ImagePathModel*)obj;
            
            [tempArr addObject:model.imagePath];
        }];
        _collectionView.selectedPhotos = tempArr;
        self.lastImageArr=tempArr;
    }
    [self.view addSubview:_collectionView];
    
    //save View
    SaveView* save = [[SaveView alloc]initWithFrame:CGRectMake(0, KScreenHeight - NavigationH - BottomH, KScreenWidth, BottomH) tipHiden:YES block:^{
        
        [self requestUpload];
    }];
    [self.view addSubview:save];
}
#pragma mark - 点击保存
-(void)requestUpload{
    
    if (self.selectImages.count > 0 && !_isImageUpload) {
        
        return;
    }
    
    [self upLoadContent];
    
}

-(void)upLoadContent{

    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = @"店铺简介";
        model.templateModelnameCode = ShopDetail;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel* item = [[TemplateModel alloc]init];
        item.content = self.textView.text;
        
        item.images = [self getImagePaths];
        data.date = @[item];
        model.templateModelnameDate = data;
        model.templateNo = Tongyong;
        
    }else{
        
        TemplateModel* item = [[TemplateModel alloc]init];
        item.content = self.textView.text;
        item.images = [self getImagePaths];
        self.model.templateModelnameDate.date =  @[item];
        model = self.model;
    }
    
    NSArray* arr = @[model];
    
    __weak typeof(self) wSelf = self;
    [self saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
       
        wSelf.block(model,self.model?NO:YES);
        [wSelf.navigationController popViewControllerAnimated:YES];
        
        [self performSelector:@selector(delyAction) withObject:nil afterDelay:.3];
        
    } error:^(NSError *error) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }];

}
-(void)delyAction{
  [SVProgressHUD setMinimumDismissTimeInterval:1.0];
  [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
}

-(NSMutableArray* )getImagePaths{

    NSMutableArray* tempArr = [NSMutableArray array];
    [self.collectionView.selectedPhotos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ImagePathModel* model = [[ImagePathModel alloc]init];
        NSString* imageStr;
        if ([(NSString*)obj contains:ImagePre]) {
            imageStr = [(NSString*)obj substringFromIndex:ImagePre.length];
        }
        model.imagePath = imageStr;
        [tempArr addObject:model];
    }];
    

    
    return tempArr;
}

-(void)upLoadImages{
    self.lastImageArr=_collectionView.selectedPhotos;
    
    [self.imagePaths removeAllObjects];
    __block NSInteger requestIndex = 0;

    [SVProgressHUD showWithStatus:@"照片上传中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [self.selectImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage* image = (UIImage*)obj;
//        
//        CGFloat offSet = 1;
//        if (image.size.height > 750) {
//            offSet = image.size.height / 750;
//        }
//  
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
                        
                        [self.imagePaths addObject:[data objectForKey:@"imgPath"]];
                        
                    }
                }
            }
            NSLog(@"%ld",self.imagePaths.count);
            
            requestIndex++;
            [self judgeFinish:requestIndex];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            requestIndex++;
            [self judgeFinish:requestIndex];
        }];
    }];
}

-(void)judgeFinish:(NSInteger)index{
    
    if (index == self.selectImages.count) {
        [SVProgressHUD dismiss];
        _isImageUpload = YES;
        NSMutableArray* tempArr = [NSMutableArray array];
//        [tempArr addObjectsFromArray:_collectionView.selectedPhotos];
        [tempArr addObjectsFromArray:self.lastImageArr];
        [tempArr addObjectsFromArray:self.imagePaths];
        _collectionView.selectedPhotos = tempArr;

    }
}


-(NSMutableArray *)imagePaths{

    if (!_imagePaths) {
        _imagePaths = [NSMutableArray array];
    }
    return _imagePaths;
}

@end
