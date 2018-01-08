//
//  UIImage+ImageWithColor.m
//  kakatrip
//
//  Created by caiming on 16/9/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)createImageWithColor:(UIColor *)color;
{
    return [self createImageWithColor:color withSize:CGSizeMake(1, 1)];
}

+ (UIImage *) createImageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
