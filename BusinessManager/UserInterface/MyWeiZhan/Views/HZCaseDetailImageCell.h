//
//  HZCaseDetailImageCell.h
//  BusinessManager
//
//  Created by niuzs on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZCaseDetailImageCell;
@protocol HZCaseDetailImageCellDelegate <NSObject>

- (void)caseDetailImageCell:(HZCaseDetailImageCell *)cell buttonAction:(UIButton *)sender;

@end

extern NSString *const HZCaseDetailImageCellID ;
@interface HZCaseDetailImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;
@property (weak, nonatomic) IBOutlet UIButton *deleteImgBtn;
@property (strong, nonatomic)NSIndexPath *indexPath;
@property (assign, nonatomic)id < HZCaseDetailImageCellDelegate > delegate;
@end
