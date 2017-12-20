//
//  Utils.m
//  BusinessTool
//
//  Created by Chen dy on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils

+ (NSString *) stringFromHex:(NSString *)str 
{   
    NSMutableData *stringData = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    NSInteger i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1]; 
    }
    
    return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
}

+ (NSString *) stringToHex:(NSString *)str
{   
    NSUInteger len = [str length];
    unichar *chars = (unichar*) malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return hexString ;
}

+(char*)Hex2Ascii:(const char *)hex
{
	NSInteger len = strlen(hex), tlen, i, cnt;
	
	char* asc = new char[len * 4];
	memset(asc, 0, len * 4);	
	for (i = 0, cnt = 0, tlen = 0; i<len; i++)
	{
		char c = toupper(hex[i]);
		
		if ((c>='0'&& c<='9') || (c>='A'&& c<='F'))
		{
			unsigned char t = (c >= 'A') ? c - 'A' + 10 : c - '0';
			
			if (cnt)
				asc[tlen++] += t, cnt = 0;
			else
				asc[tlen] = t << 4, cnt = 1;
		}
	}
	return asc;
}


+(char*)Ascii2Hex:(const char*)asc
{	
	
	NSInteger i, len = strlen(asc);
	char* hex = new char[len * 4];
	memset(hex, 0, len* 4);
	char chHex[] = "0123456789abcdef";
	
	for (i = 0; i<len; i++)
	{
		hex[i*2] = chHex[((unsigned char)asc[i]) >> 4];
		hex[i*2 +1] = chHex[((unsigned char)asc[i]) & 0xf];
		//hex[i*3 +2] = ' ';
	}	
	hex[len * 2] = '\0';	
	return hex;		
}

/**********************************************************************
 **函数功能 : 获取评分
 **********************************************************************/
+(NSString*)getGradeImageNameByNSString:(NSString*)gradeValue
{
	return [Utils getGradeImageNameByDouble:[gradeValue doubleValue]];
}

/**********************************************************************
 **函数功能 : 获取评分
 **********************************************************************/
+(NSString*)getGradeImageNameByDouble:(CGFloat)gradeValue
{
	NSString *gradeImageName;
	
	if (0 <= gradeValue && gradeValue < 1) 
	{
		gradeImageName = @"star_0.png";
	}
	else if (1 <= gradeValue && gradeValue < 2)
	{
		gradeImageName = @"star_1.png";
	}
	else if (2 <= gradeValue && gradeValue < 3)
	{
		gradeImageName = @"star_2.png";
	}
	else if (3 <= gradeValue && gradeValue < 4)
	{
		gradeImageName = @"star_3.png";
	}
	else if (4 <= gradeValue && gradeValue < 5)
	{
		gradeImageName = @"star_4.png";
	}
	else if (5 <= gradeValue)
	{
		gradeImageName = @"star_5.png";
	}
	
	return gradeImageName;
}

@end
