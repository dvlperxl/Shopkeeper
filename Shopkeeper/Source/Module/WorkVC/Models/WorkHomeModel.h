//
//  WorkHomeModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkHomeModel : NSObject

@property(nonatomic,assign)BOOL hasPurchaseMall;
@property(nonatomic,assign)BOOL showTips;

- (KKTableViewModel *)workHomeTableViewModel;

- (void)hasShowMallToastForStoreId:(NSNumber *)storeId;
- (BOOL)showMallToastForStoreId:(NSNumber *)storeId;
@end
