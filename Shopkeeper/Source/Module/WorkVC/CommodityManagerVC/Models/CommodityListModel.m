//
//  CommodityListModel.m
//  Dev
//
//  Created by xl on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "CommodityListModel.h"
#import "CommodityListHeader.h"
#import "KaKaCache.h"

@interface CommodityListModel ()

@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,copy) NSString *currentCategoryId;
@property (nonatomic,strong) NSMutableDictionary *categoryDicList;
@property (nonatomic,strong) NSMutableArray *pickerDataSource;
@end

@implementation CommodityListModel

- (instancetype)initWithStoreId:(NSString *)storeId {
    if (self = [super init]) {
        _storeId = storeId;
    }
    return self;
}

- (void)getCategoryListSuccess:(void(^)(void))success failure:(void(^)(NSString *errorMsg))failure {
    if (!self.categoryList) {
        [[APIService share]httpRequestQueryGoodsCategorySuccess:^(NSDictionary *responseObject) {
            [KaKaCache setObject:responseObject forKey:@"server_findGoodCategoryByPid"];
            self.categoryList = [NSArray yy_modelArrayWithClass:[CommodityCategoryModel class] json:responseObject];
            if (success) {
                success();
            }
        } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
            if (failure) {
                failure(errorMsg);
            }
        }];
    } else {
        if (success) {
            success();
        }
    }
}
- (void)tableViewModelWithCategoryId:(NSString *)categoryId success:(void(^)(KKTableViewModel *))success failure:(void(^)(NSString *))failure {
    if (!categoryId || categoryId.length == 0) {
        categoryId = @"0";
    }
    self.currentCategoryId = categoryId;
    [self getCategoryListSuccess:^{
        NSArray *goodsList = self.categoryDicList[categoryId];
        if (goodsList) {
            if (success) {
                KKTableViewModel *tableViewModel = [self tableViewModelWithGoodsList:goodsList categoryId:categoryId];
                success(tableViewModel);
            }
        } else {
            [[APIService share]httpRequestQueryGoodsList:nil storeId:self.storeId goodsCategory:[categoryId isEqualToString:@"0"] ? nil : categoryId success:^(NSDictionary *responseObject) {
                NSArray *goodsList = (NSArray *)responseObject;
                [self.categoryDicList setObject:goodsList forKey:categoryId];
                if (success) {
                    KKTableViewModel *tableViewModel = [self tableViewModelWithGoodsList:goodsList categoryId:categoryId];
                    success(tableViewModel);
                }
            } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                if (failure) {
                    failure(errorMsg);
                }
            }];
        }
    } failure:^(NSString *errorMsg) {
        if (failure) {
            failure(errorMsg);
        }
    }];
}
- (void)newestTableViewModelWithCategoryId:(NSString *)categoryId success:(void(^)(KKTableViewModel *tableViewModel))success failure:(void(^)(NSString *errorMsg))failure {
    NSString *handleCategoryId = categoryId;
    if ([self.currentCategoryId isEqualToString:@"0"]) {  // 当前选中全部
        handleCategoryId = @"0";
    }
    self.currentCategoryId = handleCategoryId;
    [[APIService share]httpRequestQueryGoodsList:nil storeId:self.storeId goodsCategory:[handleCategoryId isEqualToString:@"0"] ? nil : handleCategoryId success:^(NSDictionary *responseObject) {
        NSArray *goodsList = (NSArray *)responseObject;
        [self.categoryDicList setObject:goodsList forKey:handleCategoryId];
        if (success) {
            KKTableViewModel *tableViewModel = [self tableViewModelWithGoodsList:goodsList categoryId:handleCategoryId];
            success(tableViewModel);
        }
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        if (failure) {
            failure(errorMsg);
        }
    }];
}
- (void)deleteRowCellModelWithCommodityId:(NSString *)commodityId success:(void(^)(KKTableViewModel *tableViewModel))success failure:(void(^)(NSString *errorMsg))failure {
    for (NSString *categoryId in self.categoryDicList.allKeys) {
        NSMutableArray *goodsList = ((NSArray *)self.categoryDicList[categoryId]).mutableCopy;
        NSDictionary *dealGoods = nil;
        for (NSDictionary *goods in goodsList) {
            if ([goods[@"id"] isEqualToString:commodityId]) {
                dealGoods = goods;
                break;
            }
        }
        if (dealGoods) {
            [goodsList removeObject:dealGoods];
            [self.categoryDicList setObject:goodsList.copy forKey:categoryId];
        }
    }
    
    NSArray *goodsList = self.categoryDicList[self.currentCategoryId];
    if (goodsList) {
        if (success) {
            KKTableViewModel *tableViewModel = [self tableViewModelWithGoodsList:goodsList categoryId:self.currentCategoryId];
            success(tableViewModel);
        }
    } else {
        if (failure) {
            failure(@"找不到需要删除的数据");
        }
    }
}
- (NSMutableArray *)pickerViewDataSource {
    if (!_pickerDataSource) {
        _pickerDataSource = @[].mutableCopy;
        NSMutableArray *one = @[].mutableCopy;
        for (CommodityCategoryModel *category in self.categoryList) {
            if ([category.pid isEqualToString:@"0"]) {
                [one addObject:category];
            }
        }
        [_pickerDataSource addObject:one];
        CommodityCategoryModel *model = one[0];
        NSMutableArray *two = @[].mutableCopy;
        for (CommodityCategoryModel *category in self.categoryList) {
            if ([category.pid isEqualToString:model.id]) {
                [two addObject:category];
            }
        }
        [_pickerDataSource addObject:two];
    }
    return _pickerDataSource;
}
- (NSArray *)pickerViewDataSourceWithCategory:(CommodityCategoryModel *)category {
    NSMutableArray *two = @[].mutableCopy;
    for (CommodityCategoryModel *model in self.categoryList) {
        if ([model.pid isEqualToString:category.id]) {
            [two addObject:model];
        }
    }
    return two.copy;
}
- (CommodityCategoryModel *)categoryWithId:(NSString *)categoryId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id = %@",categoryId];
    NSArray *preArray = [self.categoryList filteredArrayUsingPredicate:predicate];
    if (preArray && preArray.count > 0) {
        return preArray.firstObject;
    }
    return nil;
}
#pragma mark - 数据处理
- (KKTableViewModel *)tableViewModelWithGoodsList:(NSArray *)goodsList categoryId:(NSString *)categoryId {
    KKTableViewModel *tableViewModel = [[KKTableViewModel alloc]init];
    KKSectionModel *sectionModel = [[KKSectionModel alloc]init];
    [tableViewModel addSetionModel:sectionModel];
    for (NSDictionary *goodsDic in goodsList) {
        [sectionModel addCellModel:[self cellModelWithGoodsDic:goodsDic]];
    }
    sectionModel.headerData = [self headerDataModelWithCategoryId:categoryId show:(goodsList.count > 0)];
    return tableViewModel;
}
- (KKCellModel *)cellModelWithGoodsDic:(NSDictionary *)goodDic {
    KKCellModel *cellModel = [[KKCellModel alloc]init];
    cellModel.data = [self cellModelDataWithGoodsDic:goodDic];
    cellModel.cellClass = NSClassFromString(@"CommodityListCell");
    cellModel.height = 75.0f;
    return cellModel;
}
- (KKCellModel *)headerDataModelWithCategoryId:(NSString *)categoryId show:(BOOL)show {
    KKCellModel *header = [[KKCellModel alloc]init];
    header.data = [self headerModelWithCategoryId:categoryId];
    header.cellClass = NSClassFromString(@"CommodityListHeader");
    header.height = 50.0f;
    return header;
}
- (CommodityListCellModel *)cellModelDataWithGoodsDic:(NSDictionary *)goodDic {
    NSString *name = goodDic[@"goods_name"];
//    CommodityCategoryModel *category = [self categoryWithId:goodDic[@"goods_category"]];
//    if (category) {
//        CommodityCategoryModel *bigCat = [self categoryWithId:category.pid];
//        if ([bigCat.code isEqualToString:@"ny"]) {   // 农药
//
//        } else if ([bigCat.code isEqualToString:@"hf"]) {   // 化肥
//
//        }
//    }
    NSNumber *content = goodDic[@"content"];
    NSString *contentUnit = goodDic[@"contentUnit"];
    NSNumber *nitrogen = goodDic[@"nitrogen"];
    NSNumber *phosphorus = goodDic[@"phosphorus"];
    NSNumber *potassium = goodDic[@"potassium"];
    if ([content integerValue]!=0 && contentUnit.length > 0) {
        name = [NSString stringWithFormat:@"%@ %@%@",name,content,contentUnit];
    } else if ([nitrogen integerValue]!=0 || [phosphorus integerValue]!=0 || [potassium integerValue]!=0) {
        name = [NSString stringWithFormat:@"%@ %@-%@-%@",name,nitrogen,phosphorus,potassium];
    }
    NSString *contentStr = [NSString stringWithFormat:@"%@ %@",goodDic[@"goods_brand"],goodDic[@"goods_speci"]];
    NSString *price = [NSString stringWithFormat:@"¥%@",goodDic[@"output_sale"]];
    NSString *commodityId = goodDic[@"id"];
    CommodityListCellModel *data = [CommodityListCellModel cellModelDataWithName:name content:contentStr price:price commodityId:commodityId];
    return data;
}
- (CommodityListHeaderModel *)headerModelWithCategoryId:(NSString *)categoryId {
    NSString *left = @"全部商品";
    NSString *right = @"筛选商品";
    NSString *headerId = @"0";
    CommodityCategoryModel *category = [self categoryWithId:categoryId];
    if (category) {
        CommodityCategoryModel *bigCat = [self categoryWithId:category.pid];
        NSMutableString *leftM = @"".mutableCopy;
        [leftM appendString:bigCat.name ? bigCat.name : @""];
        [leftM appendString:@" "];
        [leftM appendString:category.name ? category.name : @""];
        left = leftM.copy;
        headerId = category.id;
    }
    CommodityListHeaderModel *headerModel = [CommodityListHeaderModel headerModelWithLeftTitle:left rightTitle:right headerId:headerId];
    return headerModel;
}
#pragma mark - getter
- (NSMutableDictionary *)categoryDicList {
    if (!_categoryDicList) {
        _categoryDicList = [NSMutableDictionary dictionary];
    }
    return _categoryDicList;
}
@end
