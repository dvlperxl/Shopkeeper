//
//  UIBarButtonItem+hn_extension.h
//  Shopkeeper
//
//  Created by xl on 2017/12/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (hn_extension)

/** 根据图片生成高亮和正常状态的Item*/
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
/** 根据图片生成高亮和正常状态的Item,可设置左右偏移*/
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage levelEdge:(CGFloat)edge;
/** 高亮、正常、不可选状态的纯文字Item*/ //这里可不需要传disabledcolor，当设置self.navigationItem.rightBarButtonItem.enabled=NO;时，系统自己会变成不可选中颜色
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title normalColor:(UIColor *)normalColor highColor:(UIColor *)highColor disabledColor:(UIColor *)disabledColr;
/** 带图片和文字的Item*/
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title normalColor:(UIColor *)normalColor image:(NSString *)image;
@end
