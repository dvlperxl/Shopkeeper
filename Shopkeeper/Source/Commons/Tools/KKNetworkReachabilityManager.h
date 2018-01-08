//
//  KKNetworkReachabilityManager.h
//  kakatrip
//
//  Created by CaiMing on 2016/12/29.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef NS_ENUM(NSInteger, KKNetworkReachabilityStatus)
{
    KKNetworkReachabilityStatusUnknown          = -1,
    KKNetworkReachabilityStatusNotReachable     = 0,
    KKNetworkReachabilityStatusReachableViaWWAN = 1,
    KKNetworkReachabilityStatusReachableViaWiFi = 2,
};

@protocol KKNetworkReachabilityDelegate <NSObject>

- (void)KKNetworkReachabilityStatus:(KKNetworkReachabilityStatus)networkReachabilityStatus;

@end

@interface KKNetworkReachabilityManager : NSObject

@property (nonatomic, weak)id<KKNetworkReachabilityDelegate>delegate;

@property (readonly, nonatomic, assign) KKNetworkReachabilityStatus networkReachabilityStatus;

SingletonH

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)removeDelegate:(id<KKNetworkReachabilityDelegate>)delegate;

@end
