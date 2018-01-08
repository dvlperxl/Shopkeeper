//
//  Calculate.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculate : NSObject

+ (NSString*)amountDisplayCalculate:(id)a multiplyingBy:(id)b;
+ (NSString*)amountDisplayCalculate:(id)a addBy:(id)b;
+ (NSString*)amountDisplayCalculateTwoFloat:(id)a;//string or number
@end
