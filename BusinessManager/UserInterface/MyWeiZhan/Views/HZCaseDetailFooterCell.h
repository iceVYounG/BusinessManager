//
//  HZCaseDetailFooterCell.h
//  BusinessManager
//
//  Created by niuzs on 16/9/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const HZCaseDetailFooterCellID ;
@protocol  HZCaseDetailFooterCellDelegate <NSObject>

- (void)footerCellDidClickNewBtn;
- (void)footerCellDidClickSaveBtn;

@end

@interface HZCaseDetailFooterCell : UICollectionViewCell


@property (nonatomic, weak) id <HZCaseDetailFooterCellDelegate> delegate;
@end
