//
//  APIService+Work.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService+Work.h"

NSString *const ActionQueryOrderList    = @"server_queryStoreRetailMap";
NSString *const ActionQueryStoreReturn  = @"server_queryStoreReturn";
NSString *const ActionQueryOrderDetail  = @"server_queryStoreRetailById";
NSString *const ActionQueryStoreReturnDetail  = @"server_queryStoreReturnById";
NSString *const ActionQueryFramerList   = @"server_queryFarmerCustomersByStoreId";
NSString *const ActionQueryFramerDetail   = @"server_queryFarmerCustomerById";
NSString *const  ActionQueryFarmerRetailAndCreditPay = @"server_queryFarmerRetailAndCreditPay";//赊欠额
NSString *const  ActionQueryNoticeList = @"server_notices_listNotice";//公告列表

NSString *const  ActionQueryMemberList = @"server_getMembersByStoreId";//会员列表
NSString *const  ActionReleaseNotice   = @"server_notices_releaseNotice";//发布公告 server_createResendNotice
NSString *const  ActionCreateReleaseNotice   = @"server_createResendNotice";//创建发送失败的公告
NSString *const  ActionImportFarmerCustomer = @"server_importFarmerCustomer";//导入会员

@implementation APIService (Work)

- (void)httpRequestQueryOrderListWithStatus:(NSString*)status
                                    storeId:(NSString*)storeId
                             farmercustomer:(NSString*)farmercustomer
                                    success:(SuccessResponse)succcess
                                    failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:status forKey:@"status"];
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:farmercustomer forKey:@"farmercustomer"];

    [self doPostRequestWithAction:ActionQueryOrderList
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}

- (void)httpRequestQueryStoreReturnList:(NSString*)storeId
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    
    [self doPostRequestWithAction:ActionQueryStoreReturn
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}

- (void)httpRequestQueryOrderDetail:(NSString*)orderId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:orderId forKey:@"id"];
    [self doPostRequestWithAction:ActionQueryOrderDetail
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryReturnDetail:(NSString*)returnId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:returnId forKey:@"returnId"];
    
    [self doPostRequestWithAction:ActionQueryStoreReturnDetail
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryFarmerCustomerList:(NSString*)searchkey
                                   storeId:(NSString*)storeId
                                 querytype:(NSString*)querytype
                                   orderBy:(NSString*)orderBy
                                  pageSize:(NSNumber*)pageSize
                                    pageNo:(NSNumber*)pageNo
                                   success:(SuccessResponse)succcess
                                   failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:searchkey forKey:@"searchkey"];
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:querytype forKey:@"querytype"];
    [param setObject:orderBy forKey:@"orderby"];
    [param setObject:pageSize forKey:@"pageSize"];
    [param setObject:pageNo forKey:@"pageNo"];
    
    [self doPostRequestWithAction:ActionQueryFramerList
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestQueryFarmerDetail:(NSNumber*)customerId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:customerId forKey:@"customerId"];
    
    [self doPostRequestWithAction:ActionQueryFramerDetail
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];

}


- (void)httpRequestQueryFarmerRetailAndCreditPay:(NSNumber*)farmerId
                                         success:(SuccessResponse)succcess
                                         failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:farmerId forKey:@"farmerId"];

    [self doPostRequestWithAction:ActionQueryFarmerRetailAndCreditPay
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}

- (void)httpRequestQueryNoticeList:(NSString*)userId
                           success:(SuccessResponse)succcess
                           failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:userId forKey:@"userid"];
    
    [self doPostRequestWithAction:ActionQueryNoticeList
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
    
}


- (void)httpRequestQueryMemberList:(NSString*)storeId
                            pageNo:(NSNumber*)pageNo
                          pageSize:(NSNumber*)pageSize
                           success:(SuccessResponse)succcess
                           failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:pageNo forKey:@"pageNo"];
    [param setObject:pageSize forKey:@"pageSize"];
    
    [self doPostRequestWithAction:ActionQueryMemberList
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

//server_createOrUpdateFarmerCustomerForPos
- (void)httpRequestAddMemberWithAddress:(NSString*)address
                             customerId:(NSString*)customerId
                                 areaId:(NSNumber*)areaId
                            customerNme:(NSString*)customerNme
                                storeId:(NSString*)storeId
                                village:(NSString*)village
                          customerPhone:(NSString*)customerPhone
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:address forKey:@"address"];
    [param setObject:areaId forKey:@"areaId"];
    [param setObject:customerNme forKey:@"customerNme"];
    [param setObject:customerId forKey:@"customerId"];
    [param setObject:village forKey:@"village"];
    [param setObject:customerPhone forKey:@"customerPhone"];
    [self doPostRequestWithAction:@"server_createOrUpdateFarmerCustomerForPos"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestReleaseNotice:(NSString*)title
                        contacts:(NSString*)contacts
                          userid:(NSString*)userid
                          imgUrl:(NSString*)imgUrl
                        mainbody:(NSString*)mainbody
                         storeId:(NSString*)storeId
                         success:(SuccessResponse)succcess
                         failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:title forKey:@"title"];
    [param setObject:contacts forKey:@"contacts"];
    [param setObject:userid forKey:@"userid"];
    [param setObject:imgUrl forKey:@"imgUrl"];
    [param setObject:mainbody forKey:@"mainbody"];
    [param setObject:@"" forKey:@"summary"];
    [param setObject:storeId forKey:@"storeId"];

    [self doPostRequestWithAction:ActionReleaseNotice
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

- (void)httpRequestCreateReleaseNotice:(NSString*)title
                              contacts:(NSString*)contacts
                                userid:(NSString*)userid
                                imgUrl:(NSString*)imgUrl
                              mainbody:(NSString*)mainbody
                               storeId:(NSString*)storeId
                               success:(SuccessResponse)succcess
                               failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:title forKey:@"title"];
    [param setObject:contacts forKey:@"contacts"];
    [param setObject:userid forKey:@"userid"];
    [param setObject:imgUrl forKey:@"imgUrl"];
    [param setObject:mainbody forKey:@"mainbody"];
    [param setObject:@"" forKey:@"summary"];
    [param setObject:storeId forKey:@"storeId"];
    
    [self doPostRequestWithAction:ActionCreateReleaseNotice
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}



- (void)httpRequestQueryStoreAnalys:(NSString*)storeId
                            success:(SuccessResponse)succcess
                            failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [self doPostRequestWithAction:@"server_storeanalysemain"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}


//server_checkAccount_sumInfo

- (void)httpRequestQueryDailyCheckWithStoreId:(NSString*)storeId
                                    queryDate:(NSString*)queryDate
                                      success:(SuccessResponse)succcess
                                      failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:queryDate forKey:@"queryDate"];
    [self doPostRequestWithAction:@"server_checkAccount_sumInfo"
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}
//
- (void)httpRequestQueryImportFarmerCustomerWithStoreId:(NSString *)storeId
                                              inputList:(NSString *)inputList
                                                success:(SuccessResponse)succcess
                                                failure:(FailureResponse)failure {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:inputList forKey:@"inputList"];
    [self doPostRequestWithAction:ActionImportFarmerCustomer
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              succcess(responseObject);
                          } failure:failure];
}

@end
