//
//  YuyueDetailEditCell.m
//  BusinessManager
//
//  Created by 张心亮 on 16/8/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "YuyueDetailEditCell.h"
#import "WeiZhanModel.h"



@implementation YuyueDetailEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.valueFild.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(TemplateModel *)model{
    _model = model;
    self.valueFild.text = NoNullStr(model.name,@"");
}
- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath;
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height - .5)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - .5)];
    [[UIColor lightGrayColor] setStroke];
    [bezierPath setLineWidth:.5];
    [bezierPath stroke];
}
@end

@implementation YuyueDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatSubView];
        
    }
    return self;
}

-(void)creatSubView{
    
    self.valueTextV = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectZero];
    self.valueTextV.font = [UIFont systemFontOfSize:16];
    self.valueTextV.placeholder = @"请输入需要消费者填的项目名称";
    self.valueTextV.textContainerInset = UIEdgeInsetsMake(0, 2, 0, 0);
    self.valueTextV.showsVerticalScrollIndicator = NO;
    self.valueTextV.backgroundColor = [UIColor clearColor];
    self.valueTextV.delegate = self;
    [self.contentView addSubview:_valueTextV];
    
    self.deleteSender = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 15 - 5, 0, 15, 15)];
    [self.deleteSender setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.deleteSender addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteSender];
}
-(void)setModel:(TemplateModel *)model{
    _model = model;
    self.valueTextV.text = NoNullStr(model.name,@"");
    
    [self layOutTextView];
}

-(void)layOutTextView{
        
    
    CGFloat valueH = HeightForString(_model.name,16,KScreenWidth - 130);
    if (valueH > self.height) {
        valueH = self.height;
    }
    self.valueTextV.frame = CGRectMake(8, (self.height - valueH)/2, KScreenWidth - 130, valueH);
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath;
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height - .5)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - .5)];
    [[UIColor lightGrayColor] setStroke];
    [bezierPath setLineWidth:.5];
    [bezierPath stroke];
}

-(void)deleteAction{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userDidDeleteTheCell:)]) {
        
        [self.delegate userDidDeleteTheCell:_model];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    _model.name = textView.text;

}
@end

@implementation HZYuYueDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

-(void)creatSubView{
    
    UIView *margnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 15)];
    margnView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:margnView];
    
    _textView = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth - 30 , 44)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.placeholder = @"请输入需要消费者填的项目名称";
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.layer.cornerRadius = 3;
    _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    [self.contentView addSubview:_textView];
    
    self.deleteSender = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 15 - 15, 15, 15, 15)];
    
    [self.deleteSender setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    
    [self.deleteSender addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.deleteSender];
    
}

-(void)setModel:(TemplateModel *)model{
    _model = model;
    
    _textView.text = model.name;
}

-(void)buttonAction:(UIButton *)sender{
    
    if (_delegate && [self.delegate respondsToSelector:@selector(yuYueDetailCell:didDeleteCellWithModel:)]) {
        [_delegate yuYueDetailCell:self didDeleteCellWithModel:_model];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _model.name = textField.text;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    _model.name = textField.text;
    return YES;
}
@end






#define Font 13
@implementation HZYuYueDefaultCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (KScreenWidth < 330.f ) {
        _fitmentArea.titleLabel.font = [UIFont systemFontOfSize:Font];
        _fitmentPrice.titleLabel.font = [UIFont systemFontOfSize:Font];
        _fitmentTime.titleLabel.font = [UIFont systemFontOfSize:Font];
        _contactName.titleLabel.font = [UIFont systemFontOfSize:Font];
        _contactPhone.titleLabel.font = [UIFont systemFontOfSize:Font];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
