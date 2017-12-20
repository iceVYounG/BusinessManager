//
//  StringHelper.m
//  PTLog
//
//  Created by Ellen Miner on 1/2/09.
//  Copyright 2009 RaddOnline. All rights reserved.
//

#import "StringHelper.h"
#import "GTMBase641.h"

@implementation NSString (StringHelper)
#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/*
- (void)RAD_resizeLabel:(UILabel *)aLabel WithSystemFontOfSize:(CGFloat)size {
	aLabel.frame = [self RAD_frameForCellLabelWithSystemFontOfSize:size];
	aLabel.text = self;
	[aLabel sizeToFit];
}

- (UILabel *)RAD_newSizedCellLabelWithSystemFontOfSize:(CGFloat)size {
	UILabel *cellLabel = [[UILabel alloc] initWithFrame:[self RAD_frameForCellLabelWithSystemFontOfSize:size]];
	cellLabel.textColor = [UIColor blackColor];
	cellLabel.backgroundColor = [UIColor clearColor];
	cellLabel.textAlignment = UITextAlignmentLeft;
	cellLabel.font = [UIFont systemFontOfSize:size];
	
	cellLabel.text = self; 
	cellLabel.numberOfLines = 0; 
	[cellLabel sizeToFit];
	return cellLabel;
}
*/

- (NSString *)baseHexEncode
{
    NSData *encodingData = [GTMBase641 encodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* base64EncodingString = [[NSString alloc] initWithBytes:[encodingData bytes] 
                                                               length:[encodingData length] 
                                                             encoding:NSUTF8StringEncoding];
    return [base64EncodingString toHex];
}

- (NSString *)baseHexDecode
{
    if (self)
    {
        NSData* base64decode = [GTMBase641 decodeString:[self fromHex]];
        return [[NSString alloc] initWithBytes:[base64decode bytes] 
                                         length:[base64decode length]
                                       encoding:NSUTF8StringEncoding] ;
    }
    return nil;
}


- (NSString *) fromHex
{   
    NSMutableData *stringData = [[NSMutableData alloc] init] ;
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    NSInteger i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1]; 
    }
    
    return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding] ;
}

- (NSString *) toHex
{   
    NSUInteger len = [self length];
    unichar *chars = (unichar*) malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return hexString ;
}

- (NSString *) md5 {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(NSInteger i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)length2
{
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }        
    }
    return strlength;
} 

- (NSString *) documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:self];
}





//@implementation NSString (NSString_JavaAPI)

- (NSInteger) compareTo: (NSString*) comp {
    NSComparisonResult result = [self compare:comp];
    if (result == NSOrderedSame) {
        return 0;
    }
    return result == NSOrderedAscending ? -1 : 1;
}

- (NSInteger) compareToIgnoreCase: (NSString*) comp {
    return [[self lowercaseString] compareTo:[comp lowercaseString]];
}

- (bool) contains: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location != NSNotFound;
}

- (bool) endsWith: (NSString*) substring {
    NSInteger location = [self lastIndexOf:substring];
    return location == [self length] - [substring length];
}

- (bool) startsWith: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == 0;
}

- (NSInteger) indexOf: (NSString*) substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSInteger) indexOf:(NSString *)substring startingFrom: (NSInteger) index {
    NSString* test = [self substringFromIndex:index];
    return [test indexOf:substring];
}

- (NSInteger) lastIndexOf: (NSString*) substring {
    if (! [self contains:substring]) {
        return -1;
    }
    NSInteger matchIndex = 0;
    NSString* test = self;
    while ([test contains:substring]) {
        if (matchIndex > 0) {
            matchIndex += [substring length];
        }
        matchIndex += [test indexOf:substring];
        test = [test substringFromIndex: [test indexOf:substring] + [substring length]];
    }
    
    return matchIndex;
}

- (NSInteger) lastIndexOf:(NSString *)substring startingFrom: (NSInteger) index {
    NSString* test = [self substringFromIndex:index];
    return [test lastIndexOf:substring];
}

- (NSString*) substringFromIndex:(NSInteger)from toIndex: (NSInteger) to {
    NSRange range;
    range.location = from;
    range.length = to - from;
    return [self substringWithRange: range];
}


- (NSArray*) split: (NSString*) token {
    return [self split:token limit:0];
}

- (NSArray*) split: (NSString*) token limit: (NSInteger) maxResults {
    NSMutableArray* result = [NSMutableArray arrayWithCapacity: 8];
    NSString* buffer = self;
    while ([buffer contains:token]) {
        if (maxResults > 0 && [result count] == maxResults - 1) {
            break;
        }
        NSInteger matchIndex = [buffer indexOf:token];
        NSString* nextPart = [buffer substringFromIndex:0 toIndex:matchIndex];
        buffer = [buffer substringFromIndex:matchIndex + [token length]];
        if (nextPart) {
            [result addObject:nextPart];
        }
    }
    if ([buffer length] > 0) {
        [result addObject:buffer];
    }
    
    return result;
}

- (NSString*) replace: (NSString*) target withString: (NSString*) replacement {
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}


//@implementation NSString(MPTidbits)

- (BOOL)isEmpty
{
	return (self==nil || [self isEmptyIgnoringWhitespace:YES]);
}

- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace
{
	NSString *toCheck = (ignoreWhitespace) ? [self stringByTrimmingWhitespace] : self;
	return [toCheck isEqualToString:@""];
}

- (NSString *)stringByTrimmingWhitespace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//custom

//判断邮箱是否合法的代码
-(BOOL)isEmail
{
    if((0 != [self rangeOfString:@"@"].length) &&
       (0 != [self rangeOfString:@"."].length))
    {
        
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy] ;
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        //使用compare option 来设定比较规则，如
        //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
        NSRange range1 = [self rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [self substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainString = [self substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}


//手机号码判断
- (BOOL)isMobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1([3-9])\\d{9}$";  //判断号码1(3-9)
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
//    139、138、137、136、135、134、159、150、151、158、157、188、187、152、182、147、183
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//邮箱正则表达式
-(BOOL)isValidateEmail{
    
    NSString *atom = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]";
    NSString *domain = [NSString stringWithFormat:@"(%@+(\\.%@+)*",atom,atom];
    NSString *ip_domain = @"\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\]";
    
    NSString *emailRegex =[NSString stringWithFormat:@"^%@+(\\.%@+)*@%@|%@)$",atom,atom,domain,ip_domain];

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//注册密码正则表达式
//满足三个中任意一个即为不正确的密码
-(BOOL)isValidatePwd
{
    NSString *numRegex = @"^[0-9]*$";
    NSPredicate *numMatch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    
    NSString *strRegex = @"^[A-Za-z]*$";
    NSPredicate *strMatch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    
    NSString *symbolRegex = @"^[^A-Za-z0-9]*$";
    NSPredicate *symbolMatch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", symbolRegex];
    
    if ([numMatch evaluateWithObject:self]) {
//        [SVProgressHUD showErrorWithStatus:@"密码不能为纯数字"];
        return NO;
    }else if ([strMatch evaluateWithObject:self]) {
//        [SVProgressHUD showErrorWithStatus:@"密码不能为纯字母"];
        return NO;
        
    }else if ([symbolMatch evaluateWithObject:self]) {
//        [SVProgressHUD showErrorWithStatus:@"密码不能为纯符号"];
        return NO;
        
    }
    return YES;
}

+(NSString*) stringFromInteger:(NSInteger)num{
    return [NSString stringWithFormat:@"%d",num];
}

+(NSString*) stringFromFloat:(float)num{
    return [NSString stringWithFormat:@"%f",num];
}

/**
 *@日期格式转换函数
 *date所要转化的日期 输入date格式为"yyyyMMddHHmmss"
 *type转化的格式  1:输出@"yyyy-MM-dd HH:mm:ss"
 *              2:输出@"yyyy-MM-dd"
 *              3:距离1970的时间戳输入date为时间戳 输出@"yyyy-MM-dd"
 *              4:输出@"yyyy年MM月dd日"
 *              5:输出@"yyyy-MM-dd HH:mm"
 **/
- (NSString *)switchDateReturnType:(NSUInteger)type
{
    if(self.length ==0){
        return @"";
    }
    NSString* string = self;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    if (type == 3) {//时间戳转换成具体时间
        inputDate = [NSDate dateWithTimeIntervalSince1970:[string longLongValue]];
    }
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    if (type == 1) {
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else if(type == 2){
        [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if(type == 3){
        [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if(type == 4){
        [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    else if(type == 5){
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    else if(type == 6){
        [outputFormatter setDateFormat:@"M月dd日"];
    }
    else if(type == 7){
        [outputFormatter setDateFormat:@"HH:mm:ss"];
    }
    else if(type == 8){
        [outputFormatter setDateFormat:@"yyyy年MM月"];
    }
    else if(type == 9){
        [outputFormatter setDateFormat:@"yyyyMMdd"];
    }
    else if(type == 10){
        [outputFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
        
    }
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
    
}

-(BOOL) isCorrectCardID{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0||[self isEqualToString:@""])
    {
        return NO;
    }
    else if ( self.length == 18)
    {
    
        bool sfz18NO = [self checkIdentityCardNo];
        if (!sfz18NO)
        {
            return NO;
        }else{
            return YES;
        }
    }
    else
    {
        return NO;
    }
}
- (BOOL)isValidateNumber
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


#pragma mark - 身份证识别
-(BOOL)checkIdentityCardNo
{
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithUnit:(BOOL)unit
{
    if (self.length == 0)
    {
        return @"";
    }
    CGFloat price = [self floatValue];
    if (unit)
    {
        return [NSString stringWithFormat:@"¥%g",price];
    }
    else
    {
        return [NSString stringWithFormat:@"%g",price];
    }
}

/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithOrderList
{
    if (self.length == 0){
        
        return @"";
        
    }
    CGFloat price = [self floatValue];
    NSString *str = [NSString stringWithFormat:@"¥%.2f",price];
    
    if ([str hasSuffix:@"0"]) {
        
        return [NSString stringWithFormat:@"¥%.1f",price];
    }
    
    return [NSString stringWithFormat:@"¥%.2f",price];
    
}

//新统一
/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)covertStringToPriceStringWithUnit:(BOOL)unit
{
    if (self.length == 0)
    {
        return @"";
    }
    CGFloat price = [self floatValue];
    if (unit){
        return [NSString stringWithFormat:@"¥%.2f",price];
    }
    else{
        return [NSString stringWithFormat:@"%.2f",price];
    }
}


//车牌
- (BOOL)isCarNumber{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self isValidateByRegex:carRegex];
}

#pragma mark - New
//有效手机号
- (BOOL)judgeTelephone{
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
//邮箱
-(BOOL) judgeEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//身份证号
- (BOOL) judgeIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
//有效金额
-(BOOL)judgeMoney{
    NSString *regex = @"^(?!0+$)(?!0*\\.0*$)\\d{1,8}(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
//纯数字
-(BOOL)judgeNum
{
    NSString *regex = @"^[0-9]{0,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
@end
