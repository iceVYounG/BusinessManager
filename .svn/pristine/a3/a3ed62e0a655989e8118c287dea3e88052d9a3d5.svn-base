//
//  StringHelper.h
//  PTLog
//
//  Created by Ellen Miner on 1/2/09.
//  Copyright 2009 RaddOnline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (StringHelper)

+ (NSString *)filterIllegalString:(NSString *)string;
+ (NSString *)filterTheHtmlFromfahterString:(NSString *)string;
+ (NSArray *)filterTheImageUrlArrFromFatherString:(NSString *)string;
/*过滤掉字符串后面拼接<img src=的文本*/
+ (NSString *)WZ_FloorFilterDescribeTextFromContent:(NSString *)content;
/*取出content中拼接的图片地址*/
+ (NSArray *)WZ_NewFloorFilterTheImageUrlArrFromFatherString:(NSString *)string;
/*
- (UILabel *)RAD_newSizedCellLabelWithSystemFontOfSize:(CGFloat)size;
- (void)RAD_resizeLabel:(UILabel *)aLabel WithSystemFontOfSize:(CGFloat)size;
*/

- (NSString *) baseHexEncode;
- (NSString *) baseHexDecode;

- (NSString *) fromHex; 
- (NSString *) toHex;

- (NSString *) md5;
- (NSString *) trim;
- (NSInteger) length2;


- (NSString *) documentPath;


//@interface NSString (NSString_JavaAPI)
- (NSInteger) compareTo: (NSString*) comp;
- (NSInteger) compareToIgnoreCase: (NSString*) comp;
- (bool) contains: (NSString*) substring;
- (bool) endsWith: (NSString*) substring;
- (bool) startsWith: (NSString*) substring;
- (NSInteger) indexOf: (NSString*) substring;
- (NSInteger) indexOf:(NSString *)substring startingFrom: (NSInteger) index;
- (NSInteger) lastIndexOf: (NSString*) substring;
- (NSInteger) lastIndexOf:(NSString *)substring startingFrom: (NSInteger) index;
- (NSString*) substringFromIndex:(NSInteger)from toIndex: (NSInteger) to;
- (NSArray*) split: (NSString*) token;
- (NSString*) replace: (NSString*) target withString: (NSString*) replacement;
- (NSArray*) split: (NSString*) token limit: (NSInteger) maxResults;


//@interface NSString(MPTidbits)

- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)stringByTrimmingWhitespace;


//custom
-(BOOL)isEmail;
- (BOOL)isMobileNumber;
-(BOOL)isValidateEmail;
-(BOOL)isValidatePwd;
- (BOOL)isValidateByRegex:(NSString *)regex;
- (BOOL)isValidateNumber;
+(NSString*) stringFromInteger:(NSInteger)num;
+(NSString*) stringFromFloat:(float)num;


/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithUnit:(BOOL)unit;

//订单显示价格
- (NSString *)priceStringWithOrderList;

//新统一
/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)covertStringToPriceStringWithUnit:(BOOL)unit;

/**
 *@日期格式转换函数
 *date所要转化的日期 格式为"yyyyMMddHHmmss"
 *type转化的格式  1:@"yyyy-MM-dd HH:mm:ss"
 *              2:@"yyyy-MM-dd"
 **/
- (NSString *)switchDateReturnType:(NSUInteger)type;
/**
 *  是否是正确的身份证号
 *
 *  @return YES/NO
 */
-(BOOL) isCorrectCardID;

- (BOOL)isCarNumber;

//-(BOOL)judgeTelephoneLength;
-(BOOL)judgeTelephone;
-(BOOL)judgeEmail;
-(BOOL)judgeIdentityCard;
-(BOOL)judgeMoney;
-(BOOL)judgeNum;

/**判断金额的输入是否非法，在TextField 和 TextView 的代理中使用 最佳
 * text : 文本框中的内容
 * string : 输入的单个字符
 * maxLength : 最大字符限制
 */
- (BOOL)VIPManger_isLegalInputWithText:(NSString *)text inputString:(NSString *)string andLimitedLength:(NSInteger)maxLength;

/**判断折扣数据是否非法，建议在 TextField 和 TextView 的代理中使用最佳
 * text : 文本框中的内容
 * string : 输入的单个字符
 * maxLength : 最大字符限制
 */
- (BOOL)VIPManger_iSLegalDiscountInput:(NSString *)text inputString:(NSString *)string andLimitedLength:(NSInteger)maxLength;

/**
 * @ 判断是否是合法的金额格式 (数字判断)
 * @ money 金额: 要转换的金额数
 * @ params limitedNum: 小数位数的限制 必须 >= 1位，因为允许小数点的存在; 默认限制小数点后 2 位
 * @ return YES: 合法  NO: 非法
 */

- (BOOL)WZ_NewFloorIsLegalMoney:(CGFloat)money andFormat:(NSInteger)limitedNum;

/*
 *@ 判断是否是合法的金额格式
 *@ limitedNum 小数位数的限制 必须 >= 1位，因为允许小数点的存在; 默认限制小数点后 2 位
 *@ Return YES: 合法  NO: 非法
 */

- (BOOL)WZ_NewFloorIsLegalMoneyFormat:(NSInteger)limitedNum;

/**
 * @ money 要转换的金额
 * @ direction YES: 分转元  NO:元转分
 * @ Return 转换后的金额值
 */

+ (NSString *)transformMoneyFormatter:(NSString *)moneyStr andTransformDirection:(BOOL)direction;


/**
正则表达式去除html标签
 */

+(NSString *)getZZwithString:(NSString *)string;

@end
