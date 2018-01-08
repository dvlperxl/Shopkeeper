//
//  WebViewController.m
//  kakatrip
//
//  Created by caiming on 16/10/10.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
//#import "NSString+Format.h"
//#import "TabBarViewController.h"
#import "KKWebViewBridge.h"
#import "KeyChain.h"

@interface WebViewController ()<KKWebViewBridgeDelegate>

@property(nonatomic, strong)KKWebViewBridge *webView;

@property(nonatomic, strong)UIBarButtonItem *menuButton;
@property(nonatomic, assign)BOOL isShowCloseButton;

@property(nonatomic, strong)NSDictionary *shareParam;
@property(nonatomic, strong)UIImage *shareThumbImage;

@end

@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setScrollViewInsets:@[self.webView.webView.scrollView]];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
    if (self.webTitle)
    {
        self.navigationItem.title = self.webTitle;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)initSubviews
{
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];

}

- (KKWebViewBridge *)webView
{
    if (!_webView) {
        
        _webView = [[KKWebViewBridge alloc]init];
        _webView.delegate = self;
        _webView.url = self.url;
    }
    
    return _webView;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    self.webView.url = _url;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [self.webView removeUserScript];
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.webView installUserScript];
    [super viewWillAppear:animated];
}

- (void)onMenuButtonAction
{
    
//    BOOL install = [[WeChatShare share]isInstallWeChat];
//
//    if (install == NO) {
//
//        [KKProgressHUD showErrorAddTo:self.view message:@"抱歉，您尚未安装可分享应用"];
//        return;
//    }
//
//    ShareView *shareView = [[ShareView alloc]initWithFrame:CGRectZero];
//
//    ShareItem *friendItem = [ShareItem shareItemWithImage:@"wechatFriend" title:@"发送给朋友" handler:^(ShareItem *item) {
//
//        [[WeChatShare share]shareFriendWithTitle:self.shareParam[@"title"] content:self.shareParam[@"content"] image:self.shareThumbImage link:self.shareParam[@"link"]];
//
//    }];
//    ShareItem *friendCircleItem = [ShareItem shareItemWithImage:@"wechatCircle" title:@"分享到朋友圈" handler:^(ShareItem *item) {
//        [[WeChatShare share]shareFriendOfCricleWithTitle:self.shareParam[@"title"] content:self.shareParam[@"content"] image:self.shareThumbImage link:self.shareParam[@"link"]];
//    }];
//
//    [shareView showMenuWithShareItems:@[friendItem,friendCircleItem]];
}

- (void)onBackBtnAction
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];

    }else
    {
        [super onBackBtnAction];
    }

}


- (void)onCloseBtnAction
{
//     [super onBackBtnAction];
}

- (void)initLeftBarButtonItems
{
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 20, 20);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"blue_arrow_back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(onBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil
//                                       action:nil];
//    negativeSpacer.width = 0;//
//
//    UIBarButtonItem* closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseBtnAction)];
//
//
//    NSMutableArray *btns = [NSMutableArray arrayWithObjects:negativeSpacer,backItem, nil];
//
//    if (_isShowCloseButton) {
//
//        [btns addObject:closeItem];
//    }
//
//    [self.navigationItem setLeftBarButtonItems:btns animated:NO];
}

#pragma mark - KKWebViewBridgeDelegate

- (void)kkWebvView:(KKWebViewBridge *)kkWebView didReceiveScriptMessage:(KKScriptMessage *)message
{
    
    NSString *methodName = message.name;
    NSDictionary *param = message.body;
    NSLog(@"%@",methodName);
    NSLog(@"%@",param);
    
    if ([methodName isEqualToString:@"KaKaTrip"])
    {
        if (param) {
            
            NSString *action = param[@"action"];

            if ([action isEqualToString:@"showNativePage"]) {

                [self showNativeViewControllerWithParam:param[@"param"]];

            }else if ([action isEqualToString:@"setTitle"])
            {
                [self setNavTitle:param[@"param"]];

            }else if ([action isEqualToString:@"hideMenu"])
            {
                [self hideMenu];

            }else if ([action isEqualToString:@"showMenu"])
            {
                [self showMenu];

            }else if ([action isEqualToString:@"hideCloseButton"])
            {
                [self hideCloseButton];

            }else if ([action isEqualToString:@"share"])
            {
                [self share:param[@"param"]];
            }
            else if ([action isEqualToString:@"setShare"])
            {
                [self setShare:param[@"param"]];
                
            }else if ([action isEqualToString:@"setUserInfo"])
            {
                [self setUserInfo:param[@"param"]];
            }
            
        }
    }

}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView webViewTitle:(NSString *)title
{

    _isShowCloseButton = [kkWebView canGoBack];
    [self initLeftBarButtonItems];

    if (title&&title.length>0) {

        self.navigationItem.title = title;
    }
    NSLog(@"%@",title);
}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView documentTitle:(NSString *)title
{
    NSLog(@"%@",title);
    if (title)
    {
        self.navigationItem.title = title;
    }
}

#pragma mark - native method

- (void)showNativeViewControllerWithParam:(NSDictionary *)param
{

//    TabBarViewController *tbc = (TabBarViewController*)[[KKRouter sharedInstance]rootViewController];
//    if ([tbc isKindOfClass:[TabBarViewController class]])
//    {
//        [tbc showNativePage:param];
//    }
    
}

- (void)setNavTitle:(NSDictionary *)param
{
    self.navigationItem.title = param[@"title"];
}

- (void)hideMenu
{
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)showMenu
{
    self.navigationItem.rightBarButtonItem = self.menuButton;
}

- (void)hideCloseButton
{
    _isShowCloseButton = NO;
    [self initLeftBarButtonItems];
}

- (void)setShare:(NSDictionary *)param
{
    [self share:param];
    [self onMenuButtonAction];
}

- (void)share:(NSDictionary *)param
{
    [self showMenu];
    self.shareParam = param;
}

- (void)setUserInfo:(NSDictionary*)param
{
    if (param) {
        
        NSString *token = param[@"token"];
        NSString *mobile = param[@"mobile"];
        [KeyChain setToken:token];
        [KeyChain setMobileNo:mobile];
//        [[NSNotificationCenter defaultCenter]postNotificationName:Notification_Login object:nil];
    }
}

- (UIBarButtonItem *)menuButton
{
    if (!_menuButton) {
        
        _menuButton =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webMenu"]
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(onMenuButtonAction)];
        
    }
    
    return _menuButton;
}



- (void)setShareParam:(NSDictionary *)shareParam
{
    if (shareParam != nil) {
        
        _shareParam = shareParam;
        
        NSString *url = shareParam[@"image"];
        
        UIImageView *imagev = [UIImageView new];
        
        __weak WebViewController *weakSelf = self;
        [imagev kk_setImageWithURLString:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (weakSelf) {
                weakSelf.shareThumbImage = image;
            }
        }];
        
    }
}

- (UIImage *)shareThumbImage
{
    if (!_shareThumbImage) {
        
        _shareThumbImage = [UIImage imageNamed:@"aboutIcon"];
    }

    return _shareThumbImage;
}


////将文件copy到tmp目录
//- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
//    NSError *error = nil;
//    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
//        return nil;
//    }
//    // Create "/temp/www" directory
//    NSFileManager *fileManager= [NSFileManager defaultManager];
//    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
//    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
//    
//    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
//    // Now copy given file to the temp directory
//    [fileManager removeItemAtURL:dstURL error:&error];
//    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
//    // Files in "/temp/www" load flawlesly :)
//    return dstURL;
//}

@end
