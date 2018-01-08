//
//  UIBezierPath+KKBezierPath.m
//  kakatrip
//
//  Created by CaiMing on 2017/1/16.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "UIBezierPath+KKBezierPath.h"

#define kCornerRadius 3
#define kArrWith 4

@implementation UIBezierPath (KKBezierPath)

+ (UIBezierPath *)cutDownCorner:(CGRect)originalFrame point_x:(CGFloat)point_x
{
    CGRect rect = originalFrame;
    CGFloat height = rect.size.height;
    CGFloat width  = rect.size.width;
    
    if (point_x < kCornerRadius+kArrWith/2)
    {
        point_x = kCornerRadius+kArrWith/2;
    }
    
    if (point_x>width - kCornerRadius-kArrWith/2)
    {
        point_x =width - kCornerRadius-kArrWith/2;
    }
    

    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(kCornerRadius,0)];
    [bezierPath addArcWithCenter:CGPointMake(kCornerRadius, kCornerRadius) radius:kCornerRadius startAngle:-M_PI/2 endAngle:-M_PI clockwise:NO];
    
    [bezierPath addLineToPoint:CGPointMake(0,height - kArrWith-kCornerRadius)];
    [bezierPath addArcWithCenter:CGPointMake(kCornerRadius,height-kCornerRadius-kArrWith) radius:kCornerRadius startAngle:-M_PI endAngle:-M_PI-M_PI/2 clockwise:NO];
    
    [bezierPath addLineToPoint:CGPointMake(point_x-kArrWith/2,height - kArrWith)];
    [bezierPath addLineToPoint:CGPointMake(point_x, height)];
    
    [bezierPath addLineToPoint:CGPointMake(point_x+kArrWith/2,height - kArrWith)];
    [bezierPath addLineToPoint:CGPointMake(width-kCornerRadius,height - kArrWith)];
    [bezierPath addArcWithCenter:CGPointMake(width-kCornerRadius,height-kCornerRadius-kArrWith) radius:kCornerRadius startAngle:-M_PI-M_PI/2 endAngle:-M_PI*2 clockwise:NO];
    [bezierPath addLineToPoint:CGPointMake(width,kCornerRadius)];
    [bezierPath addArcWithCenter:CGPointMake(width-kCornerRadius,kCornerRadius) radius:kCornerRadius startAngle:0 endAngle:-M_PI/2 clockwise:NO];
    bezierPath.lineCapStyle = kCGLineCapRound;
    [bezierPath closePath];
    
    return bezierPath;
    
}

@end
