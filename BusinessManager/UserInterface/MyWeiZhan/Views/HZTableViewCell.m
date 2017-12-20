//
//  HZTableViewCell.m
//  BusinessManager
//
//  Created by niuzs on 16/8/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HZTableViewCell.h"
#import "WeiZhanModel.h"
static NSString *cellID = @"HZCell";

@implementation HZTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    
    HZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HZTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview];
    }
    return self;
}
- (void)addSubview{
    CGFloat width= ([UIScreen mainScreen].bounds.size.width-3) /2;
    CGFloat gap = 3.f;
    CGFloat height = 151.f;
    for (int i = 0; i < 8; i++) {
        
        HZView *imageView = [[HZView alloc]initWithFrame:CGRectMake(gap * (i%2)+(width + gap)*(i%2),
                                                                    gap* (i/2) + (height + gap)*(i/2) ,
                                                                    width, height)];
        self.iconView = imageView;
        imageView.tag = TAG + i;
        [self.contentView addSubview:imageView];
    }
}
- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    for (HZView *imageV in self.contentView.subviews) {
        imageV.hidden = YES;
        
    }
    [dataArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HZView *imageV = [self.contentView viewWithTag:TAG + idx];
        
        TemplateModel *model = dataArray[idx];
        [imageV.iconImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePre,model.imgPath]] placeholderImage:[UIImage imageNamed:model.imageName]];
        imageV.iconName.text = model.name;
        imageV.hidden = NO;
        
    }];
    [self addEditingSender];//添加编辑按钮
}


- (void)addEditingSender{
    CGFloat w = [JMView getWidth:@[@"编辑"]];
    self.jView = [[JMView alloc] initWithFrame:CGRectMake(KScreenWidth - w, 0, w, JMViewH) btnNames:@[@"编辑"]];
    self.jView.tag = HZCaseDetailEdit;
    [self.contentView addSubview:self.jView];
}

@end
@implementation HZView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        _iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height *0.8)];
        _iconImageV.backgroundColor = [UIColor whiteColor];
        _iconName= [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageV.frame), width, height *0.2)];
        _iconName.textAlignment = NSTextAlignmentCenter;
        _iconName.backgroundColor = [UIColor whiteColor];
        _iconName.font = [UIFont systemFontOfSize:ICONFONT];
        [self addSubview:_iconName];
        [self addSubview:_iconImageV];
    }
    return self;
}

@end