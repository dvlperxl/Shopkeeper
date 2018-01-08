//
//  WebViewController.h
//  kakatrip
//
//  Created by caiming on 16/10/10.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "BaseViewController.h"
#import "KKWebViewBridge.h"

@interface WebViewController : BaseViewController

@property(nonatomic, readonly)KKWebViewBridge *webView;

@property(nonatomic,copy)NSString *url;

//可选
@property(nonatomic,copy)NSString *webTitle;

@end
