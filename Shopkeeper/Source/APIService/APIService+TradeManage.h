//
//  APIService+TradeManage.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (TradeManage)



/**
 待确认订单-撤销订单

 @param type type 0撤销 1确认
 @param retail 订单详情
 @param succcess success
 @param failure failure
 */
- (void)httpRequestConfirmStoreRetailWithType:(NSNumber*)type
                                       retail:(NSDictionary*)retail
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure;

/**
 送货订单-确认收货
 
 @param retailId 订单Id
 @param succcess success
 @param failure failure
 */
- (void)httpRequestSetStoreRetailStatusWithRetailId:(NSString*)retailId
                                            success:(SuccessResponse)succcess
                                            failure:(FailureResponse)failure;

/**
 已收货订单 –确认退货
 
 @param retailId 订单Id
 @param succcess success
 @param failure failure
 */
- (void)httpRequestDealRetailReturnWithRetailId:(NSString*)retailId
                                        success:(SuccessResponse)succcess
                                        failure:(FailureResponse)failure;

@end
