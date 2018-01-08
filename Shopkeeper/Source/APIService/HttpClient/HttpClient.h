//
//  HttpClient.h
//  PalmDoctorPT
//
//  Created by caiming on 15/12/30.
//  Copyright © 2015年 kangmeng. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

/**
 *  返回该类的一个实例
 *
 *  @return client;
 */
+ (instancetype)sharedClient;



/**
 *  GET请求
 *
 *  @param path          请求api路径
 *  @param params          请求参数
 *  @param successBlock   成功的应答
 *  @param failureBlock     失败的应答
 */

-(void)doGetRequestWithPath:(NSString *)path
                 parameters:(NSDictionary *)params
                    success:(void (^)(NSDictionary *result))successBlock
                    failure:(void (^)(NSDictionary *failResult))failureBlock;


/**
 *  Delete请求
 *
 *  @param path         api路径
 *  @param params       参数
 *  @param successBlock  成功的应答
 *  @param failureBlock  失败的应答
 */
- (void)doDeleteRequestWithPath:(NSString *)path
                     parameters:(NSDictionary *)params
                        success:(void (^)(NSDictionary *result))successBlock
                        failure:(void (^)(NSDictionary *failResult))failureBlock;

/**
 *  POST请求
 *
 *  @param path          请求api路径
 *  @param params          请求参数
 *  @param successBlock    成功的应答
 *  @param failureBlock     失败的应答
 */

-(void)doPostRequestWithPath:(NSString *)path
                  parameters:(NSDictionary *)params
                     success:(void (^)(NSDictionary *result))successBlock
                     failure:(void (^)(NSDictionary *failResult))failureBlock;


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
                          progress:(void (^)(NSUInteger bytesWritten,
                                             long long totalBytesWritten,
                                             long long totalBytesExpectedToWrite))progresBlock;

@end
