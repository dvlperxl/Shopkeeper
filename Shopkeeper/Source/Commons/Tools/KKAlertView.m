//
//  KKAlertView.m
//  kakatrip
//
//  Created by CaiMing on 2016/11/25.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KKAlertView.h"

typedef void(^Handler)(KKAlertAction* item);

@interface KKAlertAction()

@property(nonatomic,strong)Handler handler;
@property(nonatomic,copy,readwrite)NSString *title;

@end

@implementation KKAlertAction

+(id)alertActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void(^)(KKAlertAction* action))handler
{
    KKAlertAction *action = [[KKAlertAction alloc]init];
    action.handler = handler;
    action.title = title;
    return action;
}

@end


@interface KKAlertView ()

@property(nonatomic, strong)NSArray *actions;

@end


@implementation KKAlertView

- (void)showAlertActionViewWithTitle:(NSString *)title actions:(NSArray *)actions
{
    [self showAlertActionViewWithTitle:title content:nil actions:actions];
}

- (void)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content contentTextAlignment:(NSTextAlignment)textAlignment actions:(NSArray *)actions;
{

    if (content == nil || content.length<1) {
        content = title;
        title = @"";
    }
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
    for (KKAlertAction *kkAction in actions)
    {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:kkAction.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (kkAction.handler) {
                kkAction.handler(kkAction);
            }
        }];
        
        [alertView addAction:alertAction];
    }
    
    [[CMRouter sharedInstance].currentController presentViewController:alertView animated:YES completion:nil];

}

- (void)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content actions:(NSArray *)actions
{
    [self showAlertActionViewWithTitle:title content:content contentTextAlignment:NSTextAlignmentLeft actions:actions];
}

+ (instancetype)showAlertActionViewWithTitle:(NSString *)title actions:(NSArray *)actions
{
    KKAlertView *alert = [[KKAlertView alloc]init];
    [alert showAlertActionViewWithTitle:title content:nil contentTextAlignment:NSTextAlignmentCenter actions:actions];
    return alert;
}

+ (instancetype)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content actions:(NSArray *)actions
{
    KKAlertView *alert = [[KKAlertView alloc]init];
    [alert showAlertActionViewWithTitle:title content:content contentTextAlignment:NSTextAlignmentCenter actions:actions];
    return alert;
}

+ (instancetype)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content contentTextAlignment:(NSTextAlignment)textAlignment actions:(NSArray *)actions
{
    KKAlertView *alert = [[KKAlertView alloc]init];
    [alert showAlertActionViewWithTitle:title content:content contentTextAlignment:textAlignment actions:actions];
    return alert;
}


@end
