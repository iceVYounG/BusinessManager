//
//  WeiZhanCollectView.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanCollectView.h"
#import "UIView+UIViewController.h"
#import "FoodWeiZhanVC.h"
#import "WC_GeneralVC.h"
#import "HouseWeiZhanVC.h"
#import "E_Commerce.h"
#import "FourSWeiZhanVC.h"
#import "HomeZhuangWeiZhanVC.h"
#import "CustomAlertView.h"
#import "FlowerShopVC.h"
static NSString* identfier = @"WeiZhanCollectViewCellId";

@implementation WeiZhanCollectView
{
    MKNetworkOperation *operation;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout andIsTiyan:(BOOL)isTiyan select:(SelectIndex)block {
    
//
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _block = block;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        AccountInfo.isTiyan=isTiyan;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identfier];
        
       
        
    }
    return self;
}


-(void)clickChooseBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:{//鲜花店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"鲜花店详情配置";
            vc.type=FlowerShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{//水果店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"水果店详情配置";
            vc.type=FruitShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:{//面包店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"面包店详情配置";
            vc.type=BreadShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{//特色餐饮
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            FoodWeiZhanVC* vc = [[FoodWeiZhanVC alloc]initWithNibName:@"FoodWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 4:{//通用
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            WC_GeneralVC* vc = [[WC_GeneralVC alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{//4S
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            HomeZhuangWeiZhanVC* vc = [[HomeZhuangWeiZhanVC alloc]initWithNibName:@"HomeZhuangWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{//家装
            
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            HouseWeiZhanVC* vc = [[HouseWeiZhanVC alloc]initWithNibName:@"HouseWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:{//房产
            
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            if (![AccountInfo.b2cStoreId isKindOfClass:[NSNull class]]) {
                E_Commerce *vc = [[E_Commerce alloc]init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            }else{
                UIWindow *window=[[UIApplication sharedApplication].delegate window];
                CustomAlertView *alert=[[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
                [window addSubview:alert];
            }
        }
            break;
            
        default:{
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"鲜花店详情配置";
            vc.type=FlowerShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 9;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identfier forIndexPath:indexPath];
        switch (indexPath.item) {
        case 0:
        {
        cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flowerPage.jpg"].CGImage);
        
        }
            break;
        case 1:
        {
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"fruitPage.jpg"].CGImage);
            
        }
            break;
        case 2:
        {
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"breadPage.jpg"].CGImage);
            
        }
            break;
        case 3:
        {
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"canyin.jpg"].CGImage);
            
        }
            break;
        case 4:
        {
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tongyong-moban.jpg"].CGImage);
            
        }
            break;
        case 5:
        {
            
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"jiazhuang-moban.jpg"].CGImage);
        }
            break;
        case 6:
        {
                cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"fangchanImage.jpg"].CGImage);
        }
            break;
        case 7:
        {
        
              cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"dianshang-moban.jpg"].CGImage);
        }
            break;
        case 8:
        {
          
            cell.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flowerPage.jpg"].CGImage);

        }
            break;
        
        default:
            break;
    }
    
    self.chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtn.backgroundColor=[UIColor colorWithHexString:@"#00aaee"];
    [self.chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chooseBtn setTitle:@"选择该模板" forState:UIControlStateNormal];
    self.chooseBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.chooseBtn addTarget:self action:@selector(clickChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.chooseBtn.frame=CGRectMake(-40, SCREEN_SIZE.height-NavigationH-119, SCREEN_SIZE.width, 44);
    self.chooseBtn.tag=indexPath.row;
    [cell addSubview:self.chooseBtn];

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    if (AccountInfo.isTiyan) {
        if (AccountInfo.tempStoreId.length==0) {
            NSMutableDictionary *prams = [NSMutableDictionary dictionary];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showWithStatus:@"数据请求中..."];
            [operation cancel];
            operation = [[MallNetworkEngine vipCardMGshare]requestNotEncodeWithDate:[NSDate date] requestWithPath:API_getSeqno Params:prams CompletionHandler:^(MKNetworkOperation *completedOperation) {
                NSDictionary *dic = [completedOperation responseDecodeToDic];
                
                NSString *code = [dic objectForKey:@"code"];
                NSString *msg = [dic objectForKey:@"msg"];
                
                if ([code isEqualToString:@"00-00"]) {
                    [SVProgressHUD dismiss];
                    NSDictionary *data = [dic objectForKey:@"data"];
                    if ([data isKindOfClass:[NSDictionary class]]) {
                        
                        NSString *seqno = [data objectForKey:@"seqno"];
                        AccountInfo.tempStoreId=seqno;
                        [weakSelf selectIndex:indexPath.item];
                        //                self.tempStoreId = seqno;
                        
                    }else{
                        [SVProgressHUD dismiss];
                        
                    }
                    
                }else{
                    [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
                }
                
                
                NSLog(@"%@",dic);
            } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [SVProgressHUD showInfoWithStatus:@"小宝正在打盹，请过几分再试下"];
            }];

        }
        else{
            [weakSelf selectIndex:indexPath.item];
        }
    }
    else{
        [weakSelf selectIndex:indexPath.item];
    
    }
    
}

-(void)selectIndex:(NSInteger)index{
    switch (index) {
        case 0:{//鲜花店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"鲜花店详情配置";
            vc.type=FlowerShop;
            if (AccountInfo.isTiyan) {
                
                
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{//水果店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"水果店详情配置";
            vc.type=FruitShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:{//面包店
            FlowerShopVC *vc=[[FlowerShopVC alloc]init];
            vc.titleStr=@"面包店详情配置";
            vc.type=BreadShop;
            if (AccountInfo.isTiyan) {
                AccountInfo.isTiyan=YES;
            }
            else{
                AccountInfo.isTiyan=NO;
            }
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{//特色餐饮
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            FoodWeiZhanVC* vc = [[FoodWeiZhanVC alloc]initWithNibName:@"FoodWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 4:{//通用
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            WC_GeneralVC* vc = [[WC_GeneralVC alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{//4S
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            HomeZhuangWeiZhanVC* vc = [[HomeZhuangWeiZhanVC alloc]initWithNibName:@"HomeZhuangWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{//家装
            
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            HouseWeiZhanVC* vc = [[HouseWeiZhanVC alloc]initWithNibName:@"HouseWeiZhanVC" bundle:nil];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:{//房产
            
            if (AccountInfo.isTiyan) {
                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
                return;
            }
            if (![AccountInfo.b2cStoreId isKindOfClass:[NSNull class]]) {
                E_Commerce *vc = [[E_Commerce alloc]init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            }else{
                UIWindow *window=[[UIApplication sharedApplication].delegate window];
                CustomAlertView *alert=[[CustomAlertView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
                [window addSubview:alert];
            }
        }
            break;
            //        case 8:{//电商
            //
            //            if (self.isTiyan) {
            //                [OMGToast showWithText:@"该模板体验功能正在建设中，敬请期待"];
            //                return;
            //            }
            //            FourSWeiZhanVC* vc = [[FourSWeiZhanVC alloc]initWithNibName:@"FourSWeiZhanVC" bundle:nil];
            //            [self.viewController.navigationController pushViewController:vc animated:YES];
            //           
            //        }
            //            break;
        default:{
            
        }
            break;
    }

}





-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(SpaceH, SpaceW, 0, SpaceW);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.width - SpaceW*2, self.height-SpaceH);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGFloat targetX = scrollView.contentOffset.x;
    NSLog(@"---targetX-->:%.1f",targetX);
    NSInteger index = (targetX + SCREEN_SIZE.width / 2) / SCREEN_SIZE.width;
    NSLog(@"--index->>:%d",index);
    if (index < 0) {
        index = 0;
    }else if(index >= 9){
        index = 9 - 1;
    }
    
    if (self.block) {
        
        _block(index);
    }
}


#pragma mark - 初始化
@synthesize datasArry = _datasArry;

-(NSMutableArray *)datasArry{

    if (!_datasArry) {
        _datasArry = [NSMutableArray array];
    }
    return _datasArry;
}

@end
