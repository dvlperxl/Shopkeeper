//
//  APIService+RecipePackage.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+RecipePackage.h"

@implementation APIService (RecipePackage)


- (void)httpRequestQueryRecipePackageListWithStoreId:(NSNumber*)storeId
                                              isFull:(BOOL)isFull
                                             success:(SuccessResponse)succcess
                                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(isFull) forKey:@"isFull"];
    [self doPostRequestWithAction:@"server_queryStorecorps"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}


/**
 查询门店作物

 @param storeId storeId description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryStoreBaseCropListWithStoreId:(NSNumber*)storeId
                                             success:(SuccessResponse)succcess
                                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_findStoreBaseCrop"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}


/**
 查询所有作物列表
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryAllCropListSuccess:(SuccessResponse)succcess
                                   failure:(FailureResponse)failure
{
    [self doPostRequestWithAction:@"server_findBaseCategory"
                       parameters:nil
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 添加作物
 
 @param storeId storeId description
 @param baseCategoryId baseCategoryId description
 @param cropId cropId description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestAddCropWithStoreId:(NSNumber*)storeId
                       baseCategoryId:(NSNumber*)baseCategoryId
                               corpId:(NSNumber*)cropId
                     baseCategoryName:(NSString*)baseCategoryName
                              success:(SuccessResponse)succcess
                              failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:baseCategoryId forKey:@"baseCategoryId"];
    [param setObject:cropId forKey:@"cropId"];
    [param setObject:baseCategoryName forKey:@"baseCategoryName"];
    [self doPostRequestWithAction:@"server_mergeStoreBaseCrop"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestAddRecipePackageWithStoreId:(NSString*)storeId
                                   integration:(NSInteger)integration
                                   storeCorpId:(NSNumber*)storeCorpId
                                   description:(NSString*)description
                                          name:(NSString*)name
                                     salePrice:(NSString*)salePrice
                          prescriptionSpecName:(NSString*)prescriptionSpecName
                                     goodsList:(NSArray*)goodsList
                                prescriptionId:(NSString *)prescriptionId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(integration) forKey:@"integration"];
    [param setObject:storeCorpId forKey:@"storeCorpId"];
    [param setObject:description forKey:@"description"];
    [param setObject:name forKey:@"name"];
    [param setObject:salePrice forKey:@"salePrice"];
    [param setObject:prescriptionSpecName forKey:@"prescriptionSpecName"];
    [param setObject:[NSObject jsonStringFromData:goodsList] forKey:@"goodsList"];
    [param setObject:prescriptionId forKey:@"id"];
    
    [self doPostRequestWithAction:@"server_addPrescription"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}

- (void)httpRequestQueryStorePrescriptionWitId:(NSString *)prescriptionId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:prescriptionId forKey:@"prescriptionId"];
    
    [self doPostRequestWithAction:@"server_queryStorePrescription"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}


@end
