//
//  SelectPresentView.m
//  BusinessManager
//
//  Created by The Only on 16/8/10.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "SelectPresentView.h"

@implementation SelectPresentView
+ (instancetype)loadCustomView {
    return [[NSBundle mainBundle] loadNibNamed:@"ChoosePresentView" owner:self options:nil][0];
}
@end
