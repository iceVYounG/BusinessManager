//
//  LoopViewCell.h
//  BusinessManager
//
//  Created by Niuyp on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMPickCollectView.h"

#define KLoopViewH  300

@protocol LoopViewDelegate <NSObject>

- (void)updateTableViewWithPhotos:(NSMutableArray*)photos indexPath:(NSIndexPath*)indexPath JMPickCollectView:(JMPickCollectView*)collectionView;
- (void)deleteImageCell:(UIButton *)sender cell:(id)cell;
@end

@class TemplateModelData;
@interface LoopViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageSender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) JMPickCollectView *pickCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *deleteSender;

@property (weak, nonatomic) id<LoopViewDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) TemplateModelData *model;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) NSMutableArray *imagePaths;
@end
