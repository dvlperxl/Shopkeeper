//
//  RootVC.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RootVC.h"
#import "AppDelegate.h"
#import "UpdateVersionView.h"
#import "KKTimer.h"

@interface RootVC ()

@property(nonatomic, strong)UIImageView *bannerImageV;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property(nonatomic,assign)NSTimeInterval timeout;
@property(assign)dispatch_source_t timer;
@property(nonatomic,strong)UIButton *jumpButton;

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.bannerImageV];
    if ([AppConfig share].dev)
    {
        if ([KeyChain getToken].length<1)
        {
            [KeyChain setMobileNo:@"18926536250"];
            [KeyChain setToken:@"EvHJegY6hbf9N2UiZlwTs4zm+63SKBfdtIEw8v94NN2Qe/5czplwK6z7nUUi9ziUEx+cEhSZXrxbBkoVJGOkaqL4hosFf9oJRhoACQG9+44="];
        }
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.bannerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.offset(0);
        make.bottom.mas_lessThanOrEqualTo(self.bottomImageView.mas_top).offset(-3);
        
    }];
}



- (void)onJumpAction
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;

    if ([KeyChain getToken].length>0) {
        [app showTBC];
    }else{
        [app showLogin];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(onJumpAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"跳过3" forState:UIControlStateNormal];
    button.backgroundColor = ColorWithRGB(63, 58, 58, 0.5);
    button.layer.cornerRadius = 13;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = APPFONT(12);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _jumpButton = button;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(26);
        make.top.offset(38);
        make.right.offset(-15);
        
    }];
    
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;

    [self startTimer:3 handle:^{
        
        if ([KeyChain getToken].length>0) {
            [app showTBC];
        }else{
            [app showLogin];
        }

    }];

    
}

- (UIImageView *)bannerImageV
{
    if (!_bannerImageV) {
        
        _bannerImageV = [[UIImageView alloc]init];
        _bannerImageV.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImageV.image = Image(@"launch_banner");
    }
    return _bannerImageV;
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
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
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
            
            _timeout-=1;
            dispatch_async(mainQueue, ^{
  
                NSString *title = [NSString stringWithFormat:@"跳过%@",@(_timeout+1)];
                [self.jumpButton setTitle:title forState:UIControlStateNormal];
            });

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
