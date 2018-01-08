//
//  AppDelegate.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "HNDataBase.h"
#import "KKNetworkReachabilityManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <Bugly/Bugly.h>
#import "JPush.h"
#import <AlipaySDK/AlipaySDK.h>
#import "KaKaPay.h"

#ifdef Dev

#import <FLEX/FLEX.h>

#endif


@interface AppDelegate ()

@property(nonatomic, strong)UILongPressGestureRecognizer *tap;
@property(nonatomic, strong)JPush *jPush;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //注册JPush
    [self.jPush jPushApplication:application didFinishLaunchingWithOptions:launchOptions];

    [Bugly startWithAppId:[AppConfig share].bugLyAppId];
    [[UINavigationBar appearance]setTintColor:ColorWithRGB(242, 151, 0, 1)];
    [self showRootVC];
    [self.window makeKeyAndVisible];
    [[AppConfig share] checkVersion];
    [IQKeyboardManager sharedManager].enable = YES;
    
    if (@available(iOS 11.0, *))
    {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
#if Dev

    self.tap  = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(handleSixFingerQuadrupleTap:)];
    self.tap.minimumPressDuration = 3;
    [self.window addGestureRecognizer:self.tap];
    
#endif
    [[HNDataBase share] areaList];
//    NSLog(@"%ld",(long)[KKNetworkReachabilityManager share].networkReachabilityStatus);
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self.jPush registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self handleOpenUrl:url];
}


- (BOOL)handleOpenUrl:(NSURL *)url
{
    
    if ([url.scheme isEqualToString:@"shopkeeper"])
    {
        [self.jPush handlePushScheme:url];
        
    }else if ([url.scheme isEqualToString:@"hnappalipay"])//支付宝
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [[KaKaPay share]alipayCompletion:resultDic];
            
        }];
    }
    
    return YES;
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [self.jPush application:application
didReceiveRemoteNotification:userInfo
     fetchCompletionHandler:completionHandler];
    
}


#if Dev
- (void)handleSixFingerQuadrupleTap:(UILongPressGestureRecognizer *)tapRecognizer
{
    
    if (tapRecognizer.state == UIGestureRecognizerStateRecognized) {
        // This could also live in a handler for a keyboard shortcut, debug menu item, etc.
        [[FLEXManager sharedManager] showExplorer];
    }
    
}
#endif

- (void)showRootVC
{
    self.window.rootViewController = [[CMRouter sharedInstance]getObjectWithClassName:@"RootVC"];
}

- (void)showTBC
{
    self.window.rootViewController = [[CMRouter sharedInstance]getObjectWithClassName:@"RootTBC"];
}

- (void)showLogin
{
    UINavigationController *nc = [[BaseNavigationController alloc]initWithRootViewController:[[CMRouter sharedInstance]getObjectWithClassName:@"UserHomeViewController"]];
    self.window.rootViewController = nc;

}

- (JPush *)jPush
{
    if (!_jPush) {
        
        _jPush = [JPush new];
    }
    return _jPush;
}

@end
