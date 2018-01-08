//
//  WorkStoreModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkStoreModel : NSObject<YYModel>

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSString *storeName;


- (void)save;
+ (instancetype)lastChooseStore;


@end
