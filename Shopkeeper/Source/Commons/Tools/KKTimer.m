//
//  KKTime.m
//  kakatrip
//
//  Created by CaiMing on 2017/3/16.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KKTimer.h"



@interface KKTimer ()

@property(nonatomic,assign)NSTimeInterval timeout;
@property(assign)dispatch_source_t timer;

@end


@implementation KKTimer

+ (KKTimer*)startTimer:(NSTimeInterval)timeInterval handle:(KKTimeoutCallBack)handle
{
    KKTimer *time = [[KKTimer alloc]init];
    [time startTimer:timeInterval handle:handle];
    return time;
}

- (void)startTimer:(NSTimeInterval)timeInterval handle:(KKTimeoutCallBack)handle
{
    _timeout = timeInterval;
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    _timer = timer;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
        
      NSLog(@"Event Handler - %@",@(_timeout));
      if (_timeout <= 0)
        {
            NSLog(@"timeOut");
            dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
            dispatch_async(mainQueue, ^{
                if (handle) {
                    handle();
                }
            });
      
            
        }else {
            
            _timeout-=timeInterval;
        }

        
    });
    dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
        NSLog(@"Cancel Handler");
    });
    dispatch_resume(timer);
}

- (void)cancelTimer
{
    dispatch_source_cancel(_timer);
}


@end
