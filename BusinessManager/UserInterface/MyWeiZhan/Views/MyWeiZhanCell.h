//
//  MyWeiZhanCell.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyWeiZhanCellH 228

@class MyWeiZhanModel;

@protocol MyWeiZhanDelegate <NSObject>

-(void)selectedBottomSender:(NSInteger)tag model:(MyWeiZhanModel*)model;

-(void)xiugaiAction:(MyWeiZhanModel*)model;

-(void)tijiaoAction:(MyWeiZhanModel*)model;
@end



@interface MyWeiZhanCell : UITableViewCell <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *xiugaiBtn;

@property (weak, nonatomic) IBOutlet UIWebView *pageWeb;

@property (weak, nonatomic) IBOutlet UIImageView *dimensionImagev;

@property (weak, nonatomic) IBOutlet UILabel *weiZhanName;

@property (weak, nonatomic) IBOutlet UIButton *adressBtn;

@property (weak, nonatomic) IBOutlet UIView *buttomBackView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property(nonatomic,strong)MyWeiZhanModel* model;

@property(nonatomic,weak)id<MyWeiZhanDelegate>delegate;

@end
