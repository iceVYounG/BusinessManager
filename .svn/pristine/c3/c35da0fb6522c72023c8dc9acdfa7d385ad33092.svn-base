//
//  JMPickCollectView.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/28.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 自带collecttionview的选照片类
typedef void(^SelectedImages)(NSMutableArray* photos, NSMutableArray* assets);
typedef void(^FinishBlock)(NSMutableArray* oringinArry);

@class PickPrameModel;
@interface JMPickCollectView : UICollectionView

+(JMPickCollectView *)creatWithPramModel:(PickPrameModel*)model block:(SelectedImages)selectedBlock;

@property(nonatomic,copy)SelectedImages selectedBlock;
@property(nonatomic,strong) NSMutableArray *selectedPhotos;

@end

@interface PickPrameModel : BaseModel

@property(nonatomic,assign) CGRect frame;
@property(nonatomic,assign) CGFloat margin;
@property(nonatomic,assign) NSInteger numOfRow;
@property(nonatomic,assign) NSInteger maxCount;

@end

#pragma mark - 一行代码选照片的工具类
typedef void(^SelectedImage)(UIImage* originImage, UIImage* mediaImage);

@interface JMPickTool : NSObject

+ (void)showPickVCMaxImageCount:(NSInteger)count CallBackBlock:(SelectedImages)block; //可选多张

+ (void)showPickVCWithCallBackBlock:(SelectedImage)block;//只能一张

@property(nonatomic,copy)SelectedImages selectedBlock;
@property(nonatomic,copy)SelectedImage selectBlock;

@end


