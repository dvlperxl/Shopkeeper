//
//  StockManageModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockManageModel : NSObject

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *fromType;//0商城，1自营

- (KKTableViewModel*)tableViewModelInsertDataList:(NSArray*)dataList;

@end
