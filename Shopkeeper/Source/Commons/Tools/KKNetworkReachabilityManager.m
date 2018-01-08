//
//  KKNetworkReachabilityManager.m
//  kakatrip
//
//  Created by CaiMing on 2016/12/29.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KKNetworkReachabilityManager.h"


typedef void (^KKNetworkReachabilityStatusBlock)(KKNetworkReachabilityStatus status);

@interface KKNetworkReachabilityManager ()

@property(nonatomic,strong)NSMutableArray *delegates;

@end

@implementation KKNetworkReachabilityManager

SingletonM

-(id)init
{
    if (self = [super init])
    {
    }
    
    [self networkReachability];
    
    return self;
}

- (KKNetworkReachabilityStatus)networkReachabilityStatus
{
    return [self kkNetworkReachabilityStatusOfAFNetworkReachabilityStatus:[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus];
}

- (void)networkReachability
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
          KKNetworkReachabilityStatus kkStatus = [self kkNetworkReachabilityStatusOfAFNetworkReachabilityStatus:status];
        
        for (id delegate in self.delegates) {
            
            if ([delegate respondsToSelector:@selector(KKNetworkReachabilityStatus:)]) {
                [delegate KKNetworkReachabilityStatus:kkStatus];
            }
        }
        
    }];
    
    [manager startMonitoring];
}

- (KKNetworkReachabilityStatus)kkNetworkReachabilityStatusOfAFNetworkReachabilityStatus:(AFNetworkReachabilityStatus)status
{
    KKNetworkReachabilityStatus kkStatus = KKNetworkReachabilityStatusUnknown;
    
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            kkStatus = KKNetworkReachabilityStatusUnknown;
            NSLog(@"未识别的网络");
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"不可达的网络(未连接)");
            kkStatus = KKNetworkReachabilityStatusNotReachable;
            
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            kkStatus = KKNetworkReachabilityStatusReachableViaWWAN;
            
            NSLog(@"2G,3G,4G...的网络");
            
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
            kkStatus = KKNetworkReachabilityStatusReachableViaWiFi;
            
            NSLog(@"wifi的网络");
            
            break;
        default:
            break;
    }
    
    return kkStatus;
}

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)stopMonitoring
{
    
}

- (void)setDelegate:(id<KKNetworkReachabilityDelegate>)delegate
{
    _delegate = delegate;
    if (![self.delegates containsObject:_delegate]) {
        [self.delegates addObject:_delegate];
    }
}

- (void)removeDelegate:(id<KKNetworkReachabilityDelegate>)delegate
{
    _delegate = delegate;
    if ([self.delegates containsObject:_delegate]) {
        [self.delegates removeObject:_delegate];
    }

}

- (NSMutableArray *)delegates
{
    if (!_delegates) {
        
        _delegates = [NSMutableArray arrayWithCapacity:1];
    }
    return _delegates;
}

@end
