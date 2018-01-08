//
//  RecipePackageDetailModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailModel.h"
#import "RecipePackageDetailCell.h"
#import "RecipePackageDetailHeader.h"
#import "RecipePackageDetailFooter.h"

@interface RecipePackageDetailModel ()

@property (nonatomic,strong) NSDictionary *prescriptionDic;
@property (nonatomic,assign) NSInteger totalCount;
@end

@implementation RecipePackageDetailModel

- (void)inputPrescriptionDic:(NSDictionary *)prescriptionDic {
    if (prescriptionDic) {
        self.prescriptionDic = [self dictionValueStrWithDic:prescriptionDic];
        self.totalCount = [self totalGoodsCountWithDetailArray:prescriptionDic[@"detail"]];
    }
}

- (RecipePackageDetailTabHeaderModel *)tabHeaderModel {
    RecipePackageDetailTabHeaderModel *headerModel = [[RecipePackageDetailTabHeaderModel alloc]init];
    headerModel.prescriptionTitle = self.cropName;
    headerModel.prescriptionNameTitle = @"处方名称";
    headerModel.prescriptionNameContent = [self.prescriptionDic objectForKey:@"prescriptionName"];
    headerModel.prescriptionSpecTitle = @"规格";
    headerModel.prescriptionSpecContent = [NSString stringWithFormat:@"%@/套",[self.prescriptionDic objectForKey:@"prescriptionSpecName"]];
    return headerModel;
}
- (KKTableViewModel *)tableViewModel {
    KKTableViewModel *tableModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [sectionModel addCellModelList:[self cellModelList]];
    sectionModel.headerData = [self sectionHeaderModel];
    sectionModel.footerData = [self sectionFooterModel];
    [tableModel addSetionModel:sectionModel];
    return tableModel;
}
- (RecipePackageDetailTabFooterModel *)tabFooterModel {
    RecipePackageDetailTabFooterModel *footerModel = [[RecipePackageDetailTabFooterModel alloc]init];
    footerModel.salePriceTitle = @"销售价格";
    footerModel.salePriceContent = [self showSalePrice:[self.prescriptionDic objectForKey:@"salePrice"]];
    footerModel.integrationTitle = @"商品积分";
    footerModel.integrationContent = [self integrationNameWithIntegration:[self.prescriptionDic objectForKey:@"integration"]];
    footerModel.descriptionTitle = @"处方说明";
    footerModel.descriptionContent = [self.prescriptionDic objectForKey:@"description"];
    return footerModel;
}


- (NSArray <KKCellModel *> *)cellModelList {
    NSArray *goodsList = [self.prescriptionDic objectForKey:@"detail"];
    if (!goodsList || goodsList.count == 0) {
        return @[];
    }
    NSMutableArray *cellList = @[].mutableCopy;
    for (NSDictionary *goods in goodsList) {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.data = [self cellDataWithGoodsDic:[self dictionValueStrWithDic:goods]];
        cellModel.cellClass = NSClassFromString(@"RecipePackageDetailCell");
        cellModel.height = 195.0f;
        [cellList addObject:cellModel];
    }
    return cellList.copy;
}
- (KKCellModel *)sectionHeaderModel {
    KKCellModel *headerModel = [KKCellModel new];
    headerModel.data = @"处方商品";
    headerModel.cellClass = NSClassFromString(@"RecipePackageDetailHeader");
    headerModel.height = 50.0f;
    return headerModel;
}
- (KKCellModel *)sectionFooterModel {
    KKCellModel *footerModel = [KKCellModel new];
    footerModel.data = [self sectionFooterData];
    footerModel.cellClass = NSClassFromString(@"RecipePackageDetailFooter");
    footerModel.height = 50.0f;
    return footerModel;
}
- (RecipePackageDetailCellModel *)cellDataWithGoodsDic:(NSDictionary *)goodsDic {
    RecipePackageDetailCellModel *data = [RecipePackageDetailCellModel new];
    data.goodsBrand = goodsDic[@"goodsBrand"];
    data.goodsName = goodsDic[@"goodsName"];
    data.singlePrice = [NSString stringWithFormat:@"¥%@",goodsDic[@"goodsOutputSale"]];
    data.goodsSpeci = goodsDic[@"goodsSpec"];
    data.useSpcTitle = @"用量说明";
    data.useSpcContent = goodsDic[@"goodsUseNumber"];
    data.useSpcUnit = [NSString stringWithFormat:@"%@/%@",goodsDic[@"goodsUseUnit"],goodsDic[@"goodsUseSpc"]] ;
    data.goodsNumber = [goodsDic[@"goodsNumber"] integerValue];
    return data;
}
//- (ReicpePackageAddPrescriptionHeaderModel *)sectionHeaderData {
//    ReicpePackageAddPrescriptionHeaderModel *headerData = [ReicpePackageAddPrescriptionHeaderModel new];
//    headerData.headerLeftTitle = @"处方商品";
//    return headerData;
//}
- (RecipePackageDetailFooterModel *)sectionFooterData {
    RecipePackageDetailFooterModel *footerData = [RecipePackageDetailFooterModel new];
    footerData.footerLeftTitle = [NSString stringWithFormat:@"共%ld件商品",(long)self.totalCount];
    footerData.footerRightTitle = [NSString stringWithFormat:@"合计：¥%@",AMOUNTSTRING([self.prescriptionDic objectForKey:@"prescriptionPrice"])];
    return footerData;
}

- (NSString *)showSalePrice:(NSString *)salePrice {
    if (![salePrice hasPrefix:@"¥"]) {
        return [NSString stringWithFormat:@"¥%@",salePrice];
    }
    return salePrice;
}
- (NSString *)integrationNameWithIntegration:(NSString *)integration {
    if (!integration) {
        return nil;
    }
    if ([integration integerValue] == 0) {
        return @"无积分";
    } else {
        return [NSString stringWithFormat:@"%@元1积分",integration];
    }
}
- (NSInteger)totalGoodsCountWithDetailArray:(NSArray *)detail {
    if (!detail) {
        return 0;
    }
    NSInteger total = 0;
    for (NSDictionary *goods in detail) {
        total += [goods[@"goodsNumber"] integerValue];
    }
    return total;
}
- (NSDictionary *)dictionValueStrWithDic:(NSDictionary *)originalDic {
    NSMutableDictionary *dic = originalDic.mutableCopy;
    for (NSString *key in originalDic.allKeys) {
        NSString *value = originalDic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [(NSNumber *)value stringValue];
            [dic setObject:value forKey:key];
        }
    }
    return dic.copy;
}
@end
