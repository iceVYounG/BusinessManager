//
//  WZ_AddNewFloorVCViewController.m
//  BusinessManager
//
//  Created by KL on 16/9/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WZ_AddNewFloorVCViewController.h"
#import "WZ_AddNewFloorCollectionCell.h"
#import "JMPickCollectView.h"
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "CLImageEditor.h"
#import "WZ_ConfigGoooodsInfoVC.h"

//Cell的宽、高
#define NewFloorCell_Width  (KScreenWidth - 3.0) / 2.0
#define NewFloorCell_Heigh  NewFloorCell_Width * (169.0/186.0)
//cell中的image的高、宽
#define NewFloorCellImg_Width (KScreenWidth - 3.0) / 2.0
#define NewFloorCellImg_Height NewFloorCellImg_Width * (125.0/186.0)
//CelllineSpace
#define NewFloorCell_LineSpacing 15.0
#define NewFloorCell_InteritemSpacing 3.0
/*商品最大数量*/
#define NewFloorCell_MaxLimitedGoodsCount 10

//楼层名称字数限制
#define MAX_STARWORDS_LENGTH_AddNewFloor_Name 20

@interface WZ_AddNewFloorVCViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, WZ_AddNewFloorCollectionCellDelegate, WZ_ConfigGoooodsInfoVCDelegate>

@property (nonatomic, strong) NSMutableArray *floorDataArry;
@property (nonatomic, strong) NSMutableArray *originImages;
@property (nonatomic, assign) NSIndexPath *addNewGoodsCellIndexPath;

@end

@implementation WZ_AddNewFloorVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"楼层配置";
    [self getDataFromModel];
    [self.floorCollectionView registerNib:[UINib nibWithNibName:@"WZ_AddNewFloorCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"WZ_AddNewFloorCollectionCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewFloorTextFieldDidChangeAction:) name:UITextFieldTextDidChangeNotification object:self.floorNameTF];
}

- (void)getDataFromModel {
    if (self.goodsModel && ![self.goodsModel.id isEmpty]) {
        NSArray *arr = self.goodsModel.items.copy;
        if (arr.count > 0) {
            for (TemplateModel *model in arr) {
                [self.floorDataArry addObject:model];
            }
        }
        self.floorNameTF.text = NoNullStr(self.goodsModel.floorName, @"");
    }
}


#pragma mark - UICollectionViewDelegate / dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.floorDataArry.count < NewFloorCell_MaxLimitedGoodsCount) {
        return self.floorDataArry.count + 1;
    }else {
        return self.floorDataArry.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifi = @"WZ_AddNewFloorCollectionCell";
    WZ_AddNewFloorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifi forIndexPath:indexPath];
    cell.addNewFloorCellDelegate = self;
    cell.indexPath = indexPath;
    if (indexPath.item == self.floorDataArry.count) {
        if (indexPath.item > NewFloorCell_MaxLimitedGoodsCount) {
            cell.isAddNewCell = NO;
        }else {
            cell.isAddNewCell = YES;
            cell.goodsItemModel = nil;
            
        }
        
    }else {
        cell.isAddNewCell = NO;
    }
    if (indexPath.item < self.floorDataArry.count) {
//        cell.isAddNewCell = NO;
        TemplateModel *itemModel = [self.floorDataArry objectAtIndex:indexPath.item];
        cell.goodsItemModel = itemModel;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(NewFloorCell_Width, NewFloorCell_Heigh);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return NewFloorCell_LineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return NewFloorCell_InteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KScreenWidth, 15.0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WZ_ConfigGoooodsInfoVC *configVC = [[WZ_ConfigGoooodsInfoVC alloc] initWithNibName:@"WZ_ConfigGoooodsInfoVC" bundle:nil];
    configVC.delegate = self;
    configVC.isTiYanAccount = self.isTioYanAccount;
    configVC.selectedIndexPath = indexPath;
    if (indexPath.item < self.floorDataArry.count) {
//        TemplateModel *templateModel = [self.dataArry objectAtIndex:indexPath.item];
        TemplateModel *model = [self.floorDataArry objectAtIndex:indexPath.item];
        if (model && model.id.length > 0) {
            configVC.goodsID = model.id ;
        }
    }else {
        configVC.goodsID = nil;
    }
    
    [self.navigationController pushViewController:configVC animated:YES];
}



#pragma mark - WZAddNewFloorCellDelegate

//删除商品
- (void)WZ_AddNewFloorCollectionCellDeleteGoodsActionWith:(NSIndexPath *)indexPath {
    [self.floorDataArry removeObjectAtIndex:indexPath.item];
    [self.floorCollectionView reloadData];
}

#pragma mark - WZ_ConfigGoooodsInfoVCDelegate
- (void)WZ_ConfigGoooodsInfoVCPopActionWithModel:(TemplateModel *)goodsModel andSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    if (goodsModel) {
        if (selectedIndexPath.item == self.floorDataArry.count) {
            [self.floorDataArry addObject:goodsModel];
            [self.floorCollectionView reloadData];
        }else {
            [self.floorDataArry replaceObjectAtIndex:selectedIndexPath.item withObject:goodsModel];
            [self.floorCollectionView reloadItemsAtIndexPaths:@[selectedIndexPath]];
        }

    }
}

#pragma mark - 保存按钮 Action
- (IBAction)saveBtnClick:(UIButton *)sender {
    sender.enabled = NO;
    if ([self.floorNameTF.text isEmpty]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请输入楼层名称"];
        [self.floorNameTF becomeFirstResponder];
        sender.enabled = YES;
        return;
    }
    if (self.floorDataArry.count == 0) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"请添加至少一件商品"];
        sender.enabled = YES;
        return;
    }
    
    PartModel* partModel = [[PartModel alloc] init];
    if (self.isTioYanAccount) {
        partModel.storeId = NoNullStr(AccountInfo.tempStoreId, @"");
    }else {
        partModel.storeId = NoNullStr(AccountInfo.storeId, @"");
    }
    
    partModel.templateModelname = @"楼层";
    partModel.templateModelnameCode = FloorCode;
    partModel.templateNo = self.templateNo;
    //goodsModel如果不存在就是新增数据
    //【注】：模块ID字段，新增和编辑传0，删除传-1
    partModel.id = 0;
    if (!self.goodsModel) {
        
        TemplateModel *templateModel = [[TemplateModel alloc] init];
        NSArray *arr = [NSArray arrayWithArray:self.floorDataArry];
        templateModel.items = arr;
        templateModel.floorCode = self.floorCode;
        templateModel.preCode = self.preCode;
        templateModel.floorName = NoNullStr(self.floorNameTF.text, @"");
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        data.date = @[templateModel];
        partModel.templateModelnameDate = data;
        
    }else{
        
//        TemplateModel *model = [[TemplateModel alloc] init];
        self.goodsModel.items = self.floorDataArry.copy;
        self.goodsModel.floorCode = self.floorCode;
        self.goodsModel.preCode = self.preCode;
        self.goodsModel.floorName = NoNullStr(self.floorNameTF.text, @"");
        
        TemplateModelData* data = [[TemplateModelData alloc] init];
        data.date = @[self.goodsModel];
        partModel.templateModelnameDate = data;
        
    }
    
    NSArray* arr = @[partModel];
    
    WS(weakSelf);
    [self saveTemplte:arr.mutableCopy succeed:^(id responseObject) {
        NSLog(@"---responseObject-->>:%@", responseObject);
//        wSelf.block(model,self.goodsModel ? NO : YES);
        if (self.addNewFloorPopToSendFloorDataBlock) {
            self.addNewFloorPopToSendFloorDataBlock(partModel);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        
    }];
    sender.enabled = YES;
}

#pragma mark - UITextFieldDidChangeNofify
- (void)addNewFloorTextFieldDidChangeAction:(NSNotification *)notifi {
    UITextField *textField = (UITextField *)notifi.object;
    if ([textField isEqual:self.floorNameTF]) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_AddNewFloor_Name)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_AddNewFloor_Name];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_AddNewFloor_Name];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_AddNewFloor_Name)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
}


#pragma mark - getter
- (NSMutableArray *)floorDataArry {
    if (!_floorDataArry) {
        _floorDataArry = [NSMutableArray array];
    }
    return _floorDataArry;
}

- (NSMutableArray *)originImages {
    if (!_originImages) {
        _originImages = [NSMutableArray array];
    }
    return _originImages;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     NSLog(@"已释放-->>:%@", NSStringFromClass([self class]));
}

@end
