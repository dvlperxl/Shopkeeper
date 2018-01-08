//
//  GoodsDetailModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property (nonatomic,strong) NSArray *categoryList;

- (instancetype)initWithStoreId:(NSString *)storeId;
- (void)setGoodsInfoDic:(NSDictionary *)infoDic;
- (NSDictionary *)goodsInfoDic;
- (KKTableViewModel *)tableViewModel;

@end
