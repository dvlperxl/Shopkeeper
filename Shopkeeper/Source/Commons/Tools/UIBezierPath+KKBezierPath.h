//
//  UIBezierPath+KKBezierPath.h
//  kakatrip
//
//  Created by CaiMing on 2017/1/16.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (KKBezierPath)

+ (UIBezierPath *)cutDownCorner:(CGRect)originalFrame point_x:(CGFloat)point_x;

@end
