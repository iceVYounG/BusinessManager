//
//  BuyNotesTableViewCell.m
//  BusinessManager
//
//  Created by 周迎春 on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BuyNotesTableViewCell.h"

@implementation BuyNotesTableViewCell

- (void)setModel:(MsgBuyNotesModel *)model{
    _model = model;
    
    self.orderNumLB.text = [NSString stringWithFormat:@"%@",model.b2cOrderno];
    self.goodsContentLB.text = [NSString stringWithFormat:@"%@",model.msgTitle];
    self.goodsPriceLB.text = [NSString stringWithFormat:@"%@",model.amount];
//    self.buyTimeLB.text = [NSString stringWithFormat:@"%@",model.createTime];
    //拼接时间
//    NSString *yearStr = [model.createTime substringWithRange:(NSMakeRange(0, 4))];
//    NSString *monthStr = [model.createTime substringWithRange:NSMakeRange(4, 2)];
//    NSString *dayStr = [model.createTime substringWithRange:NSMakeRange(6, 2)];
//    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:yearStr,monthStr,dayStr,nil];
//    NSString *timeStr1 =[arr1 componentsJoinedByString:@"-"];
//    
//    NSString *hourStr = [model.createTime substringWithRange:NSMakeRange(8, 2)];
//    NSString *minStr = [model.createTime substringWithRange:NSMakeRange(10, 2)];
//    NSString *secStr = [model.createTime substringWithRange:NSMakeRange(12, 2)];
//    NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:hourStr,minStr,secStr,nil];
//    NSString *timeStr2 =[arr2 componentsJoinedByString:@":"];
//    self.buyTimeLB.text = [timeStr1 stringByAppendingString:[NSString stringWithFormat:@" %@",timeStr2]];
    self.buyTimeLB.text = [self tramsforTimeFormat:model.createTime];

}

- (NSString *)tramsforTimeFormat:(NSString *)timeStr {
    NSDate *time = [self.inputFormat dateFromString:timeStr];
    NSString *formatTime = [self.outputFormat stringFromDate:time];
    return formatTime;
}

- (NSDateFormatter *)inputFormat {
    if (!_inputFormat) {
        _inputFormat = [[NSDateFormatter alloc] init];
//        [_inputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_inputFormat setDateFormat:@"yyyyMMddHHmmss"];
    }
    return _inputFormat;
}

- (NSDateFormatter *)outputFormat {
    if (!_outputFormat) {
        _outputFormat = [[NSDateFormatter alloc] init];
//        [_inputFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_outputFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _outputFormat;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
