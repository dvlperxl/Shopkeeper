//
//  APIService+Util.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
// server_system_notice_unread_num

NSString *const ActionQueryCurrentVersionInfo  = @"server_getDefaultConfig";
NSString *const ActionQueryH5PageURL  = @"server_news_queryBH5PageUrl";
NSString *const ActionQuerySystemUnreadMessageCount  = @"server_system_notice_unread_num";

#import "APIService+Util.h"
#import "KaKaCache.h"

@implementation APIService (Util)

- (void)httpRequestQueryCurrentVersionInfoSuccess:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:@"ios" forKey:@"os"];
    [param setObject:APP_SHORT_VERSION forKey:@"versionCode"];
    [self doPostRequestWithAction:ActionQueryCurrentVersionInfo
                       parameters:param
                          success:^(NSDictionary *responseObject)
    {
                              
                              [KaKaCache setObject:responseObject forKey:ActionQueryCurrentVersionInfo];
                              succcess(responseObject);
                              
                          }failure:failure];
}

- (void)httpRequestQueryH5PageURLSuccess:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure
{

    [self doPostRequestWithAction:ActionQueryH5PageURL
                       parameters:nil
                          success:succcess
                          failure:failure];
}

- (void)httpRequestQuerySystemUnreadMessageCountSuccess:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure
{

    [self doPostRequestWithAction:ActionQuerySystemUnreadMessageCount
                       parameters:nil
                          success:succcess
                          failure:failure];
}


/**
 检查客户端是否需要更新

 @param succcess success
 @param failure failure
 */
- (void)httpRequestCheckVersionSuccess:(SuccessResponse)succcess
                               failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:@"ios" forKey:@"os"];
    [param setObject:APP_SHORT_VERSION forKey:@"versionCode"];

    [self doPostRequestWithAction:@"server_getReleaseInfo"
                       parameters:param
                          success:succcess
                          failure:failure];
}


- (void)httpRequestUpLoadImageRequestWithImagesData:(NSArray<NSData*>*)imagesData
                                            success:(void (^)(id result))successBlock
                                            failure:(void (^)(id failResult))failureBlock
                                           progress:(void (^)(NSUInteger bytesWritten,
                                                              long long totalBytesWritten,
                                                              long long totalBytesExpectedToWrite))progresBlock

{
    [self upLoadImageRequestWithImagesData:imagesData
                                   success:successBlock
                                   failure:failureBlock
                                  progress:progresBlock];
}

/**
 saveDeviceModel
 
 @param succcess success
 @param failure failure
 */
- (void)httpRequestUploadDeviceToken:(NSString*)deviceToken
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:@"ios" forKey:@"platform"];
    [param setObject:@"ios" forKey:@"os"];
    [param setObject:[[UIDevice currentDevice] systemVersion] forKey:@"osVersion"];
    [param setObject:deviceToken forKey:@"deviceToken"];

    [self doPostRequestWithAction:@"server_saveDeviceModel"
                       parameters:param
                          success:succcess
                          failure:failure];
}

- (void)httpRequestServerCustomPropertySuccess:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure {
    [self doPostRequestWithAction:@"server_customProperty"
                       parameters:nil
                          success:succcess
                          failure:failure];
}

/**
 获取支付信息
 
 
 @param succcess success
 @param failure failure
 */

- (void)httpRequestQueryOrderPayInfo:(NSString*)orderId
                             payType:(NSString*)payType
                           orderType:(NSString*)orderType
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:orderId forKey:@"orderId"];
    [param setObject:payType forKey:@"payType"];
    [param setObject:orderType forKey:@"orderType"];
    [param setObject:@"IOS" forKey:@"platformType"];
    [param setObject:@"B" forKey:@"appType"];
    
    [self doPostRequestWithAction:@"server_queryOrderPayInfo"
                       parameters:param
                          success:succcess
                          failure:failure];
}

- (void)httpRequestGetStoreRechargeWithStoreId:(NSNumber*)storeId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_getStoreRecharge"
                       parameters:param
                          success:succcess
                          failure:failure];
}

- (void)httpRequestGetStoreSmsWithStoreId:(NSNumber*)storeId
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_queryStoreSms"
                       parameters:param
                          success:succcess
                          failure:failure];
}

//server_createStoreSmsOrder

- (void)httpRequestCreateStoreSmsOrderWithStoreId:(NSNumber*)storeId
                                           method:(NSString*)method
                                        smsAmount:(NSNumber*)smsAmount
                                        smsNumber:(NSNumber*)smsNumber
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:method forKey:@"method"];
    [param setObject:smsAmount forKey:@"smsAmount"];
    [param setObject:smsNumber forKey:@"smsNumber"];
    [self doPostRequestWithAction:@"server_createStoreSmsOrder"
                       parameters:param
                          success:succcess
                          failure:failure];
}

//server_querySmsOrders

- (void)httpRequestGetStoreSmsOrderListWithStoreId:(NSNumber*)storeId
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_querySmsOrders"
                       parameters:param
                          success:succcess
                          failure:failure];
}



@end
