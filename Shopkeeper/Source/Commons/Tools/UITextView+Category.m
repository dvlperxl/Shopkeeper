//
//  UITextView+Category.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/12.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Category)


/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float)heightForWidth:(float)width
{
    CGSize sizeToFit = [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

@end
