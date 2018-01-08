//
//  KaKaCache.m
//  kakatrip
//
//  Created by caiming on 16/9/28.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KaKaCache.h"
#import <YYCache/YYCache.h>
#import "KeyChain.h"

static NSString *cacheName = @"kakatripCache";

@implementation KaKaCache

+ (id<NSCoding>)objectForKey:(NSString *)key
{
    
    NSString *mobile = @"";
    NSString *token  = [KeyChain getToken];

    if (token&&token.length>0)
    {
        mobile = [KeyChain getMobileNo];
    }
    
    NSString *userKey = [NSString stringWithFormat:@"%@%@",key,mobile];
    YYCache *cache = [[YYCache alloc]initWithName:cacheName];
    return   [cache objectForKey:userKey];
    
}
+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    
    NSString *mobile = @"";
    NSString *token  = [KeyChain getToken];
    
    if (token&&token.length>0)
    {
        mobile = [KeyChain getMobileNo];
    }
    
    NSString *userKey = [NSString stringWithFormat:@"%@%@",key,mobile];
    YYCache *cache = [[YYCache alloc]initWithName:cacheName];
    [cache setObject:object forKey:userKey];
}


+(void)removeAllCache
{
    YYCache *cache = [[YYCache alloc]initWithName:cacheName];
    [cache removeAllObjects];
}



@end
