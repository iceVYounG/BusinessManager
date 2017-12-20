//
//  UnitMetiodManager.h
//  CMCCMall
//
//  Created by user on 14-1-8.
//  Copyright (c) 2014年 cmcc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UniMetiodManagerDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>

/** 调整图片大小 */
UIImage * UIImageScaleToSize(UIImage *img, CGSize size);

//获取字符串高度
float HeightForString(NSString *value,float fontSize,float width);

//获取字符串宽度
float WidthForString(NSString *value,float fontSize,float height);


@class MyCUListItemRsp;
@class PhoneAccountModel;
@class MYTeamInfo;
@interface UnitMetiodManager : NSObject

@property(nonatomic, strong)PhoneAccountModel *accountModel;
@property (strong, nonatomic) NSMutableArray *contactArray;//联系人数组
@property(nonatomic,assign)NSUInteger timeOut;         //订单超时时间
@property(nonatomic,assign)BOOL isLocalSignMember;//开通会员之后需要重新访问初始化接口，该参数自己改动，不是服务器返回

@property(nonatomic,retain)NSString *SELECT_CIYT;  //选择城市
@property(nonatomic,retain)NSString *SELECT_CODE;  //选择城市code
@property(nonatomic,retain)NSString *CITY_CODE;  //320500苏州
@property(nonatomic,retain)NSString *PROVINCE_CODE;//

//另外保存（用来区别与首页）
@property(nonatomic,retain)NSString *CHILD_CITYNAME;
@property(nonatomic,retain)NSString *CHILD_CITYCODE;
@property(nonatomic,retain)NSString *CHILD_PROVINCE_CODE;

@property (strong, nonatomic) NSString *rpUserName; //红包业务目标库用户真实姓名
@property (strong, nonatomic) NSString *rpBalance; //红包业务红包余额
@property (assign, nonatomic) BOOL isExistNewRP; //是否存在新红包
@property (strong, nonatomic) NSString *md39Uid;//39网的userId
@property (strong, nonatomic) MyCUListItemRsp *myCUItem;//默认小区
//@property (strong, nonatomic) MyCUListItemRsp *selectCUItem;//当前选择的小区

@property (strong, nonatomic) MYTeamInfo *teamInfoRsp;//首页我的战队数据模型


@property (assign, nonatomic)float totalFlow;//总流量
@property (assign, nonatomic)float useFlow;//已用流量;
- (NSString *) showExistFlow;//展示剩余流量
- (NSString *) showUsedFlow;//展示已用流量

@property (assign, nonatomic) NSInteger cartCount; //购物车数量

- (BOOL) isUserSelectJSProvince;

- (BOOL) isUserSelectSZCity;


@property(nonatomic,retain)NSString *UUID;         //保存uuid



@property(assign)BOOL isFirstLoadApp;//记录是否第一次登陆app
@property(assign)BOOL showMainTitleView;//记录是否显示mainTitleView

//@property(nonatomic,strong)  *navc;//网络断开情况下 返回上一页的navc
@property(nonatomic, assign)id<UniMetiodManagerDelegate> delegate;


+(UnitMetiodManager*)share;

//判断接口返回字段是否存在值
+ (BOOL)exitTheValueWithTheDiction:(NSDictionary *)dic withKey:(NSString *)key;

//把返回字段转换成string类型
+ (NSString *)exchangeTheReturnValueToString:(id)value;

/**
    @brief 判断返回字段换成string类型后是否和@“”相等
 
 */

+(BOOL)compareReturnStringWith:(NSString *)returnStr;

/**
 *  判断返回数组是否有效，无效转换为[NSArry array]
 *
 *  @param value 服务器返回数组
 *
 *  @return 有效数组
 */
+ (NSArray *)exchangeTheReturnValueToArray:(id)value;

// 判断是不是苏州号码
+(BOOL)ifSuZhouMobile;

- (PhoneAccountModel *)getTheUserInfoPayInfomaton;

-(void)reGetTheUserInfoPayInfomaton;

/**
 *  退出登录的时候删除用的话费流量等信息
 */
-(void)removeAllInfoPayInfomation;


//存放订单超时时间
- (void)setTheOrederTimeOut:(NSUInteger)tOut;

//获取订单超时时间
- (NSString *)getTheOrderTimeOut:(NSUInteger)time;

- (void)Shake:(UIView *)aView;

//获取uuid
- (NSString *)getChainkey;

//用户手机号展示
- (NSString *)showTheUserPhoneNumber;
- (NSString *)showPhoneNumberWithNumString:(NSString *)numberString;

-(NSMutableArray *)parseH5Url:(NSString *)h5Url;


/**
 *  本地保存AddressId
 */
- (void)saveTheAddressKeyWith:(NSString *)addressId;
- (void)removeTheLocalAddressKey;
- (NSString *)getTheLocalAddressKey;

+ (void)saveShowGuideKey:(BOOL)isShow;
+ (BOOL)getShowGuideKey;

- (void)saveTheHYITKey:(BOOL)isAutoLogin;
- (BOOL)getTheLocalHYITKey;

//判断是否自动登录
- (void)saveTheIsAutoLoginKey:(BOOL)isAutoLogin;
- (BOOL)getTheLocalIsAutoLoginKey;


//判断是否进入过附近
- (void)saveTheIntoNearByKey:(BOOL)isInto;
- (BOOL)getTheIntoNearByKey;


//判断团购支付方式：积分
- (BOOL)isSupportScorePay;

//判断当前账号是否是移动账号
- (BOOL)isChinaMobileNumber;
- (BOOL)isJiangXiChinaMobileNumber;
- (BOOL)isJiangSuChinaMobileNumber;
//判断当前账号是否是付费会员
- (BOOL)isChargeMember;
//判断当前账号是否是会员
- (BOOL)isMember;
+(NSString*)getChineseCalendarWithDate:(NSDate *)date;
+(NSString *)getLunarSpecialDate:(int)iYear Month:(int)iMonth Day:(int)iDay;

//点击判断是否绑定手机号（移动，联通，电信手机号都包括）
- (BOOL)isLinkPhoneNumber;

//拨打电话
- (void)callTheSystemTelephone:(NSString *)telNum;

//过滤html标签
- (NSString *)flattenHTML:(NSString *)html;

//显示特殊数量
- (NSString *)showSpecialCountWithCount:(NSInteger)count;
 
-(NSString *)getCurrentTime;

- (NSString *)getWeekDayWithDate:(NSDate *)date;

- (NSDate *)switchStringToDateWithString:(NSString *)dateStr;
- (NSString *)switchDateToStringWithDate:(NSDate *)date type:(NSInteger)type;
@end
