//
//  KKColor.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/3.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "KKColor.h"
#import "UIColor+HexColor.h"

@implementation KKColor
+ (UIColor *)hexColor:(NSString *)string
{
    return [UIColor colorWithHexString:string];
}

@end
