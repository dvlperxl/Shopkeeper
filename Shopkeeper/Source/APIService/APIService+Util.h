//
//  APIService+Util.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//
//server_queryCurrentVersionInfo.
#import "APIService.h"

@interface APIService (Util)


/**
 获取当前版本信息


 @param succcess success
 @param failure failure
 */
- (void)httpRequestQueryCurrentVersionInfoSuccess:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure;


/**
 咨询页面查看H5PageURL

 @param succcess success
 @param failure failure
 */
- (void)httpRequestQueryH5PageURLSuccess:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure;


/**
 查看未读消息数

 @param succcess success
 @param failure failure
 */
- (void)httpRequestQuerySystemUnreadMessageCountSuccess:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure;

/**
 检查客户端是否需要更新
 
 @param succcess success
 @param failure failure
 */
- (void)httpRequestCheckVersionSuccess:(SuccessResponse)succcess
                               failure:(FailureResponse)failure;


/**
 图片上传

 @param imagesData imagesData description
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 @param progresBlock progresBlock description
 */
- (void)httpRequestUpLoadImageRequestWithImagesData:(NSArray<NSData*>*)imagesData
                                            success:(void (^)(id result))successBlock
                                            failure:(void (^)(id failResult))failureBlock
                                           progress:(void (^)(NSUInteger bytesWritten,
                                                              long long totalBytesWritten,
                                                              long long totalBytesExpectedToWrite))progresBlock;


/**
 saveDeviceModel
 
 @param succcess success
 @param failure failure
 */
- (void)httpRequestUploadDeviceToken:(NSString*)deviceToken
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;


/**
 ServerCustomProperty
 
 @param succcess success
 @param failure failure
 */
- (void)httpRequestServerCustomPropertySuccess:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;


/**
 获取支付信息
 
 
 @param succcess success
 @param failure failure
 */

- (void)httpRequestQueryOrderPayInfo:(NSString*)orderId
                             payType:(NSString*)payType
                           orderType:(NSString*)orderType
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;

- (void)httpRequestGetStoreRechargeWithStoreId:(NSNumber*)storeId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure;

- (void)httpRequestGetStoreSmsWithStoreId:(NSNumber*)storeId
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;

- (void)httpRequestCreateStoreSmsOrderWithStoreId:(NSNumber*)storeId
                                           method:(NSString*)method
                                        smsAmount:(NSNumber*)smsAmount
                                        smsNumber:(NSNumber*)smsNumber
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure;

- (void)httpRequestGetStoreSmsOrderListWithStoreId:(NSNumber*)storeId
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure;

@end
