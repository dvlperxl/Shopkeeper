//
//  HNWebViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNWebViewController.h"

#import <WebKit/WebKit.h>
#import "KKWebViewBridge.h"

@interface HNWebViewController ()<KKWebViewBridgeDelegate>

@property(nonatomic, strong)KKWebViewBridge *webView;

@end

@implementation HNWebViewController

- (void)dealloc {
    [self.webView removeUserScript];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.customBackTitle == nil) {
        self.customBackTitle = @"返回";
    }
    [self initSubviews];
    self.navigationItem.title = self.webTitle;
    [self.webView installUserScript];
    if (_url) {
        self.webView.url = [self urlAppendBaseParam:_url];
    }
}
- (void)setUrl:(NSString *)url {
    _url = url;
    if ([self isViewLoaded]) {
        self.webView.url = [self urlAppendBaseParam:url];
    }
}
- (void)onBackBtnAction
{
    if ([self.webView.webView canGoBack])
    {
        [self.webView.webView goBack];
        
    }else
    {
        [super onBackBtnAction];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(0);
    }];
}


- (void)kkWebvView:(KKWebViewBridge *)kkWebView webViewTitle:(NSString *)title
{
    if (title&&title.length>0) {
        self.navigationItem.title = title;
    }
    NSLog(@"%@",title);
}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView documentTitle:(NSString *)title
{
    if (title&&title.length>0) {
        
        self.navigationItem.title = title;
    }
}

- (BOOL)kkWebvView:(KKWebViewBridge*)kkWebView openURL:(NSString*)url
{
    NSURL *aUrl = [NSURL URLWithString:self.url];
    
    if ([url containsString:aUrl.path])
    {
        [self.backBtn setTitle:self.customBackTitle forState:UIControlStateNormal];
        
    }else
    {
        [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    }
    return YES;
}
// 处理js回调
- (void)kkWebvView:(KKWebViewBridge *)kkWebView didReceiveScriptMessage:(KKScriptMessage *)message {
    
}
- (void)initSubviews
{
    [self.view addSubview:self.webView];
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
