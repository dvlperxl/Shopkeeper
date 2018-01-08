//
//  APIService+GoodsManage.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+GoodsManage.h"

@implementation APIService (GoodsManage)

- (void)httpRequestQueryGoodsList:(NSString*)searchkey
                          storeId:(NSString*)storeId
                    goodsCategory:(NSString*)goodsCategory
                          success:(SuccessResponse)succcess
                          failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:searchkey forKey:@"goodsName"];
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:goodsCategory forKey:@"goodsCategory"];
    
    [self doPostRequestWithAction:@"server_findGoodsByCondition"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}


- (void)httpRequestQueryStockGoodsListWithStoreId:(NSNumber*)storeId
                                         category:(NSString*)category
                                         isOnline:(NSInteger)isOnline
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:category forKey:@"category"];
    [param setObject:@0 forKey:@"type"];
    [param setObject:@(isOnline) forKey:@"isOnline"];
    [self doPostRequestWithAction:@"server_queryGoodsByCategory"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}



- (void)httpRequestQueryGoodsCategorySuccess:(SuccessResponse)succcess
                                     failure:(FailureResponse)failure
{
    [self doPostRequestWithAction:@"server_findGoodCategoryByPid"
                       parameters:nil
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

/**
 门店分类列表
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryGoodsCategoryWithStoreId:(NSNumber*)storeId
                                        isOnline:(NSInteger)isOnline
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:@(isOnline) forKey:@"isOnline"];

    [self doPostRequestWithAction:@"server_queryTwoGoodsCategory"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}


- (void)httpRequestQueryGoodsSpecSuccess:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure
{
    [self doPostRequestWithAction:@"server_getAllWccDictionList"
                       parameters:nil
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryBaseGoodsForBSearchWithSearchKey:(NSString *)searchKey
                                                  pageNo:(NSNumber *)pageNo
                                                 success:(SuccessResponse)succcess
                                                 failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:searchKey forKey:@"searchKey"];
    [param setObject:pageNo forKey:@"pageNo"];
    [self doPostRequestWithAction:@"server_queryBaseGoodsForBSearch"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestMergeGoodsPosWithGoods:(NSString *)goods
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:goods forKey:@"goods"];
    [self doPostRequestWithAction:@"server_mergeGoodsPos"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryGoodsDetailWithId:(NSString *)goodsId
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:goodsId forKey:@"goodsId"];
    [self doPostRequestWithAction:@"server_queryCbdGoodsById"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestDeleteGoodsWthId:(NSString *)goodsId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:goodsId forKey:@"goodsId"];
    [self doPostRequestWithAction:@"server_deleteGoods"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}
@end
