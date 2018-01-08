//
//  HttpClient.m
//  PalmDoctorPT
//
//  Created by caiming on 15/12/30.
//  Copyright © 2015年 kangmeng. All rights reserved.
//

#import "HttpClient.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "sys/utsname.h"

@interface HttpClient()

@property(nonatomic, strong)AFHTTPSessionManager *httpManager;
@property(nonatomic, strong)NSString *userAgent;

@end

@implementation HttpClient

+ (instancetype)sharedClient
{
    static HttpClient *client = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        client = [[HttpClient alloc] init];
        client.httpManager = [AFHTTPSessionManager manager];
        client.httpManager.requestSerializer.timeoutInterval = 100;
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
    });
    
    return client;
}

/**
 *  GET请求
 *
 *  @param path          请求api路径
 *  @param params          请求参数
 *  @param successBlock    成功的应答
 *  @param failureBlock     失败的应答
 */

-(void)doGetRequestWithPath:(NSString *)path
                 parameters:(NSDictionary *)params
                    success:(void (^)(NSDictionary *result))successBlock
                    failure:(void (^)(NSDictionary *failResult))failureBlock;
{
    NSLog(@"get :%@ %@",path,params);
//
//    [_httpManager GET:path parameters:params
//             progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        successBlock(responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"post %@ error: %@",path,error);
//        NSMutableDictionary *param = @{}.mutableCopy;
//        [param setObject:@(error.code) forKey:@"errorCode"];
//        failureBlock(param);
//    }];
    
}


- (void)doDeleteRequestWithPath:(NSString *)path
                     parameters:(NSDictionary *)params
                        success:(void (^)(NSDictionary *result))successBlock
                        failure:(void (^)(NSDictionary *failResult))failureBlock
{
    NSLog(@"delete :%@ %@",path,params);
    
    [_httpManager DELETE:path
              parameters:params
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     successBlock(responseObject);
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     
                 }];
}

/**
 *  POST请求
 *
 *  @param path          请求api路径
 *  @param params          请求参数
 *  @param successBlock 成功的应答
 *  @param failureBlock 失败的应答
 */

-(void)doPostRequestWithPath:(NSString *)path
                  parameters:(NSDictionary *)params
                     success:(void (^)(NSDictionary *result))successBlock
                     failure:(void (^)(NSDictionary *failResult))failureBlock;
{

    NSLog(@"post :%@",path);
    NSLog(@"%@",params);
//    _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    if ([KeyChain getToken].length>0)
    {
        [_httpManager.requestSerializer setValue:[KeyChain getToken] forHTTPHeaderField:@"Login-Token"];
    }
    [_httpManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"Device-Type"];
    [_httpManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"Date-Type"];
    [_httpManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"Data-From"];
    
    NSLog(@"%@",_httpManager.requestSerializer.HTTPRequestHeaders);
    _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    if ([path hasPrefix:@"https:"])
    {
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _httpManager.securityPolicy = securityPolicy;
//        _httpManager.securityPolicy.allowInvalidCertificates = NO;
    }
    
    
    [_httpManager POST:path
            parameters:params
               success:^(NSURLSessionDataTask *task,
                         id responseObject)
     {
         NSLog(@"serverName :%@",params[@"serverName"]);
         NSLog(@"%@",responseObject);
         successBlock(responseObject);

     } failure:^(NSURLSessionDataTask *task,
                 NSError *error)
     {
         NSLog(@"serverName :%@",params[@"serverName"]);
         NSLog(@"post %@ error: %@",path,error);
         NSMutableDictionary *param = @{}.mutableCopy;
         [param setObject:@(error.code) forKey:@"errorCode"];
         failureBlock(param);
     }];
}



/**
 上传图片

 @param path path description
 @param params params description
 @param imagesData imagesData description
 @param imageKeys imageKeys description
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 @param progresBlock progresBlock description
 */
- (void)upLoadImageRequestWithPath:(NSString *)path
                            params:(NSDictionary *)params
                            images:(NSArray *)imagesData
                          imageKey:(NSArray *)imageKeys
                           success:(void (^)(id result))successBlock
                           failure:(void (^)(id failResult))failureBlock
                          progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progresBlock
{



    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    if ([KeyChain getToken].length>0)
    {
        [serializer setValue:[KeyChain getToken] forHTTPHeaderField:@"Login-Token"];
    }
    [serializer setValue:@"APP" forHTTPHeaderField:@"Device-Type"];
    [serializer setValue:@"iOS" forHTTPHeaderField:@"Date-Type"];
    [serializer setValue:@"iOS" forHTTPHeaderField:@"Data-From"];
    
    NSError *err;
    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i<imagesData.count; i++)
        {
            NSData *imageData =[imagesData objectAtIndex:i];
            NSString *tempFileName = [NSString stringWithFormat:@"photo%d.JPEG",i];
            NSString *imageName = [imageKeys objectAtIndex:i];
            if (imageName == nil) {
                imageName = @"imageName";
            }
            if ([imageData length]>0)
            {
                [formData appendPartWithFileData:imageData name:imageName fileName:tempFileName mimeType:@"image/jpeg"];
            }
        }

    } error:&err];



    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([path hasPrefix:@"https:"])
    {
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        manager.securityPolicy = securityPolicy;
    }
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSLog(@"%@",responseObject);
                                         if (successBlock) {
                                             successBlock(responseObject);
                                         }
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"%@ %@",operation,error);
                                         if (failureBlock) {
                                             failureBlock(error);
                                         }
                                     }];

    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
                        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
        if (progresBlock) {
           progresBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
        }
    }];

    // 5. Begin!
    [operation start];


}




#define IOS_SystemName [[UIDevice currentDevice] systemName]


-(NSString *)userAgent{
    
    if (!_userAgent) {
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        _userAgent = [NSString stringWithFormat:@"Shopkeeper/%@ (AppStore;%@;iOS %@;%@)",APP_SHORT_VERSION,IOS_SystemName,[[UIDevice currentDevice] systemVersion],deviceString];
        NSLog(@"UserAgent:%@",_userAgent);
    }
    
    return _userAgent;
}

//- (NSString *)logDic:(NSDictionary *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSString *str =
//    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
//
//    return str;
//}


@end
