//
//  MsgPushModel.h
//  BusinessManager
//
//  Created by KL on 16/7/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseModel.h"
#import "MJExtension.h"

@interface MsgPushModel : BaseModel

@end

//------------------短信彩信推送---------------------//

@interface MsgPushManagerList : BaseModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *msgType;
@property (nonatomic, strong) NSString *msgTypeName;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *sendState;
@property (nonatomic, strong) NSString *sendStateName;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *targetUser;
@property (nonatomic, strong) NSString *targetUserName;
@property (nonatomic, strong) NSString *targetUserNum;

@end

//------------------短信彩信购买记录---------------------//
@interface MsgBuyNotesModel : BaseModel
@property (nonatomic, assign) NSString *Id;
@property (nonatomic, strong) NSString *msgGoodsId;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *totalQuantity;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *localOrderno;
@property (nonatomic, strong) NSString *b2cOrderno;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *msgTitle;

+(MsgBuyNotesModel *)getModelWithDic:(NSDictionary *)dic;
@end

