//
//  ExpertsListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ExpertsListViewController.h"
#import <WebKit/WebKit.h>
#import "KKWebViewBridge.h"
#import "KeyChain.h"

@interface ExpertsListViewController ()<KKWebViewBridgeDelegate>

@property(nonatomic, strong)KKWebViewBridge *webView;

@end

@implementation ExpertsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    NSString *url = [self pathAppendBaseURL:@"/api/pages/expertAppointment/index.html"];
    self.webView.url  = [self urlAppendBaseParam:url];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
       make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView webViewTitle:(NSString *)title
{
    if (title&&title.length>0) {
        
        self.navigationItem.title = title;
    }
}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView documentTitle:(NSString *)title
{
    if (title&&title.length>0) {
        
        self.navigationItem.title = title;
    }
}


- (BOOL)kkWebvView:(KKWebViewBridge*)kkWebView openURL:(NSString*)url
{
    if ([url hasPrefix:@"http"]) {
        [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":url}];
        return NO;
    }
    return YES;
}

- (void)initSubviews
{
    [self.view addSubview:self.webView];
    [self setScrollViewInsets:@[self.webView.webView.scrollView]];
}

- (KKWebViewBridge *)webView
{
    if (!_webView) {
        
        _webView = [[KKWebViewBridge alloc]init];
        _webView.delegate = self;
    }
    return _webView;
}

@end
