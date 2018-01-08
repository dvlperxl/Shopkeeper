//
//  DeviceMessage.h
//  kakatrip
//
//  Created by CaiMing on 2016/11/14.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceMessage : NSObject

+ (NSString *)deviceUUID;
+ (NSString *)advertisingIdentifier;

@end
