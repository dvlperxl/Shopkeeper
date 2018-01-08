//
//  CommodityListModel.h
//  Dev
//
//  Created by xl on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityCategoryModel.h"
#import "CommodityListCell.h"

@interface CommodityListModel : NSObject

@property (nonatomic,strong) NSArray *categoryList;
- (instancetype)initWithStoreId:(NSString *)storeId;

- (void)getCategoryListSuccess:(void(^)(void))success failure:(void(^)(NSString *errorMsg))failure;
- (void)tableViewModelWithCategoryId:(NSString *)categoryId success:(void(^)(KKTableViewModel *tableViewModel))success failure:(void(^)(NSString *errorMsg))failure;
- (void)newestTableViewModelWithCategoryId:(NSString *)categoryId success:(void(^)(KKTableViewModel *tableViewModel))success failure:(void(^)(NSString *errorMsg))failure;
- (void)deleteRowCellModelWithCommodityId:(NSString *)commodityId success:(void(^)(KKTableViewModel *tableViewModel))success failure:(void(^)(NSString *errorMsg))failure;

- (NSMutableArray *)pickerViewDataSource;
- (NSArray *)pickerViewDataSourceWithCategory:(CommodityCategoryModel *)category;
@end
