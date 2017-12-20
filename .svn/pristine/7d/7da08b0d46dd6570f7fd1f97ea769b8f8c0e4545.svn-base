//
//  flowCountVC.m
//  BusinessManager
//
//  Created by 张心亮 on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG


#define tableViewCellHeight 48

#import "flowCountVC.h"
#import "billTopCell.h"
#import "dataCountModel.h"
#import "WeiZhanModel.h"
#import "BEMSimpleLineGraphView.h"
#import "Masonry.h"
#import "UIScrollView+EmptyDataSet.h"

@interface flowCountVC ()<UITableViewDelegate, UITableViewDataSource, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource> {
    
    NSMutableArray *dayArr;
}

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *visitorNumber;
@property (weak, nonatomic) IBOutlet UILabel *visitorPercent;
@property (weak, nonatomic) IBOutlet UILabel *lookNumber;
@property (weak, nonatomic) IBOutlet UILabel *lookPercent;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lineViews;
//@property (strong,nonatomic)NSMutableArray *rightArr;
@property (strong,nonatomic)UITableView *dropTableView;
@property (strong,nonatomic)NSMutableArray *leftArr;
@property (assign,nonatomic)BOOL isLeftTableView;
@property (strong,nonatomic)UIView *mengBanView;
@property (weak, nonatomic) IBOutlet UIImageView *visitorImage;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels2;

@property (weak, nonatomic) IBOutlet UIImageView *lookImage;
@property (weak, nonatomic) IBOutlet UILabel *chageLabel;
@property (assign,nonatomic)NSString *days;

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *chartView;     //图表视图
@property (nonatomic, strong) NSMutableArray *dataArray1;  //图表数据
@property (nonatomic, assign) BOOL isPVShow;       //当前是否展示PV，否则展示UV
@property (nonatomic, strong) NSDateFormatter *inputFormat;
@property (nonatomic, strong) NSDateFormatter *outputFormat;
@property (nonatomic, assign) BOOL isNetWorkAvailable;//网络是否通畅
@property (nonatomic, assign) BOOL isGetRightData;//是否未获取到正常的数据 flag != 00-00

@property (nonatomic, strong) NSMutableArray *templateArry;//模板数据

@property (weak, nonatomic) IBOutlet UIButton *leftChangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightChangeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *lookUpDownImg;
@property (weak, nonatomic) IBOutlet UIImageView *visitorUpDownImg;

@property (nonatomic, assign) NSInteger leftSelectedRow;    //选中的行
@property (nonatomic, assign) NSInteger rightSelectedRow;    //选中的行
//*******模板编码(非必须)： ws001-电商模版 ws002-4S店模版 ws003-餐饮模版 ws004-家装模板 ws005-房产模板
//@property (nonatomic, strong) NSMutableArray *rightTemplateNoArr;   //右边模板编码

@end


@implementation flowCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流量统计";
//    [self requestMyWeiZhanDatas:@"7"];
    self.isNetWorkAvailable = YES;
    self.isGetRightData = NO;
    self.rightSelectedRow = 0;
    [self initView];
    
    
}
-(void)initView {

     dayArr=[NSMutableArray arrayWithObjects:@"7",@"30", nil];
    //选择按钮文字偏移
    _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _isLeftTableView=YES;
//    _leftArr=[NSMutableArray arrayWithObjects:@"最近7日",@"最近30日", nil];
//    _rightArr=[NSMutableArray arrayWithObjects:@"全部",@"小区商户",@"4s",@"餐饮",@"家装",@"房产", nil];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f6f5fa"];
    _dropTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _dropTableView.delegate=self;
    _dropTableView.dataSource=self;
    _dropTableView.emptyDataSetDelegate = self;
    _dropTableView.emptyDataSetSource = self;
    _dropTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    for (UIView *view in _lineViews) {
//        view.backgroundColor=[UIColor colorWithHexString:@"#dadada"];
//    }
    
    _mengBanView=[[UIView alloc]initWithFrame:CGRectZero];
    [_mengBanView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mengBanTappedAction:)];
    [_mengBanView addGestureRecognizer:tapped];
    for (UILabel *label in _labels) {
        label.textColor=[UIColor colorWithHexString:@"#333333"];
    }
    for (UILabel *label in _labels2) {
        label.textColor=[UIColor colorWithHexString:@"#666666"];
    }
    
    
    _visitorNumber.textColor=[UIColor colorWithHexString:@"#999999"];
    _lookNumber.textColor=[UIColor colorWithHexString:@"#999999"];
    
    _visitorPercent.textColor=[UIColor colorWithHexString:@"#f54545"];
    _lookPercent.textColor=[UIColor colorWithHexString:@"#0f990f"];
    
    _chageLabel.textColor=[UIColor colorWithHexString:@"#333333"];
    
    //initView
    self.lookUpDownImg.image = nil;
    self.visitorUpDownImg.image = nil;
    self.lookPercent.text = @"";
    self.visitorPercent.text = @"";
    self.leftChangeBtn.enabled = NO;
    self.rightChangeBtn.enabled = NO;
    self.rightSelectedRow = 0;
    self.leftSelectedRow = 0;
    
    //chartView
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    //渐变
    self.chartView.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);

    // Enable and disable various graph properties and axis displays
    self.chartView.enableTouchReport = NO;
    self.chartView.enablePopUpReport = YES;
    self.chartView.enableYAxisLabel = YES;
    self.chartView.autoScaleYAxis = YES;
    self.chartView.alwaysDisplayDots = NO;
    self.chartView.enableReferenceXAxisLines = YES;
    self.chartView.enableReferenceYAxisLines = YES;
    self.chartView.enableReferenceAxisFrame = YES;
//    self.chartView.alwaysDisplayPopUpLabels = YES;

    // Draw an average line
    //平均线
//    self.chartView.averageLine.enableAverageLine = YES;
//    self.chartView.averageLine.alpha = 0.6;
//    self.chartView.averageLine.color = [UIColor darkGrayColor];
//    self.chartView.averageLine.width = 2.5;
//    self.chartView.averageLine.dashPattern = @[@(2),@(2)];

    // Set the graph's animation style to draw, fade, or none
    self.chartView.animationGraphStyle = BEMLineAnimationDraw;

//    // Dash the y reference lines
    self.chartView.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.chartView.formatStringForValues = @"%.f";
    
    self.chartView.colorTouchInputLine = [UIColor redColor];
    self.chartView.widthTouchInputLine = 2.0;
    //请求数据
    [self requestMyWeiZhanDatas:@"7"];
    //请求模板数据
    [self requestMuBanNameData];
    
}

- (NSMutableArray *)leftArr {
    if (!_leftArr) {
        _leftArr = [NSMutableArray arrayWithObjects:@"最近7日",@"最近30日", nil];
    }
    return _leftArr;
}

//- (NSMutableArray *)rightArr {
//    if (!_rightArr) {
//        _rightArr = [NSMutableArray arrayWithObjects:@"全部",@"小区商户",@"4s",@"餐饮",@"家装",@"房产", nil];
//    }
//    return _rightArr;
//}

//- (NSMutableArray *)rightTemplateNoArr {
//    if (!_rightTemplateNoArr) {
//        _rightTemplateNoArr = [NSMutableArray arrayWithObjects:@"",@"ws001",@"ws002",@"ws003",@"ws004",@"ws005", nil];
//    }
//    return _rightTemplateNoArr;
//}

//模板数据
- (void)setTemplateArry:(NSMutableArray *)templateArry {
    if (templateArry.count == 0) {
        _templateArry = templateArry;
    }else {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < templateArry.count; i++) {
            MyWeiZhanModel *itemModel = [templateArry objectAtIndex:i];
            if (i == 0) {
                MyWeiZhanModel *model = [[MyWeiZhanModel alloc] init];
                model.shopName = @"全部";
                model.templateNo = @"";
                [arr addObject:model];
            }
            [arr addObject:itemModel];
        }
        _templateArry = arr.mutableCopy;
    }
}

#pragma mark - 请求

-(void)requestMyWeiZhanDatas:(NSString *)days{
    NSLog(@"%@",days);
    NSInteger day = [days integerValue];
//    NSString *templateNo = [self.rightTemplateNoArr objectAtIndex:self.rightSelectedRow];
    MyWeiZhanModel *model = [self.templateArry objectAtIndex:self.rightSelectedRow];
    NSString *templateNo = model.templateNo;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];  //商户ID
    [params setObject:NoNullStr(templateNo, @"") forKeyedSubscript:@"templateNo"];
    [params setObject:@(day) forKey:@"days"];
    [params setObject:@(1) forKey:@"dateType"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请稍等..."];
    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_flowCount Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        if (Succeed(dic)) {
            [SVProgressHUD dismiss];
            
            self.dataArray1 = [NSMutableArray array];
            DCFlowCountMainModel *mainModel = [DCFlowCountMainModel mj_objectWithKeyValues:dic];
            self.dataArray1 = mainModel.data.mutableCopy;
//            NSLog(@"------total-->>>%@",mainModel.total);
//            NSLog(@"-----data-->>%@",mainModel.data);
            
            //refresh
            [self refreshUIData:mainModel.total];
            self.chartView.animationGraphStyle = BEMLineAnimationDraw;
            [self.chartView reloadGraph];
            
        }
        else{
            
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试！"];
            
        }
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showErrorWithStatus:@"服务器繁忙，请稍后再试！"];

    }];
    
}
#pragma mark - 获取模板数据
- (void)requestMuBanNameData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    
    [[MallNetManager share] request:API_Storecenter prams:params succeed:^(id responseObject) {
//        NSDictionary *dic = [responseObject responseDecodeToDic];
        MyWeiZhans *rsp = [MyWeiZhans mj_objectWithKeyValues:responseObject];
        if (rsp) {
            self.isGetRightData = YES;
        }else {
            self.isGetRightData = NO;
        }
        self.templateArry = rsp.data.mutableCopy;
        [_dropTableView reloadEmptyDataSet];
    } showHUD:YES];
    
}



- (IBAction)leftBtn:(id)sender {
    [_dropTableView removeFromSuperview];
    _isLeftTableView=YES;
    _dropTableView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_SIZE.width, self.leftArr.count*tableViewCellHeight);
    [self.view addSubview:_dropTableView];
    [_dropTableView reloadData];
    
    _mengBanView.frame = CGRectMake(0, CGRectGetMaxY(_dropTableView.frame), SCREEN_SIZE.width, 1000);
    _mengBanView.alpha = 1.0;
    [self.view addSubview:_mengBanView];
}

- (IBAction)rightBtn:(id)sender {
    [_dropTableView removeFromSuperview];
    _isLeftTableView = NO;
    CGFloat height;
    if (self.templateArry.count > 0) {
        height = self.templateArry.count > 6 ? 288.0 : self.templateArry.count * tableViewCellHeight;
    }else {
        height = 144.0;
    }
    _dropTableView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_SIZE.width, height);
    [self.view addSubview:_dropTableView];
    [_dropTableView reloadData];
    
    _mengBanView.frame=CGRectMake(0, CGRectGetMaxY(_dropTableView.frame), SCREEN_SIZE.width, 1000);
    _mengBanView.alpha = 1.0;
    [self.view addSubview:_mengBanView];
}
- (IBAction)leftChangeAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.isPVShow = !self.isPVShow;
        btn.enabled = NO;
        self.rightChangeBtn.enabled = NO;
        self.rightChangeBtn.selected = NO;
        [btn setTintColor:[UIColor lightGrayColor]];
        [self.rightChangeBtn setTintColor:[UIColor darkGrayColor]];
        CGRect oldFrame = self.chageLabel.frame;
        CGRect new1Frame;
        new1Frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y - 15.0, oldFrame.size.width, oldFrame.size.height);
        CGRect new2Frame;
        new2Frame = CGRectMake(new1Frame.origin.x, new1Frame.origin.y + 35.0, new1Frame.size.width, new1Frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.chageLabel.frame = new1Frame;
            self.chageLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                if (self.isPVShow) {
                    self.chageLabel.text = @"浏览量";
                }else {
                    self.chageLabel.text = @"访客数";
                }
                
                self.chageLabel.frame =new2Frame;
                [UIView animateWithDuration:0.2 animations:^{
                    self.chageLabel.frame = oldFrame;
                    self.chageLabel.alpha = 1.0;
                    self.rightChangeBtn.enabled = YES;
                }];
                
            }
            
        }];
        
        self.chartView.animationGraphStyle = BEMLineAnimationFade;
        [self.chartView reloadGraph];
        
    }
    
}

- (IBAction)rightChangeAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.isPVShow = !self.isPVShow;
        btn.enabled = NO;
        self.leftChangeBtn.enabled = NO;
        self.leftChangeBtn.selected = NO;
        [btn setTintColor:[UIColor lightGrayColor]];
        [self.leftChangeBtn setTintColor:[UIColor darkGrayColor]];
        
        CGRect oldFrame = self.chageLabel.frame;
        CGRect new1Frame;
        new1Frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y - 15.0, oldFrame.size.width, oldFrame.size.height);
        CGRect new2Frame;
        new2Frame = CGRectMake(new1Frame.origin.x, new1Frame.origin.y + 35.0, new1Frame.size.width, new1Frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.chageLabel.frame = new1Frame;
            self.chageLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                if (self.isPVShow) {
                    self.chageLabel.text = @"浏览量";
                }else {
                    self.chageLabel.text = @"访客数";
                }
                
                self.chageLabel.frame =new2Frame;
                [UIView animateWithDuration:0.2 animations:^{
                    self.chageLabel.frame = oldFrame;
                    self.chageLabel.alpha = 1.0;
                    self.leftChangeBtn.enabled = YES;
                }];
                
            }
            
        }];

        
        self.chartView.animationGraphStyle = BEMLineAnimationFade;
        [self.chartView reloadGraph];
    }
}


- (void)mengBanTappedAction:(UIGestureRecognizer *)touch {
    CGRect oldFrame = _dropTableView.frame;
    if (touch.numberOfTouches == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            _mengBanView.alpha = 0.0;
            _dropTableView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, 0);
        } completion:^(BOOL finished) {
            [_mengBanView removeFromSuperview];
            [_dropTableView removeFromSuperview];
        }];
    }
}

#pragma mark - RefreshUIData 

- (void)refreshUIData:(DCFlowCountTotalModel *)model {
    self.leftChangeBtn.enabled = YES;
    self.rightChangeBtn.enabled = YES;
    self.visitorNumber.text = model.uvTotal;
    self.visitorPercent.text = [NSString stringWithFormat:@"%@%%", model.uvTotalUp];
    self.lookNumber.text = model.pvTotal;
    self.lookPercent.text = [NSString stringWithFormat:@"%@%%", model.pvTotalUp];
    
    if ([model.uvTotalUp floatValue] < 0) {
        self.visitorUpDownImg.image = [UIImage imageNamed:@"DataCount_jianArrow.png"];
        self.visitorPercent.textColor = [UIColor colorWithHexString:@"#0F990F"];
    }else if ([model.uvTotalUp floatValue] > 0) {
        self.visitorUpDownImg.image = [UIImage imageNamed:@"DataCount_addArrow.png"];
        self.visitorPercent.textColor = [UIColor colorWithHexString:@"#F54545"];
    }else {
        self.visitorUpDownImg.image = nil;
        self.visitorPercent.textColor = [UIColor colorWithHexString:@"#F54545"];
    }
    
    if ([model.pvTotalUp floatValue] < 0) {
        self.lookUpDownImg.image = [UIImage imageNamed:@"DataCount_jianArrow.png"];
        self.lookPercent.textColor = [UIColor colorWithHexString:@"#0F990F"];
    }else if ([model.pvTotalUp floatValue] > 0) {
        self.lookUpDownImg.image = [UIImage imageNamed:@"DataCount_addArrow.png"];
        self.lookPercent.textColor = [UIColor colorWithHexString:@"#F54545"];
    }else {
        self.lookUpDownImg.image = nil;
        self.lookPercent.textColor = [UIColor colorWithHexString:@"#F54545"];
    }
    
}

#pragma mark - UITableViewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isLeftTableView) {
        return self.leftArr.count;
    }
    
    return self.templateArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"billTopCell";
    billTopCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isLeftTableView) {
         cell.cellLabel.text=[self.leftArr objectAtIndex:indexPath.row];
        if (self.leftSelectedRow == indexPath.row) {
            cell.cellLabel.textColor = [UIColor colorWithHexString:@"#00AAEE"];
            cell.rightImage.image = [UIImage imageNamed:@"DataCount_checkMark.png"];
        }else {
            cell.rightImage.image = nil;
            cell.cellLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        }
    }
    else
    {
//        cell.cellLabel.text=[self.rightArr objectAtIndex:indexPath.row];
        MyWeiZhanModel *itemModel = [self.templateArry objectAtIndex:indexPath.row];
        cell.cellLabel.text = itemModel.shopName;
        if (self.rightSelectedRow == indexPath.row) {
            cell.cellLabel.textColor = [UIColor colorWithHexString:@"#00AAEE"];
            cell.rightImage.image = [UIImage imageNamed:@"DataCount_checkMark.png"];
        }else {
            cell.rightImage.image = nil;
            cell.cellLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        }
    }

    
    return cell;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableViewCellHeight;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isLeftTableView) {

        [self requestMyWeiZhanDatas:dayArr[indexPath.row]];
        self.leftSelectedRow = indexPath.row;
        
    }
    else{
        
        self.rightSelectedRow = indexPath.row;
        [self requestMyWeiZhanDatas:dayArr[self.leftSelectedRow]];
    
    }
    
    billTopCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = !cell.selected;
    
    if (_isLeftTableView) {
        NSString *leftStr = [self.leftArr objectAtIndex:indexPath.row];
        [_leftBtn setTitle:leftStr forState:UIControlStateNormal];
    }else {
//        NSString *rightStr = [self.rightArr objectAtIndex:indexPath.row];
        MyWeiZhanModel *model = [self.templateArry objectAtIndex:indexPath.row];
        [_rightBtn setTitle:model.shopName forState:UIControlStateNormal];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    CGRect oldFrame = _dropTableView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        _mengBanView.alpha = 0.0;
        _dropTableView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, 0);
    } completion:^(BOOL finished) {
        [_mengBanView removeFromSuperview];
        [_dropTableView removeFromSuperview];
    }];

}

#pragma mark - BEMSimpleLineGraphDataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.dataArray1.count;
}


- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    DCFlowCountItemModel *model = [self.dataArray1 objectAtIndex:index];
    if (self.isPVShow) {    //流浪量
        return model.pv;
    }
    return model.uv;        //访客数
}


#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    if (self.dataArray1.count > 8) {
        return 3;
    }
    return 1;
}

- (NSString *)lineGraph:(nonnull BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    DCFlowCountItemModel *model = [self.dataArray1 objectAtIndex:index];
    return [self tramsformDateToFormatStr:model.dateTime];
}


//- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
//    self.labelValues.text = [NSString stringWithFormat:@"%@", [self.arrayOfValues objectAtIndex:index]];
//    self.labelDates.text = [NSString stringWithFormat:@"in %@", [self labelForDateAtIndex:index]];
//}
//
//- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.labelValues.alpha = 0.0;
//        self.labelDates.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//        self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
//        
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.labelValues.alpha = 1.0;
//            self.labelDates.alpha = 1.0;
//        } completion:nil];
//    }];
//}
//
//- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
//    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
//}
//
///* - (void)lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph {
// // Use this method for tasks after the graph has finished drawing
// } */
//
//- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
//
//    if (self.isPVShow) {    //流浪量
//        return @" PV";
//    }
//    return @" UV";          //访客数
//}

#pragma mark - DNZEmptyDataSource / delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *errorStr;
    if (self.isGetRightData) {
        if (self.templateArry.count == 0) {
            errorStr = @"暂无数据";
        }
    }else {
        errorStr = @"获取数据失败,请检查网络设置";
    }
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    NSAttributedString *errorAttribute = [[NSAttributedString alloc] initWithString:errorStr attributes:attribute];
    return errorAttribute;
}

#pragma mark - 日期格式转换  20160812 --> 8-12

- (NSDateFormatter *)inputFormat {
    if (!_inputFormat) {
        _inputFormat = [[NSDateFormatter alloc] init];
        [_inputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_inputFormat setLocale:[NSLocale currentLocale]];
        [_inputFormat setDateFormat:@"yyyyMMdd"];
        [_inputFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    }
    return _inputFormat;
}

- (NSDateFormatter *)outputFormat {
    if (!_outputFormat) {
        _outputFormat = [[NSDateFormatter alloc] init];
        [_outputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_outputFormat setLocale:[NSLocale currentLocale]];
        [_outputFormat setDateFormat:@"M-d"];
        [_outputFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    }
    return _outputFormat;
}


- (NSString *)tramsformDateToFormatStr:(NSString *)dateStr {
    //将字符串 转为 日期
//    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
//    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [dateFormat1 setLocale:[NSLocale currentLocale]];
//    [dateFormat1 setDateFormat:@"yyyyMMdd"];
//    [dateFormat1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    //将日期 转为 指定格式
//    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
//    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [dateFormat2 setLocale:[NSLocale currentLocale]];
//    [dateFormat2 setDateFormat:@"M-d"];
//    [dateFormat2 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSDate *date1 = [self.inputFormat dateFromString:dateStr];
    NSString *time = [self.outputFormat stringFromDate:date1];

    return time;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
