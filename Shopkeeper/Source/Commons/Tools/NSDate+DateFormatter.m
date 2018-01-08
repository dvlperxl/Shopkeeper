//
//  NSDate+DateFormatter.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NSDate+DateFormatter.h"

@implementation NSDate (DateFormatter)

- (NSString*)stringWithDateFormatter:(NSString*)dateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormatter];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithDateString:(NSString *)dateString dateFormatter:(NSString*)dateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormatter];
    return [formatter dateFromString:dateString];
}

@end
