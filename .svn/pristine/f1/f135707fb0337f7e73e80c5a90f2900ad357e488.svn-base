//
//  HZCaseDetailCell.m
//  BusinessManager
//
//  Created by niuzs on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "HZCaseDetailCell.h"
#import "UIButton+WebCache.h"
#import "MJExtension.h"
#import "JMPickCollectView.h"
#define GAP 15
@implementation HZCaseDetailCell

- (void)awakeFromNib {

    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_iconNameTextF.frame) +15 , KScreenWidth - 20, 121)];
    _textView.placeholder = @"输入文字介绍 , 如果没有图片可不上传图片";
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textContainerInset = UIEdgeInsetsMake(3, 2, 0, 2);
    
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1;
    [self.contentView addSubview:_textView];
        
    //collectionView
    PickPrameModel* model = [[PickPrameModel alloc] init];
    
    CGFloat y = CGRectGetMaxY(_textView.frame) + 10;
    model.frame = CGRectMake(10, y, KScreenWidth - 20, 115);
    model.numOfRow = 4;
    model.margin = 4;
    model.maxCount = 9;
    _collectionView = [JMPickCollectView creatWithPramModel:model block:^(NSMutableArray *photos, NSMutableArray *assets) {
        if (!_selectImages) {
            _selectImages = [NSMutableArray array];
        }
        self.selectImages = photos;
        [self upLoadImages];
    }];
    [self.contentView addSubview:_collectionView];
    
}
-(void)upLoadImages{
    
    __block NSInteger requestIndex = 0;
    
    [SVProgressHUD showWithStatus:@"照片上传中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [self.selectImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage* image = (UIImage*)obj;
        
        CGFloat offSet = 1;
        if (image.size.height > 750) {
            offSet = image.size.height / 750;
        }
        
        NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(image, CGSizeMake(image.size.width/offSet,image.size.height/offSet)), 1.0);
        
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        [params setObject:[imageData base64EncodedString] forKey:@"code"];
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
        [tempArr addObjectsFromArray:_collectionView.selectedPhotos];
        [tempArr addObjectsFromArray:self.lastImageArr];
        [tempArr addObjectsFromArray:self.imagePaths];
        _collectionView.selectedPhotos = tempArr;
        
    }
}

- (void)setModel:(TemplateModel *)model{
    _model = model;
    if (self.model) {
    [self.iconImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"uploadImage"]];
        self.iconNameTextF.text = model.name;
        _textView.text = model.content;
    
        NSMutableArray* tempArr = [NSMutableArray array];
        TemplateModel* model = self.model;//[self.model.templateModelnameDate.date lastObject];
        [model.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ImagePathModel* model = (ImagePathModel*)obj;
            
            [tempArr addObject:model.imagePath];
        }];
        _collectionView.selectedPhotos = tempArr;
        self.lastImageArr=tempArr;
    }
    [self.collectionView reloadData];
}



@end

























@implementation HZCaseBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = 15;
        CGFloat imageW = (KScreenWidth - 5 * margin)/4;
        CGFloat imageH = imageW + 25;

        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_addBtn setTitleEdgeInsets:UIEdgeInsetsMake(-25, 0, 0, 0)];
        [_addBtn setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];
        [_addBtn setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
        _addBtn.backgroundColor = [UIColor redColor];
        [_addBtn setTitle:@"上传图片" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _addBtn.frame = CGRectMake(15, 15, 75, 100);
        
        [self addSubview:_addBtn];
        
        for (int i = 0; i < 15 ; i++) {
            int row=i/4;
            int loc=i%4;
            CGFloat appviewx=margin+(margin+imageW)*loc;
            CGFloat appviewy=margin+(margin+imageH)*row;
            
            _iconView = [[HZCaseDetailImageView alloc]initWithFrame:CGRectMake(appviewx, appviewy , imageW , imageH)];
            _iconView.tag = 1000 + i;
            _iconView.hidden = YES;
            [self addSubview:_iconView];
        }

    }
    
    return self;
}
- (void)setModel:(TemplateModel *)model{
    _model = model;
    
    for (HZCaseDetailImageView *iconV in self.subviews) {
        iconV.hidden = YES;
    }
    
    [model.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = (NSString *)obj;
        HZCaseDetailImageView *iconV = [self viewWithTag:1000 +idx];
        iconV.hidden = NO;
        
        [iconV.attachment sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,obj]] forState:UIControlStateNormal];
        
    }];
    
}

@end


@implementation HZCaseDetailImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.attachment = [UIButton buttonWithType:UIButtonTypeCustom];
        self.attachment.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height - 30);
        [self.attachment setTitleEdgeInsets:UIEdgeInsetsMake(-25, 0, 0, 0)];
        self.attachment.backgroundColor = [UIColor redColor];
        [self addSubview:self.attachment];
        
        self.deleteSender = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteSender.frame = CGRectMake(CGRectGetWidth(self.frame)-15, 0, 15, 15);
        [self.deleteSender setBackgroundImage:[UIImage imageNamed:@"VipCardManager_CancelImage"] forState:UIControlStateNormal];
        [self addSubview:self.deleteSender];
    }
    return self;
}

@end
