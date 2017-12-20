//
//  CustomAlertView.h
//  BusinessManager
//
//  Created by 王启明 on 16/9/7.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView<UITextViewDelegate>
@property (nonatomic,strong)UITextView *hittLab;
@property (nonatomic,strong)NSString *PhoneStr;
@end
