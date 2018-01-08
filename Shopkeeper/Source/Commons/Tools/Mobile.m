//
//  Mobile.m
//  kakatrip
//
//  Created by CaiMing on 2016/12/9.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "Mobile.h"

@implementation Mobile

+ (void)telephone:(NSString*)phoneNo
{
    
    
    if (phoneNo&&phoneNo.length>0) {
        
        phoneNo = [phoneNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNo];
        // 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
//        NSMutableString *str= [NSMutableString string];
//
//        if (![phoneNo hasPrefix:@"tel:"]) {
//
//            [str appendFormat:@"tel:%@",phoneNo];
//
//        }else
//        {
//            [str appendString:phoneNo];
//        }
//
//        UIWebView * callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [[CMRouter sharedInstance].currentController.view addSubview:callWebview];
    }

}

@end
