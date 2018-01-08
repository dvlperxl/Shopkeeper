//
//  NSString+StringTransform.h
//  kakatrip
//
//  Created by caiming on 16/10/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTransform)

/**
 *  汉字转拼音
 *
 *  @return pinyin
 */
- (NSString *)transformPinyin;

/**
 *  首字母大写
 *
 *  @return 首字母大写字符串
 */
- (NSString *)upperFirstLetter;


- (BOOL)isHasSpace;

- (NSString *)deleteSpace;

- (BOOL)isValidWithRegular:(NSString *)regular;

-(CGFloat)calculateHeight:(CGSize)size font:(UIFont*)font;

-(BOOL)validateMobile;

-(BOOL)validateEmail;
/** 1-1000整数验证*/
- (BOOL)validateThousandNum;
/** 1-10000内的数验证，最多2位小数（0.01-9999.99）*/
- (BOOL)validateTenThousandAndTwoDecimal;
/** 验证价格（支持两位小数，整数部分最多8位）*/
- (BOOL)validatePrice;
/** 验证2位整数*/
- (BOOL)validateTwoPlaceNum;
/**
 数字验证

 @param preCount 整数部分个数（当为0时，验证1以内的小数）
 @param laterCount 小数部分个数（当为0时，验证整数）
 @return 结果
 */
- (BOOL)validateNumWithPointPreCount:(NSInteger)preCount pointLaterCount:(NSInteger)laterCount;

/** 验证一位字符是否是数字或点*/
- (BOOL)validateCharNumAndPointAtIndex:(NSUInteger)index;
/** 字符串转为数字（3.09ml -> 3.09; 3.00 -> 3.00; ml3.09 -> nil）*/
- (NSString *)numberValue;

- (NSString *)URLEncodeString;

-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font;

-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

-(NSString *)md5HexDigest;

//判断首字符的合法性
- (BOOL)firstLetterLegal;

@end


