//
//  GenealWeiZhanCell.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "GenealWeiZhanCell.h"
#import "UIView+UIViewController.h"
#import "JMPickCollectView.h"
#import "WeiZhanModel.h"
#import "WeiZhanBaseController.h"

@implementation GenealWeiZhanCell
#pragma mark - BaseCell
- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = 0;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
         self.selectionStyle = 0;
        
    }
    return self;
}
-(void)setCellType:(JMCellType)cellType{
    _cellType = cellType;
    
}


@end

#pragma mark - 微站名称cell

@implementation EditingTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = HexColor(@"#3a90ff");
    
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc]initWithFrame:CGRectMake(KScreenWidth - w, (kEditingTitleCellH - JMViewH)/2, w, JMViewH) btnNames:@[@"编辑"]];
    
    [self.contentView addSubview:self.jView];
}


@end

#pragma mark - 微站简介cell
@implementation DetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}
-(void)addEditingSender{
    if (self.jView) {
        return;
    }
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc]initWithFrame:CGRectMake(KScreenWidth - w, 5, w, JMViewH) btnNames:@[@"编辑"]];
    
    [self.contentView addSubview: self.jView];
}

-(void)setModel:(TemplateModel *)model{
    _model = model;

    self.titleLabel.text = model.key;
    self.detailLabel.text = model.value;
}
- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath;
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height - .5)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - .5)];
    [[UIColor groupTableViewBackgroundColor] setStroke];
    [bezierPath setLineWidth:.5];
    [bezierPath stroke];
}
@end

#pragma mark - 商户介绍cell
@implementation BusinessDetail

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
       
        [self addEditView];
      
        [self addCellTop];
    }
    return self;
}

-(void)addEditView{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc]initWithFrame:CGRectMake(KScreenWidth - w, 5, w, JMViewH) btnNames:@[@"编辑"]];
    
    [self.contentView addSubview: self.jView];
}
-(void)addCellTop{

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 30)];
    _titleLabel.text = @"商户介绍";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 16, KScreenWidth, ImageH)];
    _backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_backView];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_backView.frame) + 10, KScreenWidth - 20, 0)];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
}
-(void)setModel:(TemplateModel *)model{
    _model = model;
   
    [_backView removeAllSubviews];
  
   [model.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if (idx == 3) {
           return ;
       }
       ImagePathModel* model = (ImagePathModel*)obj;
       UIImageView* imagev = [[UIImageView alloc]initWithFrame:CGRectMake(ImageSpace + idx*(ImageH+ImageSpace), 0, ImageH, ImageH)];
       [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,model.imagePath]] placeholderImage:[UIImage imageNamed:@"louce03"]];
       [_backView addSubview:imagev];
   }];

    CGFloat h = [model.shopFileCellH floatValue];
    CGRect frame = _contentLabel.frame;
    frame.size.height = h + 5;
    _contentLabel.frame = frame;
    _contentLabel.text = model.content;
}

- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, 46)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, 46)];
    [[UIColor lightGrayColor] setStroke];
    [bezierPath setLineWidth:.5];
    [bezierPath stroke];
    
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(0.0, rect.size.height - .5)];
    [bezierPath1 addLineToPoint:CGPointMake(rect.size.width, rect.size.height - .5)];
    [[UIColor lightGrayColor] setStroke];
    [bezierPath1 setLineWidth:.5];
    [bezierPath1 stroke];
}
@end

@implementation HongBaoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self addEditingSender1];
        
        [self addEditingSender2];
    }
    return self;
}

-(void)setModel:(PartModel *)model{
    _model = model;
 
    if (!_model) {
         [self editViewHiden];
        return;
    }
    
    NSString* path = [(TemplateModel*)_model.templateModelnameDate.date.lastObject imgPath];
    
    UIImage* placeHoldImage;
    if ([_model.templateModelnameCode isEqualToString:QiangHB]) {
        
        placeHoldImage = [UIImage imageNamed:@"hongbao"];
        
    }else if ([_model.templateModelnameCode isEqualToString:DaZP]){
    
        placeHoldImage = [UIImage imageNamed:@"canyin-banner"];
    }else{
    
        placeHoldImage = [UIImage imageNamed:@"dianshang-lunbo"];
    }
    
    [_imagev sd_setImageWithURL:[NSURL URLWithString:[ImagePre stringByAppendingPathComponent:path]] placeholderImage:placeHoldImage];
    
    [self editViewHiden];
}

-(void)editViewHiden{

    self.jView.prams = _model;
    self.jView2.prams = _model;
    
    if (_model) {
        TemplateModel *temp = (TemplateModel *)self.model.templateModelnameDate.date.lastObject;
        
        self.jView.hidden = ![temp.status boolValue];//NO 不隐藏  YES隐藏
        self.imagev.hidden = ![temp.status boolValue];
        self.jView2.hidden = [temp.status boolValue];

    }else{
        self.jView.hidden = YES;
        self.imagev.hidden = YES;
        self.jView2.hidden = NO;
    }
}
-(void)addEditingSender1{
    
    _imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kHongBaoCellH)];
    _imagev.image = [UIImage imageNamed:@"hongbao"];
    [self.contentView addSubview:_imagev];
    
    CGFloat w = [JMView getWidth:ThreeBtns];
    self.jView = [[JMView alloc]initWithFrame:CGRectMake(KScreenWidth - w, (kHongBaoCellH - JMViewH)/2, w, JMViewH) btnNames:ThreeBtns];
    
    [self.contentView addSubview: self.jView];
}
-(void)addEditingSender2{

    UIView* spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, JMViewH)];
    spaceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat w = [JMView getWidth:OneBtnsShow];
    self.jView2 = [[JMView alloc]initWithFrame:CGRectMake(KScreenWidth - w, 0, w, JMViewH) btnNames:OneBtnsShow];
    
    self.jView2.tag = 666;
    
    [self.contentView addSubview:self.jView2];
}

@end

#pragma mark - 一键呼叫服务cell
@implementation CallSenderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.callSender.layer.cornerRadius = self.callSender.height;
    self.callSender.clipsToBounds = YES;
}

@end
