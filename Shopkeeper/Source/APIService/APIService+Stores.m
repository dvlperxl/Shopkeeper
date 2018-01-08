//
//  APIService+Stores.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

NSString *const ActionQueryStoresByUser       = @"server_queryStoresByUser";
NSString *const ActionSaveStore               = @"server_createOrUpdateStoreById";
NSString *const ActionVillageListByAreaId     = @"server_searchAreaByKeyword";

#import "APIService+Stores.h"
#import "KaKaCache.h"

@implementation APIService (Stores)

- (void)httpRequestQueryStoresByUser:(NSString*)userId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure
{
    
//    NSString *key = STRING(ActionQueryStoresByUser, userId);
//
//    NSDictionary *obj = (NSDictionary*)[KaKaCache objectForKey:key];
//    if (obj) {
//
//        succcess(obj);
//    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:userId forKey:@"userId"];
    [self doPostRequestWithAction:ActionQueryStoresByUser
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              
                              succcess(responseObject);
//                              [KaKaCache setObject:responseObject forKey:key];
                              
    } failure:failure];
    
}

- (void)httpRequestSaveStoreWithAddress:(NSString*)address
                                village:(NSString*)village
                              storeName:(NSString*)storeName
                                 areaId:(NSNumber*)areaId
                                 userId:(NSString*)userId
                                storeId:(NSNumber*)storeId
                               userName:(NSString*)userName
                          isApplyDevice:(BOOL)isApplyDevice
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:userId forKey:@"userId"];
    [param setObject:address forKey:@"address"];
    [param setObject:village forKey:@"village"];
    [param setObject:storeName forKey:@"storeName"];
    [param setObject:areaId forKey:@"areaId"];
    [param setObject:@(isApplyDevice) forKey:@"isApplyDevice"];
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:userName forKey:@"userName"];
    [self doPostRequestWithAction:ActionSaveStore
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              
                              succcess(responseObject);
                              
                          } failure:failure];
}

- (void)httpRequestVillageListWithareaId:(NSNumber*)areaId
                                 success:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:areaId forKey:@"areaId"];
    [self doPostRequestWithAction:ActionVillageListByAreaId
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              
                              succcess(responseObject);
                              
                          } failure:failure];
}

@end
