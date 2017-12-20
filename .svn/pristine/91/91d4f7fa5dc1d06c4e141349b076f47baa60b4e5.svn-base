//
//  LoopTableVIew.m
//  BusinessManager
//
//  Created by Niuyp on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoopTableVIew.h"
#import "LoopViewCell.h"
#import "WeiZhanModel.h"
#import "JMPickCollectView.h"

@interface LoopTableVIew() <LoopViewDelegate>
@property (nonatomic, strong) JMPickCollectView* pickCollectView;
@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) UIView* footerView;
@property (nonatomic, strong) NSIndexPath* currentIndex;
@property (nonatomic, strong) NSMutableArray *imagePaths;
@end

@implementation LoopTableVIew

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        if (self.dataSources) {
            
            NSLog(@"%@",self.dataSources);
        }
        
    }
    return self;
}


#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSources.date.count == 0) {
        return 1;
    }
    return self.dataSources.date.count + self.datasArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    static NSString *indetify = @"LoopViewCell";
    LoopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetify];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LoopViewCell class]) owner:nil options:nil] lastObject];
    }
    if (self.dataSources) {
        
        for (TemplateModel* template in self.dataSources.date) {
            if (template.imgPath) {
                [cell.photos addObject:template.imgPath];
            }
        }

    }else{
        cell.photos = nil;
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    if (self.dataSources) {
        
        for (TemplateModel* model in self.dataSources.date) {
            
            NSLog(@"_______%@",model.imgPath);
            NSLog(@"_______%@",model.content);
        }
    }
//    cell.pickCollectionView.selectedPhotos = self.dataSources
    cell.deleteSender.tag = indexPath.row;

    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == self.currentIndex.section)) {
        return KLoopViewH + self.photos.count/4 * 100;
    }
    return KLoopViewH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return self.footerView;
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
//    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPaths] withRowAnimation:UITableViewRowAnimationNone];

}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
}
#pragma mark - LoopView delegate
- (void)updateTableViewWithPhotos:(NSMutableArray *)photos indexPath:(NSIndexPath *)indexPath JMPickCollectView:(JMPickCollectView *)collectionView{
    self.currentIndex = indexPath;
    self.photos = photos;
    self.pickCollectView = collectionView;
    [self upLoadImage:photos];
    [self reloadData];
}
- (void)upLoadImage:(NSMutableArray*)phones{
    __block NSInteger requestIndex = 0;
    
    [SVProgressHUD showWithStatus:@"照片上传中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [self.photos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData* imageData = UIImageJPEGRepresentation(UIImageScaleToSize(obj, CGSizeMake(720, 144)), 1.0);
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        [params setObject:NoNullStr([imageData base64EncodedString], @"") forKey:@"code"];
        [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
        [params setObject:@"png" forKey:@"suffix"];
        
        [[MallNetManager share] request:API_ImageUpload parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (Succeed(responseObject)) {
                
                if ([responseObject objectForKey:@"data"]) {
                    NSDictionary* data = [responseObject objectForKey:@"data"];
                    
                    if ([data objectForKey:@"imgPath"]) {
                        
                        [self.imagePaths addObject:[data objectForKey:@"imgPath"]];
                    }
                }
            }
            requestIndex++;
            [self judgeFinish:requestIndex];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            requestIndex++;
            [self judgeFinish:requestIndex];
        }];
    }];
    

}

-(void)judgeFinish:(NSInteger)index{
    
    if (index == self.photos.count) {
        [SVProgressHUD dismiss];
//        _isImageUpload = YES;
        NSMutableArray* tempArr = [NSMutableArray array];
        [tempArr addObjectsFromArray:self.pickCollectView.selectedPhotos];
        [tempArr addObjectsFromArray:self.imagePaths];
        self.pickCollectView.selectedPhotos = tempArr;
    }
}
- (void)deleteImageCell:(UIButton *)sender cell:(id)cell{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];

    
    LoopViewCell* loopCell = (LoopViewCell*)cell;

    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:loopCell.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    [self deleteSections:[NSIndexSet indexSetWithIndex:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"sender.tag:%ld",(long)sender.tag);
    if (sender.tag < self.dataSources.date.count) {
        
        NSMutableArray* tempArr = [NSMutableArray array];
        [tempArr addObjectsFromArray:self.dataSources.date];
        [tempArr removeObjectAtIndex:sender.tag];
        self.dataSources.date = tempArr.copy;
    }else{
        [self.datasArray removeObjectAtIndex:sender.tag - self.dataSources.date.count];

    }
    [self.originImages removeObjectAtIndex:sender.tag];
    
    [self reloadData];
    
}

- (void)addCellAction:(UIButton*)sender{
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];

    [self insertRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.datasArray addObject:index];
    [self reloadData];
}
@synthesize datasArray = _datasArray,pickCollectView = _pickCollectView,footerView = _footerView,dataSources = _dataSources;

- (NSMutableArray *)datasArray{
    
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (NSMutableArray *)photos{
    
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (UIView *)footerView{
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
        _footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame  = CGRectMake(0, 15, KScreenWidth, 25);
        
        [button setImage:[UIImage imageNamed:@"uploadImage"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addCellAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    
    return _footerView;
}
- (JMPickCollectView *)pickCollectView{
    
    if (!_pickCollectView) {
        _pickCollectView = [[JMPickCollectView alloc] init];
//        PickPrameModel* model = [[PickPrameModel alloc] init];
        
//        model.frame = CGRectMake(0, 200, KScreenWidth, 100);
//        model.numOfRow = 4;
//        model.margin = 4;
//        model.maxCount = 9;
//        _pickCollectView = [JMPickCollectView creatWithPramModel:model block:^(NSMutableArray *photos, NSMutableArray *assets) {
//            _pickCollectView.frame = CGRectMake(0, 0, KScreenWidth, (photos.count/4 + 1* 100));
//            [_pickCollectView reloadData];
//        }];

    }
    
    return _pickCollectView;
}

- (TemplateModelData *)dataSources{
    if (!_dataSources) {
        _dataSources = [[TemplateModelData alloc] init];
    }
    return _dataSources;
}

@end
