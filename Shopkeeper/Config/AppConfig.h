//
//  AppConfig.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

@property(nonatomic,readonly)NSString *bugLyAppId;//
@property(nonatomic,readonly)NSString *jpushAppkey;//

SingletonH

- (BOOL)test;
- (BOOL)dev;
- (BOOL)prod;
- (void)checkVersion;


@end
