//
//  NSMutableArray+safe.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/19.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSMutableArray (safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [obj swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
        [obj swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
    });
}

- (void)safeAddObject:(id)anObject
{
    if (anObject) {
        
        [self safeAddObject:anObject];
        
    }else{
        NSLog(@"obj is nil");
        
    }
}

- (id)safeObjectAtIndex:(NSInteger)index
{
    if(index<[self count]){
        return [self safeObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
    return nil;
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if(index<[self count]){
        [self safeRemoveObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
}

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index
{
    if(index<=[self count] && obj){
        [self safeInsertObject:obj atIndex:index];
    }else{
        NSLog(@"index is beyond bounds or obj is nil");
    }
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)obj
{
    if (obj&&index<[self count])
    {
        [self safeReplaceObjectAtIndex:index withObject:obj];
    }
}


- (void)addStringNilToSpace:(NSString*)obj
{
    if (obj== nil) {
        obj = @"";
    }
    [self addObject:obj];
}



@end
