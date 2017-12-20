//
//  WZ_TextPhotoVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_TextPhotoVC.h"
#import "UIPlaceHolderTextView.h"
#import "JMPickCollectView.h"
#import "JMView.h"
#import "WeiZhanModel.h"

@interface WZ_TextPhotoVC ()<UITextViewDelegate>
{
 BOOL _isImageUpload;

}
@property(nonatomic,strong) UIPlaceHolderTextView* textView;
@property(nonatomic,strong)NSMutableArray* selectImages;
@property(nonatomic,strong)NSMutableArray* imagePaths;
@property(nonatomic,strong)JMPickCollectView* collectionView;
@property(nonatomic,strong)NSMutableArray* lastImageArr;
@property (nonatomic, strong) UILabel* placeholderLabel;
@property (nonatomic, strong) UIButton* saveSender;
@end

@implementation WZ_TextPhotoVC

- (instancetype)initWithBlock:(WZTextBlock)block{
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];

}



-(void)UI{
    
    TemplateModel* templateModel = [self.model.templateModelnameDate.date lastObject];
    
    NSString *content = templateModel.content;
    NSArray *contenArr = [content componentsSeparatedByString:@"<"];
    templateModel.content = [contenArr firstObject];
    NSMutableArray *contentArray = [NSMutableArray arrayWithArray:contenArr];
    if (contenArr.count!=0) {
        [contentArray removeObjectAtIndex:0];
    }
    
    if (templateModel.content.length > 0) {
        self.placeholderLabel.hidden = YES;
        
        self.textView.text=templateModel.content;
        
    }
    
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    
    CGFloat height = HeightForString(self.placeholder, 14.f, KScreenWidth - 20);
    self.placeholderLabel.frame = CGRectMake(10, 5, KScreenWidth - 20, height + 5);
    [self.textView addSubview:self.placeholderLabel];
    
    self.placeholderLabel.text = self.placeholder;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
    [self.view addSubview:self.saveSender];
    
    
    //collectionView
    PickPrameModel* model = [[PickPrameModel alloc] init];
    
    model.frame = CGRectMake(0, 200, KScreenWidth, KScreenHeight - 200 - NavigationH - 55);
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
        
        [contentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *string = (NSString *)obj;
            //过滤里面的非法字符串
            NSString *urlString = [NSString filterIllegalString:string];
            [tempArr addObject:urlString];
        }];
        _collectionView.selectedPhotos = tempArr;
        self.lastImageArr=tempArr;
    }
    [self.view addSubview:_collectionView];
    
}
#pragma mark - 点击保存
-(void)requestUpload{
    
    if (self.selectImages.count > 0 && !_isImageUpload) {
        
        return;
    }
    
    [self upLoadMessage];
    
}


#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView{
    
    self.placeholderLabel.hidden = YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
        // 默认的return（确认）会换行，返回 NO 则不会换行
    }
    
    return YES;
}
#pragma mark - 观察textView内容的变化
- (void)textViewDidChange{
    
    self.placeholderLabel.hidden = self.textView.text.length == 0 ? NO : YES;
}
#pragma mark - 点击空白，收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)even{
    [self.textView resignFirstResponder];
}


-(void)upLoadMessage{
    
    
    NSMutableArray *htmlStrings = [self getImagePaths];
    __block  NSString *content = _textView.text;
    [htmlStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *htmlString = (NSString *)obj;
        content = [content stringByAppendingString:htmlString];
    }];

    if (content.length==0) {
        [OMGToast showWithText:@"请编辑后保存"];
        return;
    }
    
    PartModel* model;
    if (!self.model) {
        model = [[PartModel alloc] init];
        
        model.storeId = NoNullStr(AccountInfo.storeId, @"");
        model.templateModelname = self.tempName;
        model.templateModelnameCode = _nameCode;
        model.id = self.model.id;
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        TemplateModel* item = [[TemplateModel alloc]init];
        item.content = content;
        item.id=@"";
        data.date = @[item];
        
        //<img src="/storeimg/367661/1962/622/N/p_3676611962622.jpg" alt="" />
//        item.images = [self getImagePaths];// 这里的imagPath需添加在content里面
        model.templateModelnameDate = data;
        model.templateNo = self.Modelname;
        
    }else{
        
        TemplateModel* item = self.model.templateModelnameDate.date.lastObject;
        item.content = content;
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

//-(NSMutableArray* )getImagePaths{
//    
//    NSMutableArray* tempArr = [NSMutableArray array];
//    [self.collectionView.selectedPhotos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        ImagePathModel* model = [[ImagePathModel alloc]init];
//        NSString* imageStr;
//        if ([(NSString*)obj contains:ImagePre]) {
//            imageStr = [(NSString*)obj substringFromIndex:ImagePre.length];
//        }
//        [tempArr addObject:imageStr];
//        
////        model.imagePath = imageStr;
////        [tempArr addObject:model];
//    }];
//    
//    
//    return tempArr;
//}



-(NSMutableArray* )getImagePaths{
    
    NSMutableArray* tempArr = [NSMutableArray array];
    [self.collectionView.selectedPhotos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* htmlString;
        if ([(NSString*)obj contains:ImagePre]) {
            NSString *imageStr = [(NSString*)obj substringFromIndex:ImagePre.length];
            htmlString = [NSString stringWithFormat:@"<img src=\"/storeimg/%@\" alt=\"\" />",imageStr];
            [tempArr addObject:htmlString];
        }
    }];
    return tempArr;
}





-(void)upLoadImages{
    
    __block NSInteger requestIndex = 0;
    [self.imagePaths removeAllObjects];
    self.lastImageArr=_collectionView.selectedPhotos;
    [SVProgressHUD showWithStatus:@"照片上传中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [self.selectImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage* image = (UIImage*)obj;
        
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





@synthesize collectionView = _collectionView,placeholderLabel = _placeholderLabel,saveSender = _saveSender,imagePaths = _imagePaths;

- (UIButton *)saveSender{
    if (!_saveSender) {
        _saveSender = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveSender.frame = CGRectMake(15, KScreenHeight - 55 - NavigationH, KScreenWidth - 15 * 2, 40);
        [_saveSender setTitle:@"保存" forState:UIControlStateNormal];
        
        [_saveSender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveSender.backgroundColor = [UIColor blueColor];
        _saveSender.clipsToBounds = YES;
        _saveSender.layer.cornerRadius = 5.f;
        [_saveSender addTarget:self action:@selector(upLoadMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveSender;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, KScreenWidth - 20, 20)];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = [UIFont systemFontOfSize:14.f];
        _placeholderLabel.textColor = [UIColor grayColor];
    }
    return _placeholderLabel;
}


-(NSMutableArray *)imagePaths{
    
    if (!_imagePaths) {
        _imagePaths = [NSMutableArray array];
    }
    return _imagePaths;
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
