//
//  APIService+Stores.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (Stores)

- (void)httpRequestQueryStoresByUser:(NSString*)userId
                             success:(SuccessResponse)succcess
                             failure:(FailureResponse)failure;

- (void)httpRequestSaveStoreWithAddress:(NSString*)address
                                village:(NSString*)village
                              storeName:(NSString*)storeName
                                 areaId:(NSNumber*)areaId
                                 userId:(NSString*)userId
                                storeId:(NSNumber*)storeId
                               userName:(NSString*)userName
                          isApplyDevice:(BOOL)isApplyDevice
                                success:(SuccessResponse)succcess
                                failure:(FailureResponse)failure;

- (void)httpRequestVillageListWithareaId:(NSNumber*)areaId
                                 success:(SuccessResponse)succcess
                                 failure:(FailureResponse)failure;



@end
