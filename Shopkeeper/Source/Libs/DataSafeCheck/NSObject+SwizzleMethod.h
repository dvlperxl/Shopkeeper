//
//  NSObject+SwizzleMethod.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/14.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<objc/runtime.h>

@interface NSObject (SwizzleMethod)

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

- (void)invokeMethodWithMethodName:(NSString*)methodName param:(id)param;

@end
