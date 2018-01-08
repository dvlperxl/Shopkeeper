//
//  DeviceMessage.m
//  kakatrip
//
//  Created by CaiMing on 2016/11/14.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "DeviceMessage.h"
#import <AdSupport/AdSupport.h>
#import "KeyChain.h"

@implementation DeviceMessage

+ (NSString *)advertisingIdentifier
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog("idfa:%@",idfa);
    
    return idfa;
}

+ (NSString *)deviceUUID
{
    NSString *uuid = [KeyChain getUUID];
    
    if (uuid == nil) {
        
        uuid = [NSUUID UUID].UUIDString;
        [KeyChain setUUID:uuid];
    }
    
    NSLog(@"%@",uuid);
    
    return uuid;
}

@end
