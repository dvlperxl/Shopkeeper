//
//  KaKaCache.h
//  kakatrip
//
//  Created by caiming on 16/9/28.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KaKaCache : NSObject

+ (id<NSCoding>)objectForKey:(NSString *)key;
+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

+ (void)removeAllCache;

@end
