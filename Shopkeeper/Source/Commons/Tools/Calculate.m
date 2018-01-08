//
//  Calculate.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "Calculate.h"

@implementation Calculate


+ (NSString*)amountDisplayCalculate:(NSNumber*)a multiplyingBy:(NSNumber*)b
{
    if ([a isKindOfClass:[NSNumber class]]||[b isKindOfClass:[NSNumber class]]||[a isKindOfClass:[NSString class]]||[b isKindOfClass:[NSString class]])
    {
        
        NSString *aStr = [NSString stringWithFormat:@"%@",a];
        NSString *bStr = [NSString stringWithFormat:@"%@",b];
        NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:aStr];
        NSDecimalNumber *count = [NSDecimalNumber decimalNumberWithString:bStr];
        NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                          decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                          scale:2
                                          raiseOnExactness:NO
                                          raiseOnOverflow:NO
                                          raiseOnUnderflow:NO
                                          raiseOnDivideByZero:YES];
        NSDecimalNumber *total = [price decimalNumberByMultiplyingBy:count withBehavior:roundUp];
        NSString *amountStr = total.description;
        amountStr = [self amountDisplayCalculateTwoFloat:amountStr];
        return amountStr;
    }
    return @"0.0";
}

+ (NSString*)amountDisplayCalculate:(id)a addBy:(id)b
{
    
    
    if ([a isKindOfClass:[NSNumber class]]||[b isKindOfClass:[NSNumber class]]||[a isKindOfClass:[NSString class]]||[b isKindOfClass:[NSString class]])
    {
        NSString *aStr = [NSString stringWithFormat:@"%@",a];
        NSString *bStr = [NSString stringWithFormat:@"%@",b];
        NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:aStr];
        NSDecimalNumber *count = [NSDecimalNumber decimalNumberWithString:bStr];
        NSDecimalNumber *total = [price decimalNumberByAdding:count];
        NSString *amountStr = total.description;
        amountStr = [self amountDisplayCalculateTwoFloat:amountStr];
        return amountStr;
    }
    return @"0.0";
}

+ (NSString*)amountDisplayCalculateTwoFloat:(id)a
{
    if ([a isKindOfClass:[NSNumber class]] || [a isKindOfClass:[NSString class]])
    {
        NSString *amountStr = [NSString stringWithFormat:@"%@",a];
        NSArray *result = [amountStr componentsSeparatedByString:@"."];
        if (result.count==2)
        {
            NSString *first = result.firstObject;
            NSString *last = result.lastObject;
            if (last.length == 0)
            {
                last = [NSString stringWithFormat:@"%@",@"00"];
                
            }else if (last.length == 1)
            {
                last = [NSString stringWithFormat:@"%@0",last];
                
            }else if (last.length > 2)
            {
                last = [last substringWithRange:NSMakeRange(0, 2)];
            }
            amountStr = [NSString stringWithFormat:@"%@.%@",first,last];
        }else
        {
            amountStr = [NSString stringWithFormat:@"%@.00",amountStr];
        }
        
        return amountStr;
    }
    
    return @"0.0";
}

@end
