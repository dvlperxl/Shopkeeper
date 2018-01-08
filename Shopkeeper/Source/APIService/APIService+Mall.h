//
//  APIService+Mall.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (Mall)

/**
 购物车列表
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryShopCartsListWithStoreId:(NSNumber*)storeId
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure;

/**
 获取购物车数量
 
 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryShopCartsGoodsNumberWithStoreId:(NSNumber*)storeId
                                                success:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure;
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
                                          failure:(FailureResponse)failure;


/**
 获取订单信息

 @param storeId 门店id
 @param wholesaleId 大Bid
 @param goodsId 商品id
 @param goodsWrapId 商品包装id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestQueryPreRetailWithStoreId:(NSNumber*)storeId
                                 wholesaleId:(NSString *)wholesaleId
                                     goodsId:(NSString *)goodsId
                                 goodsWrapId:(NSString *)goodsWrapId
                                       count:(NSNumber*)count
                                     success:(SuccessResponse)succcess
                                     failure:(FailureResponse)failure;



/**
 开单

 @param storeId 门店id
 @param totalAmount 总价
 @param payType 支付类型
 @param head 抬头
 @param taxNo 税务号
 @param name 收货人姓名
 @param address 收货人地址
 @param areaId 收货人地区id
 @param mobile 收货人手机号
 @param wholesaleOrder 商品列表
 @param succcess succcess description
 @param failure failure description
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
                                           failure:(FailureResponse)failure;



/**
 获取供应商列表

 @param storeId 门店id
 @param succcess succcess description
 @param failure failure description
 */
- (void)httpRequestGetListWholesaleInfoStoreId:(NSNumber*)storeId
                                           success:(SuccessResponse)succcess
                                           failure:(FailureResponse)failure;
@end
