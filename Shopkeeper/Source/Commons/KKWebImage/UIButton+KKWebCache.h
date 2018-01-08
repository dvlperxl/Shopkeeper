//
//  UIButton+KKWebCache.h
//  kakatrip
//
//  Created by CaiMing on 2016/11/8.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KKWebCache)

- (void)kk_setBackgroundImageWithURL:(NSString *)urlString forState:(UIControlState)controlState;
- (void)kk_setImageWithURLString:(NSString *)urlString forState:(UIControlState)controlState;
- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder forState:(UIControlState)controlState;
//- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
//- (void)kk_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;


@end
