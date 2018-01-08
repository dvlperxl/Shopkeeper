//
//  APIService+User.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "APIService.h"

@interface APIService (User)

- (void)httpRequestSendSMS:(NSString*)mobile
                   success:(SuccessResponse)succcess
                   failure:(FailureResponse)failure;

- (void)httpRequestRegister:(NSString*)mobile
                 verifyCode:(NSString*)verifyCode
                   success:(SuccessResponse)succcess
                   failure:(FailureResponse)failure;


- (void)httpRequestLogin:(NSString*)mobile
              verifyCode:(NSString*)verifyCode
                 success:(SuccessResponse)succcess
                 failure:(FailureResponse)failure;

- (void)httpRequestSaveUserInfo:(NSString*)mobile
                       userName:(NSString*)userName
                        address:(NSString*)address
                         areaId:(NSNumber*)areaId
                        village:(NSString*)village
                            uid:(NSString*)uid
                        success:(SuccessResponse)succcess
                        failure:(FailureResponse)failure;

- (void)httpRequestQueryUserWithMobile:(NSString*)mobile
                               success:(SuccessResponse)succcess
                               failure:(FailureResponse)failure;

//- (void)httpRequestLogout:(NSString*)mobile
//                   success:(SuccessResponse)succcess
//                   failure:(FailureResponse)failure;

@end
