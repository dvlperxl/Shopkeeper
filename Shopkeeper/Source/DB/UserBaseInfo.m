//
//  UserBaseInfo.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "UserBaseInfo.h"
#import "AppDelegate.h"

@implementation UserBaseInfo

SingletonM

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uid":@"id"};
}

- (void)logout
{
    [KeyChain setToken:@""];
    [KeyChain setMobileNo:@""];
    [KeyChain setUserId:@""];
    self.userName = nil;
    
    [self showLogin];
}

#pragma mark - show

- (void)showLogin
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate showLogin];
}

@end
