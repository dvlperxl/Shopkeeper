//
//  APIService+GoodsManage.h
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (GoodsManage)

/**
 商品列表
 
 @param searchkey 商品名称
 @param storeId 门店id
 @param goodsCategory 分类
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryGoodsList:(NSString*)searchkey
                          storeId:(NSString*)storeId
                    goodsCategory:(NSString*)goodsCategory
                          success:(SuccessResponse)succcess
                          failure:(FailureResponse)failure;

- (void)httpRequestQueryStockGoodsListWithStoreId:(NSNumber*)storeId
                                         category:(NSString*)category
                                         isOnline:(NSInteger)isOnline
                                          success:(SuccessResponse)succcess
                                          failure:(FailureResponse)failure;

/**
 分类列表
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryGoodsCategorySuccess:(SuccessResponse)succcess
                                     failure:(FailureResponse)failure;



/**
 门店分类列表
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryGoodsCategoryWithStoreId:(NSNumber*)storeId
                                        isOnline:(NSInteger)isOnline
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure;



/**
 规格及积分
 
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryGoodsSpecSuccess:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure;


/**
 商品登记证号查询

 @param searchKey 搜索关键字
 @param pageNo 页数
 @param succcess succcess
 @param failure failure 
 */
- (void)httpRequestQueryBaseGoodsForBSearchWithSearchKey:(NSString *)searchKey
                                                  pageNo:(NSNumber *)pageNo
                                                 success:(SuccessResponse)succcess
                                                 failure:(FailureResponse)failure;


/**
 商品保存

 @param goods 商品信息字符串
 @param succcess succcess
 @param failure failure
 */
- (void)httpRequestMergeGoodsPosWithGoods:(NSString *)goods
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;


/**
 商品详情

 @param goodsId 商品id
 @param succcess succcess
 @param failure failure
 */
- (void)httpRequestQueryGoodsDetailWithId:(NSString *)goodsId
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;


/**
 删除商品

 @param goodsId 商品id
 @param succcess succcess
 @param failure failure 
 */
- (void)httpRequestDeleteGoodsWthId:(NSString *)goodsId
                                  success:(SuccessResponse)succcess
                                  failure:(FailureResponse)failure;

@end
