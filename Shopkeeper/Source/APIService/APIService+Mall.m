//
//  APIService+Mall.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+Mall.h"

@implementation APIService (Mall)

/**
 购物车列表
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryShopCartsListWithStoreId:(NSNumber*)storeId
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_queryShopCarts"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 获取购物车数量
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryShopCartsGoodsNumberWithStoreId:(NSNumber*)storeId
                                                success:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_getShoppingCartGoodsNumber"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}
/**
 更新购物车
 
 @param storeId 门店id
 @param shopcarts 购物车数组
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestUpdateShopCartsListWithStoreId:(NSNumber*)storeId
                                        shopcarts:(NSArray *)shopcarts
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:[NSObject jsonStringFromData:shopcarts] forKey:@"shopcarts"];
    [self doPostRequestWithAction:@"server_updateShopCarts"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}
/**
 获取订单信息
 */
- (void)httpRequestQueryPreRetailWithStoreId:(NSNumber*)storeId
                                 wholesaleId:(NSString *)wholesaleId
                                     goodsId:(NSString *)goodsId
                                 goodsWrapId:(NSString *)goodsWrapId
                                       count:(NSNumber*)count
                                     success:(SuccessResponse)succcess
                                     failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:wholesaleId forKey:@"wholesaleId"];
    [param setObject:goodsId forKey:@"goodsId"];
    [param setObject:goodsWrapId forKey:@"goodsWrapId"];
    [param setObject:count forKey:@"count"];
    [self doPostRequestWithAction:@"server_queryPreRetail"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}
/**
 开单
 */
- (void)httpRequestMergeWholesaleRetailWithStoreId:(NSNumber*)storeId
                                         storeName:(NSString *)storeName
                                       totalAmount:(NSNumber *)totalAmount
                                           payType:(NSString *)payType
                                       needInvoice:(NSNumber *)needInvoice
                                              head:(NSString *)head
                                             taxNo:(NSString *)taxNo
                                      receiverName:(NSString *)name
                                   receiverAddress:(NSString *)address
                                    receiverAreaId:(NSNumber *)areaId
                                    receiverMobile:(NSString *)mobile
                                    wholesaleOrder:(NSArray *)wholesaleOrder
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure {
    NSString *errorMsg = nil;
    BOOL flag = NO;
    if (!storeId) {
        errorMsg = @"请选择门店";
    }
    if (!flag) {
        if (!name || name.length == 0) {
            flag = YES;
            errorMsg = @"请选择收货人";
        }
    }
    if (!flag) {
        if (!mobile || mobile.length == 0) {
            flag = YES;
            errorMsg = @"请输入收货人手机号";
        }
    }
    if (!flag) {
        if (!areaId) {
            flag = YES;
            errorMsg = @"请选择收货地区";
        }
    }
    if (!flag) {
        if (!address || address.length == 0) {
            flag = YES;
            errorMsg = @"请选择收货地址";
        }
    }
    if (!flag) {
        if (!wholesaleOrder || wholesaleOrder.count == 0) {
            flag = YES;
            errorMsg = @"请选择商品";
        }
    }
    if (!flag) {
        if ([needInvoice boolValue]) {   // 需要发票
            if (!head || head.length == 0) {
                flag = YES;
                errorMsg = @"请输入发票抬头";
            } else if (head.length > 64) {
                flag = YES;
                errorMsg = @"发票抬头最多可输入64个字";
            }
            if (!flag) {
                if (!taxNo || taxNo.length == 0) {
                    flag = YES;
                    errorMsg = @"请输入税务号";
                }
            }
        }
    }
    if (!flag) {
        if (!payType || payType.length == 0) {
            flag = YES;
            errorMsg = @"请选择支付方式";
        }
    }
    if (errorMsg) {
        if (failure) {
            failure(@(0),errorMsg,@{});
        }
        return;
    }
    NSMutableDictionary *param = @{}.mutableCopy;
    NSMutableDictionary *order = @{}.mutableCopy;
    [order setObject:storeId forKey:@"storeId"];
    [order setObject:storeName forKey:@"storeName"];
    [order setObject:totalAmount forKey:@"totalAmount"];
    [order setObject:payType forKey:@"payType"];
    [order setObject:head forKey:@"head"];
    [order setObject:taxNo forKey:@"taxNo"];
    [order setObject:needInvoice forKey:@"needInvoice"];
    NSMutableDictionary *receiverInfo = @{}.mutableCopy;
    [receiverInfo setObject:name forKey:@"name"];
    [receiverInfo setObject:address forKey:@"address"];
    [receiverInfo setObject:areaId forKey:@"areaId"];
    [receiverInfo setObject:mobile forKey:@"mobile"];
    [order setObject:receiverInfo forKey:@"receiverInfo"];
    [order setObject:wholesaleOrder forKey:@"wholesaleOrder"];
    
    [param setObject:[NSObject jsonStringFromData:order] forKey:@"order"];
    [self doPostRequestWithAction:@"server_mergeWholesaleRetail"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 获取供应商列表
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestGetListWholesaleInfoStoreId:(NSNumber*)storeId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_getListWholesaleInfo"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

@end
