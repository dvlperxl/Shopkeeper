//
//  KKProgressHUD.h
//  kakatrip
//
//  Created by caiming on 16/9/20.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface KKProgressHUD : MBProgressHUD

+ (void)showMBProgressAddTo:(UIView*)aView message:(NSString *)message;
+ (void)showMBProgressAddTo:(UIView*)aView;
+ (void)hideMBProgressForView:(UIView*)aView;
+ (void)showSuccessAdd:(UIView *)aView message:(NSString *)message;
+ (void)showErrorAddTo:(UIView *)aView message:(NSString *)message;
+ (void)showReminder:(UIView *)aView message:(NSString *)message;

@end
