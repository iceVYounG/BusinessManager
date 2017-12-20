//
//  ChoosePrizeTypeView.m
//  BusinessManager
//
//  Created by The Only on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ChoosePrizeTypeView.h"

@implementation ChoosePrizeTypeView
{
    BOOL shiWuSelected;// 实物
    BOOL dianZiQuanSelected;// 电子券
    BOOL xianCashSelected;// 现金
}

- (instancetype)initWithFrame:(CGRect)frame block:(choosePrizeTypeBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePrizeTypeView" owner:nil options:nil] firstObject];
        [self setFrame:frame];
        self.chooseTypeView.layer.cornerRadius = 16;

        self.prizeTypeBlock = block;
        shiWuSelected = NO;
        dianZiQuanSelected = NO;
        xianCashSelected = NO;
    }
    return self;
}
-(void)show
{
    self.layer.transform = CATransform3DMakeScale(1.4f, 1.4f, 1.0);
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];

}

-(void)close
{
    CATransform3D currentTransform = self.layer.transform;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backGroundView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.chooseTypeView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];

}
- (IBAction)cancleAction:(id)sender
{
    
    [self close];
}

- (IBAction)btnActionClick:(id)sender
{
    [self.shiWuPrizeButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateSelected];
    [self.shiWuPrizeButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.dianZiQuanPrizeButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateSelected];
    [self.dianZiQuanPrizeButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.xianJinCashButton setTitleColor:[UIColor colorWithHexString:@"#00AAEE"] forState:UIControlStateSelected];
    [self.xianJinCashButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    UIButton *btn = (UIButton *)sender;
    if (self.prizeTypeBlock)
    {
        self.prizeTypeBlock(btn.titleLabel.text);
    }
    
    if ([self.delegate respondsToSelector:@selector(didFinishClickBtnTag:chooseView:)])
    {
        
        [self.delegate didFinishClickBtnTag:btn.tag chooseView:self];
    }
    [self close];
}
@end