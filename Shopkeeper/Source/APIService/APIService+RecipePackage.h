//
//  APIService+RecipePackage.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (RecipePackage)


/**
 查询处方套餐列表

 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryRecipePackageListWithStoreId:(NSNumber*)storeId
                                              isFull:(BOOL)isFull
                                             success:(SuccessResponse)succcess
                                             failure:(FailureResponse)failure;

/**
 查询门店作物
 
 @param storeId storeId description
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryStoreBaseCropListWithStoreId:(NSNumber*)storeId
                                             success:(SuccessResponse)succcess
                                             failure:(FailureResponse)failure;


/**
 查询所有作物列表
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryAllCropListSuccess:(SuccessResponse)succcess
                                   failure:(FailureResponse)failure;


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
                              failure:(FailureResponse)failure;


/**
 新增自定义套餐

 @param storeId storeId description
 @param integration integration description
 @param storeCorpId storeCorpId description
 @param description description description
 @param name name description
 @param salePrice salePrice description
 @param prescriptionSpecName prescriptionSpecName description
 @param goodsList goodsList description
 @param succcess succcess description
 @param failure failure description
 */
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
                                       failure:(FailureResponse)failure;

/**
 套餐详情

 @param prescriptionId 套餐id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryStorePrescriptionWitId:(NSString *)prescriptionId
                                       success:(SuccessResponse)succcess
                                       failure:(FailureResponse)failure;
@end
