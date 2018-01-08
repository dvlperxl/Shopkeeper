//
//  SearchRegistrationGoodsModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchRegistrationGoodsModel : NSObject

- (void)getTableViewModelWithSearchKey:(NSString *)searchKey success:(void(^)(KKTableViewModel *tableModel,BOOL hasMore))success failure:(void(^)(NSString *errorMsg))failure;
- (void)getNextPageSuccess:(void(^)(KKTableViewModel *tableModel,BOOL hasMore))success failure:(void(^)(NSString *errorMsg))failure;
@end
