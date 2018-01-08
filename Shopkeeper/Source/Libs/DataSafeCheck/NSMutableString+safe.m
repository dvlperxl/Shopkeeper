//
//  NSMutableString+safe.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NSMutableString+safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSMutableString (safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(appendString:) withMethod:@selector(safeAppendString:)];
        
    });
}

- (void)safeAppendString:(NSString*)str
{
    if ([str isKindOfClass:[NSString class]])
    {
        [self safeAppendString:str];
        
    }else if ([str isKindOfClass:[NSNumber class]])
    {
        [self safeAppendString:STRINGWITHOBJECT(str)];
    }
    
}

//- (void)safeSetObject:(id)object forKey:(NSString*)key
//{
//    if (object&&key) {
//        [self safeSetObject:object forKey:key];
//    }else
//    {
//        NSLog(@"%@,%@",object,key);
//    }
//}
//

@end
