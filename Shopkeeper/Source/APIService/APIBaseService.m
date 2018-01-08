//
//  APIBaseService.m
//  kakatrip
//
//  Created by caiming on 16/9/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "APIBaseService.h"
#import "HttpClient.h"
#import "UserBaseInfo.h"


@interface APIBaseService ()


@end

@implementation APIBaseService

-(void)doPostRequestWithAction:(NSString *)action
                    parameters:(NSDictionary *)params
                       success:(SuccessResponse)success
                       failure:(FailureResponse)failure
{
    NSMutableDictionary *mParam = @{}.mutableCopy;
    [mParam setObject:action forKey:@"serverName"];
    [mParam setObject:@"1.0" forKey:@"serverVersion"];
    [mParam setObject:[NSObject jsonStringFromData:params] forKey:@"inputParam"];
    [mParam setObject:[DeviceMessage advertisingIdentifier] forKey:@"idfa"];
    [self doPostRequestWithURL:BASE_API_URL
                    parameters:mParam
                       success:success
                       failure:failure];
}


- (void)doPostRequestWithURL:(NSString *)URLString
                  parameters:(NSDictionary *)params
                     success:(SuccessResponse)success
                     failure:(FailureResponse)failure
{
    
    [[HttpClient sharedClient]doPostRequestWithPath:URLString
                                         parameters:params
                                            success:^(NSDictionary *result)
     {
         if ([result isKindOfClass:[NSDictionary class]]) {
             
             NSString *status = STRINGWITHOBJECT([result objectForKey:@"status"]);
             if ([status isEqualToString:@"0"])
             {
                 if (success) {
                     success(result[@"result"]);

                 }
                 
             }else
             {
                 NSNumber *errorCode = [result objectForKey:@"errorCode"];

                 NSString *errorMessage = [result objectForKey:@"errorMessage"];
                 if (errorMessage==nil) {
                     errorMessage = [result objectForKey:@"errorMsg"];
                 }
                 if (failure) {
                     failure(errorCode,errorMessage,result);

                 }
                 
                 if (errorCode.integerValue>1001&&errorCode.integerValue<1008)
                 {
                      [[UserBaseInfo share]logout];
                 }

             }
         }else
         {
             if (failure) {
                 failure(@999,@"格式不正确",result);
             }
         }
  
         
     } failure:^(NSDictionary *failResult) {
         
         NSNumber *errorCode = [failResult objectForKey:@"errorCode"];
         
         if (errorCode&&errorCode.integerValue == -1009) {
             if (failure) {
                 failure(@-1009,@"当前网络不可用，请检查你的网络设置",failResult);
             }
             
         }else
         {
             if (failure) {
                 failure(@-1001,@"链接服务器失败,请稍后重试",failResult);
             }
         }
         
     }];
}


- (void)upLoadImageRequestWithImagesData:(NSArray<NSData*> *)imagesData
                                 success:(void (^)(id result))successBlock
                                 failure:(void (^)(id failResult))failureBlock
                                progress:(void (^)(NSUInteger bytesWritten,
                                                   long long totalBytesWritten,
                                                   long long totalBytesExpectedToWrite))progresBlock
{
    NSArray*imageKeys = @[@"data"];
    [[HttpClient sharedClient]upLoadImageRequestWithPath:@"https://www.nongdingwang.net/cms/api/uploadFile"
                                                  params:nil
                                                  images:imagesData
                                                imageKey:imageKeys
                                                 success:successBlock
                                                 failure:failureBlock
                                                progress:progresBlock];
}

- (void)cleanCache
{
    
    NSURL *cacheDirectory  =  [[NSFileManager defaultManager]URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSFileManager *mgr = [NSFileManager defaultManager];

    NSDictionary *attributes = [mgr attributesOfItemAtPath:cacheDirectory.path error:nil];
//    NSNumber *sizeNumber = attributes[@"NSFileSize"];
//    NSLog(@"%.1fM",sizeNumber.integerValue/1024.0);
//    unsigned long long size = 0;
    if (attributes == nil) {

    }else if (attributes.fileType)
    {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:cacheDirectory.path];

        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [cacheDirectory.path stringByAppendingPathComponent:subpath];
            // 累加文件大小
//            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;

//
//            if (size >= pow(10, 9)) { // size >= 1GB
//
//                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
//
//            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
//
//                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
//
//            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
//
//                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
//
//            } else { // 1KB > size
//
//                sizeText = [NSString stringWithFormat:@"%zdB", size];
//            }

            NSError *error;

            BOOL success =  [mgr removeItemAtPath:fullSubpath error:&error];

            if (success) {

                NSLog(@"success");

            }else
            {
                NSLog(@"%@",error);
            }

        }
        
    }
    

}


@end
