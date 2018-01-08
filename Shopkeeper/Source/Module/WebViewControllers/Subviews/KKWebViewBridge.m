//
//  KKWebViewBridge.m
//  kakatrip
//
//  Created by CaiMing on 2016/12/29.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "KKWebViewBridge.h"
#import "KeyChain.h"
#import "NSURL+Scheme.h"

@interface KKScriptMessage ()

/*! @abstract The body of the message.
 @discussion Allowed types are NSNumber, NSString, NSDate, NSArray,
 NSDictionary, and NSNull.
 */
@property (nonatomic, readwrite, copy) id body;

/*! @abstract The name of the message handler to which the message is sent.
 */

@property (nonatomic, readwrite, copy) NSString *name;

@end

@implementation KKScriptMessage

@end

@interface KKWebViewBridge ()<UIWebViewDelegate,WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) NSMutableURLRequest *request;
@property(nonatomic, strong) WKUserContentController *userContentController;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) NSArray *loadJSBridge;
@property(nonatomic, strong) NSString *JSBridgeConfig;
@property (nonatomic, readwrite) BOOL canGoBack;
@property (nonatomic, assign) BOOL failure;

@property(nonatomic,strong)NSURL *currentDisPlayURL;

@property(nonatomic,strong)KKLoadFailureAndNotResultView *resultView;

@end

@implementation KKWebViewBridge

- (id)init
{
    if (self = [super init]) {
        
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews
{
    [self addSubview:self.webView];
    [self addSubview:self.progressView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.offset(0);
    }];
    
    NSLog(@"%@",self.webView.scrollView);
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(2);
    }];
}

- (BOOL)canGoBack
{
    return self.webView.canGoBack;
}

- (void)goBack
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
//        [self reload];
    }
}

- (void)reload
{
    [self.webView reload];
}

- (void)removeUserScript
{
    [self.userContentController removeAllUserScripts];
    [self.userContentController removeScriptMessageHandlerForName:@"hnapp"];
}

- (void)installUserScript
{
    WKUserContentController *userController = self.userContentController;
    [userController addScriptMessageHandler:self name:@"hnapp"];

//    if ([self isInstallScript]) {
//
//
////        WKUserScript *script = [[WKUserScript alloc]initWithSource:[NSString stringWithFormat:@"KaKaTripApp = %@;",[self JSData]] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
////        [userController addUserScript:script];
//
////        WKUserScript *bridgeScript = [[WKUserScript alloc]initWithSource:self.JSBridgeConfig
////                                                           injectionTime:WKUserScriptInjectionTimeAtDocumentStart
////                                                        forMainFrameOnly:YES];
////
////        [userController addUserScript:bridgeScript];
////
////        WKUserScript *initScript = [[WKUserScript alloc]initWithSource:@"KaKaTripApp.init();"
////                                                         injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
////                                                      forMainFrameOnly:YES];
////
////        [userController addUserScript:initScript];
//
//    }
//
}

- (BOOL)isInstallScript
{

    NSString *host = [NSURL URLWithString:_url].host;
    
    if (host) {
        
        for (NSString *domain in self.loadJSBridge)
        {
            NSRange range = [domain rangeOfString:host];
            
            if (range.length>0)
            {
                return YES;
            }
        }
    }
    
    return NO;
}


- (void)setUrl:(NSString *)url
{
    _url = url;
    [self.webView loadRequest:self.request];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"start");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    if ([self.delegate respondsToSelector:@selector(kkWebvView:webViewTitle:)]) {
        
        [self.delegate kkWebvView:self webViewTitle:self.webView.title];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"success");
    [webView  evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        if ([self.delegate respondsToSelector:@selector(kkWebvView:documentTitle:)]) {
            
            [self.delegate kkWebvView:self documentTitle:result];
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error
{
    NSLog(@"xxxxxx");
    
    if (error.code != -1009) {
//        [KKProgressHUD showErrorAddTo:self message:@"加载失败,请稍后重试"];
    }else
    {
//        [KKProgressHUD showErrorAddTo:self message:@"网络错误,请检查网络设置"];
        
        
        __weak typeof(self) weakSelf = self;
        
        KKLoadFailureAndNotResultView *errorView = [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:error.code tapBlock:^{
            
            if (weakSelf.currentDisPlayURL) {
                weakSelf.request.URL = weakSelf.currentDisPlayURL;
            }
            [weakSelf.webView loadRequest:weakSelf.request];
            
        }];
        errorView.frame = self.bounds;
        [self addSubview:errorView];
    }
}

//在发送请求之前，决定是否跳转

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    NSLog(@"%@",url);
    _currentDisPlayURL = url;
    
    NSString *scheme = url.scheme;
    if ([scheme isEqualToString:@"tel"])
    {
        [Mobile telephone:[url resourceSpecifier]];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else if ([scheme isEqualToString:@"sms:"])
    {
        UIApplication * app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }else
    {
//        if ([url.absoluteString isEqual:self.url])
//        {
//            decisionHandler(WKNavigationActionPolicyAllow);
//            
//        }else
        if ([self.delegate respondsToSelector:@selector(kkWebvView:openURL:)]) {
            
            BOOL open =  [self.delegate kkWebvView:self openURL:url.absoluteString];
            decisionHandler(open?WKNavigationActionPolicyAllow:WKNavigationActionPolicyCancel);
            
        }
        else
        {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    }
    
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    
    
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    NSLog(@"%@",frameInfo);
    
    if (![frameInfo isMainFrame]) {
        
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
    
}



// 在收到响应后，决定是否跳转

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    KKAlertView *alert = [[KKAlertView alloc]init];
    KKAlertAction *action = [KKAlertAction alertActionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
       
        completionHandler();
        
    }];
    [alert showAlertActionViewWithTitle:message actions:@[action]];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"hnapp"]) {
        if ([self.delegate respondsToSelector:@selector(kkWebvView:didReceiveScriptMessage:)])
        {
            KKScriptMessage *kkScripeMessage = [KKScriptMessage new];
            kkScripeMessage.name = message.name;
            kkScripeMessage.body = message.body;
            [self.delegate kkWebvView:self didReceiveScriptMessage:kkScripeMessage];
        }
    }
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress: %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.webView.estimatedProgress == 1.0)
        {
            [self performSelector:@selector(hiddenProgressView) withObject:nil afterDelay:0.5];
        }
    }
}

- (void)hiddenProgressView
{
    self.progressView.progress = 0;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc]init];
        _progressView.progressTintColor=ColorWithRGB(242, 151, 0, 1);
        _progressView.trackTintColor=[UIColor clearColor];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    
    return _progressView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        
//        [self setUserAgent];
        
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能js自动通过窗口打开，需要通过用户交互才能打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.userContentController = self.userContentController;

        WKWebView * WK;
        WK = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        WK.backgroundColor = [UIColor whiteColor];
        WK.UIDelegate = self;
        WK.navigationDelegate = self;
        _webView = WK;
        
        [_webView addObserver:self
                     forKeyPath:@"estimatedProgress"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    }
    
    return _webView;
}

- (WKUserContentController*)userContentController
{
    
    if (!_userContentController) {
        
        _userContentController =  [[WKUserContentController alloc] init];
        
//        NSMutableString*javascript = [NSMutableString string];
//
//        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
//
//        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript
//                                                                injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
//                                                             forMainFrameOnly:YES];
//        [_userContentController addUserScript:noneSelectScript];
        
    }
    return _userContentController;
}

- (NSMutableURLRequest *)request
{
    if (!_request) {

        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:300.0];
    }
    
    return _request;
}


//- (void)setUserAgent
//{
//    NSString *userAgent = [AppConfig share].defaultUserAgent;
//    NSString *kakatripUA = [NSString stringWithFormat:@"cn.kakatrip.ios/%@",APP_SHORT_VERSION];
//    NSString *newUserAgent = STRING(userAgent, kakatripUA);
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent,@"UserAgent", nil];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//}
//
//- (NSString *)JSData
//{
//    NSString *token = [KeyChain getToken];
//    if (token== nil) {
//        token = @"";
//    }
//    NSMutableDictionary *dict = @{}.mutableCopy;
//    [dict setObject:@"iPhone" forKey:@"platform"];
//    [dict setObject:APP_SHORT_VERSION forKey:@"version"];
//    [dict setObject:token forKey:@"token"];
//    return [NSObject jsonStringFromData:dict];
//}

//- (NSString *)JSBridgeConfig
//{
////    NSString *jsString = [AppConfig share].JSBridgeConfig;
//
//    if (jsString) {
//
//        _JSBridgeConfig = jsString;
//    }
//
//    if (_JSBridgeConfig == nil) {
//
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"KaKaTripJSBridge" ofType:@"js"];
//
//        _JSBridgeConfig = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    }
//
//    return _JSBridgeConfig;
//}

//- (NSArray*)loadJSBridge
//{
//
//    AppConfig *appcofig = [AppConfig share];
//
//    if (appcofig.loadJSBridgeList) {
//
//        _loadJSBridge = appcofig.loadJSBridgeList;
//
//    }
//
//    if (!_loadJSBridge) {
//
//        _loadJSBridge = @[@"https://h5.kalv.mobi",@"https://h5.kakatrip.cn"];
//    }
//    return _loadJSBridge;
//}

//- (void)KKNetworkReachabilityStatus:(KKNetworkReachabilityStatus)networkReachabilityStatus
//{
//    switch (networkReachabilityStatus) {
//        case KKNetworkReachabilityStatusUnknown:
//            NSLog(@"未识别的网络");
//            break;
//
//        case KKNetworkReachabilityStatusNotReachable:
//            NSLog(@"不可达的网络(未连接)");
//            break;
//
//        case KKNetworkReachabilityStatusReachableViaWWAN:
//            NSLog(@"2G,3G,4G...的网络");
//            if (_failure == YES) {
//
//                _failure = NO;
//                [self.webView loadRequest:self.request];
//            }
//
//            break;
//
//        case KKNetworkReachabilityStatusReachableViaWiFi:
//            NSLog(@"wifi的网络");
//            if (_failure == YES) {
//
//                _failure = NO;
//                [self.webView loadRequest:self.request];
//
//            }
//            break;
//        default:
//            break;
//    }
//
//}

- (void)onTapAction
{
    [self.resultView removeFromSuperview];
    if (self.currentDisPlayURL) {
        self.request.URL = self.currentDisPlayURL;
    }
    [self.webView loadRequest:self.request];
}


-(UITapGestureRecognizer *)tap{
    
    if (!_tap) {
        
        _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction)];
    }
    return _tap;
}

- (void)dealloc
{

    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}
//
//- (void)testIndex
//{
//    //调用逻辑
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    if(path){
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
//            // iOS9. One year later things are OK.
//            NSURL *fileURL = [NSURL fileURLWithPath:path];
//            [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
//        } else {
//            // iOS8. Things can be workaround-ed
//            //   Brave people can do just this
//            //   fileURL = try! pathForBuggyWKWebView8(fileURL)
//            //   webView.loadRequest(NSURLRequest(URL: fileURL))
//            
//            NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
//            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//            [self.webView loadRequest:request];
//        }
//    }
//}
//
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

//static char imgUrlArrayKey;
//
//- (void)setMethod:(NSArray *)imgUrlArray
//
//{
//    
//    objc_setAssociatedObject(self, &imgUrlArrayKey, imgUrlArray,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//}
//
//
//
//- (NSArray *)getImgUrlArray
//
//{
//    
//    return objc_getAssociatedObject(self, &imgUrlArrayKey);
//    
//}
//
//-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView
//
//{
//    
//    
//    
//    //查看大图代码
//    
//    //js方法遍历图片添加点击事件返回图片个数
//    
//    
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"getImages" ofType:@"js"];
//    
//    NSString * jsGetImages = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//        //用js获取全部图片
//        
//    [wkWebView evaluateJavaScript:jsGetImages completionHandler:^(id Result, NSError * error) {
//        
//        NSLog(@"js___Result==%@",Result);
//        
//        NSLog(@"js___Error -> %@", error);
//        
//    }];
//    
//        NSString *js2=@"getImages()";
//    
//        __block NSArray *array=[NSArray array];
//        
//        [wkWebView evaluateJavaScript:js2 completionHandler:^(id Result, NSError * error) {
//        
//        NSLog(@"js2__Result==%@",Result);
//        
//        NSLog(@"js2__Error -> %@", error);
//            
//        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
//        
//        if([resurlt hasPrefix:@"#"])
//            
//        {
//            resurlt=[resurlt substringFromIndex:1];
//        }
//        
//        NSLog(@"result===%@",resurlt);
//        
//        array=[resurlt componentsSeparatedByString:@"#"];
//        
//        NSLog(@"array====%@",array);
//        
//        [self setMethod:array];
//        
//    }];
//    return array;
//        
//}
//
//-(BOOL)showBigImage:(NSURLRequest *)request
//
//{
//    
//    //将url转换为string
//    
//    NSString *requestString = [[request URL] absoluteString];
//    
//    
//    
//    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
//    
//    if ([requestString hasPrefix:@"myweb:imageClick:"])
//        
//    {
//        
//        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
//        
//        NSLog(@"image url------%@", imageUrl);
//        
//        
//        
//        NSArray *imgUrlArr=[self getImgUrlArray];
//        
//        NSInteger index=0;
//        
//        for (NSInteger i=0; i<[imgUrlArr count]; i++) {
//            
//            if([imageUrl isEqualToString:imgUrlArr[i]])
//                
//            {
//                
//                index=i;
//                
//                break;
//                
//            }
//            
//        }
//        
//        
//        
////        [WFImageUtilshowImgWithImageURLArray:[NSMutableArrayarrayWithArray:imgUrlArr]index:index myDelegate:nil];
//        
//        
//        
//        return NO;
//        
//    }
//    
//    return YES;
//    
//}

////在WKWebview协议中调用上面两个类别的方法
//
//// 类似 UIWebView 的 －webViewDidFinishLoad:
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//
//{
//    
//    //通过js获取htlm中图片url
//    
//    [webView getImageUrlByJS:webView];
//    
//}
//
//
//
//// 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//    
//    
//    [webView showBigImage:navigationAction.request];
//    
//    
//    
//    decisionHandler(WKNavigationActionPolicyAllow);
//    
//}

@end
