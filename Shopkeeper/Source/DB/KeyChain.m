//
//  KeyChain.m
//  kakatrip
//
//  Created by CaiMing on 2016/10/17.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KeyChain.h"
#import "KeychainItemWrapper.h"

@implementation KeyChain

+(NSString *)getToken
{
    NSDictionary *secValueData = [[self class] getKeySecValueData];
    NSString *token = [secValueData objectForKey:@"token"];
    if (token == nil) {
        token = @"";
    }
    return token;
}

+(void)setToken:(NSString *)token
{
    NSMutableDictionary *secValueData = [[self class] getKeySecValueData].mutableCopy;
    [secValueData setObject:token forKey:@"token"];
    [[self class]setKeySecValueData:secValueData.copy];
}


+(NSDictionary *)getKeySecValueData
{
    
    NSDictionary *secValueData = [[NSUserDefaults standardUserDefaults]objectForKey:@"kakatrip"];
    if (secValueData == nil) {
        secValueData = @{};
    }
    return secValueData;
}

+ (void)setKeySecValueData:(NSDictionary *)secValueData
{
    NSLog(@"%@",secValueData);
    [[NSUserDefaults standardUserDefaults]setObject:secValueData forKey:@"kakatrip"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}



+(void)setUUID:(NSString *)uuid
{
    NSMutableDictionary *secValueData = [[self class] getKeySecValueData].mutableCopy;
    [secValueData setObject:uuid forKey:@"deviceId"];
    [[self class]setKeySecValueData:secValueData];
    
}
+(NSString*)getUUID
{
    
    NSDictionary *secValueData = [[self class] getKeySecValueData];
    NSString *uuid = [secValueData objectForKey:@"deviceId"];
    return uuid;
}

+(void)setMobileNo:(NSString *)mobile
{
    NSMutableDictionary *secValueData = [[self class] getKeySecValueData].mutableCopy;
    [secValueData setObject:mobile forKey:@"mobile"];
    [[self class]setKeySecValueData:secValueData];
}

+(NSString*)getMobileNo
{
    NSDictionary *secValueData = [[self class] getKeySecValueData];
    NSString *mobile = [secValueData objectForKey:@"mobile"];
    return mobile;
}

+(void)setUserId:(NSString *)userId
{
    NSMutableDictionary *secValueData = [[self class] getKeySecValueData].mutableCopy;
    [secValueData setObject:userId forKey:@"userId"];
    [[self class]setKeySecValueData:secValueData];
}

+(NSString*)getUserId
{
    NSDictionary *secValueData = [[self class] getKeySecValueData];
    NSString *userId = [secValueData objectForKey:@"userId"];
    return userId;
}

@end
