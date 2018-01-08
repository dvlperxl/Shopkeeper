//
//  KKPresentationController.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/2.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPresentationController : UIView

+ (instancetype)presentationControllerWithTitle:(NSString*)title url:(NSString*)urlString;
+ (instancetype)presentationControllerWithTitle:(NSString*)title contentView:(UIView*)contentView;

+ (instancetype)presentationControllerWithContentView:(UIView*)contentView;

- (void)showInSuperView:(UIView *)aView;
- (void)showInCenterWithSuperView:(UIView *)aView;
- (void)showInSuperView:(UIView *)aView animation:(BOOL)animation;

- (void)showInSuperViewBottom:(UIView *)aView;
- (void)dismiss;

@end
