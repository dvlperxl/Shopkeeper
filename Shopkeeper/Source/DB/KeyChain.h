//
//  KeyChain.h
//  kakatrip
//
//  Created by CaiMing on 2016/10/17.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChain : NSObject

+(void)setToken:(NSString *)token;
+(NSString *)getToken;

+(void)setUUID:(NSString *)uuid;
+(NSString*)getUUID;

+(void)setMobileNo:(NSString *)mobile;
+(NSString*)getMobileNo;


+(void)setUserId:(NSString *)userId;
+(NSString*)getUserId;

@end
