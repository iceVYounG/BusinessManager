//
//  ADViewCell.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ADViewCell.h"
#import "UIView+UIViewController.h"
#import "BannerEditVC.h"
#import "WZ_EditActivitiesVC.h"
#import "JMButton.h"
#import "WeiZhanModel.h"


@implementation ADViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self addEditingSender];
    
}

-(void)addEditingSender{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.contentView.frame.size.height - JMViewH) * 0.5 + 16, w, JMViewH) btnNames:@[@"编辑"]];
    self.jView.tag = KADViewTag;
    [self.contentView addSubview:self.jView];
}

- (void)setAdImageWithArray:(NSMutableArray *)array{

        self.loopView.imageNames = array.copy;
        NSLog(@"imageNames====%@",self.loopView.imageNames);
}

@end




@implementation ADTitleViewCell

- (void)awakeFromNib {
    _phoneNumber.clipsToBounds = YES;
    _phoneNumber.layer.cornerRadius = 2.f;
    
    _shopName.clipsToBounds = YES;
    _shopName.layer.cornerRadius = 2.f;
    
    [self addEditingSender];
}

-(void)addEditingSender{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.frame.size.height - JMViewH) * 0.5, w, JMViewH) btnNames:@[@"编辑"]];
    self.jView.tag = KADTitleViewTag;
    [self.contentView addSubview:self.jView];

}


- (void)setModel:(TemplateModel *)model{
    _model = model;
    
    if (!_model) {
        return;
    }
    _shopName.text = model.name;
    _phoneNumber.text = model.type;
    if (model.imgPath) {
        NSString* imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath];
        
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:nil];

    }
    
}
@end

@implementation ADImageCell

- (void)awakeFromNib{
    
}

- (void)setModel:(ADImageModel *)model{
    
    _model = model;
    
    if (!model) {
        return;
    }
    BOOL isContain = NO;
    for (UIView* view in self.contentView.subviews) {
        
        if (view.tag == 998) {
            isContain = YES;
        }
    }
    if (!isContain) {
        [self creatBottomSenders:_model];
        
        if (_model.isEdit) {
            
            
            CGFloat w = [JMView getWidth:OneBtnsEdit];
            self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (KADImageCellH - JMViewH) * 0.5, w, JMViewH) btnNames:OneBtnsEdit];
            self.jView.tag = KADImageTag;
            [self addSubview:self.jView];
        }

    }
    

}

-(void)creatBottomSenders:(ADImageModel*)model{
    
    CGFloat width = KScreenWidth/4;
    CGFloat height = self.contentView.height;
    CGFloat imageW = 30;
    CGFloat titleW = 27;
    [model.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        JMButton* sender = [JMButton creatButton:CGRectMake(width*idx, 1, width, height-2)];

        sender.tag = idx + 998;
        sender.ImagePrams(model.images[idx],0).TitlePrams(model.titles[idx],13,[UIColor grayColor])
        .ImageEdgInsets((width - imageW) * 0.5,(height - imageW - titleW)*0.5,imageW,imageW)
        .TitleEdgInsets(4,(height - imageW - titleW*0.4),width - 8,imageW)
        .ClickAction(self,nil);
        [self.contentView addSubview:sender];
    }];
}

@end

@implementation ADBannerCell

- (void)awakeFromNib{
    
    
    [self addEditingSender];
}

-(void)addEditingSender{
    CGFloat w = [JMView getWidth:ThreeBtns];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (KADImageCellH - JMViewH) * 0.5, w, JMViewH) btnNames:ThreeBtns];
    self.jView.tag = KADBannerTag;
    [self.contentView addSubview:self.jView];

}

@end


#pragma mark - ADButtonCell
@implementation ADButtonCell

- (void)awakeFromNib{
    _ideaBtn.clipsToBounds = YES;
    _ideaBtn.layer.cornerRadius = 8.f;

    [self addEditingSender];
}

- (void)addEditingSender{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.frame.size.height - JMViewH) * 0.5, w, JMViewH) btnNames:@[@"编辑"]];
    self.jView.tag = KADButtonTag;
    [self.contentView addSubview:self.jView];
}
@end


@implementation PropertyCell

- (void)awakeFromNib{
    [self setUpSubView];
    [self addEditingSender];
    self.backgroundColor=[UIColor clearColor];
    
    
}


- (void)setModel:(TemplateModel *)model{
    _model = model;
    
    if (!_model) {
        return;
    }
    _nameOfShop.text = model.name;
    _nameOfPhone.text = model.type;
//    if (model.imgPath) {
//        NSString* imagePath = [NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath];
//        
//        [_bigImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"foodLopView2"]];
//        
//    }
    
}




- (void)setUpSubView{
    CGFloat width = KScreenWidth/3;
    CGFloat height = 60;
    CGFloat imageW = 30;
    CGFloat titleW = 27;
    NSArray* title = @[@"促销活动",@"预约看房",@"联系我们",@"楼盘简介",@"户型欣赏",@"为您导航"];
    NSArray* images = @[@"103",@"104",@"105",@"100",@"101",@"102"];
    [title enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        int i = idx / 3; int  j = idx % 3;
        JMButton* sender = [JMButton creatButton:CGRectMake(width*j, self.bigImage.height*0.5 - (height + 10)*(i), imageW, height)];
        sender.tag = idx + 673;
        sender.ImagePrams(images[idx],0).TitlePrams(title[idx],12,[UIColor whiteColor])
        .ImageEdgInsets((width - imageW) * 0.5,8,imageW,imageW)
        .TitleEdgInsets(4,imageW + 16,width - 8,titleW)
        .ClickAction(self,nil);
        [self.contentView addSubview:sender];
//        idx%3


    }];

    
    
      
}

- (void)addEditingSender{
    
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.frame.size.height - JMViewH) * 0.04, w, JMViewH) btnNames:@[@"编辑"]];
//    self.jView.delegate = self;
    self.jView.tag = 899;
    [self.contentView addSubview:self.jView];
    
    self.jView2 = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.frame.size.height - JMViewH) * 0.4, w, JMViewH) btnNames:@[@"编辑"]];
//    editSender.delegate = self;
    self.jView2.tag = 990;
    [self.contentView addSubview:self.jView2];
    
    
//    JMView* editSender = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.frame.size.height - JMViewH) * 0.4, w, JMViewH) btnNames:@[@"编辑"]];
//    editSender.delegate = self;
//    editSender.tag = 990;
//    [self.contentView addSubview:editSender];
    
//    CGFloat w1 = [JMView getWidth:@[@"显示活动"]];
//    JMView* bottomSender = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w1, (self.frame.size.height - JMViewH) * 0.8, w1, JMViewH) btnNames:@[@"显示活动"]];
//    bottomSender.tag = 991;
//    bottomSender.delegate = self;
//
//    [self.contentView addSubview:bottomSender];
 

}

@end

@implementation ADCollectionCell

- (void)awakeFromNib{
    
    self.backgroundColor = [UIColor whiteColor];
}


@end



@implementation FourSCell

- (void)awakeFromNib{
    [self addEditingSender];
    self.backgroundColor = [UIColor whiteColor];
}


-(void)addEditingSender{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, (self.contentView.frame.size.height - JMViewH) * 0.5 + 16, w, JMViewH) btnNames:@[@"编辑"]];
    self.jView.tag = 107;
    [self.contentView addSubview:self.jView];
}



@end

