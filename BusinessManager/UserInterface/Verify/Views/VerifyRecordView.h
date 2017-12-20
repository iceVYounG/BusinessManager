//
//  VerifyRecordView.h
//  BusinessManager
//
//  Created by Raven－z on 16/8/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VerifyRecordModel;

@interface VerifyRecordView : UIView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
- (instancetype)init;

@end

@interface VerifyRecordViewTableViewCell : UITableViewCell

@property (nonatomic, strong) VerifyRecordModel *model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end