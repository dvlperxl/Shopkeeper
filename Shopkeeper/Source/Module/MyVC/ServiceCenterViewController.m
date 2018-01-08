//
//  ServiceCenterViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/2.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ServiceCenterViewController.h"
#import <WebKit/WebKit.h>
//#import "NSString+Format.h"
//#import "TabBarViewController.h"
#import "KKWebViewBridge.h"
#import "KeyChain.h"

@interface ServiceCenterViewController ()<KKWebViewBridgeDelegate>

@property(nonatomic, strong)KKWebViewBridge *webView;
@property(nonatomic, strong)NSString *path;

@end

@implementation ServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.path = @"/api/pages/helpCenter/index.html";
    [self initSubviews];
    NSString *url = [self pathAppendBaseURL:self.path];
    self.webView.url  = [self urlAppendBaseParam:url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([url containsString:self.path])
    {
        self.leftButtonTitle = @"我的";
        
    }else
    {
        self.leftButtonTitle = @"返回";
    }
    
    [self.backBtn setTitle:self.leftButtonTitle forState:UIControlStateNormal];

    return YES;
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
