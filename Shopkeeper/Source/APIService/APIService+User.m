//
//  APIService+User.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

NSString *const ActionSms                 = @"server_wcc_sms";
NSString *const ActionRegister            = @"server_wccUser_register";
NSString *const ActionLogin               = @"server_login";
NSString *const ActionQueryUserInfo       = @"server_wccUser_query";
NSString *const ActionSaveUserInfo        = @"server_wccUser_saveUser";


#import "APIService+User.h"
#import "KaKaCache.h"

@implementation APIService (User)

- (void)httpRequestSendSMS:(NSString*)mobile
                   success:(SuccessResponse)succcess
                   failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:mobile forKey:@"mobile"];
    
    [self doPostRequestWithAction:ActionSms
                       parameters:param
                          success:succcess
                          failure:failure];
}

- (void)httpRequestRegister:(NSString*)mobile
                 verifyCode:(NSString*)verifyCode
                    success:(SuccessResponse)succcess
                    failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:mobile forKey:@"mobile"];
    [param setObject:verifyCode forKey:@"verifyCode"];
    [param setObject:[DeviceMessage deviceUUID] forKey:@"deviceId"];
    [self doPostRequestWithAction:ActionRegister
                       parameters:param
                          success:succcess
                          failure:failure];
}

- (void)httpRequestLogin:(NSString*)mobile
              verifyCode:(NSString*)verifyCode
                 success:(SuccessResponse)succcess
                 failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:mobile forKey:@"mobile"];
    [param setObject:@"APP" forKey:@"deviceType"];
    [param setObject:verifyCode forKey:@"verifyCode"];
    [param setObject:[DeviceMessage deviceUUID] forKey:@"deviceId"];
    [self doPostRequestWithAction:ActionLogin
                       parameters:param
                          success:succcess
                          failure:failure];

}

- (void)httpRequestQueryUserWithMobile:(NSString*)mobile
                               success:(SuccessResponse)succcess
                               failure:(FailureResponse)failure
{
    
    NSString *key = STRING(ActionQueryUserInfo, mobile);
    
    NSDictionary *obj = (NSDictionary*)[KaKaCache objectForKey:key];
    if (obj) {
        
        succcess(obj);
    }
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:mobile forKey:@"mobile"];
    [param setObject:[DeviceMessage deviceUUID] forKey:@"deviceId"];

    [self doPostRequestWithAction:ActionQueryUserInfo
                       parameters:param
                          success:^(NSDictionary *responseObject) {
                              
                              succcess(responseObject);
                              [KaKaCache setObject:responseObject forKey:key];
                              

                              
                          } failure:^(NSNumber *errorCode,
                                      NSString *errorMsg,
                                      NSDictionary *responseObject) {
                              
                              failure(errorCode,errorMsg,responseObject);
                          }];
}

- (void)httpRequestSaveUserInfo:(NSString*)mobile
                       userName:(NSString*)userName
                        address:(NSString*)address
                         areaId:(NSNumber*)areaId
                        village:(NSString*)village
                            uid:(NSString*)uid
                        success:(SuccessResponse)succcess
                        failure:(FailureResponse)failure
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:mobile forKey:@"mobile"];
    [param setObject:userName forKey:@"userName"];
    [param setObject:address forKey:@"address"];
    [param setObject:areaId forKey:@"areaId"];
    [param setObject:village forKey:@"village"];
    [param setObject:uid forKey:@"Id"];
    [param setObject:mobile forKey:@"ownMobile"];
    [self doPostRequestWithAction:ActionSaveUserInfo
                       parameters:param
                          success:succcess
                          failure:failure];
}

@end
