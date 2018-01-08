//
//  MallGoodsDetailViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/12/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallGoodsDetailViewController.h"
#import "KKWebViewBridge.h"
#import "UIBarButtonItem+Badge.h"
#import "MallGoodsNumModel.h"

@interface MallGoodsDetailViewController ()

@end

@implementation MallGoodsDetailViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}
- (void)setupUI {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(toShoppingVCClick) image:@"nav_icon_cart" highImage:nil levelEdge:-10];
    self.navigationItem.rightBarButtonItem.badgeValue = [[MallGoodsNumModel sharedInstance] badgeValueForStoreId:self.storeId];
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor colorWithHexString:@"#FC6A21"];
    self.navigationItem.rightBarButtonItem.badgeFont = APPFONT(12);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeValueChange:) name:MallGoodsNumChangeNotification object:nil];
}

- (void)toShoppingVCClick {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"ShoppingListViewController" param:param];
}
- (void)badgeValueChange:(NSNotification *)notification {
    NSDictionary *badgeValues = notification.object;
    NSString *key = [self.storeId isKindOfClass:[NSNumber class]] ? [self.storeId stringValue] : (NSString *)self.storeId;
    self.navigationItem.rightBarButtonItem.badgeValue = [badgeValues valueForKey:key];
}
- (void)kkWebvView:(KKWebViewBridge *)kkWebView didReceiveScriptMessage:(KKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (body) {
        NSString *action = body[@"action"];
        if ([action isEqualToString:@"refreshShopCartNum"]) {  // 刷新购物车数量
            NSString *badgeValue = body[@"parameters"];
            [[MallGoodsNumModel sharedInstance]setBadgeValue:badgeValue forStoreId:self.storeId];
        } else if ([action isEqualToString:@"jumpToConfirmOrder"]) {  // 跳转确认订单页面
            NSDictionary *parameters = [NSObject dataFormJsonString:body[@"parameters"]];
            if (parameters) {
                NSMutableDictionary *param = parameters.mutableCopy;
                [param setValue:self.storeId forKey:@"storeId"];
                [[CMRouter sharedInstance]presentControllerWithControllerName:@"MallOrderInfoViewController" param:param];
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
