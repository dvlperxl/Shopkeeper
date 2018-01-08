//
//  NSObject+SwizzleMethod.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/14.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NSObject+SwizzleMethod.h"

@implementation NSObject (SwizzleMethod)

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)invokeMethodWithMethodName:(NSString*)methodName param:(id)param
{
    if (methodName == nil) {
        
        NSLog(@"methodName is nil");

        return;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
    
    if ([self respondsToSelector:NSSelectorFromString(methodName)])
    {
        [self performSelector:NSSelectorFromString(methodName) withObject:param];
        
    }else
    {
        NSLog(@"未找到方法的实现");
    }

#pragma clang diagnostic pop

}


@end
