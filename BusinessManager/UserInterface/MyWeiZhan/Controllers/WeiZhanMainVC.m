//
//  WeiZhanMainVC.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanMainVC.h"
#import "WeiZhanCollectView.h"
#import "FoodWeiZhanVC.h"
#import "WC_GeneralVC.h"
#import "HouseWeiZhanVC.h"
#import "E_Commerce.h"
#import "FourSWeiZhanVC.h"
#import "HomeZhuangWeiZhanVC.h"
#import "CustomAlertView.h"
#import "FlowerShopVC.h"
#define TitleBtn_Width 100
#define TitleViewH 45

@interface WeiZhanMainVC ()
{
    UIButton* _lastSender;
}
@property(nonatomic,strong)WeiZhanCollectView* collectView;
@property(nonatomic,strong)UIScrollView* titleScrollView;
@property(nonatomic,strong)UIView* selectView;
@end

@implementation WeiZhanMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择微站模板";
    [self collectView];
    if (AccountInfo.isTiyan) {
        [self requestGetSeqno];
    }
}


#pragma mark - Action
-(void)selectTitleAction:(UIButton*)sender{
    if (_lastSender == sender && sender) {
        return;
    }
    [self settingSelectSender:sender];
    [self settingUnSelectSender:_lastSender];
    _lastSender = sender;
    NSIndexPath* indexpath = [NSIndexPath indexPathForItem:sender.tag - 994 inSection:0];
    NSLog(@"--indexpath->:%@", indexpath);
    if ((sender.tag-994) <0 ) {
        indexpath = [NSIndexPath indexPathForItem:0 inSection:0];
    }else{
        indexpath = [NSIndexPath indexPathForItem:sender.tag - 994 inSection:0];
    }
      [self.collectView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self moveToCenter:sender];
 
}

-(void)settingSelectSender:(UIButton*)sender{
    
    [sender setTitleColor:HexColor(@"#66CCCC") forState:UIControlStateNormal];
    
  [UIView animateWithDuration:.25 animations:^{
      CGRect rect = self.selectView.frame;
      NSLog(@"sender.center.x->:%f",sender.center.x);
      rect.origin.x = sender.center.x - TitleBtn_Width/2;
      if (rect.origin.x < 0) {
          rect.origin.x = 0;
      }
      
      self.selectView.frame = rect;
  }];
}
-(void)settingUnSelectSender:(UIButton*)sender{
    
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)moveToCenter:(UIButton*)btn{
    
    CGFloat offset = btn.center.x - SCREEN_SIZE.width / 2;
    if (offset < 0){
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - SCREEN_SIZE.width;
    if (offset > maxOffset){
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - 初始化
@synthesize collectView = _collectView, titleScrollView = _titleScrollView,selectView = _selectView;

-(WeiZhanCollectView *)collectView{
    WS(weakSelf);
    if (!_collectView) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = SpaceW*2;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectView=[[WeiZhanCollectView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), SCREEN_SIZE.width, SCREEN_SIZE.height - TitleViewH - NavigationH) collectionViewLayout:layout andIsTiyan:AccountInfo.isTiyan select:^(NSInteger index) {
            UIButton* sender = [self.titleScrollView viewWithTag:index + 994];
//            NSLog(@"sender.tag-->>:%d", sender.tag);
            [self selectTitleAction:sender];
        }];
        
        _collectView.pagingEnabled = YES;
        
        [self.view addSubview:_collectView];
        
    }
    return _collectView;
}

-(UIScrollView *)titleScrollView{

    if (!_titleScrollView) {
        
        NSArray* titles = @[@"花店",@"水果",@"面包",@"餐饮",@"通用",@"家装",@"房产",@"电商"];
        
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, TitleViewH)];
        _titleScrollView.contentSize = CGSizeMake(titles.count * TitleBtn_Width, 0);
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGRect rect = CGRectMake(TitleBtn_Width * idx, 0, TitleBtn_Width, TitleViewH);
            UIButton *btn = [[UIButton alloc] initWithFrame:rect];
            btn.tag = idx + 994;
            NSLog(@">>%ld",btn.tag);
            
            [btn setTitle:titles[idx] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [btn addTarget:self action:@selector(selectTitleAction:) forControlEvents:UIControlEventTouchDown];
            
            if (idx == 0) {
                [self settingSelectSender:btn];
                _lastSender = btn;
            }
            [_titleScrollView addSubview:btn];
        }];
       [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}

-(UIView *)selectView{

    if (!_selectView) {
        
        _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, TitleViewH-2, TitleBtn_Width, 2)];
        _selectView.backgroundColor = HexColor(@"#66CCCC");
        [self.titleScrollView addSubview:_selectView];
    }
    return _selectView;
}


@end
