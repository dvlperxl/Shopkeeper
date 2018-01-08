//
//  KKTime.h
//  kakatrip
//
//  Created by CaiMing on 2017/3/16.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

typedef void(^KKTimeoutCallBack)(void);

#import <Foundation/Foundation.h>

@interface KKTimer : NSObject

+ (KKTimer*)startTimer:(NSTimeInterval)timeInterval handle:(KKTimeoutCallBack)handle;

- (void)cancelTimer;




@end
