//
//  MallGoodsNumModel.m
//  Shopkeeper
//
//  Created by xl on 2017/12/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallGoodsNumModel.h"

NSString *const MallGoodsNumChangeNotification = @"MallGoodsNumChangeNotification";

@interface MallGoodsNumModel ()

@property (nonatomic,strong) NSMutableDictionary *badgeValues;
@end

@implementation MallGoodsNumModel

+ (instancetype)sharedInstance {
    static MallGoodsNumModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[MallGoodsNumModel alloc]init];
    });
    return model;
}

- (NSString *)badgeValueForStoreId:(NSNumber *)storeId {
    if (storeId) {
        NSString *key = [storeId isKindOfClass:[NSNumber class]] ? [storeId stringValue] : (NSString *)storeId;
        return [self.badgeValues valueForKey:key];
    }
    return @"";
}
- (void)setBadgeValue:(NSString *)badgeValue forStoreId:(NSNumber *)storeId {
    if (storeId && badgeValue) {
        NSString *key = [storeId isKindOfClass:[NSNumber class]] ? [storeId stringValue] : (NSString *)storeId;
        NSString *value = [self badgeValueWithIntBadge:badgeValue.integerValue];
        [self.badgeValues setObject:value forKey:key];
        [[NSNotificationCenter defaultCenter]postNotificationName:MallGoodsNumChangeNotification object:self.badgeValues.copy];
    }
}
- (void)loadShopCartsGoodsNumberForStoreId:(NSNumber *)storeId {
    [[APIService share]httpRequestQueryShopCartsGoodsNumberWithStoreId:storeId success:^(NSDictionary *responseObject) {
        NSInteger goodsNumber = [(NSNumber *)responseObject integerValue];
        NSString *badge = [self badgeValueWithIntBadge:goodsNumber];
        NSString *key = [storeId isKindOfClass:[NSNumber class]] ? [storeId stringValue] : (NSString *)storeId;
        [self.badgeValues setObject:badge forKey:key];
        [[NSNotificationCenter defaultCenter]postNotificationName:MallGoodsNumChangeNotification object:self.badgeValues.copy];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}
- (NSString *)badgeValueWithIntBadge:(NSInteger)intBadge {
    NSString *value = @"";
    if (intBadge > 99) {
        value = @"99+";
    } else if (intBadge > 0) {
        value = [NSString stringWithFormat:@"%d",(int)intBadge];
    }
    return value;
}
- (NSMutableDictionary *)badgeValues {
    if (!_badgeValues) {
        _badgeValues = [NSMutableDictionary dictionary];
    }
    return _badgeValues;
}
@end
