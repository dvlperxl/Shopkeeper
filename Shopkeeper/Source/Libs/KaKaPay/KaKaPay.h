//
//  KaKaPay.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/18.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^KKPayBlock)(BOOL success);

@interface KaKaPay : NSObject

SingletonH


- (void)kakaPay:(NSNumber*)orderId
        payType:(NSString*)payType
        payInfo:(NSDictionary*)payInfo
       payBlock:(KKPayBlock)payBlock;

- (void)wechatPayCompletion:(NSInteger)errorCode;
- (void)alipayCompletion:(NSDictionary*)resultDict;
//- (BOOL)isInstallWeChat;

@end
