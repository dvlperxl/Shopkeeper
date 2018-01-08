//
//  JPush.m
//  kakatrip
//
//  Created by CaiMing on 2016/11/28.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "JPush.h"

#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "RootTBC.h"
#import "AppDelegate.h"
//#import "NSURL+Scheme.h"

#import "KeyChain.h"


static NSString *channel = @"AppStore";

@interface JPush ()<JPUSHRegisterDelegate>

@property(nonatomic,strong)NSString *deviceToken;
@property(nonatomic,strong)NSString *registrationId;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation JPush

- (void)jPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    BOOL isProduction = NO;
    if ([AppConfig share].prod)
    {
        isProduction = YES;
    }
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:[AppConfig share].jpushAppkey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
//    //2.1.9版本新增获取registration id block接口。

}

+ (void)uploadRegistrationID
{
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        [[APIService share]httpRequestUploadDeviceToken:registrationID success:^(NSDictionary *responseObject) {
            
        } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
            
        }];
        
    }];
}

+ (void)setAlias:(NSString *)alias
{
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        
    
    } seq:1];

    
}

- (void)resetBadge
{
    [JPUSHService resetBadge];
}

+ (void)setBadge:(NSInteger)value
{
    [JPUSHService setBadge:value];
}

- (void)registerDeviceToken:(NSData *)deviceToken
{
    
    [JPUSHService registerDeviceToken:deviceToken];
    
    _deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                     stringByReplacingOccurrencesOfString:@">" withString:@""]
                                    stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self httpRequestUpLoadPushInfo];

}

- (void)httpRequestUpLoadPushInfo
{
    if (_registrationId==nil || _deviceToken == nil) {
        
        return;
    }
    
//    用户自定义属性接口:
//    /api/app/main/customProperty
//    需要请求头的token
//    返回结构:
//    {
//        "result": {
//            "registerAlias": "MTM4MTg0OTA0ODQ="
//        },
//        "status": 0
//    }
//
//    registerAlias就是注册极光的别名值
    //serverName = server_customProperty
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    
        if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
//            [rootViewController addNotificationCount];
            NSString *urlScheme = [userInfo objectForKey:@"url"];
            if (urlScheme) {
                
                NSURL *url = [NSURL URLWithString:urlScheme];
                [self handlePushScheme:url];
                
            }
            NSDictionary *data = [userInfo objectForKey:@"extras"];
            
            if (data) {
                [self handlePushInfo:data];
            }

        }
    
    if (completionHandler) {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wunguarded-availability"

#pragma mark- JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    //    UNNotificationRequest *request = notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
        {
            [JPUSHService handleRemoteNotification:userInfo];
            NSLog(@"iOS10 前台收到远程通知:%@",userInfo);
        }
        else {
            // 判断为本地通知
            //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"%@",[CMRouter sharedInstance].rootViewController);
    
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            [JPUSHService handleRemoteNotification:userInfo];
            NSString *urlScheme = [userInfo objectForKey:@"url"];
            if (urlScheme) {
                
                NSURL *url = [NSURL URLWithString:urlScheme];
                [self handlePushScheme:url];
                
            }
            
            NSDictionary *data = [userInfo objectForKey:@"extras"];
            
            if (data) {
                [self handlePushInfo:data];
            }
            
        }
        else {
            
        }
    } else {
        // Fallback on earlier versions
    }
    
    completionHandler();  // 系统要求执行这个方法
}


#pragma clang diagnostic pop


#endif


- (void)handlePushScheme:(NSURL*)url
{
//    if ([url.scheme isEqualToString:@"kakatrip"])
//    {
//        NSDictionary *data = [url kakatripSchemeParam];
//        [self handlePushInfo:data];
//    }
}


- (void)handlePushInfo:(NSDictionary *)userInfo
{

    id data = userInfo;
    NSDictionary *message;
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        message = [NSObject dataFormJsonString:data];
    }
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        
        message = data;
    }
    
    if ([message isKindOfClass:[NSDictionary class]]) {
        
        
        NSString *isNative = STRINGWITHOBJECT(message[@"isNative"]);
        
        if ([isNative isEqualToString:@"0"])
        {
            RouterModel *model = [RouterModel new];
            NSMutableDictionary *param = @{}.mutableCopy;
            [param setObject:message[@"serverUrl"] forKey:@"url"];
            model.param = param.copy;
            model.className = @"WebViewController";
            
            RootTBC *tbc = (RootTBC*)[CMRouter sharedInstance].rootViewController;
            if ([tbc isKindOfClass:[RootTBC class]])
            {
                [tbc showNativePage:model];
                
            }else
            {
                AppDelegate *appDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.model = model;
            }
        }
    }

    
}

@end
