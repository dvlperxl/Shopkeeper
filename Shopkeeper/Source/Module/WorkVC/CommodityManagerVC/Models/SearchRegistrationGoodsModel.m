//
//  SearchRegistrationGoodsModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SearchRegistrationGoodsModel.h"
#import "SearchRegistrationGoodsCell.h"

@interface SearchRegistrationGoodsModel ()

@property (nonatomic,copy) NSString *searchKey;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,weak) KKTableViewModel *tableModel;
@end


@implementation SearchRegistrationGoodsModel

- (void)getTableViewModelWithSearchKey:(NSString *)searchKey success:(void(^)(KKTableViewModel *tableModel,BOOL hasMore))success failure:(void(^)(NSString *))failure {
    self.searchKey = searchKey;
    self.currentPage = 1;
    [[APIService share]httpRequestQueryBaseGoodsForBSearchWithSearchKey:searchKey pageNo:@(self.currentPage) success:^(NSDictionary *responseObject) {
        self.totalCount = [responseObject[@"total"] integerValue];
        NSArray *datas = [NSArray yy_modelArrayWithClass:[SearchRegistrationGoodsCellModel class] json:responseObject[@"result"]];
        KKTableViewModel *tableViewModel = [self registrationGoodsTableViewModelWithDataList:datas];
        if (success) {
            success(tableViewModel,tableViewModel.sectionDataList.firstObject.cellDataList.count < self.totalCount);
        }
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        if (failure) {
            failure(errorMsg);
        }
    }];
}
- (void)getNextPageSuccess:(void(^)(KKTableViewModel *tableModel,BOOL hasMore))success failure:(void(^)(NSString *))failure {
    [[APIService share]httpRequestQueryBaseGoodsForBSearchWithSearchKey:self.searchKey pageNo:@(++self.currentPage) success:^(NSDictionary *responseObject) {
        NSArray *datas = [NSArray yy_modelArrayWithClass:[SearchRegistrationGoodsCellModel class] json:responseObject[@"result"]];
        [self.tableModel.sectionDataList.firstObject addCellModelList:[self cellModelListWithDataList:datas]];
        if (success) {
            success(self.tableModel,self.tableModel.sectionDataList.firstObject.cellDataList.count < self.totalCount);
        }
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        self.currentPage--;
        if (failure) {
            failure(errorMsg);
        }
    }];
}
- (KKTableViewModel *)registrationGoodsTableViewModelWithDataList:(NSArray <SearchRegistrationGoodsCellModel *>*)dataList {
    KKTableViewModel *tableModel = [KKTableViewModel new];
    tableModel.noResultImageName = Default_nodata;
    tableModel.noResultTitle = @"没有找到相关内容";
    tableModel.noResultDesc = @"换个关键词试试";
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableModel addSetionModel:sectionModel];
    [sectionModel addCellModelList:[self cellModelListWithDataList:dataList]];
    self.tableModel = tableModel;
    return tableModel;
}
- (NSArray<KKCellModel *> *)cellModelListWithDataList:(NSArray <SearchRegistrationGoodsCellModel *>*)dataList {
    NSMutableArray *list = @[].mutableCopy;
    for (SearchRegistrationGoodsCellModel *cellData in dataList) {
        [self cellDataProcessor:cellData];
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.data = cellData;
        cellModel.cellClass = NSClassFromString(@"SearchRegistrationGoodsCell");
        cellModel.height = 105.0f;
        [list addObject:cellModel];
    }
    return list.copy;
}
- (void)cellDataProcessor:(SearchRegistrationGoodsCellModel *)cellData {
    cellData.attributedSn = [self attributedProcessor:cellData.sn];
    cellData.attributedName = [self attributedProcessor:cellData.name];
    cellData.attributedCompany = [self attributedProcessor:cellData.company];
}
- (NSAttributedString *)attributedProcessor:(NSString *)str {
    NSMutableAttributedString *attributedSn = [[NSMutableAttributedString alloc]initWithString:str attributes:@{}];
    [attributedSn addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ED8508"]} range:[str rangeOfString:self.searchKey]];
    return attributedSn.copy;
}
@end
