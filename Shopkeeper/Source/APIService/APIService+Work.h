//
//  APIService+Work.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//：farmercustomer=141841  storeId=856

#import "APIService.h"

@interface APIService (Work)

- (void)httpRequestQueryOrderListWithStatus:(NSString*)status
                                    storeId:(NSString*)storeId
                             farmercustomer:(NSString*)farmercustomer
                                    success:(SuccessResponse)succcess
                                    failure:(FailureResponse)failure;

- (void)httpRequestQueryStoreReturnList:(NSString*)storeId
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure;

- (void)httpRequestQueryOrderDetail:(NSString*)orderId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure;

- (void)httpRequestQueryReturnDetail:(NSString*)returnId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;

- (void)httpRequestQueryFarmerCustomerList:(NSString*)searchkey
                                    storeId:(NSString*)storeId
                                 querytype:(NSString*)querytype
                                   orderBy:(NSString*)orderBy
                                  pageSize:(NSNumber*)pageSize
                                    pageNo:(NSNumber*)pageNo
                                    success:(SuccessResponse)succcess
                                    failure:(FailureResponse)failure;

//server_createOrUpdateFarmerCustomerForPos
- (void)httpRequestAddMemberWithAddress:(NSString*)address
                             customerId:(NSString*)customerId
                                 areaId:(NSNumber*)areaId
                            customerNme:(NSString*)customerNme
                                storeId:(NSString*)storeId
                                village:(NSString*)village
                          customerPhone:(NSString*)customerPhone
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure;


- (void)httpRequestQueryFarmerDetail:(NSNumber*)customerId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;

/**
 赊欠记录

 @param farmerId farmerId
 @param succcess 成功的应答
 @param failure 失败的应答
 */
- (void)httpRequestQueryFarmerRetailAndCreditPay:(NSNumber*)farmerId
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure;


/**
 查看公告列表

 @param userId 用户id
 @param succcess 成功应答
 @param failure 失败的应答
 */
- (void)httpRequestQueryNoticeList:(NSString*)userId
                           success:(SuccessResponse)succcess
                           failure:(FailureResponse)failure;

- (void)httpRequestQueryMemberList:(NSString*)storeId
                            pageNo:(NSNumber*)pageNo
                          pageSize:(NSNumber*)pageSize
                           success:(SuccessResponse)succcess
                           failure:(FailureResponse)failure;

- (void)httpRequestReleaseNotice:(NSString*)title
                        contacts:(NSString*)contacts
                          userid:(NSString*)userid
                          imgUrl:(NSString*)imgUrl
                        mainbody:(NSString*)mainbody
                         storeId:(NSString*)storeId
                         success:(SuccessResponse)succcess
                         failure:(FailureResponse)failure;

- (void)httpRequestCreateReleaseNotice:(NSString*)title
                              contacts:(NSString*)contacts
                                userid:(NSString*)userid
                                imgUrl:(NSString*)imgUrl
                              mainbody:(NSString*)mainbody
                               storeId:(NSString*)storeId
                               success:(SuccessResponse)succcess
                               failure:(FailureResponse)failure;


/**
 经营分析首页

 @param storeId 门店Id
 @param succcess 成功的应答
 @param failure 失败的应答
 */
- (void)httpRequestQueryStoreAnalys:(NSString*)storeId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure;




/**
 每日对账

 @param storeId 门店id
 @param queryDate 查询日期
 @param succcess success
 @param failure fail
 */
- (void)httpRequestQueryDailyCheckWithStoreId:(NSString*)storeId
                                    queryDate:(NSString*)queryDate
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure;

/**
 导入会员
 
 @param storeId 门店id
 @param inputList 会员列表字符串
 @param succcess success
 @param failure fail
 */
- (void)httpRequestQueryImportFarmerCustomerWithStoreId:(NSString *)storeId
                                              inputList:(NSString *)inputList
                                                success:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure;
@end

