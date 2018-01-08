//
//  KaKaPay.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/18.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KaKaPay.h"
#import <AlipaySDK/AlipaySDK.h>

@interface KaKaPay()

@property(nonatomic,strong)NSNumber*orderId;
@property(nonatomic,strong)NSString*payType;
@property(nonatomic)KKPayBlock payBlock;

@end

@implementation KaKaPay

SingletonM

- (void)kakaPay:(NSNumber*)orderId
        payType:(NSString*)payType
        payInfo:(NSDictionary*)payInfo
       payBlock:(KKPayBlock)payBlock
{
    self.orderId = orderId;
    self.payType = payType;
    self.payBlock = payBlock;
    
    if ([payType isEqualToString:@"wechat"])
    {
//        [self wechatPay:payInfo];
        
    }else if ([payType isEqualToString:@"alipay"])
    {
        [self alipay:payInfo[@"orderInfo"]];
    }
}

//- (void)wechatPay:(NSDictionary*)param
//{
//    PayReq *req = [PayReq new];
//    req.partnerId = param[@"partnerid"];
//    req.nonceStr = param[@"noncestr"];
//    req.package = param[@"package"];
//    req.prepayId = param[@"prepayid"];
//    req.sign = param[@"sign"];
//    req.timeStamp = (UInt32)[param[@"timestamp"] longLongValue];
//    BOOL success = [WXApi sendReq:req];
//    if (success == NO) {
//
//        NSArray *keys = @[@"partnerid",@"noncestr",@"package",@"prepayid",@"sign",@"timestamp"];
//
//        for (NSString *key in keys) {
//
//            if (param[key] == nil)
//            {
//                [KKProgressHUD showReminder:[CMRouter sharedInstance].currentController.view message:[NSString stringWithFormat:@"%@ 不能为空",key]];
//                return;
//            }
//        }
//
//        [KKProgressHUD showReminder:[CMRouter sharedInstance].currentController.view message:@"微信支付失败，请重试，或更换支付方式"];
//
//    }
//}

- (void)alipay:(NSString*)orderStr
{
    AlipaySDK *alipay = [AlipaySDK defaultService];
    [alipay payOrder:orderStr fromScheme:@"hnappalipay" callback:^(NSDictionary *resultDic) {
        
        [self alipayCompletion:resultDic];
    }];
}

- (void)wechatPayCompletion:(NSInteger)errorCode
{
    
    if (errorCode == 0)
    {
//        [self httpHotelOrderPayConFirm];//支付成功向服务器确认
        
    }else
    {
        if (self.payBlock)
        {
            self.payBlock(NO);//支付失败
        }
    }
}

- (void)alipayCompletion:(NSDictionary*)resultDict
{
    NSNumber *resultStatus = resultDict[@"resultStatus"];
    if (resultStatus && resultStatus.integerValue == 9000)
    {
        //支付成功
        if (self.payBlock)
        {
            self.payBlock(YES);
        }
        
    }else
    {
        if (self.payBlock)
        {
            self.payBlock(NO);//支付失败
        }
    }
}


- (void)httpHotelOrderPayConFirm
{
    [KKProgressHUD showMBProgressAddTo:[CMRouter sharedInstance].currentController.view];
//    [[APIService share]httpRequestHotelOrderPayConfirm:self.orderId
//                                               success:^(NSDictionary *responseObject) {
//
//                                                   if (self.payBlock)
//                                                   {
//                                                       self.payBlock(YES);//支付失败
//                                                   }
//
//
//    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
//
//        if (self.payBlock)
//        {
//            self.payBlock(NO);//支付失败
//        }
//    }];
}

//- (BOOL)isInstallWeChat
//{
//    return  [WXApi isWXAppInstalled];
//}

@end
