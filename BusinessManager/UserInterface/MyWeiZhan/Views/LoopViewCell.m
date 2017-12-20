//
//  LoopViewCell.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoopViewCell.h"

@implementation LoopViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _textView.layer.borderWidth = .5f;
    
}
- (void)setModel:(TemplateModelData *)model{
    _model = model;
    if (!_model) {
        return;
    }
    
    [_imageSender.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    
    
    
}
- (void)setPhotos:(NSMutableArray *)photos{
    [self createPickerView:photos];

}
- (void)createPickerView:(NSMutableArray *)photos{
    PickPrameModel* model = [[PickPrameModel alloc] init];
    
    model.frame = CGRectMake(0, 200, KScreenWidth, 100);
    model.numOfRow = 4;
    model.margin = 4;
    model.maxCount = 9;
    _pickCollectionView = [JMPickCollectView creatWithPramModel:model block:^(NSMutableArray *photos, NSMutableArray *assets) {
        
        if (photos.count > 3) {
            self.pickCollectionView.frame = CGRectMake(0, 200, KScreenWidth, (photos.count/4 + 1)*100);
            [self.pickCollectionView reloadData];
            
            if (self.delegate) {
                [self.delegate updateTableViewWithPhotos:(NSMutableArray* )photos indexPath:self.indexPath JMPickCollectView:_pickCollectionView];
            }

        }
    }];

    _pickCollectionView.alwaysBounceVertical = NO;
    [self addSubview:_pickCollectionView];
}

//- (void)upLoadImage:(NSMutableArray*)phones{
//    __block NSInteger requestIndex = 0;
//    
//    [SVProgressHUD showWithStatus:@"照片上传中..."];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    
//    [self.photos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(obj, CGSizeMake(720, 144)), 1.0);
//        NSMutableDictionary* params = [NSMutableDictionary dictionary];
//        [params setObject:[imageData base64EncodedString] forKey:@"code"];
//        [params setObject:AccountInfo.storeId forKey:@"storeId"];
//        [params setObject:@"png" forKey:@"suffix"];
//        
//        [[MallNetManager share] request:API_ImageUpload parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            if (Succeed(responseObject)) {
//                
//                if ([responseObject objectForKey:@"data"]) {
//                    NSDictionary* data = [responseObject objectForKey:@"data"];
//                    
//                    if ([data objectForKey:@"imgPath"]) {
//                        
//                        [self.imagePaths addObject:[data objectForKey:@"imgPath"]];
//                    }
//                }
//            }
//            requestIndex++;
//            [self judgeFinish:requestIndex];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//            requestIndex++;
//            [self judgeFinish:requestIndex];
//        }];
//    }];
//    
//    
//}
//
//-(void)judgeFinish:(NSInteger)index{
//    
//    if (index == self.photos.count) {
//        [SVProgressHUD dismiss];
////        _isImageUpload = YES;
//        NSMutableArray* tempArr = [NSMutableArray array];
////        [tempArr addObjectsFromArray:self.selectedPhotos];
//        [tempArr addObjectsFromArray:self.imagePaths];
//        self.pickCollectionView.selectedPhotos = tempArr;
//    }
//}
- (IBAction)deleteAction:(UIButton *)sender {
    
    if (self.delegate) {
        [self.delegate deleteImageCell:sender cell:self];
    }
}


- (IBAction)selectPhotoAction:(UIButton *)sender {
    
    [JMPickTool showPickVCWithCallBackBlock:^(UIImage *originImage, UIImage *mediaImage) {
        if (mediaImage) {
           [self.imageSender setImage:mediaImage forState:UIControlStateNormal];
        }
        else{
            [self.imageSender setImage:originImage forState:UIControlStateNormal];
        }
      
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
