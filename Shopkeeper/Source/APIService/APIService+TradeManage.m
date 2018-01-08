//
//  APIService+TradeManage.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+TradeManage.h"

@implementation APIService (TradeManage)

/**
 待确认订单-撤销订单
 
 @param type type
 @param retail 订单详情
 @param succcess success
 @param failure failure
 */
- (void)httpRequestConfirmStoreRetailWithType:(NSNumber*)type
                                       retail:(NSDictionary*)retail
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:type forKey:@"type"];
    [param setObject:[NSObject jsonStringFromData:retail] forKey:@"retail"];
    [self doPostRequestWithAction:@"server_confirmStoreRetail"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}


/**
 送货订单-确认收货

 @param retailId 订单Id
 @param succcess success
 @param failure failure
 */
- (void)httpRequestSetStoreRetailStatusWithRetailId:(NSString*)retailId
                                            success:(SuccessResponse)succcess
                                            failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:retailId forKey:@"retailId"];
    [param setObject:@3 forKey:@"status"];
    [self doPostRequestWithAction:@"server_setStoreRetailStatus"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 已收货订单 –确认退货

 @param retailId 订单Id
 @param succcess success
 @param failure failure
 */
- (void)httpRequestDealRetailReturnWithRetailId:(NSString*)retailId
                                    success:(SuccessResponse)succcess
                                    failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:retailId forKey:@"retailId"];
    [param setObject:@"confirmReturn" forKey:@"type"];
    [self doPostRequestWithAction:@"server_dealRetailReturn"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}



@end
