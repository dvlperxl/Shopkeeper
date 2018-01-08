//
//  InformationViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "InformationViewController.h"
#import <WebKit/WebKit.h>
//#import "NSString+Format.h"
//#import "TabBarViewController.h"
#import "KKWebViewBridge.h"
#import "KeyChain.h"

@interface InformationViewController ()<KKWebViewBridgeDelegate>

@property(nonatomic, strong)KKWebViewBridge *webView;
@property(nonatomic,strong)NSString *fromBH5PageUrl;
@property(nonatomic,strong)NSString *fromBH5QueryUrl;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton * searchButton;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    [self httpRequestQueryH5PageURL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestQueryH5PageURL
{
    [[APIService share]httpRequestQueryH5PageURLSuccess:^(NSDictionary *responseObject)
     {
         self.fromBH5PageUrl = responseObject[@"fromBH5PageUrl"];
         self.fromBH5QueryUrl = responseObject[@"fromBH5QueryUrl"];
         self.webView.url = [self urlAppendBaseParam:self.fromBH5PageUrl];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject)
    {
        __weak typeof(self) weakSelf = self;
        KKLoadFailureAndNotResultView *resultView = [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                    tapBlock:^{
                                                                                                        
                                                                                                        [weakSelf httpRequestQueryH5PageURL];
                                                                                                        
                                                                                                    }];
        [self.view addSubview:resultView];
        
    }];
}

- (void)onSearchButtonAction
{
    if (self.fromBH5QueryUrl) {
        [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":self.fromBH5QueryUrl,@"leftButtonTitle":@"资讯"}];
    }
}

- (BOOL)kkWebvView:(KKWebViewBridge*)kkWebView openURL:(NSString*)url
{
    NSURL *aUrl = [NSURL URLWithString:self.fromBH5PageUrl];
    
    if (![url containsString:aUrl.path])
    {
        [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":url,@"leftButtonTitle":@"资讯"}];
        return NO;
    }
    return YES;
}

- (void)initSubviews
{
    [self.view addSubview:self.webView];

    [self setScrollViewInsets:@[self.webView.webView.scrollView]];

    self.navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 116);
    [self.navView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.bottom.offset(-12);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(45);
    }];
    
    
    
    [self.navView addSubview:self.searchButton];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(145);
        make.height.mas_equalTo(36);
        make.bottom.offset(-12);
        make.right.offset(-15);
    }];
    
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc]initWithImage:Image(@"nongdingtoutiao")];
    }
    return _imageView;
}

- (KKWebViewBridge *)webView
{
    if (!_webView) {
        
        _webView = [[KKWebViewBridge alloc]init];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIButton*)searchButton
{
    if (!_searchButton) {
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.layer.masksToBounds = YES;
        _searchButton.layer.cornerRadius = 18;
        _searchButton.backgroundColor =ColorWithRGB(245, 245, 245, 1);
        [_searchButton addTarget:self action:@selector(onSearchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        //
        UIImageView *imageView = [[UIImageView alloc]initWithImage:Image(@"icon_search")];
        [_searchButton addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(11);
            make.centerY.equalTo(_searchButton.mas_centerY).offset(0);
            make.width.height.mas_equalTo(12);
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"农事百事通";
        lab.textColor = ColorWithRGB(142, 142, 147, 1);
        lab.font = APPFONT(17);
        [_searchButton addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(31);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(_searchButton.mas_centerY).offset(0);
        }];
        
    }
    return _searchButton;
}

@end
