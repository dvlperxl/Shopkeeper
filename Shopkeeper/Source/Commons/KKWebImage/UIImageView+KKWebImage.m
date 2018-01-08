//
//  UIImageView+KKWebImage.m
//  kakatrip
//
//  Created by CaiMing on 2016/11/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "UIImageView+KKWebImage.h"
#import "NSString+StringTransform.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (KKWebImage)

- (void)kk_setImageWithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setImageWithURL:url];
}
- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}

- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                   completed:completedBlock];
}


- (void)kk_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholder
                         options:(SDWebImageOptions)options
                       completed:(SDExternalCompletionBlock)completedBlock
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodeString]];
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:completedBlock];
}


@end
