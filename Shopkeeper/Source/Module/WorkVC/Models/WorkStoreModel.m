//
//  WorkStoreModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkStoreModel.h"
#import "KaKaCache.h"

@implementation WorkStoreModel

- (NSArray *)getAllProperties
{
    return @[@"storeId",@"storeName"];
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"storeId":@"id"};
}

- (void)save
{
    [KaKaCache setObject:[self yy_modelToJSONString] forKey:@"lastChooseStore"];
}

+ (instancetype)lastChooseStore
{
    NSDictionary *cache = (NSDictionary*)[KaKaCache objectForKey:@"lastChooseStore"];
    if (cache) {
        
        return [WorkStoreModel yy_modelWithJSON:cache];
    }
    return nil;
}

@end
