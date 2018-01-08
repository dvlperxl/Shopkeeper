//
//  UIButton+KKWebCache.m
//  kakatrip
//
//  Created by CaiMing on 2016/11/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "UIButton+KKWebCache.h"
#import "NSString+StringTransform.h"
#import <SDWebImage/UIButton+WebCache.h>


@implementation UIButton (KKWebCache)

- (void)kk_setImageWithURLString:(NSString *)urlString forState:(UIControlState)controlState
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setImageWithURL:url forState:controlState];
}

- (void)kk_setBackgroundImageWithURL:(NSString *)urlString forState:(UIControlState)controlState
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setBackgroundImageWithURL:url forState:controlState];
}


- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder forState:(UIControlState)controlState
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setImageWithURL:url forState:controlState placeholderImage:placeholder];
}


@end
