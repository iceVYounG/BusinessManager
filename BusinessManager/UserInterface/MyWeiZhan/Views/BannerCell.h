//
//  BannerCell.h
//  BusinessManager
//
//  Created by Niuyp on 16/8/4.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"


#define KBannerCellH   315
#define KBigCellH      607

@protocol bannerCellDelegate <NSObject>

- (void)imageSelectWithButton:(UIButton*)imageSender cell:(id)cell;

@end
@class PartModel;
@interface BannerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *shopNameField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
@property (weak, nonatomic) IBOutlet UIButton *imageSender;
@property (weak, nonatomic) IBOutlet UIButton *updateSender;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *icon;

@property (nonatomic, strong) PartModel *model;

@property (weak, nonatomic) id<bannerCellDelegate> delegate;

@end


@protocol EditCellDelegate <NSObject>

- (void)editSenderCilckWithBtn:(MenuView*)menuView cell:(id)cell isEdit:(BOOL)isEdit;

@end
@class ADImageModel;
@interface EditCell : UITableViewCell

@property (weak, nonatomic) id<EditCellDelegate> delegate;

@property (nonatomic, strong) ADImageModel *model;
@end
