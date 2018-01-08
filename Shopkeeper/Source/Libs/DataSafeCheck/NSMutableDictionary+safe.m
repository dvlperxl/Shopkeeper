//
//  NSMutableDictionary+safe.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/20.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "NSMutableDictionary+safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSMutableDictionary (safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safeSetObject:forKey:)];

    });
}

- (void)safeSetObject:(id)object forKey:(NSString*)key
{
    if (object&&key) {
        [self safeSetObject:object forKey:key];
    }else
    {
        NSLog(@"%@,%@",object,key);
    }
}



@end
