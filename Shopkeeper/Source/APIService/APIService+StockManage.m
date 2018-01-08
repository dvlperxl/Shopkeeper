//
//  APIService+StockManage.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+StockManage.h"

@implementation APIService (StockManage)

- (void)httpRequestGetConfirmedPurchasesByCond:(NSNumber*)storeId
                                        pageNo:(NSInteger)pageNo
                                      pageSize:(NSInteger)pageSize
                                      retailNo:(NSString*)retailNo
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(pageNo) forKey:@"pageNo"];
    [param setObject:@(pageSize) forKey:@"pageSize"];
    [param setObject:retailNo forKey:@"retailNo"];

    [self doPostRequestWithAction:@"server_getConfirmedPurchasesByCond"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 
 
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
                            failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(pageNo) forKey:@"pageNo"];
    [param setObject:@(pageSize) forKey:@"pageSize"];
    [param setObject:retailNo forKey:@"retailNo"];//
    [param setObject:status forKey:@"status"];//
//    [param setObject:@"wholeSaleName" forKey:@"wholeSaleName"];//
    
    
    
    NSString *serverName = @"server_getConfirmedPurchasesByCond";
    if (fromType.integerValue == 0)
    {
        serverName = @"server_bigBRetailList";
        
        if ([status isEqualToString:@"10"])
        {
            serverName = @"server_listWholeSaleReturnList";
        }
        
    }else
    {
        if ([status isEqualToString:@"10"])
        {
            serverName = @"server_getReturnedPurchasesByCond";
        }
        
        if ([status isEqualToString:@"2"])
        {
            serverName = @"server_getToConfirmPurchasesByCond";

        }
    }
    [self doPostRequestWithAction:serverName
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestSupplierListWithStoreId:(NSNumber*)storeId
                                    pageNo:(NSInteger)pageNo
                                  pageSize:(NSInteger)pageSize
                                   success:(SuccessResponse)succcess
                                   failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(pageNo) forKey:@"pageNo"];
    [param setObject:@(pageSize) forKey:@"pageSize"];
    [self doPostRequestWithAction:@"server_querySupplierList"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}

- (void)httpRequestAddSupplierWithStoreId:(NSNumber*)storeId
                                    param:(NSDictionary*)param
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure
{
    NSMutableDictionary *md = param.mutableCopy;
    [md setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_createOrUpdateSupplier"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}

- (void)httpRequestMergeStorePurchaseWithPurchase:(NSDictionary*)purchase
                                   purchaseDetail:(NSArray*)purchaseDetail
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:[NSObject jsonStringFromData:purchase] forKey:@"purchase"];
    [param setObject:[NSObject jsonStringFromData:purchaseDetail] forKey:@"purchaseDetail"];
    [self doPostRequestWithAction:@"server_mergeStorePurchase"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}

- (void)httpRequestQueryStorePurchaseById:(NSString*)oid
                                   status:(NSString*)status
                                      tag:(NSNumber*)tag
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure
{
    NSMutableDictionary *md = @{}.mutableCopy;
//    [md setObject:oid forKey:@"id"];
    NSString *serveName = @"server_queryStorePurchaseById";
    
    if (tag.integerValue == 0)//xiaob
    {
        [md setObject:oid forKey:@"id"];
         serveName = @"server_queryStorePurchaseById";
        
    }else
    {
        serveName = @"server_getConfirmedPurchasesDetail";
        [md setObject:oid forKey:@"storePurchaseId"];
        
        if (status.integerValue == 2)
        {
            serveName = @"server_getToConfirmPurchasesDetail";
            [md setObject:oid forKey:@"wholeSaleRetailId"];
            
        }
    }
    
    if (status.integerValue == 10)
    {
        [md setObject:oid forKey:@"wholesaleReturnId"];
        serveName = @"server_getReturnedPurchaseDetail";
    }
    
    [self doPostRequestWithAction:serveName
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}

/**
 商城订单详情
 
 @param wholeSaleRetailId wholeSaleRetailId description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryMallOrderDetail:(NSString*)wholeSaleRetailId
                                 status:(NSNumber*)status
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure
{
    
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:wholeSaleRetailId forKey:@"wholeSaleRetailId"];
    
    NSString *serveName = @"server_bigBRetailDetail";
    if (status.integerValue == 10)
    {
        serveName = @"server_queryWholesaleReturnDetail";
        [md setObject:wholeSaleRetailId forKey:@"returnId"];
    }
    
    [self doPostRequestWithAction:serveName
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    

}

- (void)httpRequestModifyReceivePersonAddress:(NSNumber*)storeId
                                 storeAddress:(NSDictionary*)storeAddress
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure
{
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:storeId forKey:@"storeId"];
    [md setObject:[NSObject jsonStringFromData:storeAddress] forKey:@"storeAddress"];
    
    [self doPostRequestWithAction:@"server_modifyStoreAddress"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}


- (void)httpRequestQueryReceivePersonAddressDetail:(NSString*)addressId
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure
{
    
    
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:addressId forKey:@"addressId"];
    [self doPostRequestWithAction:@"server_storeAddressDetail"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestMallConfirmOrder:(NSString*)wholeSaleRetailId
                              goods:(NSArray*)goods
                            storeId:(NSNumber*)storeId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure
{
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:wholeSaleRetailId forKey:@"wholeSaleRetailId"];
    [md setObject:[NSObject jsonStringFromData:goods] forKey:@"goods"];
    [md setObject:storeId forKey:@"storeId"];

    [self doPostRequestWithAction:@"server_confirmBigBReceipt"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryStoreAddressList:(NSNumber*)storeId
                                 success:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure
{

    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_storeAddressList"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}

- (void)httpRequestConfirmReceipt:(NSString*)wholeSaleRetailId
                          storeId:(NSNumber*)storeId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure
{
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:wholeSaleRetailId forKey:@"wholeSaleRetailId"];
    [md setObject:storeId forKey:@"storeId"];
    
    [self doPostRequestWithAction:@"server_confirmReceipt"
                       parameters:md
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}



@end
