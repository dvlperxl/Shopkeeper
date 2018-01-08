//
//  GoodsDetailModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDetailModel.h"
#import "GoodsDetailNormalCell.h"
#import "GoodsDetailImageCell.h"
#import "GoodsDetailMoreTitleCell.h"
#import "CommodityCategoryModel.h"

@interface GoodsDetailModel ()

@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,strong) NSMutableDictionary *goodsInfo;
@end

@implementation GoodsDetailModel

- (instancetype)initWithStoreId:(NSString *)storeId {
    if (self = [super init]) {
        _storeId = storeId;
    }
    return self;
}
- (void)setGoodsInfoDic:(NSDictionary *)infoDic {
    [self.goodsInfo setValuesForKeysWithDictionary:infoDic];
}
- (NSDictionary *)goodsInfoDic {
    return self.goodsInfo.copy;
}
- (KKTableViewModel *)tableViewModel {
    KKTableViewModel *tableModel = [[KKTableViewModel alloc]init];
    [tableModel addSetionModel:[self goodsNameSectionModel]];
    [tableModel addSetionModel:[self categorySectionModel]];
    [tableModel addSetionModel:[self goodsPriceSectionModel]];
    [tableModel addSetionModel:[self goodsMoreInfoSectionModel]];
    return tableModel;
}

/** 商品名称相关区数据*/
- (KKSectionModel *)goodsNameSectionModel {
    KKSectionModel *sectionModel = [KKSectionModel new];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"登记证号" parameterNames:@[@"registrationNo"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"登记名称" parameterNames:@[@"goodsName"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"商品名" parameterNames:@[@"goodsBrand"]]];
    return sectionModel;
}

/** 分类相关区数据*/
- (KKSectionModel *)categorySectionModel {
    KKSectionModel *sectionModel = [KKSectionModel new];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"分类" parameterNames:@[@"goodsCategory"]]];
    NSString *categoryPid = [self categoryPidWithId:[self.goodsInfo objectForKey:@"goodsCategory"]];
    if ([categoryPid isEqualToString:@"1"]) {   // 农药，特殊处理
        [sectionModel addCellModel:[self normalCellModelWithLeftName:@"含量" parameterNames:@[@"content",@"contentUnit"]]];
        [sectionModel addCellModel:[self normalCellModelWithLeftName:@"毒性" parameterNames:@[@"toxicity"]]];
        [sectionModel addCellModel:[self normalCellModelWithLeftName:@"剂型" parameterNames:@[@"formulation"]]];
    } else if ([categoryPid isEqualToString:@"2"]) {  // 化肥，特殊处理
        [sectionModel addCellModel:[self moreLabelCellModelWithLeftName:@"含量"]];
    }
    return sectionModel;
}

/** 价格相关区数据*/
- (KKSectionModel *)goodsPriceSectionModel {
    KKSectionModel *sectionModel = [KKSectionModel new];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"规格" parameterNames:@[@"goodsSpeci"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"销售价" parameterNames:@[@"outputSale"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"进货单价" parameterNames:@[@"inputSale"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"商品积分" parameterNames:@[@"integration"]]];
    [sectionModel addCellModel:[self imageCellModelWithParameterName:@"imageUrl"]];
    return sectionModel;
}

/** 更多信息区数据*/
- (KKSectionModel *)goodsMoreInfoSectionModel {
    KKSectionModel *sectionModel = [KKSectionModel new];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"生产日期" parameterNames:@[@"manufactureDate"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"有效日期" parameterNames:@[@"validityTime"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"库存数" parameterNames:@[@"stock"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"生产企业" parameterNames:@[@"companyName"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"使用说明" parameterNames:@[@"useIntro"]]];
    [sectionModel addCellModel:[self normalCellModelWithLeftName:@"备注" parameterNames:@[@"remark"]]];
    return sectionModel;
}
- (KKCellModel *)normalCellModelWithLeftName:(NSString *)leftName parameterNames:(NSArray *)parameterNames {
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.data = [self normalCellDataModelWithLeftName:leftName parameterNames:parameterNames];
    cellModel.cellClass = NSClassFromString(@"GoodsDetailNormalCell");
    cellModel.height = 44.0f;
    return cellModel;
}
- (KKCellModel *)imageCellModelWithParameterName:(NSString *)parameterName {
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.data = [self imageCellDataModelWithParameterName:parameterName];
    cellModel.cellClass = NSClassFromString(@"GoodsDetailImageCell");
    cellModel.height = 92.0f;
    return cellModel;
}
- (KKCellModel *)moreLabelCellModelWithLeftName:(NSString *)leftName {
    KKCellModel *cellModel = [KKCellModel new];
    if ([self moreTitleCellDataModelWithLeftName:leftName]) {
        cellModel.data = [self moreTitleCellDataModelWithLeftName:leftName];
        cellModel.cellClass = NSClassFromString(@"GoodsDetailMoreTitleCell");
        cellModel.height = 44.0f;
        return cellModel;
    }
    return nil;
}
- (GoodsDetailNormalCellModel *)normalCellDataModelWithLeftName:(NSString *)leftName parameterNames:(NSArray *)parameterNames {
    GoodsDetailNormalCellModel *cellData = [GoodsDetailNormalCellModel new];
    cellData.leftTitle = leftName;
    cellData.parameterNames = parameterNames;
    cellData.goodsContent = [self goodsInfoContentWithParameterNames:parameterNames];
    return cellData;
}
- (GoodsDetailImageCellModel *)imageCellDataModelWithParameterName:(NSString *)parameterName {
    GoodsDetailImageCellModel *cellData = [GoodsDetailImageCellModel new];
    NSString *imageUrl = [self.goodsInfo objectForKey:parameterName];
    if (imageUrl.length > 0) {
        cellData.imageArray = [imageUrl componentsSeparatedByString:@","].mutableCopy;
    }
    return cellData;
}
- (GoodsDetailMoreTitleCellModel *)moreTitleCellDataModelWithLeftName:(NSString *)leftName {
    GoodsDetailMoreTitleCellModel *cellData = [GoodsDetailMoreTitleCellModel new];
    cellData.leftTitle = leftName;
    NSString *nitrogen = self.goodsInfo[@"nitrogen"];
    NSString *phosphorus = self.goodsInfo[@"phosphorus"];
    NSString *potassium = self.goodsInfo[@"potassium"];
    if ([nitrogen integerValue]!= 0 || [phosphorus integerValue]!= 0 || [potassium integerValue]!= 0) {
        cellData.oneTitle = [NSString stringWithFormat:@"氮%@",nitrogen];
        cellData.twoTitle = [NSString stringWithFormat:@"磷%@",phosphorus];
        cellData.threeTitle = [NSString stringWithFormat:@"钾%@",potassium];
        return cellData;
    }
    return nil;
}
- (NSString *)goodsInfoContentWithParameterNames:(NSArray *)parameterNames {
    
    NSString *(^singleGoodsContent)(NSString *) = ^(NSString *singleParameterName) {
        NSString *goodsInfoContent = [self.goodsInfo objectForKey:singleParameterName];
        if ([goodsInfoContent isKindOfClass:[NSNumber class]]) {
            goodsInfoContent = [(NSNumber *)goodsInfoContent stringValue];
        }
        if ([singleParameterName isEqualToString:@"goodsCategory"]) {  // 特殊处理
            goodsInfoContent = [self categoryNameWithCategoryId:goodsInfoContent];
        } else if ([singleParameterName isEqualToString:@"integration"]) {   // 特殊处理
            goodsInfoContent = [self integrationNameWithIntegration:goodsInfoContent];
        } else if ([singleParameterName isEqualToString:@"manufactureDate"] || [singleParameterName isEqualToString:@"validityTime"])   {      // 特殊处理
            goodsInfoContent = [self timeNameWithTime:goodsInfoContent];
        }
        return goodsInfoContent;
    };
    
    if (parameterNames.count == 1) {
        NSString *parameterName = parameterNames.firstObject;
        return singleGoodsContent(parameterName);
    }
    NSMutableString *goodsInfoContentM = @"".mutableCopy;
    for (NSString *parameterName in parameterNames) {
        NSString *content = singleGoodsContent(parameterName);
        if (content) {
            [goodsInfoContentM appendString:content];
        }
    }
    return goodsInfoContentM;
}

- (NSString *)categoryNameWithCategoryId:(NSString *)categoryId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id = %@",categoryId];
    NSArray *preArray = [self.categoryList filteredArrayUsingPredicate:predicate];
    if (preArray && preArray.count > 0) {
        return ((CommodityCategoryModel *)preArray.firstObject).name;
    }
    return @"";
}
- (NSString *)categoryPidWithId:(NSString *)Id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id = %@",Id];
    NSArray *preArray = [self.categoryList filteredArrayUsingPredicate:predicate];
    if (preArray && preArray.count > 0) {
        return ((CommodityCategoryModel *)preArray.firstObject).pid;
    }
    return @"";
}
- (NSString *)integrationNameWithIntegration:(NSString *)integration {
    if ([integration integerValue] == 0) {
        return @"无积分";
    } else {
        return [NSString stringWithFormat:@"%@元1积分",integration];
    }
}
- (NSString *)timeNameWithTime:(NSString *)time {
    if (time) {
        NSString *suffix = @" 00:00:00";
        if ([time containsString:suffix]) {
            NSString *timeNmae = [time stringByReplacingOccurrencesOfString:suffix withString:@""];
            return timeNmae;
        }
    }
    return nil;
}
#pragma mark - getter
- (NSMutableDictionary *)goodsInfo {
    if (!_goodsInfo) {
        _goodsInfo = @{}.mutableCopy;
    }
    return _goodsInfo;
}
@end
