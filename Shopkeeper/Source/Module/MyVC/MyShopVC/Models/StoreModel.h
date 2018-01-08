//
//  StoreModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

+ (KKTableViewModel *)tableViewModelWithStoreList:(NSArray*)storeList;
+ (NSDictionary*)addStoreParam:(NSDictionary*)dict;
+ (NSDictionary*)getSaveStoreParam:(KKTableViewModel*)tableView;

@end
