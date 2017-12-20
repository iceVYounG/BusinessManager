//
//  CreateActivityVC.m
//  BusinessManager
//
//  Created by smile apple on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "CreateActivityVC.h"
#import "AddMarketACtivityVC.h"
#import "MPChooseUserTypeView.h"
#import "UUDatePicker.h"

//textField 活动名称
#define MAX_STARWORDS_LENGTH_TEXTFIELD 20

@interface CreateActivityVC ()<UUDatePickerDelegate,UITextFieldDelegate>

@end

@implementation CreateActivityVC{
    
//    UITextField *textField;
    UITextField *SpecifiedTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f5fa"];
    
    self.nextBtn.layer.cornerRadius = 4;
    self.title = @"新增营销活动";

    self.activityNameTF.delegate = self;
    self.luckyTimesTF.delegate = self;
    self.effectDaysTF.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CreateActivity_textFieldEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:self.activityNameTF];
    
    
    NSDate *now = [NSDate date];
    NSArray *txfAry = @[self.beginTimeTF,self.endTimeTF];
   
    for (int i = 0; i<txfAry.count; i++)
    {
        UITextField *txfild = txfAry[i];
        UUDatePicker *datePicker
        = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.view.frame.size.width, 216)
                                 PickerStyle:0
                                 didSelected:^(NSString *year,
                                               NSString *month,
                                               NSString *day,
                                               NSString *hour,
                                               NSString *minute,
                                               NSString *second,
                                               NSString *weekDay) {
                                     switch (i) {
                                         case 0:
                                              txfild.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,minute,second];
                                             break;
                                          case 1:
                                               txfild.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,minute,second];
                                             break;
                                             
                                         default:
                                             break;
                                     }
                                    
                                 }];
//        if (txfild == self.beginTimeTF) {
//            datePicker.minLimitDate = [[NSDate date]dateByAddingTimeInterval:-2222];
////            datePicker.minLimitDate = now;
//        }
//        if (txfild == self.endTimeTF) {
//            datePicker.minLimitDate = now;
//        }
        
        txfild.inputView = datePicker;
    }
    
    //delegate
    UUDatePicker *datePick= [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.view.frame.size.width, 216)
                                                        Delegate:self
                                                     PickerStyle:UUDateStyle_YearMonthDayHourMinuteSecond];
    datePick.ScrollToDate = now;
    
    SpecifiedTime.inputView = datePick;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField isEqual:self.activityNameTF]) {
        
        if (textField.text.length > 19) {
            return NO;
        }else {
            return YES;
        }
        
    }else if ([textField isEqual:self.luckyTimesTF]){
        if (textField.text.length > 5) {
            return NO;
        }else{
            return YES;
        }
        
    }else if ([textField isEqual:self.effectDaysTF]) {
        
        if (textField.text.length > 2) {
            return NO;
        }
        if ([self.effectDaysTF.text hasPrefix:@"0"]) {
            return NO;
        }
        if ([string isValidateNumber]) {
            return YES;
        }else {
            return NO;
        }
    }
    return YES;
}



#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
              second:(NSString *)second
             weekDay:(NSString *)weekDay
{
    SpecifiedTime.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,minute,second];
    
}


//hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


//点击下一步
- (IBAction)goToAddMacket:(id)sender {
    
    if (![self.beginTimeTF.text isEqualToString:@""]&&![self.endTimeTF.text isEqualToString:@""]) {

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:self.beginTimeTF.text];
        
        NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
        if ([date earlierDate:[dateFormatter dateFromString:currentDate]] == date) {
            [OMGToast showWithText:@"开始时间不能小于当前时间"];
            return;
        }
        
        if ([date laterDate:[dateFormatter dateFromString:self.endTimeTF.text]]== date) {
            [OMGToast showWithText:@"结束时间不能小于开始时间"];

        }else{
            if ([self.activityNameTF.text isEqualToString:@""]||[self.luckyTimesTF.text isEqualToString:@""] || [self.effectDaysTF.text isEqualToString:@""] || [self.userBtn.titleLabel.text isEqualToString:@"请选择活动目标用户"]) {
                  [OMGToast showWithText:@"请将信息填写完整"];
            }else{
                [self saveInfo];
            }
          
            
           
        }
    }else{
        
        if ([self.activityNameTF.text isEqualToString:@""] || [self.beginTimeTF.text isEqualToString:@""] || [self.endTimeTF.text isEqualToString:@""] || [self.luckyTimesTF.text isEqualToString:@""] || [self.effectDaysTF.text isEqualToString:@""] || [self.userBtn.titleLabel.text isEqualToString:@"请选择活动目标用户"]) {
            
            [OMGToast showWithText:@"请将信息填写完整"];
            
        }else{
            [self saveInfo];
        }
        
    }
 
}

//选择活动目标用户
- (IBAction)selectUserBtn:(id)sender {
    WS(weakSelf);
    MPChooseUserTypeView *view = [[MPChooseUserTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) type:AllUserShow WithBlock:^(NSString *userType, NSString *userNum) {
        
        [weakSelf.userBtn setTitle:userType forState:UIControlStateNormal];
        [weakSelf.userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    
    [view show];
    
}

//下一步，配置奖品信息请求接口
- (void)saveInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [params setObject:self.activityNameTF.text forKey:@"name"];
    [params setObject:[self datetimeFormat:self.beginTimeTF.text] forKey:@"startTime"];
    [params setObject:[self datetimeFormat:self.endTimeTF.text] forKey:@"endTime"];
    [params setObject:self.luckyTimesTF.text forKey:@"singleDrawNum"];
    [params setObject:NoNullStr(AccountInfo.storeId, @"") forKey:@"storeId"];
    [params setObject:self.effectDaysTF.text forKey:@"useDays"];
    if ([self.userBtn.titleLabel.text isEqualToString:@"所有用户"]) {
        [params setObject:@"白银" forKey:@"memberType"];
    }else{
        [params setObject:self.userBtn.titleLabel.text forKey:@"memberType"];
    }

    [[MallNetworkEngine loginshare] requestNotEncodeWithDate:self.requestDate requestWithPath:API_LuckDraw_Activitysave Params:params CompletionHandler:^(MKNetworkOperation *completedOperation) {
      
        NSDictionary *dic = [completedOperation responseDecodeToDic];
        NSLog(@"--------- %@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"00-00"]) {
            AddMarketACtivityVC *avc = [[AddMarketACtivityVC alloc]initWithNibName:@"AddMarketACtivityVC" bundle:nil];
            avc.activityName  = self.activityNameTF.text;
            avc.startTime     = [self datetimeFormat:self.beginTimeTF.text];
            avc.endTime       = [self datetimeFormat:self.endTimeTF.text];
            avc.singleDrawNum = self.luckyTimesTF.text;
            avc.useDays       = self.effectDaysTF.text;
            avc.memberType    = self.userBtn.titleLabel.text;
            avc.ID            = [[dic objectForKey:@"data"]objectForKey:@"id"];
            
            [self.navigationController pushViewController:avc animated:YES];
        }
        else if ([[dic objectForKey:@"code"] isEqualToString:@"02-05"]) {
            [OMGToast showWithText:@"活动名称已存在"];
        }
        else if ([[dic objectForKey:@"code"] isEqualToString:@"04-05"]){
            [OMGToast showWithText:@"请输入有效数字"];
        }
        
    } ErrorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器忙，请稍候再试"];
      
        
    }];
    
}

//时间转换
- (NSString *)datetimeFormat:(NSString *)time{
    NSString *str      = [time substringToIndex:10];
    NSString *yearStr  = [str substringToIndex:4];
    NSString *monthStr = [str substringWithRange:NSMakeRange(5, 2)];
    NSString *dayStr   = [str substringFromIndex:8];
    
    
    NSString *timeStr   = [time substringFromIndex:11];
    NSString *hourStr   = [timeStr substringToIndex:2];
    NSString *minuteStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    NSString *secondStr = [timeStr substringFromIndex:6];
    
    NSString *strTime=[NSString stringWithFormat:@"%@%@%@%@%@%@",yearStr,monthStr,dayStr,hourStr,minuteStr,secondStr];
    
    return strTime;
    
}

-(void)CreateActivity_textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    if ([textField isEqual:self.activityNameTF]) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH_TEXTFIELD)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH_TEXTFIELD];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH_TEXTFIELD];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH_TEXTFIELD)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
