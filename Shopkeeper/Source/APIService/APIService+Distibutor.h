//
//  APIService+Distibutor.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (Distibutor)

/**
 分销订单
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryDistibutorOrderListWithStoreId:(NSNumber*)storeId
                                                 param:(NSString*)param
                                                 state:(NSNumber*)state
                                                pageNo:(NSInteger)pageNo
                                              pageSize:(NSInteger)pageSize
                                               success:(SuccessResponse)succcess
                                               failure:(FailureResponse)failure;

/**
 分销订单详情
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryDistibutorOrderDetailWithStoreId:(NSNumber*)storeId
                                                retailId:(NSString*)retailId
                                                 success:(SuccessResponse)succcess
                                                 failure:(FailureResponse)failure;

@end
