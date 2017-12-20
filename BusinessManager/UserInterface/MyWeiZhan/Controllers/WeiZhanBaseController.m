//
//  WeiZhanBaseController.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
#import "WeiZhanModel.h"
#import "MyWeiZhanVC.h"
#import "HomeController.h"

//最大照片体积限制 1 M
#define BM_MaxImageDataLimited (1024 * 1024)
//允许相片选择的最大数量 15张
#define BM_MaxImagePickerCount 15

@interface WeiZhanBaseController ()<UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, STPhotoKitDelegate, CLImageEditorDelegate>

@end

@implementation WeiZhanBaseController {
    CGFloat tailorImageWidth;
    CGFloat tailorImageHeight;
    
    /*是否是图片多选*/
    BOOL isMutilPicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isMutilPicker = NO;
    // Do any additional setup after loading the view.
}

-(void)saveTemplte:(NSMutableArray*)datas succeed:(void (^)(id responseObject))succeed error:(void (^)(NSError* error))errored{

    [SVProgressHUD showWithStatus:@"数据处理中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [[MallNetManager share] request:API_TemplateSave parameters:[datas jm_ArryPrams] success:^(NSURLSessionDataTask *task, id responseObject) {
         [SVProgressHUD dismiss];
        
        if (Succeed(responseObject)) {
            if (succeed) {
                succeed(responseObject);
                NSLog(@"保存成功");
            }
        }else{
         
          [OMGToast showWithText:responseObject[@"msg"]];
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        if (errored) {
             errored(error);
        }
    }];
}

-(void)saveTemple:(NSString*)templeNo andshopName:(NSString *)shopName{

    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [prams setObject:NoNullStr(templeNo, @"") forKey:@"templateNo"];
    [prams setObject:NoNullStr(shopName, @"") forKey:@"shopName"];
    
    [[MallNetManager share] request:API_storeTemplateSave prams:prams succeed:^(id responseObject) {
        
        [OMGToast showWithText:@"模板保存成功"];
        BOOL isfindVc =NO;
        for (UIViewController* vc in self.navigationController.viewControllers) {
           
            if ([vc isKindOfClass:[MyWeiZhanVC class]]) {
                isfindVc= YES;
                MyWeiZhanVC* wzVC = (MyWeiZhanVC*)vc;
                
                if (wzVC.refreshBlock) {
                    wzVC.refreshBlock();
                }
                [self.navigationController popToViewController:wzVC animated:YES];
            }
        }
        if (!isfindVc) {
            MyWeiZhanVC* wzVC = [[MyWeiZhanVC alloc]init];
            [self.navigationController pushViewController:wzVC animated:YES];
        }
    } showHUD:YES];


}

BOOL isHongBaoVC;
NSString *tempNo;
-(void)quickRegister:(NSString *)linkePhone smsCode:(NSString *)smscode store:(NSString *)storeName withHongBao:(BOOL)isHongBao withTempNo:(NSString *)str{
    isHongBaoVC=isHongBao;
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:NoNullStr(storeName, @"") forKey:@"storeName"];
    [prams setObject:NoNullStr(linkePhone, @"") forKey:@"linkPhone"];
    [prams setObject:NoNullStr(smscode, @"") forKey:@"smsCode"];
    tempNo=str;
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    WS(weakSelf)
    [[MallNetManager share]request:API_fastRegister parameters:prams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        
        NSString *code = [dic objectForKey:@"code"];
        NSString *msg = [dic objectForKey:@"msg"];
        
        if ([code isEqualToString:@"00-00"]) {
            [SVProgressHUD dismiss];
            NSDictionary *data = [dic objectForKey:@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                
               int storeFlag = [[data objectForKey:@"storeFlag"] intValue];
                weakSelf.targetStoreId = [data objectForKey:@"storeId"];
                AccountInfo.storeId=weakSelf.targetStoreId;
                AccountInfo.linkPhone=[data objectForKey:@"linkPhone"];
                AccountInfo.storeName=[data objectForKey:@"storeName"];
          
                //已存在商户
                if (storeFlag ==0) {
                    UIAlertView *alter = [ [UIAlertView alloc] initWithTitle:@"" message:@"登录后，原有该模板的信息会更新为现有配置的内容，是否登录？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    [alter show];
                }else{
                    if (isHongBao) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"HongBaoVC" object:@(1)];
                    }
                    else{
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"MainVC" object:@(1)];
                    }
 
                }
     
            }
            
            
        }else{
            
            [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
            
        }
        
        
        NSLog(@"%@",dic);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    
}


-(void)requestGetSeqno{
    
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:self.requestDate requestWithPath:API_getSeqno Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        
        NSString *code = [dic objectForKey:@"code"];
        NSString *msg = [dic objectForKey:@"msg"];
        if ([code isEqualToString:@"00-00"]) {
             [SVProgressHUD dismiss];
            NSDictionary *data = [dic objectForKey:@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                NSString *seqno = [data objectForKey:@"seqno"];
                AccountInfo.tempStoreId=seqno;
//                self.tempStoreId = seqno;
                
            }else{
                [SVProgressHUD dismiss];
                
            }
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
            
        }
        
        
        NSLog(@"%@",dic);
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
    }];
}


-(void)updateStoreInforRequest:(NSString *)sourceId targetId:(NSString *)targetId withTempNo:(NSString *)str withHongBao:(BOOL)ishongBao{
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    [prams setObject:NoNullStr(sourceId, @"") forKey:@"sourceId"];
    [prams setObject:NoNullStr(targetId, @"") forKey:@"targetId"];
    [prams setObject:NoNullStr(tempNo, @"") forKey:@"templateNo"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showWithStatus:@"数据请求中..."];
    [[MallNetManager share]request:API_updateStoreInfo  parameters:prams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        
        NSString *code = [dic objectForKey:@"code"];
        NSString *msg = [dic objectForKey:@"msg"];
        
        if ([code isEqualToString:@"00-00"]) {
            [SVProgressHUD dismiss];
            AccountInfo.isLogin=YES;
            AccountInfo.isTiyan=NO;
            if (!ishongBao) {
                NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [vcs removeAllObjects];
                HomeController* homeVC = [[HomeController alloc]init];

                [vcs addObject:homeVC];
                
                MyWeiZhanVC *weizhan  = [[MyWeiZhanVC alloc]init];
                
                [vcs addObject:weizhan];
                
                self.navigationController.viewControllers = vcs;
            }else{
                NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                if (vcs.count>0) {
                    [vcs removeObjectAtIndex:0];
                }
                
                MyWeiZhanVC *weizhan  = [[MyWeiZhanVC alloc]init];
                
                [vcs insertObject:weizhan atIndex:0];
                
                HomeController* homeVC = [[HomeController alloc]init];
                
                [vcs insertObject:homeVC atIndex:0];
                
                self.navigationController.viewControllers = vcs;
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
            
        }
        
        
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];

    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (isHongBaoVC) {
       [[NSNotificationCenter defaultCenter]postNotificationName:@"HongBaoVC" object:@(buttonIndex)];
    }
    else{

     [[NSNotificationCenter defaultCenter]postNotificationName:@"MainVC" object:@(buttonIndex)];
    }   
    
}

/**
 * @ 最大图片体积限制
 * @ param image: 要裁剪的图片
 * @ return: 图片
 */

- (UIImage *)getMaxImageDataLimitedWithImage:(UIImage *)image {
    CGFloat compression = 0.5f;
    CGFloat maxCompression = 0.3f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while (imageData.length > BM_MaxImageDataLimited && compression > maxCompression) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressImage = [[UIImage alloc] initWithData:imageData];
    return compressImage;
}

/**
 * @ 最大图片体积限制 UIImage --> NSData
 * @ param image: 要裁剪的图片
 * @ return: 图片Data
 */
- (NSData *)transformImageToDataLimited:(UIImage *)image {
    CGFloat compression = 0.5f;
    CGFloat maxCompression = 0.3f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while (imageData.length > BM_MaxImageDataLimited && compression > maxCompression) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

/**
 * @ 最大图片体积限制 NSData --> NSData
 * @ param imageData: 要裁剪的图片data
 * @ return: 图片data;
 */
- (NSData *)getMaxImageDataLimitedWithData:(NSData *)imageData {
    CGFloat compression = 0.5f;
    CGFloat maxCompression = 0.3f;
    UIImage *image = [UIImage imageWithData:imageData];
    while (imageData.length > BM_MaxImageDataLimited && compression > maxCompression) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

#pragma mark - 弹出actionSheet 拍照，相册(单选) 具有剪裁功能

/**
 * @ param imageWidth: 剪裁图片-宽度
 * @ param imageHeight: 剪裁图片-高度
 */

- (void)showImagePickerOrPhotoCamera:(CGFloat)imageWidth andHeight:(CGFloat)imageHeight {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取", nil];
    tailorImageWidth = imageWidth;
    tailorImageHeight = imageHeight;
    //不具有相片多选功能
    isMutilPicker = NO;
    [sheet showInView:self.navigationController.view];
    
}

#pragma mark - actionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        switch (buttonIndex){
                
            case 0:{
                sourceType = UIImagePickerControllerSourceTypeCamera;
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = sourceType;
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
                
                break;
            case 1:{
                //多选
                if (isMutilPicker) {
                    WS(weakSelf);
                    [JMPickTool showPickVCMaxImageCount:BM_MaxImagePickerCount CallBackBlock:^(NSMutableArray *photos, NSMutableArray *assets) {
                        
                        if (weakSelf.selectedMutilImagesBlock) {
                            weakSelf.selectedMutilImagesBlock(photos);
                        }
                    }];
                //单选
                }else {
                    [self showImagePickerViewToSelectedImageAndTailor:tailorImageWidth andHeight:tailorImageHeight];
                }
            }
                
                break;
                
            default:

                break;
        }
    }
}

#pragma mark - inagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *compressImage = [self getMaxImageDataLimitedWithImage:photoImg];
    WS(weakSelf);
    //多选，无剪裁
    if (isMutilPicker) {
        NSArray *imageArr = [NSArray arrayWithObject:compressImage];
        if (weakSelf.selectedMutilImagesBlock) {
            weakSelf.selectedMutilImagesBlock(imageArr.copy);
        }
    //单选，剪裁
    }else {
        CLRatio *ratio = [[CLRatio alloc] initWithValue1:tailorImageHeight value2:tailorImageWidth];
        ratio.isLandscape = YES;
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:compressImage delegate:self ratio:ratio];
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        NSLog(@"%@", editor.toolInfo);
        NSLog(@"%@", editor.toolInfo.toolTreeDescription);
        
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
    }
    
}

#pragma mark - 调起 图片剪裁 工具

- (void)showImagePickerViewToSelectedImageAndTailor:(CGFloat)imageWidth andHeight:(CGFloat)imageHeight {
    WS(weakSelf);
    [JMPickTool showPickVCWithCallBackBlock:^(UIImage *originImage, UIImage *mediaImage) {
        
        CLRatio *ratio = [[CLRatio alloc] initWithValue1:imageHeight value2:imageWidth];
        ratio.isLandscape = YES;
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:originImage delegate:weakSelf ratio:ratio];
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        NSLog(@"%@", editor.toolInfo);
        NSLog(@"%@", editor.toolInfo.toolTreeDescription);
        
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
        
        [weakSelf presentViewController:editor animated:YES completion:nil];
        
    }];

}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    WS(weakSelf)
    if (image) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [weakSelf transformImageToDataLimited:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.selectedOrTailorImage) {
                    weakSelf.selectedOrTailorImage(imageData);
                }
            });
            
        });
        
        if (weakSelf.selectedOrBannerImage) {
            UIImage *compressImage = [weakSelf getMaxImageDataLimitedWithImage:image];
            weakSelf.selectedOrBannerImage(compressImage);
        }
        
    }
    
    [editor dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}


#pragma mark - 弹出actionSheet 拍照，相册(多选) 没有剪裁功能 (可以使用下面的代码剪裁)

/**
 * @ param imageWidth: 剪裁图片-宽度
 * @ param imageHeight: 剪裁图片-高度
 */

- (void)showCameraOrMutilPhotoPicker:(SelectedMutilImagesBlock)block {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取", nil];
    self.selectedMutilImagesBlock = block;
    isMutilPicker = YES;
    [sheet showInView:self.navigationController.view];
    
}


#pragma mark - 代码剪裁图片（无UI界面）
/**
 * @ centerBool 截取部分图像是否是中心截取
 * @ cutCGRect 需裁剪的尺寸
 **/
-(UIImage*)getSubImage:(UIImage *)image cutCGRect:(CGRect)cutCGRect centerBool:(BOOL)centerBool {
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = cutCGRect.size.width;
    float viewheight = cutCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

#pragma mark - 代码剪裁图片（无UI界面）
/**
 * @ 宽高 1 : 1 剪裁图片（根据图片的尺寸来，高 > 宽 取宽做尺寸，反之...）
 * @ centerBool 是否中心裁剪 是:从中心剪裁  否:从(0，0)原点剪裁
 *
 */
-(UIImage*)getSubImage:(UIImage *)image centerBool:(BOOL)centerBool {
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth;
    float viewheight;
    if (imgheight > imgwidth) {
        viewheight = imgwidth;
        viewwidth = imgwidth;
    }else if (imgheight < imgwidth) {
        viewheight = imgheight;
        viewwidth = imgheight;
    }else {
        viewheight = imgheight;
        viewwidth = imgwidth;
    }
    
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


#pragma mark - 代码剪裁图片（无UI界面）
/**
 * @ centerBool 是否中心裁剪 是:从中心剪裁  否:从(0，0)原点剪裁
 * @cutRatio 剪裁的宽高比
 */
-(UIImage*)getSubImage:(UIImage *)image cutRatio:(CGFloat)cutRatio centerBool:(BOOL)centerBool {
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth;
    float viewheight;
    if (imgheight > imgwidth) {
        viewheight = imgwidth * cutRatio;
        viewwidth = imgwidth;
    }else if (imgheight < imgwidth) {
        viewheight = imgheight;
        viewwidth = imgheight * cutRatio;
    }else {
        viewheight = imgheight * cutRatio;
        viewwidth = imgwidth;
    }
    
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
