//
//  APIBaseService.h
//  kakatrip
//
//  Created by caiming on 16/9/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#define BASE_IMAGE_URL @"http://img.nongdingbang.net/"

#ifdef Dev //开发

#define BASE_API_URL  @"http://139.198.0.17/wccserver/server/callServer"
#define BASE_WEB_URL  @"http://139.198.0.17"
//#define MALL_BASE_WEB_URL  @"http://test-wap.nongdingbang.net"

#else

#ifdef Test // 测试

#define BASE_API_URL  @"http://139.198.5.139/wccserver/server/callServer"
#define BASE_WEB_URL  @"http://139.198.5.139"
//#define MALL_BASE_WEB_URL  @"http://test-wap.nongdingbang.net"

#else // 生产

#define BASE_API_URL  @"https://www.nongdingwang.net/wccserver/server/callServer"
#define BASE_WEB_URL  @"https://www.nongdingwang.net"
//#define MALL_BASE_WEB_URL  @"https://wap.nongdingwang.net"

#endif

#endif


#import <Foundation/Foundation.h>

typedef void(^FailureResponse)(NSNumber *errorCode,NSString*errorMsg,NSDictionary*responseObject);
typedef void(^SuccessResponse)(id responseObject);

@interface APIBaseService : NSObject

-(void)doPostRequestWithAction:(NSString *)action
                    parameters:(NSDictionary *)params
                       success:(SuccessResponse)success
                       failure:(FailureResponse)failure;

//-(void)doGetRequestWithAction:(NSString *)action
//                   parameters:(NSDictionary *)params
//                      success:(SuccessResponse)success
//                      failure:(FailureResponse)failure;
//
//- (void)doPostRequestWithURL:(NSString *)URLString
//                  parameters:(NSDictionary *)params
//                     success:(SuccessResponse)success
//                     failure:(FailureResponse)failure;

- (void)upLoadImageRequestWithImagesData:(NSArray<NSData*> *)imagesData
                                 success:(void (^)(id result))successBlock
                                 failure:(void (^)(id failResult))failureBlock
                                progress:(void (^)(NSUInteger bytesWritten,
                                                   long long totalBytesWritten,
                                                   long long totalBytesExpectedToWrite))progresBlock;

@end
