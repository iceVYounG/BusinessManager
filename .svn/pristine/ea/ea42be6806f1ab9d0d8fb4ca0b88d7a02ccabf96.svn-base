//
//  JMPickCollectView.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "JMPickCollectView.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import "UIView+UIViewController.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "SDPhotoBrowser.h"

//照片最大体积限制
#define BM_MaxImageDataLimited_MutilPick (1000 * 1000)

@interface JMPickCollectView () <TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SDPhotoBrowserDelegate>
{
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    LxGridViewFlowLayout* myLayout;
    NSInteger _maxImageCount;
    CGFloat ItemW;
    CGFloat Margin;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end
@implementation JMPickCollectView

+(JMPickCollectView *)creatWithPramModel:(PickPrameModel*)model block:(SelectedImages)selectedBlock{
   
    return [[self alloc] initWithFrame:CGRectZero model:model block:selectedBlock];
}

-(instancetype)initWithFrame:(CGRect)frame model:(PickPrameModel*)model block:(SelectedImages)selectedBlock{

    LxGridViewFlowLayout* layout = [[LxGridViewFlowLayout alloc] init];
    ItemW = (model.frame.size.width - (model.numOfRow + 1) * model.margin) / model.numOfRow;
    Margin = model.margin;
    layout.itemSize = CGSizeMake(ItemW, ItemW+20);
    layout.minimumLineSpacing = Margin;
    layout.minimumInteritemSpacing = 0;

    if (self = [super initWithFrame:model.frame collectionViewLayout:layout]) {
        _selectedBlock = selectedBlock;
        myLayout = layout;
        _maxImageCount = model.maxCount;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return self;
}

- (void)setSelectedPhotos:(NSMutableArray *)selectedPhotos{
    
    if ([selectedPhotos.lastObject isKindOfClass:[NSString class]]) {
        
        NSMutableArray* tempArr = [NSMutableArray array];
        
        [selectedPhotos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* imagePath = (NSString*)obj;
            if (![imagePath containsString:ImagePre]) {
                imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,obj];
            }
             [tempArr addObject:imagePath];
        }];
        
        _selectedPhotos = tempArr;
    }else{
        
        _selectedPhotos = selectedPhotos;
    }
 
    [self reloadData];
}
#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxImageCount delegate:self];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.如果你需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];        
        cell.titleLabel.hidden=NO;
        cell.titleLabel.text=@"点击上传图片";
        cell.deleteBtn.hidden = YES;
    } else {
        if ([_selectedPhotos[indexPath.row] isKindOfClass:[NSString class]]) {
          
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_selectedPhotos[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_img"]];
        }else{
            cell.imageView.image = _selectedPhotos[indexPath.row];
        }
        cell.imageView.tag = indexPath.item;
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
        cell.titleLabel.hidden=YES;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _selectedPhotos.count) {
        
        [self pushImagePickerController];
        
    }
    else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self.viewController presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
//            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
//            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
//            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
//                _selectedAssets = [NSMutableArray arrayWithArray:assets];
//                _isSelectOriginalPhoto = isSelectOriginalPhoto;
//                myLayout.itemCount = _selectedPhotos.count;
//                [self reloadData];
//                self.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (Margin + ItemW));
//            }];
//            [self.viewController presentViewController:imagePickerVc animated:YES completion:nil];
            TZTestCell* cell = (TZTestCell*)[collectionView cellForItemAtIndexPath:indexPath];
            UIView *imageView = cell.imageView;
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.sourceImagesContainerView = self; // 原图的父控件
            browser.imageCount = self.selectedPhotos.count; // 图片总数
            browser.currentImageIndex = imageView.tag;
            browser.delegate = self;
            if ([self.selectedPhotos.lastObject isKindOfClass:[NSString class]]) {
                browser.type = 1;
            }else{
                browser.type = 0;
            }
            [browser show];
        }
    }
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{

    return [self.selectedPhotos objectAtIndex:index];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser imageURLForIndex:(NSInteger)index{

    return [self.selectedPhotos objectAtIndex:index];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{

    return [UIImage imageNamed:@"106"];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(Margin, Margin, Margin, Margin);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return myLayout.itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [self reloadData];
    }
}

#pragma mark - TZImagePickerController delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
//    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
//    _selectedAssets = [NSMutableArray arrayWithArray:assets];

//    _isSelectOriginalPhoto = isSelectOriginalPhoto;
//    myLayout.itemCount = _selectedPhotos.count;
//    [self reloadData];
    
    __weak typeof(self) weakSelf = self;
    
    if(assets == nil){
        weakSelf.selectedBlock(photos.mutableCopy,nil);

    }else{
        [JMPickCollectView transformAssetsArry:assets.mutableCopy finishBlock:^(NSMutableArray *oringinArry) {
            
            weakSelf.selectedBlock(photos.mutableCopy,oringinArry);
        }];
    }
   
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
//    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
//    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
//    myLayout.itemCount = _selectedPhotos.count;
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
//    [self reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}



#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    myLayout.itemCount = _selectedPhotos.count;
    
    [self performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self reloadData];
    }];
}

@synthesize imagePickerVc = _imagePickerVc;

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.viewController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.viewController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

+(void)transformAssetsArry:(NSMutableArray*)assets finishBlock:(FinishBlock)block{
  
    NSMutableArray* oringinArr = [NSMutableArray array];
    
    [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [[TZImageManager manager] getOriginalPhotoWithAsset:obj completion:^(UIImage *photo, NSDictionary *info) {
            [oringinArr addObject:photo];
            if (oringinArr.count == assets.count) {
              
                block(oringinArr);
            }
        }];
    }];
}



@end
@implementation PickPrameModel @end

@interface JMPickTool ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)UIViewController* currectVC;

@end

@implementation JMPickTool

+ (void)showPickVCMaxImageCount:(NSInteger)count CallBackBlock:(SelectedImages)block{
    static JMPickTool *tool = nil;
    if (tool == nil) {
        tool = [[self alloc]init];
    }
    tool.currectVC = [BaseService getCurrectController];
    tool.selectBlock = nil;
    tool.selectedBlock = block;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];

    __weak typeof(tool) weakSelf = tool;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (assets == nil) {
            NSMutableArray *arr = [NSMutableArray array];
            for (UIImage *image in photos) {
                UIImage *compressImage = [weakSelf BM_GetMaxImageDataLimitedWithImage:image];
                [arr addObject:compressImage];
            }
            weakSelf.selectedBlock(photos.mutableCopy,nil);

        }else{
//            NSMutableArray *assetsArr = [NSMutableArray array];
//            for (UIImage *image in assets) {
//                UIImage *compressImage = [weakSelf BM_GetMaxImageDataLimitedWithImage:image];
//                [assetsArr addObject:compressImage];
//            }
            [JMPickCollectView transformAssetsArry:assets.mutableCopy finishBlock:^(NSMutableArray *oringinArry) {
                NSMutableArray *oringArr = [NSMutableArray array];
                for (UIImage *image in oringinArry) {
                    UIImage *compressImage = [weakSelf BM_GetMaxImageDataLimitedWithImage:image];
                    [oringArr addObject:compressImage];
                }
                NSMutableArray *arr = [NSMutableArray array];
                for (UIImage *image in photos) {
                    UIImage *compressImage = [weakSelf BM_GetMaxImageDataLimitedWithImage:image];
                    [arr addObject:compressImage];
                }
                
                weakSelf.selectedBlock(arr.mutableCopy,oringArr);
            }];
        }
       

    }];
    
    [tool.currectVC.parentViewController presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - 系统自带 只能一张
+ (void)showPickVCWithCallBackBlock:(SelectedImage)block{
    static JMPickTool *tool = nil;
    if (tool == nil) {
        tool = [[self alloc]init];
    }
    tool.currectVC = [BaseService getCurrectController];
    tool.selectedBlock = nil;
    tool.selectBlock = block;
    [tool showPickVC];
}

-(void)showPickVC{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    WS(weakSelf)
    imagePickerController.delegate = weakSelf;
    imagePickerController.allowsEditing = NO;
    //    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePickerController.sourceType = sourceType;
    
    [self.currectVC presentViewController:imagePickerController animated:YES completion:nil];
    
}
#pragma mark - image picker delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WS(weakSelf);
    [self.currectVC dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = info[UIImagePickerControllerOriginalImage];
        UIImage *mediaImage = info[UIImagePickerControllerEditedImage];
        
        if (weakSelf.selectBlock) {
            
            weakSelf.selectBlock(originImage,mediaImage);
        }
    }];
 
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.currectVC dismissViewControllerAnimated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [navigationController.navigationBar setTitleTextAttributes:self.currectVC.navigationController.navigationBar.titleTextAttributes];
    [navigationController.navigationBar setBarTintColor:self.currectVC.navigationController.navigationBar.barTintColor];
    navigationController.navigationBar.translucent = IOS7;
}
            

/**
 * @ 最大图片体积限制
 * @ param image: 要裁剪的图片
 * @ return: 图片
 */

- (UIImage *)BM_GetMaxImageDataLimitedWithImage:(UIImage *)image {
    CGFloat compression = 0.5f;
    CGFloat maxCompression = 0.3f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while (imageData.length > BM_MaxImageDataLimited_MutilPick && compression > maxCompression) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressImage = [[UIImage alloc] initWithData:imageData];
    return compressImage;
}

- (void)dealloc{
    
}


@end


