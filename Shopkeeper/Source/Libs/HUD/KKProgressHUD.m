//
//  KKProgressHUD.m
//  kakatrip
//
//  Created by caiming on 16/9/20.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KKProgressHUD.h"
#import "KKToast.h"

@interface KKProgressHUD ()

@end

@implementation KKProgressHUD

+ (void)showMBProgressAddTo:(UIView*)aView message:(NSString *)message
{
    [self hideMBProgressForView:aView];
    KKProgressHUD *hud =  [KKProgressHUD showHUDAddedTo:aView animated:NO];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:41.0/255.0 blue:62.0/255.0 alpha:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.minSize = CGSizeMake(100, 46);
    hud.margin = 5;
    hud.bezelView.layer.cornerRadius = 10.0f;
}

+ (void)showMBProgressAddTo:(UIView*)aView
{
    [self showMBProgressAddTo:aView message:@"请稍等..."];
}


+ (void)hideMBProgressForView:(UIView*)aView
{
    [KKProgressHUD hideHUDForView:aView animated:YES];
}

+ (void)showErrorAddTo:(UIView *)aView message:(NSString *)message;
{
    [KKProgressHUD hideHUDForView:aView animated:NO];
    [[KKToast makeToast:message]show];
}

+ (void)showSuccessAdd:(UIView *)aView message:(NSString *)message
{
    [KKProgressHUD hideHUDForView:aView animated:NO];
    MBProgressHUD *hud = [KKProgressHUD showHUDAddedTo:aView animated:NO];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:41.0/255.0 blue:62.0/255.0 alpha:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.minSize = CGSizeMake(100, 46);
    hud.margin = 10;
    hud.bezelView.layer.cornerRadius = 10.0f;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = message;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
}

+(void)showReminder:(UIView *)aView message:(NSString *)message{
    
    [KKProgressHUD hideHUDForView:aView animated:NO];
    [[KKToast makeToast:message]show];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    if ([self getFirstResponder])
    {
        self.offset = CGPointMake(0, -100);
    }
    
    return self;
}

- (void)keyBoardWillShow
{
    self.offset = CGPointMake(0, -100);
}

- (void)keyBoardWillHide
{
    self.offset = CGPointMake(0, 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UIView*)getFirstResponder

{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    return  [self findAndResignFirstResponder:window];
    
}

- (UIView*)findAndResignFirstResponder:(UIView*)aView
{
    if (aView.isFirstResponder)
    {
        return aView;
        
    }else if (aView.subviews.count>0)
    {
        for (UIView* subView in aView.subviews)
        {
            return  [self findAndResignFirstResponder:subView];
        }
    }
    return nil;
}



@end
