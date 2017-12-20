//
//  PrizeTypeView.m
//  BusinessManager
//
//  Created by The Only on 16/7/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "PrizeTypeView.h"

@implementation PrizeTypeView

+ (instancetype)loadCustomView {
    return [[NSBundle mainBundle] loadNibNamed:@"PrizeTypeView" owner:self options:nil][0];
}

+ (instancetype)loadCustomViewWithFrame:(CGRect)frame{
    
    PrizeTypeView *prizeType = [PrizeTypeView loadCustomView];
    prizeType.frame = frame;
 
    return prizeType;
}

- (IBAction)choosePrizeType:(id)sender {
    
    
    
}


@end
