//
//  NSArray+Safe.m
//  BTravel
//
//  Created by CaiMing on 2017/6/27.
//  Copyright © 2017年 CaiMing. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSArray (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
    });
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

@end
