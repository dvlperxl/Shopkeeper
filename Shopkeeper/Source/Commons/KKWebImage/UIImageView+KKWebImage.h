//
//  UIImageView+KKWebImage.h
//  kakatrip
//
//  Created by CaiMing on 2016/11/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>

@interface UIImageView (KKWebImage)

- (void)kk_setImageWithURLString:(NSString *)urlString;

- (void)kk_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholder;

- (void)kk_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholder
                       completed:(SDExternalCompletionBlock)completedBlock;

- (void)kk_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholder
                         options:(SDWebImageOptions)options
                       completed:(SDExternalCompletionBlock)completedBlock;

@end
