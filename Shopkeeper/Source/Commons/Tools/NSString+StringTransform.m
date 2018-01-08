//
//  NSString+StringTransform.m
//  kakatrip
//
//  Created by caiming on 16/10/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "NSString+StringTransform.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (StringTransform)

/**
 *  汉字转拼音
 *
 *  @return pinyin
 */
- (NSString *)transformPinyin
{
    
    if ([self length]>0) {
        
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
        
        NSArray *array = [ms componentsSeparatedByString:@" "];
        
        NSMutableString *mStr = [NSMutableString string];
        
        for (NSString *str in array) {
            
            [mStr appendString:[str upperFirstLetter]];
            
        }
        return mStr.copy;
    }
    return @"";
}

/**
 *  首字母大写
 *
 *  @return 首字母大写字符串
 */
- (NSString *)upperFirstLetter
{
    if ([self length]>0) {
        
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        NSString *firstLetter = [self substringToIndex:1];
        firstLetter = [firstLetter uppercaseString];
        [ms replaceCharactersInRange:NSMakeRange(0, 1) withString:firstLetter];
        return ms;
    }
    return @"";
}


/**
 *
 *  手机号验证
 */

//手机号码验证
-(BOOL)validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$
    NSString *phoneRegex = @"^(13[0-9]|14[5|7]|17[0-9]|15[0-9]|18[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

/**
 *
 *  邮箱格式验证
 */

-(BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 1-1000整数验证*/
- (BOOL)validateThousandNum {
    NSString *integerRegex = @"^([1-9]\\d{0,2}|1000)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:self];
}
/** 1-10000内的数验证，最多2位小数（0.01-9999.99）*/
- (BOOL)validateTenThousandAndTwoDecimal {
    NSString *integerRegex = @"^(?!(0{1,4}(((\\.0{0,2})?))$))([1-9]{1}[0-9]{0,3}|0)(\\.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:self];
}
/** 验证价格（支持两位小数，整数部分最多8位）*/
- (BOOL)validatePrice {
    NSString *integerRegex = @"^[0-9]{1,8}([.][0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:self];
}
/** 验证2位整数*/
- (BOOL)validateTwoPlaceNum {
    NSString *integerRegex = @"^([0-9]\\d?|99)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:self];
}
- (BOOL)validateNumWithPointPreCount:(NSInteger)preCount pointLaterCount:(NSInteger)laterCount {
    if (preCount == 0 && laterCount == 0) {   // 当都为0时，不作验证
        return YES;
    }
    NSString *integerRegex = nil;
    if (preCount == 0) {    // 整数0位，验证小于1的小数
        integerRegex = [NSString stringWithFormat:@"^0\\.([0-9]{0,%ld})?$",(long)laterCount];
    } else if (laterCount == 0) {    // 不带小数
        integerRegex = [NSString stringWithFormat:@"^[0-9]{0,%ld}$",(long)preCount];
    } else {
        integerRegex = [NSString stringWithFormat:@"^[0-9]{0,%ld}(\\.[0-9]{0,%ld})?$",(long)preCount,(long)laterCount];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:self];
}
/** 验证一位字符是否是数字或点*/
- (BOOL)validateCharNumAndPointAtIndex:(NSUInteger)index {
    unichar ichar = [self characterAtIndex:index];
    NSString *iStr = [NSString stringWithFormat:@"%C", ichar];
    NSString *integerRegex = @"^(\\.|[0-9])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    return [predicate evaluateWithObject:iStr];
}
/** 字符串转为数字（3.09ml -> 3.09; 3.00 -> 3.00; ml3.09 -> nil）*/
- (NSString *)numberValue {
    if (!self) {
        return nil;
    }
    NSString *integerRegex = @"^[0-9]*(\\.[0-9]*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",integerRegex];
    BOOL isNum = [predicate evaluateWithObject:self];
    if (isNum) {
        return self;
    }
    NSString *num = nil;
    for (NSUInteger i = 0; i < self.length; i++) {
        BOOL isNum = [self validateCharNumAndPointAtIndex:i];
        BOOL subStringIsNum = i > 0 ? [predicate evaluateWithObject:[self substringToIndex:i]] : isNum;
        if (!isNum) {
            if (i > 0) {
                num = [self substringToIndex:i];
            }
            break;
        } else if (!subStringIsNum) {
            if (i - 1 > 0) {
                num = [self substringToIndex:i-1];
            }
            break;
        }
    }
    return num;
}
- (BOOL)isHasSpace
{
   return  [self isValidWithRegular:@"\\s+"];//7263
}

- (NSString *)deleteSpace
{
   return  [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (BOOL)isValidWithRegular:(NSString *)regular
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self MATCHES %@",regular];
    return [pred evaluateWithObject:self];
}


-(CGFloat)calculateHeight:(CGSize)size font:(UIFont*)font
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setObject:font forKey:NSFontAttributeName];
    
    NSAttributedString * attribute = [[NSAttributedString alloc]initWithString:self attributes:attributes.copy];
    CGRect  rect  = [attribute boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height+1;
}

- (NSString *)URLEncodeString
{
    NSString *aStr = [self trimmingWhiteSpace];
    NSString *encodedURLString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)aStr,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    return encodedURLString;
}
// 去掉首位空格
- (NSString *)trimmingWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@0.f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
}

-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpeace;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

-(NSString *)md5HexDigest

{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash uppercaseString];
    
}

//判断首字符的合法性
- (BOOL)firstLetterLegal
{
    if (self.length>0) {
        NSString *regex = @"[a-zA-Z0-9_\\u4e00-\\u9fa5]";
        NSString *firstLetter = [self substringToIndex:1];
        return ![firstLetter isValidWithRegular:regex];
    }
    return YES;
}


@end
