//
//  JPush.h
//  kakatrip
//
//  Created by CaiMing on 2016/11/28.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPush : NSObject

- (void)jPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)registerDeviceToken:(NSData *)deviceToken;
- (void)resetBadge;
+ (void)setBadge:(NSInteger)value;

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)handlePushInfo:(NSDictionary *)userInfo;
- (void)handlePushScheme:(NSURL*)url;
+ (void)setAlias:(NSString *)alias;

+ (void)uploadRegistrationID;

@end
