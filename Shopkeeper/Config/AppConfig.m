//
//  AppConfig.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

NSString *const bundleIdDev      = @"com.dongyin.shopkeeper.dev";
NSString *const bundleIdTest     = @"com.dongyin.shopkeeper.test";
NSString *const bundleIdProd     = @"com.dongyin.shopkeeper";

#import "AppConfig.h"
#import "UpdateVersionView.h"

@interface AppConfig ()<UpdateVersionViewDelegate>

@property(nonatomic,readwrite)NSString *bugLyAppId;
@property(nonatomic,readwrite)NSString *jpushAppkey;//

@property(nonatomic, strong)UIWindow *window;
@property(nonatomic, strong)UpdateVersionView *updateView;

@end


@implementation AppConfig


SingletonM

- (BOOL)test
{
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    
    if ([bundleID isEqualToString:bundleIdTest])
    {
        return YES;
    }
    return NO;
}
- (BOOL)dev
{
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleID isEqualToString:bundleIdDev])
    {
        return YES;
    }
    return NO;
}
- (BOOL)prod
{
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    if ([bundleID isEqualToString:bundleIdProd])
    {
        return YES;
    }
    return NO;

}

- (NSString*)bugLyAppId
{
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    
    if ([bundleID isEqualToString:bundleIdDev])
    {
        return @"107db79d16";
        
    }else if ([bundleID isEqualToString:bundleIdProd])
    {
        return @"b7b4963d50";
    }
    else if ([bundleID isEqualToString:bundleIdTest])
    {
        return @"16cdf2fbce";
    }
    return nil;
}

- (NSString*)jpushAppkey
{
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    
    if ([bundleID isEqualToString:bundleIdDev])
    {
        return @"";
        
    }
    else if ([bundleID isEqualToString:bundleIdTest])
    {
        return @"bf4d1e38afa1d276330b913a";
    }
    else if ([bundleID isEqualToString:bundleIdProd])
    {
        return @"ed7198d026474e7f89fc8c65";
    }
    
    return nil;
}



#pragma mark - UpdateVersionViewDelegate

- (void)updateVersionViewDidDisAppear
{
    [self.window removeFromSuperview];
    self.window = nil;
}

- (void)checkVersion
{
    [[APIService share]httpRequestCheckVersionSuccess:^(NSDictionary *responseObject)
     {
         NSString *isNeed = responseObject[@"isNeed"];
         if ([isNeed isEqualToString:@"Y"])
         {
             NSString *version =  responseObject[@"versionCode"];
             NSString *url =  responseObject[@"uri"];
             NSString *updateMessage = responseObject[@"updateMessage"];
             BOOL force = [responseObject[@"isforce"] isEqualToString:@"Y"];
             [self.window addSubview:self.updateView];
             
             UpdateVersionViewModel *model = [UpdateVersionViewModel new];
             model.version = [NSString stringWithFormat:@"v%@",version];
             model.message = updateMessage;
             model.force = force;
             model.url = url;
             [self.updateView reloadData:model];
             
         }else
         {

         }
         
     } failure:^(NSNumber *errorCode,
                 NSString *errorMsg,
                 NSDictionary *responseObject) {
         
     }];
    
    
    
    [[APIService share]httpRequestQueryCurrentVersionInfoSuccess:^(NSDictionary *responseObject) {
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}


- (UIWindow *)window
{
    if (!_window) {
        
        UIWindow *window = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
        window.windowLevel = UIWindowLevelStatusBar +100;
        window.backgroundColor = [UIColor clearColor];
        [window makeKeyAndVisible];
        _window = window;
        
    }
    return _window;
}

- (UpdateVersionView *)updateView
{
    if (!_updateView)
    {
        _updateView = [[UpdateVersionView alloc]initWithFrame:SCREEN_BOUNDS];
        _updateView.delegate = self;
    }
    return _updateView;
}

@end
