//
//  NSMutableArray+safe.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/19.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (safe)

- (void)addStringNilToSpace:(NSString*)obj;

@end
