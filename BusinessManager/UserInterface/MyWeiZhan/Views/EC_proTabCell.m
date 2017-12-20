//
//  EC_proTabCell.m
//  BusinessManager
//
//  Created by 王启明 on 16/8/17.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "EC_proTabCell.h"

@implementation EC_proTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.hidden=YES;
    // Initialization code
}

- (void)setModel:(TemplateModel *)model{
    _model=model;
    if (model) {
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BussinessImagePre,model.webPath]] placeholderImage:[UIImage imageNamed:@"img"]];
        NSString *priceStr=[NSString stringWithFormat:@"价格：¥%@",model.shopPrice];
        self.priceLb.text=priceStr;
        self.titleLB.text=model.shortName;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation EC_proTabSelect;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.seleteBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [self.seleteBtn setImage:[UIImage imageNamed:@"dfghj"] forState:UIControlStateSelected];
        self.seleteBtn.clipsToBounds=YES;
        self.seleteBtn.layer.borderWidth=1;
        self.seleteBtn.layer.borderColor=[UIColor colorWithHexString:@"#999999"].CGColor;
        [self.contentView addSubview:self.seleteBtn];
        WS(weakSelf)
        [self.seleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(25);
            make.top.equalTo(weakSelf).offset(32);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        self.imgV=[[UIImageView alloc]init];
        [self.contentView addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.seleteBtn.mas_right).offset(10);
            make.top.equalTo(weakSelf).offset(8);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            
        }];
        self.titleLb=[UILabel new];
        self.titleLb.textColor=[UIColor colorWithHexString:@"#333333"];
        self.titleLb.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.imgV.mas_right).offset(10);
            make.top.equalTo(weakSelf).offset(13);
            make.height.equalTo(@15);
        }];
        self.priceLab=[UILabel new];
        self.priceLab.font=[UIFont systemFontOfSize:13];
        self.priceLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:self.priceLab];
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLb.mas_bottom).offset(7);
            make.left.equalTo(weakSelf.imgV.mas_right).offset(10);
            make.height.equalTo(@15);
            
        }];
        
    }
    return self ;
}

- (void)setModel:(TemplateModel *)model{
    _model=model;
    if (model) {
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BussinessImagePre,model.webPath]] placeholderImage:[UIImage imageNamed:@"img"]];
        NSString *priceStr=[NSString stringWithFormat:@"价格：¥%@",model.shopPrice];
        self.priceLab.text=priceStr;
        self.titleLb.text=model.shortName;
    }
}
@end