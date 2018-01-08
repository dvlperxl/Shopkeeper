//
//  MallHomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallHomeViewController.h"
#import "KKWebViewBridge.h"
#import "UIBarButtonItem+Badge.h"
#import "KaKaCache.h"
#import "MallGoodsNumModel.h"

extern NSString *const ActionQueryCurrentVersionInfo;

@interface MallHomeViewController ()

@end

@implementation MallHomeViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    self.customBackTitle = @"工作";
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(toShoppingVCClick) image:@"nav_icon_cart" highImage:nil levelEdge:-10];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeValueChange:) name:MallGoodsNumChangeNotification object:nil];
}

- (void)loadData {
    NSString *url = [self urlFromResponse:(NSDictionary *)[KaKaCache objectForKey:ActionQueryCurrentVersionInfo]];
    if (url) {
        [self loadWebViewWithUrl:url];
        [self loadShopCartsGoodsNumber];
    } else {
        [self loadUrl];
    }
}
- (NSString *)urlFromResponse:(NSDictionary *)response {
    NSString *url = nil;
    NSArray *systemConfigurations = (NSArray*)response;
    if (systemConfigurations) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.key = %@",@"procurementMallUrl"];
        NSArray *preArray = [systemConfigurations filteredArrayUsingPredicate:predicate];
        if (preArray && preArray.count > 0) {
            url = preArray.firstObject[@"value"];
        }
    }
    return url;
}
- (void)loadUrl {
    [[APIService share]httpRequestQueryCurrentVersionInfoSuccess:^(NSDictionary *responseObject) {
        NSString *url = [self urlFromResponse:responseObject];
        if (url) {
            [self loadWebViewWithUrl:url];
            [self loadShopCartsGoodsNumber];
        } else {
            __weak typeof(self) weakSelf = self;
            [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithImageName:Default_nodata title:nil desc:nil btnTitle:@"加载失败，请重试" tapBlock:^{
                [weakSelf loadUrl];
            }]];
        }
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   [weakSelf loadUrl];
                                                                                   
                                                                               }] ];
    }];
}

- (void)toShoppingVCClick {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"ShoppingListViewController" param:param];
}

- (void)loadWebViewWithUrl:(NSString *)url {
    
    [[APIService share]httpRequestGetListWholesaleInfoStoreId:self.storeId success:^(NSDictionary *responseObject) {
        NSArray *wholesaleList = (NSArray *)responseObject;
        NSString *resultUrl;

        if ([wholesaleList isKindOfClass:[NSArray class]]&&wholesaleList.count>0)
        {
            NSString *wholesaleId = wholesaleList.firstObject[@"id"];
            NSString *wholesaleNme = wholesaleList.firstObject[@"wholesaleNme"];
            resultUrl = [self urlContainsWholesaleIdWithOriginalUrl:url wholesaleId:wholesaleId];
            if (resultUrl) {
                self.navigationItem.title = wholesaleNme ? wholesaleNme : @"";
                self.url = resultUrl;
            }
            
        }

        if (resultUrl == nil)
        {
            __weak typeof(self) weakSelf = self;
            [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithImageName:Default_nodata title:nil desc:nil btnTitle:@"加载失败，请重试" tapBlock:^{
                [weakSelf loadWebViewWithUrl:url];
            }]];
            
        }
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithImageName:Default_nodata title:nil desc:nil btnTitle:@"加载失败，请重试" tapBlock:^{
            [weakSelf loadWebViewWithUrl:url];
        }]];
    }];
}
- (void)loadShopCartsGoodsNumber {
    [[MallGoodsNumModel sharedInstance]loadShopCartsGoodsNumberForStoreId:self.storeId];
}
- (NSString *)urlContainsWholesaleIdWithOriginalUrl:(NSString *)original wholesaleId:(NSString *)wholesaleId {
    if (!original || !wholesaleId) {
        return nil;
    }
    NSMutableString *str = @"".mutableCopy;
    NSString *six = @"?";
    if ([original containsString:six]) {
        six = @"&";
    }
    [str appendString:original];
    [str appendString:six];
    [str appendString:@"wholesaleId"];
    [str appendString:@"="];
    [str appendString:wholesaleId];
    return str.copy;
}
- (void)badgeValueChange:(NSNotification *)notification {
    NSDictionary *badgeValues = notification.object;
    NSString *key = [self.storeId isKindOfClass:[NSNumber class]] ? [self.storeId stringValue] : (NSString *)self.storeId;
    self.navigationItem.rightBarButtonItem.badgeValue = [badgeValues valueForKey:key];
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor colorWithHexString:@"#FC6A21"];
    self.navigationItem.rightBarButtonItem.badgeFont = APPFONT(12);
}
- (void)kkWebvView:(KKWebViewBridge *)kkWebView didReceiveScriptMessage:(KKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (body) {
        NSString *action = body[@"action"];
        if ([action isEqualToString:@"openWebView"]) {
            NSDictionary *parameters = [NSObject dataFormJsonString:body[@"parameters"]];
            if (parameters) {
                NSMutableDictionary *param = parameters.mutableCopy;
                [param setObject:self.navigationItem.title forKey:@"webTitle"];
                [param setObject:self.storeId forKey:@"storeId"];
                [[CMRouter sharedInstance]showViewController:@"MallGoodsDetailViewController" param:param];
            }
        }
    }
}
- (void)kkWebvView:(KKWebViewBridge *)kkWebView webViewTitle:(NSString *)title {
    if (!self.navigationItem.title || self.navigationItem.title.length == 0) {
        self.navigationItem.title = title;
    }
}

- (void)kkWebvView:(KKWebViewBridge *)kkWebView documentTitle:(NSString *)title {
    if (!self.navigationItem.title || self.navigationItem.title.length == 0) {
        self.navigationItem.title = title;
    }
}
@end
