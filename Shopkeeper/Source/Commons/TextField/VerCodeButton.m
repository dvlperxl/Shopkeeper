//
//  VerCodeButton.m
//  kakatrip
//
//  Created by caiming on 16/9/26.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "VerCodeButton.h"



@interface VerCodeButton ()

@property(nonatomic, strong)UIButton *button;
@property(nonatomic, assign)NSTimeInterval timeTick;

@end

@implementation VerCodeButton

- (id)init
{
    if (self = [super init])
    {
        [self initSubviews];
    }
    return self;
}

- (void)onButtonAction
{
    
    if ([self.delegate respondsToSelector:@selector(verCodeButtonDidSelect:)])
    {
        
        [self.delegate verCodeButtonDidSelect:self];
    }
}

- (void)startTheTime:(NSTimeInterval)second
{
    
    _timeTick = second;
    
    self.button.enabled = NO;
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
//                 NSLog(@"%fEvent Handler",_timeTick);
                 if (_timeTick <= 0) {
                         dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
                         dispatch_async(mainQueue, ^{
                             self.button.enabled = YES;
                             [self.button setTitle:@"重新获取" forState:UIControlStateNormal];
                               [self.button setTitleColor:ColorWithHex(@"#ffffff") forState:UIControlStateNormal];
                             self.button.backgroundColor = ColorWithRGB(242, 151, 0, 1);

                             });
                     } else {
                             _timeTick--;
                             dispatch_async(mainQueue, ^{
                                 NSString *str = [NSString stringWithFormat:@"%@秒",@(_timeTick)];
                                 [self.button setTitle:str forState:UIControlStateNormal];
                                 self.button.backgroundColor = ColorWithRGB(235, 235, 235, 1);
                                 });
                         }
             });
         dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
                 NSLog(@"Cancel Handler");
         });
      dispatch_resume(timer);
}

- (void)endTheTiming
{
    _timeTick = 0;
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
}

#pragma mark -

- (void)initSubviews
{
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button setTitleColor:ColorWithHex(@"#ffffff") forState:UIControlStateNormal];
        _button.titleLabel.font = APPFONT(17);
        [_button addTarget:self action:@selector(onButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 8;
        _button.backgroundColor = ColorWithRGB(242, 151, 0, 1);
    }
    return _button;
}

@end
