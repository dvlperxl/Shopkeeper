//
//  APIService+StockManage.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (StockManage)

/**
 进货开单-已收货

 @param storeId 门店id
 @param pageNo pageNo
 @param pageSize pageSize
 @param retailNo retailNo
 @param succcess success
 @param failure failure
 */
- (void)httpRequestGetConfirmedPurchasesByCond:(NSNumber*)storeId
                                        pageNo:(NSInteger)pageNo
                                      pageSize:(NSInteger)pageSize
                                      retailNo:(NSString*)retailNo
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure;

/**
 进货开单-订单列表
 
 @param storeId 门店id
 @param pageNo pageNo
 @param pageSize pageSize
 @param retailNo retailNo
 @param succcess success
 @param failure failure
 */
- (void)httpRequestGetMallOrderList:(NSNumber*)storeId
                             pageNo:(NSInteger)pageNo
                           pageSize:(NSInteger)pageSize
                           retailNo:(NSString*)retailNo
                             status:(NSString*)status
                           fromType:(NSString*)fromType
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure;




/**
 供应商列表

 @param storeId storeId description
 @param pageNo pageNo description
 @param pageSize pageSize description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestSupplierListWithStoreId:(NSNumber*)storeId
                                    pageNo:(NSInteger)pageNo
                                  pageSize:(NSInteger)pageSize
                                   success:(SuccessResponse)succcess
                                   failure:(FailureResponse)failure;


/**
 进货开单-新增供应商

 @param storeId storeId description
 @param param param description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestAddSupplierWithStoreId:(NSNumber*)storeId
                                    param:(NSDictionary*)param
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;


/**
 进货开单

 @param purchase purchase description
 @param purchaseDetail purchaseDetail description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestMergeStorePurchaseWithPurchase:(NSDictionary*)purchase
                                   purchaseDetail:(NSArray*)purchaseDetail
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure;




/**
 进货开单-确认订单-确认订单详情

 @param oid oid description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryStorePurchaseById:(NSString*)oid
                                   status:(NSString*)status
                                      tag:(NSNumber*)tag
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;


/**
 商城订单详情
 
 @param wholeSaleRetailId wholeSaleRetailId description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryMallOrderDetail:(NSString*)wholeSaleRetailId
                                 status:(NSNumber*)status
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure;


- (void)httpRequestModifyReceivePersonAddress:(NSNumber*)storeId
                                 storeAddress:(NSDictionary*)storeAddress
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure;


- (void)httpRequestQueryReceivePersonAddressDetail:(NSString*)addressId
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure;

- (void)httpRequestMallConfirmOrder:(NSString*)wholeSaleRetailId
                              goods:(NSArray*)goods
                            storeId:(NSNumber*)storeId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure;

//server_storeAddressList

- (void)httpRequestQueryStoreAddressList:(NSNumber*)storeId
                                 success:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure;


- (void)httpRequestConfirmReceipt:(NSString*)wholeSaleRetailId
                          storeId:(NSNumber*)storeId
                          success:(SuccessResponse)succcess
                          failure:(FailureResponse)failure;
@end
