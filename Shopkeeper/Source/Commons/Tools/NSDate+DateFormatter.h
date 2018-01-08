//
//  NSDate+DateFormatter.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#define TODAY_YYYY_M_D @"YYYY年M月d日"
#define  YYYY_MM_dd @"YYYY-MM-dd"


#import <Foundation/Foundation.h>

@interface NSDate (DateFormatter)

- (NSString*)stringWithDateFormatter:(NSString*)dateFormatter;
+ (NSDate *)dateWithDateString:(NSString *)dateString dateFormatter:(NSString*)dateFormatter;

@end
