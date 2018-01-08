//
//  UITextView+Category.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/12.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Category)

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param width 限制字符串显示区域的宽度
 */

- (float)heightForWidth:(float)width;

@end
