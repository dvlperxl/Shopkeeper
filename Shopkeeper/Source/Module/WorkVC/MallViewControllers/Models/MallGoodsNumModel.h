//
//  MallGoodsNumModel.h
//  Shopkeeper
//
//  Created by xl on 2017/12/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const MallGoodsNumChangeNotification;
@interface MallGoodsNumModel : NSObject

+ (instancetype)sharedInstance;
- (NSString *)badgeValueForStoreId:(NSNumber *)storeId;
- (void)setBadgeValue:(NSString *)badgeValue forStoreId:(NSNumber *)storeId;
- (void)loadShopCartsGoodsNumberForStoreId:(NSNumber *)storeId;
@end
