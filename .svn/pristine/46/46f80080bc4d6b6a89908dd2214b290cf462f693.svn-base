//
//  YuyueDefaultCell.m
//  BusinessManager
//
//  Created by 张心亮 on 16/9/8.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "YuyueDefaultCell.h"

@implementation YuyueDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle=0;
    self.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    if (SCREEN_SIZE.width<330.f) {
        self.roomPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        self.roomPhone.titleLabel.font=[UIFont systemFontOfSize:15];
        self.roomPhone.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
        self.roomName.titleLabel.font=[UIFont systemFontOfSize:15];
        self.mianjiLabel.titleLabel.font=[UIFont systemFontOfSize:15];
        self.lookRoomLabel.titleLabel.font=[UIFont systemFontOfSize:15];
        self.yusuanLabel.titleLabel.font=[UIFont systemFontOfSize:15];
        self.huxingLabel.titleLabel.font=[UIFont systemFontOfSize:15];
        
        
    }
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

@implementation YuyueShiJiaCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=0;
    self.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    if (SCREEN_SIZE.width<330.f) {
        
        self.shijiaCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.shijiaCar.titleLabel.font=[UIFont systemFontOfSize:15];
        self.shijiaCar.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
         self.carName.titleLabel.font=[UIFont systemFontOfSize:15];
         self.carTime.titleLabel.font=[UIFont systemFontOfSize:15];
         self.carType.titleLabel.font=[UIFont systemFontOfSize:15];
        
    }
   
    // Initialization code
}


@end

@interface YuyueBaoYangCell()
@property (weak, nonatomic) IBOutlet UIButton *baoYangPhone;
@property (weak, nonatomic) IBOutlet UIButton *baoYangCar;
@property (weak, nonatomic) IBOutlet UIButton *baoYangItem;
@property (weak, nonatomic) IBOutlet UIButton *baoyangName;
@property (weak, nonatomic) IBOutlet UIButton *baoYangTime;


@end

@implementation YuyueBaoYangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle=0;
    self.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    
    if (SCREEN_SIZE.width<330.f) {
        self.baoYangPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.baoYangPhone.titleLabel.font=[UIFont systemFontOfSize:15];
        self.baoYangPhone.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
        
        self.baoYangCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.baoYangCar.titleLabel.font=[UIFont systemFontOfSize:15];
        self.baoYangCar.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
        self.baoYangItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.baoYangItem.titleLabel.font=[UIFont systemFontOfSize:15];
        self.baoYangItem.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        
        self.baoyangName.titleLabel.font=[UIFont systemFontOfSize:15];
        self.baoYangTime.titleLabel.font=[UIFont systemFontOfSize:15];
    
    }
    
    // Initialization code
}

@end

