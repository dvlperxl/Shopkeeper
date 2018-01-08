//
//  APIService+Distibutor.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "APIService+Distibutor.h"

@implementation APIService (Distibutor)

/**
 分销订单
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryDistibutorOrderListWithStoreId:(NSNumber*)storeId
                                                 param:(NSString*)paramName
                                                 state:(NSNumber*)state
                                                pageNo:(NSInteger)pageNo
                                              pageSize:(NSInteger)pageSize
                                               success:(SuccessResponse)succcess
                                               failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:paramName forKey:@"param"];
    [param setObject:state forKey:@"state"];
    [param setObject:@(pageNo) forKey:@"pageNo"];
    [param setObject:@(pageSize) forKey:@"pageSize"];

//    [self doPostRequestWithAction:@"server_getListOrderByStoreId"
//                       parameters:param
//                          success:^(NSDictionary *responseObject) {
//                              succcess(responseObject);
//                          } failure:failure];
    
    if (succcess) {
        succcess(@[@{@"deliverMethond":@1,@"finalAmount":@"20.0",@"id":@"146917bd-7aae-46ba-84f3-63a5ec7ce22c",@"insertTime":@"2017-12-16 00:00:00",@"retailNo":@"JY20171300011",@"status":@3,@"wholesaleName":@"供应商id=1"},@{@"deliverMethond":@1,@"finalAmount":@"20.0",@"id":@"146917bd-7aae-46ba-84f3-63a5ec7ce22c",@"insertTime":@"2017-02-16 00:00:00",@"retailNo":@"JY20171300011",@"status":@3,@"wholesaleName":@"供应商id=1"},@{@"deliverMethond":@2,@"finalAmount":@"20.0",@"id":@"146917bd-7aae-46ba-84f3-63a5ec7ce22c",@"insertTime":@"2017-02-16 00:00:00",@"retailNo":@"JY20171300011",@"status":@3,@"wholesaleName":@"供应商id=1"}]);
    }
    
}

/**
 分销订单详情
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryDistibutorOrderDetailWithStoreId:(NSNumber*)storeId
                                                retailId:(NSString*)retailId
                                                 success:(SuccessResponse)succcess
                                                 failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:retailId forKey:@"retailId"];
    
    [self doPostRequestWithAction:@"server_getOrderInfoByRetailId"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}


@end
