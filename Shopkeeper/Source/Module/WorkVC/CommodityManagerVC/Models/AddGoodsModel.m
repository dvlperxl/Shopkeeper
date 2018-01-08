//
//  AddGoodsModel.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsModel.h"
#import "AddGoodsPickerCell.h"
#import "AddGoodsTextFieldCell.h"
#import "AddGoodsPickerAndTextFieldCell.h"
#import "AddGoodsMoreTextFieldCell.h"
#import "AddGoodsTextFieldRightTitleCell.h"
#import "AddGoodsImageCell.h"
#import "AddGoodsHeaderView.h"
#import "CommodityCategoryModel.h"
#import "KaKaCache.h"
#import "NSDate+DateFormatter.h"

@interface AddGoodsModel ()

@property (nonatomic,strong) NSArray *goodsMassunit;
@property (nonatomic,strong) NSArray *goodsPackageunit;
@property (nonatomic,strong) NSArray *integralRules;
@property (nonatomic,strong) NSArray *contentUnits;
@property (nonatomic,strong) NSArray *toxicitys;
@property (nonatomic,strong) NSArray *formulations;
@property (nonatomic,copy) NSString *storeId;
@property (nonatomic,weak) KKTableViewModel *tableViewModel;
@property (nonatomic,strong) NSMutableDictionary *valuesDic;
@property (nonatomic,strong) NSMutableArray *pickerSource;
@property (nonatomic,weak) AddGoodsCellDataModel *cellData;
@property (nonatomic,weak) AddGoodsCellDataModel *imageData;
@property (nonatomic,assign) BOOL openMoreInfo;
@end

@implementation AddGoodsModel

- (instancetype)initWithStoreId:(NSString *)storeId {
    if (self = [super init]) {
        _storeId = storeId;
    }
    return self;
}
- (NSInteger)pickerComponentsCount {
    return self.pickerSource.count;
}
- (NSInteger)pickerRowsInComponent:(NSInteger)component {
    return [self.pickerSource[component] count];
}
- (NSString *)pickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id<AddGoodsPickerModelProtocol> model = self.pickerSource[component][row];
    NSString *keyPath = [model pickerShowTextKeyPath];
    return [(NSObject *)model valueForKeyPath:keyPath];
}
- (BOOL)pickerReplaceObjectInRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerSource.count == 2) {
        if (component == 0) {
            id model = self.pickerSource[component][row];
            NSArray *filterArray = [self pickerObjectWithModel:model];
            if (filterArray) {
                [self.pickerSource replaceObjectAtIndex:component+1 withObject:filterArray];
                return YES;
            }
        }
    }
    return NO;
}
- (BOOL)pickerUpdateDataWithSelectedRows:(NSArray *)rows {
    NSMutableArray *pickerModels = @[].mutableCopy;
    if (self.pickerSource.count == 2) {
        NSInteger firstComponentSelectedRow = [rows[0] integerValue];
        id <AddGoodsPickerModelProtocol>bigModel = self.pickerSource[0][firstComponentSelectedRow];
        NSArray *filterArray = [self pickerObjectWithModel:bigModel];
        if (filterArray) {
            [self.pickerSource replaceObjectAtIndex:1 withObject:filterArray];
        }
        NSInteger secondComponentSelectedRow = [rows[1] integerValue];
        id <AddGoodsPickerModelProtocol>model = self.pickerSource[1][secondComponentSelectedRow];
        [pickerModels addObject:bigModel];
        [pickerModels addObject:model];
    } else if (self.pickerSource.count == 1) {
        NSInteger selectedRow = [rows[0] integerValue];
        id <AddGoodsPickerModelProtocol>model = self.pickerSource[0][selectedRow];
        [pickerModels addObject:model];
    }
    [self updateCellModelPickerContentModelsWithPickerModels:pickerModels];
    return YES;
}
- (void)updateDateDataWithDate:(NSDate *)date {
    NSString *dateStr = nil;
    if (date) {
        dateStr = [date stringWithDateFormatter:@"yyyy-MM-dd"];
    }
    AddGoodsInputDataModel *inputData = self.cellData.pickerContentModels.firstObject;
    inputData.showValue = dateStr;
    inputData.value = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    self.valuesDic = [self allValues].mutableCopy;
}

- (void)addImageDataWithImageUrl:(NSString *)imageUrl {
    NSMutableString *imageUrls = nil;
    if (self.imageData.imageContentModel.value) {
        imageUrls = self.imageData.imageContentModel.value.mutableCopy;
    } else {
        imageUrls = @"".mutableCopy;
    }
    if (imageUrl) {
        [imageUrls appendString:@","];
        [imageUrls appendString:imageUrl];
    }
    if ([imageUrls hasPrefix:@","]) {
        [imageUrls deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    self.imageData.imageContentModel.value = self.imageData.imageContentModel.showValue = imageUrls;
    self.valuesDic = [self allValues].mutableCopy;
}
- (void)deleteImageDataWithIndex:(NSInteger)index {
    NSString *imageUrl = self.imageData.imageContentModel.value;
    if (imageUrl.length > 0) {
        NSMutableArray *imageUrls = [imageUrl componentsSeparatedByString:@","].mutableCopy;
        if (imageUrls.count >= index + 1) {
            [imageUrls removeObjectAtIndex:index];
        }
        NSString *newImageUrl = [imageUrls componentsJoinedByString:@","];
        self.imageData.imageContentModel.value = self.imageData.imageContentModel.showValue = newImageUrl;
        self.valuesDic = [self allValues].mutableCopy;
    }
}
- (void)openOrCloseMoreInfo {
    self.openMoreInfo = !self.openMoreInfo;
    self.valuesDic = [self allValues].mutableCopy;
}
- (NSArray *)pickerObjectWithModel:(id <AddGoodsPickerModelProtocol>)bigModel {
    NSString *identKey = nil;
    if ([bigModel respondsToSelector:@selector(identifierKeyPathWithFilterPickerSource)]) {
         identKey = [bigModel identifierKeyPathWithFilterPickerSource];
    }
    if (!identKey) {
        return nil;
    }
    NSMutableArray *two = @[].mutableCopy;
    NSString *identValue = [(NSObject *)bigModel valueForKeyPath:identKey];
    for (id <AddGoodsPickerModelProtocol>model in self.categoryList) {
        NSString *key = [model keyPathWithFilterPickerSource];
        NSString *value = [(NSObject *)model valueForKeyPath:key];
        if ([value isEqualToString:identValue]) {
            [two addObject:model];
        }
    }
    return two.copy;
}
- (void)getGoodsSpeciInfoSuccess:(void(^)(void))success failure:(void(^)(NSString *errorMsg))failure {
    void(^successOperation)(NSDictionary *allWccDictionList) = ^(NSDictionary *allWccDictionList) {
        // 取出 商品规格及积分
        self.goodsMassunit = [allWccDictionList objectForKey:@"goods_massunit"];
        self.goodsPackageunit = [allWccDictionList objectForKey:@"goods_packageunit"];
        self.integralRules = [allWccDictionList objectForKey:@"integral_rules"];
        // 设置默认值
        if (self.valuesDic.allKeys.count == 0) {
            NSMutableDictionary *paramDic = @{}.mutableCopy;
            [paramDic setObject:self.integralRules.firstObject forKey:@"integration"];
            [paramDic setObject:self.goodsMassunit.firstObject forKey:@"speciUnit1"];
            [paramDic setObject:self.goodsPackageunit.firstObject forKey:@"speciUnit2"];
            [paramDic setObject:self.contentUnits.firstObject forKey:@"contentUnit"];
            NSMutableDictionary *showDic = @{}.mutableCopy;
            [showDic setObject:[self integrationNameWithIntegration:self.integralRules.firstObject] forKey:@"integration"];
            [showDic setObject:self.goodsMassunit.firstObject forKey:@"speciUnit1"];
            [showDic setObject:self.goodsPackageunit.firstObject forKey:@"speciUnit2"];
            [showDic setObject:self.contentUnits.firstObject forKey:@"contentUnit"];
            [self.valuesDic setObject:paramDic.copy forKey:@"parameters"];
            [self.valuesDic setObject:showDic forKey:@"showValue"];
        }
        if (success) {
            success();
        }
    };
    // 缓存key用请求Server_name
    NSString *key = @"server_getAllWccDictionList";
    NSDictionary *allWccDictionList = (NSDictionary *)[KaKaCache objectForKey:key];
    if (allWccDictionList) {
        successOperation(allWccDictionList);
        [[APIService share]httpRequestQueryGoodsSpecSuccess:^(NSDictionary *responseObject) {
            [KaKaCache setObject:responseObject forKey:key];
        } failure:nil];
    } else {
        [[APIService share]httpRequestQueryGoodsSpecSuccess:^(NSDictionary *responseObject) {
            [KaKaCache setObject:responseObject forKey:key];
            successOperation(responseObject);
        } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
            if (failure) {
                failure(errorMsg);
            }
        }];
    }
}
- (KKTableViewModel *)addGoodsTableViewModel {
    KKTableViewModel *tableViewModel = [[KKTableViewModel alloc]init];
    [tableViewModel addSetionModel:[self goodsNameSectionModel]];
    [tableViewModel addSetionModel:[self categorySectionModel]];
    [tableViewModel addSetionModel:[self goodsPriceSectionModel]];
    [tableViewModel addSetionModel:[self goodsMoreInfoSectionModel]];
    self.tableViewModel = tableViewModel;
    return tableViewModel;
}
- (void)updateDataWithRegistrationGoodsDic:(NSDictionary *)registrationGoods {
    NSDictionary *safeDic = [self safeStringValueWithDic:registrationGoods];
    if (self.valuesDic.allKeys.count > 0) {
        NSMutableDictionary *parameters = ((NSDictionary *)[self.valuesDic objectForKey:@"parameters"]).mutableCopy;
        [parameters setValuesForKeysWithDictionary:safeDic];
        // 判断企业字符是否合法
        NSString *companyName = parameters[@"companyName"];
        if (companyName && companyName.length > 32) {
            companyName = [companyName substringToIndex:32];
        }
        [parameters setObject:companyName forKey:@"companyName"];
        safeDic = parameters.copy;
    }
    [self.valuesDic setObject:safeDic forKey:@"parameters"];
    [self.valuesDic setObject:[self showValueWithParameters:safeDic] forKey:@"showValue"];
}
- (void)inputExistGoodsDic:(NSDictionary *)existGoods {
    NSDictionary *safeDic = [self safeStringValueWithDic:existGoods];
    // 大B无积分字段，特殊处理
    if (![safeDic.allKeys containsObject:@"integration"]) {
        NSMutableDictionary *bigBGoodsDic = safeDic.mutableCopy;
        [bigBGoodsDic setObject:@"0" forKey:@"integration"];
        // 大B无规格相关字段
        if (![safeDic.allKeys containsObject:@"speciNum"] && ![safeDic.allKeys containsObject:@"speciUnit1"] && ![safeDic.allKeys containsObject:@"speciUnit2"] && [safeDic.allKeys containsObject:@"goodsSpeci"]) {
            NSString *goodsSpec = safeDic[@"goodsSpeci"];
            NSString *speciNum = [goodsSpec numberValue];
            NSString *speciUnit1 = nil;
            NSString *speciUnit2 = nil;
            if (speciNum) {
                NSString *speciUnit = [goodsSpec substringFromIndex:speciNum.length];
                speciUnit1 = [speciUnit componentsSeparatedByString:@"/"].firstObject;
                speciUnit2 = [speciUnit componentsSeparatedByString:@"/"].lastObject;
            }
            if (speciNum && speciUnit1 && speciUnit2) {
                [bigBGoodsDic setObject:speciNum forKey:@"speciNum"];
                [bigBGoodsDic setObject:speciUnit1 forKey:@"speciUnit1"];
                [bigBGoodsDic setObject:speciUnit2 forKey:@"speciUnit2"];
            }
        }
        safeDic = bigBGoodsDic.copy;
    }
    if (self.valuesDic.allKeys.count > 0) {
        [self.valuesDic removeAllObjects];
    }
    [self.valuesDic setObject:safeDic forKey:@"parameters"];
    [self.valuesDic setObject:[self showValueWithParameters:safeDic] forKey:@"showValue"];
}
- (NSDictionary *)safeStringValueWithDic:(NSDictionary *)dic {
    if (dic) {
        NSMutableDictionary *mDic = dic.mutableCopy;
        for (NSString *key in mDic.allKeys) {
            NSString *value = mDic[key];
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [(NSNumber *)value stringValue];
                [mDic setValue:value forKey:key];
            }
        }
        return mDic.copy;
    }
    return @{};
}
- (NSDictionary *)showValueWithParameters:(NSDictionary *)parameters {
    NSMutableDictionary *showValue = parameters.mutableCopy;
    NSString *categoryId = showValue[@"goodsCategory"];
    NSString *integration = showValue[@"integration"];
    NSString *manufactureDate = showValue[@"manufactureDate"];
    NSString *validityTime = showValue[@"validityTime"];
    if (categoryId) {
        [showValue setObject:[self categoryNameWithCategoryId:categoryId] forKey:@"goodsCategory"];
    }
    if (integration) {
        [showValue setObject:[self integrationNameWithIntegration:integration] forKey:@"integration"];
    }
    if (manufactureDate) {
        if (manufactureDate.length > 0) {
            NSString *show = [manufactureDate stringByReplacingOccurrencesOfString:@" 00:00:00" withString:@""];
            [showValue setObject:show forKey:@"manufactureDate"];
        }
    }
    if (validityTime) {
        if (validityTime.length > 0) {
            NSString *show = [validityTime stringByReplacingOccurrencesOfString:@" 00:00:00" withString:@""];
            [showValue setObject:show forKey:@"validityTime"];
        }
    }
    return showValue;
}
/** 商品名称相关区数据*/
- (KKSectionModel *)goodsNameSectionModel {
    KKSectionModel *nameSectionModel = [[KKSectionModel alloc]init];
    // 登记证号
    KKCellModel *registrationNumCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"登记证号" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"registrationNo"] pickerParameterName:@"registrationNo" pickerValue:[self goodsValueForKey:@"registrationNo"] pickerSuffix:@""];
        data.modelOperation = self.registrationNum;
        return data;
    }];
    [nameSectionModel addCellModel:registrationNumCell];
    // 登记名称
    KKCellModel *goodsNameCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
        return [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"登记名称" textFieldPlaceholder:@"必填" showValue:[self goodsShowValueForKey:@"goodsName"] textFieldParameterName:@"goodsName" textFieldValue:[self goodsValueForKey:@"goodsName"] textFieldSuffix:@""];
    }];
    [nameSectionModel addCellModel:goodsNameCell];
    // 商品名称
    KKCellModel *goodsBrandCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
        return [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"商品名称" textFieldPlaceholder:@"必填" showValue:[self goodsShowValueForKey:@"goodsBrand"] textFieldParameterName:@"goodsBrand" textFieldValue:[self goodsValueForKey:@"goodsBrand"] textFieldSuffix:@""];
    }];
    [nameSectionModel addCellModel:goodsBrandCell];
    return nameSectionModel;
}
/** 分类相关区数据*/
- (KKSectionModel *)categorySectionModel {
    KKSectionModel *categorySectionModel = [[KKSectionModel alloc]init];
    NSString *categoryId = [self goodsValueForKey:@"goodsCategory"];
    NSString *categoryPid = [self categoryPidWithId:categoryId];
    // 分类
    KKCellModel *goodsCategoryCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"分类" pickerPlaceholder:@"必填,请选择" showValue:[self goodsShowValueForKey:@"goodsCategory"] pickerParameterName:@"goodsCategory" pickerValue:[self goodsValueForKey:@"goodsCategory"] pickerSuffix:@""];
        __weak typeof(data) weakData = data;
        data.modelOperation = ^() {
            self.cellData = weakData;
            [self.pickerSource removeAllObjects];
            NSMutableArray *one = @[].mutableCopy;
            for (CommodityCategoryModel *category in self.categoryList) {
                if ([category.pid isEqualToString:@"0"]) {
                    [one addObject:category];
                }
            }
            [self.pickerSource addObject:one];
            CommodityCategoryModel *model = one[0];
            NSMutableArray *two = @[].mutableCopy;
            for (CommodityCategoryModel *category in self.categoryList) {
                if ([category.pid isEqualToString:model.id]) {
                    [two addObject:category];
                }
            }
            [self.pickerSource addObject:two];
            if (self.showPicker) {
                self.showPicker();
            }
        };
        return data;
    }];
    [categorySectionModel addCellModel:goodsCategoryCell];
    if ([categoryPid isEqualToString:@"1"]) {    // 农药，特殊处理
        // 含量
        KKCellModel *contentCell = [self cellModelWithCellClassStr:@"AddGoodsPickerAndTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel goodsCellModelWithLeftTitle:@"含量" textFieldContentModel:[AddGoodsInputDataModel inputDataWithPlaceholder:@"请输入农药含量" showValue:[self goodsShowValueForKey:@"content"] parameterName:@"content" value:[self goodsValueForKey:@"content"] suffix:@""] pickerContentModels:@[[AddGoodsInputDataModel inputDataWithPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"contentUnit"] parameterName:@"contentUnit" value:[self goodsValueForKey:@"contentUnit"] suffix:@""]] imageContentModel:nil rightTitle:nil];
            data.limitPointPreCount = 8;
            data.limitPointLaterCount = 2;
            data.keyboardType = UIKeyboardTypeDecimalPad;
            __weak typeof(data) weakData = data;
            data.modelOperation = ^() {
                self.cellData = weakData;
                [self.pickerSource removeAllObjects];
                NSMutableArray *toxPicks = @[].mutableCopy;
                for (NSString *tox in self.contentUnits) {
                    GoodsContentUnitPickerModel *toxModel = [GoodsContentUnitPickerModel pickerModelWithName:tox];
                    [toxPicks addObject:toxModel];
                }
                [self.pickerSource addObject:toxPicks];
                if (self.showPicker) {
                    self.showPicker();
                }
            };
            return data;
        }];
        [categorySectionModel addCellModel:contentCell];
        // 毒性
        KKCellModel *toxicityCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"毒性" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"toxicity"] pickerParameterName:@"toxicity" pickerValue:[self goodsValueForKey:@"toxicity"] pickerSuffix:@""];
            __weak typeof(data) weakData = data;
            data.modelOperation = ^() {
                self.cellData = weakData;
                [self.pickerSource removeAllObjects];
                NSMutableArray *toxPicks = @[].mutableCopy;
                for (NSString *tox in self.toxicitys) {
                    GoodsToxicityPickerModel *toxModel = [GoodsToxicityPickerModel pickerModelWithName:tox];
                    [toxPicks addObject:toxModel];
                }
                [self.pickerSource addObject:toxPicks];
                if (self.showPicker) {
                    self.showPicker();
                }
            };
            return data;
        }];
        [categorySectionModel addCellModel:toxicityCell];
        // 剂型
        KKCellModel *formulationCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"剂型" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"formulation"] pickerParameterName:@"formulation" pickerValue:[self goodsValueForKey:@"formulation"] pickerSuffix:@""];
            __weak typeof(data) weakData = data;
            data.modelOperation = ^() {
                self.cellData = weakData;
                [self.pickerSource removeAllObjects];
                NSMutableArray *toxPicks = @[].mutableCopy;
                for (NSString *tox in self.formulations) {
                    GoodsFormulationPickerModel *toxModel = [GoodsFormulationPickerModel pickerModelWithName:tox];
                    [toxPicks addObject:toxModel];
                }
                [self.pickerSource addObject:toxPicks];
                if (self.showPicker) {
                    self.showPicker();
                }
            };
            return data;
        }];
        [categorySectionModel addCellModel:formulationCell];
    } else if ([categoryPid isEqualToString:@"2"]) { // 化肥，特殊处理
        // 含量（氮磷钾）
        KKCellModel *contentCell = [self cellModelWithCellClassStr:@"AddGoodsMoreTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            // 氮
            AddGoodsInputDataModel *nitrogenInput = [AddGoodsInputDataModel inputDataWithTitle:@"氮" placeholder:@"数量" showValue:[self goodsShowValueForKey:@"nitrogen"] parameterName:@"nitrogen" value:[self goodsValueForKey:@"nitrogen"] suffix:@""];
            // 磷
            AddGoodsInputDataModel *phosphorus = [AddGoodsInputDataModel inputDataWithTitle:@"磷" placeholder:@"数量" showValue:[self goodsShowValueForKey:@"phosphorus"] parameterName:@"phosphorus" value:[self goodsValueForKey:@"phosphorus"] suffix:@""];
            // 钾
            AddGoodsInputDataModel *potassium = [AddGoodsInputDataModel inputDataWithTitle:@"钾" placeholder:@"数量" showValue:[self goodsShowValueForKey:@"potassium"] parameterName:@"potassium" value:[self goodsValueForKey:@"potassium"] suffix:@""];
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel customContentGoodsCellModelWithTitle:@"含量" customContentModels:@[nitrogenInput,phosphorus,potassium]];
            data.keyboardType = UIKeyboardTypeNumberPad;
            data.limitPointPreCount = 2;
            data.limitPointLaterCount = 0;
            return data;
        }];
        [categorySectionModel addCellModel:contentCell];
    }
    return categorySectionModel;
}

/** 价格相关区数据*/
- (KKSectionModel *)goodsPriceSectionModel {
    KKSectionModel *priceSectionModel = [[KKSectionModel alloc]init];
    // 规格
    KKCellModel *contentCell = [self cellModelWithCellClassStr:@"AddGoodsPickerAndTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel goodsCellModelWithLeftTitle:@"规格" textFieldContentModel:[AddGoodsInputDataModel inputDataWithPlaceholder:@"必填，数量" showValue:[self goodsShowValueForKey:@"speciNum"] parameterName:@"speciNum" value:[self goodsValueForKey:@"speciNum"] suffix:@""] pickerContentModels:@[[AddGoodsInputDataModel inputDataWithPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"speciUnit1"] parameterName:@"speciUnit1" value:[self goodsValueForKey:@"speciUnit1"] suffix:@"/"],[AddGoodsInputDataModel inputDataWithPlaceholder:@"" showValue:[self goodsShowValueForKey:@"speciUnit2"] parameterName:@"speciUnit2" value:[self goodsValueForKey:@"speciUnit2"] suffix:@""]] imageContentModel:nil rightTitle:nil];
        data.keyboardType = UIKeyboardTypeDecimalPad;
        data.limitPointPreCount = 4;
        data.limitPointLaterCount = 2;
        __weak typeof(data) weakData = data;
        data.modelOperation = ^() {
            self.cellData = weakData;
            [self.pickerSource removeAllObjects];
           
            NSMutableArray *one = @[].mutableCopy;
            for (NSString *massunit in self.goodsMassunit) {
                GoodsSpeciPickerModel *massunitModel = [GoodsSpeciPickerModel pickerModelWithName:massunit];
                [one addObject:massunitModel];
            }
            [self.pickerSource addObject:one];
            NSMutableArray *two = @[].mutableCopy;
            for (NSString *package in self.goodsPackageunit) {
                GoodsSpeciPickerModel *packageModel = [GoodsSpeciPickerModel pickerModelWithName:package];
                [two addObject:packageModel];
            }
            [self.pickerSource addObject:two];
            
            if (self.showPicker) {
                self.showPicker();
            }
        };
         return data;
    }];
    [priceSectionModel addCellModel:contentCell];
    // 销售单价
    KKCellModel *outputSaleCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldRightTitleCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel textFieldAndRightTitleContentGoodsCellModelWithTitle:@"销售单价" textFieldPlaceholder:@"必填" showValue:[self goodsShowValueForKey:@"outputSale"] textFieldParameterName:@"outputSale" textFieldValue:[self goodsValueForKey:@"outputSale"] textFieldSuffix:@"" rightTitle:@"元"];
        data.keyboardType = UIKeyboardTypeDecimalPad;
        data.limitPointPreCount = 8;
        data.limitPointLaterCount = 2;
        return data;
    }];
    [priceSectionModel addCellModel:outputSaleCell];
    // 进货单价
    KKCellModel *inputSaleCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldRightTitleCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel textFieldAndRightTitleContentGoodsCellModelWithTitle:@"进货单价" textFieldPlaceholder:@"" showValue:[self goodsShowValueForKey:@"inputSale"] textFieldParameterName:@"inputSale" textFieldValue:[self goodsValueForKey:@"inputSale"] textFieldSuffix:@"" rightTitle:@"元"];
        data.keyboardType = UIKeyboardTypeDecimalPad;
        data.limitPointPreCount = 8;
        data.limitPointLaterCount = 2;
        return data;
    }];
    [priceSectionModel addCellModel:inputSaleCell];
    // 商品积分
    KKCellModel *integrationCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"商品积分" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"integration"] pickerParameterName:@"integration" pickerValue:[self goodsValueForKey:@"integration"] pickerSuffix:@""];
        __weak typeof(data) weakData = data;
        data.modelOperation = ^() {
            self.cellData = weakData;
            [self.pickerSource removeAllObjects];
            
            NSMutableArray *integrationPicks = @[].mutableCopy;
            for (NSString *integration in self.integralRules) {
                GoodsIntegrationPickerModel *toxModel = [GoodsIntegrationPickerModel pickerModelWithIntegrationValue:integration];
                [integrationPicks addObject:toxModel];
            }
            [self.pickerSource addObject:integrationPicks];
            if (self.showPicker) {
                self.showPicker();
            }
        };
        return data;
    }];
    [priceSectionModel addCellModel:integrationCell];
    // 添加图片
    KKCellModel *imageCell = [self cellModelWithCellClassStr:@"AddGoodsImageCell" cellDataBlock:^AddGoodsCellDataModel *{
        AddGoodsCellDataModel *data = [AddGoodsCellDataModel imageContentGoodsCellModelWithTitle:@"添加图片" imageContentModel:[AddGoodsInputDataModel inputDataWithPlaceholder:@"" showValue:[self goodsShowValueForKey:@"imageUrl"] parameterName:@"imageUrl" value:[self goodsValueForKey:@"imageUrl"] suffix:@""]];
        self.imageData = data;
        return data;
    }];
    imageCell.height = 90.0f;
    [priceSectionModel addCellModel:imageCell];
    return priceSectionModel;
}

/** 更多信息区数据*/
- (KKSectionModel *)goodsMoreInfoSectionModel {
    KKSectionModel *moreInfoSectionModel = [[KKSectionModel alloc]init];
    KKCellModel *headerModel = [[KKCellModel alloc]init];
    AddGoodsHeaderViewModel *headerData = [[AddGoodsHeaderViewModel alloc]init];
    headerData.headerTitle = @"添加更多信息";
    headerData.open = self.openMoreInfo;
    headerModel.data = headerData;
    headerModel.cellClass = NSClassFromString(@"AddGoodsHeaderView");
    headerModel.height = 50.0f;
    moreInfoSectionModel.headerData = headerModel;
    if (self.openMoreInfo) {
        // 生产日期
        KKCellModel *manufactureDateCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"生产日期" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"manufactureDate"] pickerParameterName:@"manufactureDate" pickerValue:[self goodsValueForKey:@"manufactureDate"] pickerSuffix:@""];
            __weak typeof(data) weakData = data;
            data.modelOperation = ^() {
                self.cellData = weakData;
                if (self.showDataPicker) {
                    self.showDataPicker(nil,[NSDate date]);
                }
            };
            return data;
        }];
        [moreInfoSectionModel addCellModel:manufactureDateCell];
        // 有效日期
        KKCellModel *validityTimeCell = [self cellModelWithCellClassStr:@"AddGoodsPickerCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel pickerContentGoodsCellModelWithTitle:@"有效日期" pickerPlaceholder:@"请选择" showValue:[self goodsShowValueForKey:@"validityTime"] pickerParameterName:@"validityTime" pickerValue:[self goodsValueForKey:@"validityTime"] pickerSuffix:@""];
            __weak typeof(data) weakData = data;
            data.modelOperation = ^() {
                self.cellData = weakData;
                if (self.showDataPicker) {
                    self.showDataPicker([self manufactureDate],nil);
                }
            };
            return data;
        }];
        [moreInfoSectionModel addCellModel:validityTimeCell];
        // 库存数
        KKCellModel *stockCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            AddGoodsCellDataModel *data = [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"库存数" textFieldPlaceholder:@"" showValue:[self goodsShowValueForKey:@"stock"] textFieldParameterName:@"stock" textFieldValue:[self goodsValueForKey:@"stock"] textFieldSuffix:@""];
            data.keyboardType = UIKeyboardTypeNumberPad;
            return data;
        }];
        [moreInfoSectionModel addCellModel:stockCell];
        // 生产企业
        KKCellModel *companyNameCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            return [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"生产企业" textFieldPlaceholder:@"" showValue:[self goodsShowValueForKey:@"companyName"] textFieldParameterName:@"companyName" textFieldValue:[self goodsValueForKey:@"companyName"] textFieldSuffix:@""];
        }];
        [moreInfoSectionModel addCellModel:companyNameCell];
        // 使用说明
        KKCellModel *useIntroCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            return [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"使用说明" textFieldPlaceholder:@"" showValue:[self goodsShowValueForKey:@"useIntro"] textFieldParameterName:@"useIntro" textFieldValue:[self goodsValueForKey:@"useIntro"] textFieldSuffix:@""];
        }];
        [moreInfoSectionModel addCellModel:useIntroCell];
        // 备注
        KKCellModel *remarkCell = [self cellModelWithCellClassStr:@"AddGoodsTextFieldCell" cellDataBlock:^AddGoodsCellDataModel *{
            return [AddGoodsCellDataModel textFieldContentGoodsCellModelWithTitle:@"备注" textFieldPlaceholder:@"" showValue:[self goodsShowValueForKey:@"remark"] textFieldParameterName:@"remark" textFieldValue:[self goodsValueForKey:@"remark"] textFieldSuffix:@""];
        }];
        [moreInfoSectionModel addCellModel:remarkCell];
    }
    return moreInfoSectionModel;
}
- (NSDictionary *)allValues {
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSDictionary *values = self.valuesDic[@"parameters"];
    if (!values) {
        values = @{};
    }
    NSDictionary *showValues = self.valuesDic[@"showValue"];
    if (!showValues) {
        showValues = @{};
    }
    NSMutableDictionary *parameters = values.mutableCopy;
    NSMutableDictionary *showValuesM = showValues.mutableCopy;
    [self.tableViewModel.sectionDataList enumerateObjectsUsingBlock:^(KKSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.cellDataList enumerateObjectsUsingBlock:^(KKCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AddGoodsCellDataModel *cellData = obj.data;
            [parameters setValuesForKeysWithDictionary:cellData.requestParameters];
            [showValuesM setValuesForKeysWithDictionary:cellData.showValues];
        }];
    }];
    [dic setValue:showValuesM forKey:@"showValue"];
    [dic setValue:parameters forKey:@"parameters"];
    return dic.copy;
}
- (NSDictionary *)requestParameters {
    NSDictionary *values = self.valuesDic[@"parameters"];
    if (!values) {
        values = @{};
    }
    NSMutableDictionary *parameters = values.mutableCopy;
    [self.tableViewModel.sectionDataList enumerateObjectsUsingBlock:^(KKSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.cellDataList enumerateObjectsUsingBlock:^(KKCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AddGoodsCellDataModel *cellData = obj.data;
            [parameters setValuesForKeysWithDictionary:cellData.requestParameters];
        }];
    }];
    return parameters.copy;
}
- (NSString *)checkRequestParametersErrorMsg {
    BOOL flag = NO;
    NSString *errorMsg = nil;
    NSDictionary *requestDic = [self requestParameters];
    // 登记名称
    NSString *goodsName = requestDic[@"goodsName"];
    // 商品名称
    NSString *goodsBrand = requestDic[@"goodsBrand"];
    // 分类
    NSString *goodsCategory = requestDic[@"goodsCategory"];
    // 规格1
    NSString *speciUnit1 = requestDic[@"speciUnit1"];
    // 规格2
    NSString *speciUnit2 = requestDic[@"speciUnit2"];
    // 规格数量
    NSString *speciNum = requestDic[@"speciNum"];
    // 销售单价
    NSString *outputSale = requestDic[@"outputSale"];
    // 进货单价
    NSString *inputSale = requestDic[@"inputSale"];
    // 商品积分
    NSString *integration = requestDic[@"integration"];
    // 库存数
    NSString *stock = requestDic[@"stock"];
    // 生产企业
    NSString *companyName = requestDic[@"companyName"];
    // 使用说明
    NSString *useIntro = requestDic[@"useIntro"];
    // 备注
    NSString *remark = requestDic[@"remark"];
    // 氮
    NSString *nitrogen = requestDic[@"nitrogen"];
    // 磷
    NSString *phosphorus = requestDic[@"phosphorus"];
    // 钾
    NSString *potassium = requestDic[@"potassium"];
    if (goodsName.length == 0) {
        flag = YES;
        errorMsg = @"请输入登记名称";
    } else if (goodsName.length > 16){
        flag = YES;
        errorMsg = @"登记名称最多16个字";
    } else if ([goodsName firstLetterLegal]) {
        flag = YES;
        errorMsg = @"登记名称首字不能为特殊符号";
    }
    if (!flag) {
        if (goodsBrand.length == 0) {
            flag = YES;
            errorMsg = @"请输入商品名称";
        } else if (goodsBrand.length > 16){
            flag = YES;
            errorMsg = @"商品名称最多16个字";
        } else if ([goodsBrand firstLetterLegal]) {
            flag = YES;
            errorMsg = @"商品名称首字不能为特殊符号";
        }
    }
    if (!flag) {
        if (goodsCategory.length == 0) {
            flag = YES;
            errorMsg = @"请选择分类";
        }
    }
    if (!flag) {
        if (nitrogen.length != 0) {
            if (![nitrogen validateTwoPlaceNum]) {
                flag = YES;
                errorMsg = @"氮含量请输入0-100内的整数";
            }
        }
    }
    if (!flag) {
        if (phosphorus.length != 0) {
            if (![phosphorus validateTwoPlaceNum]) {
                flag = YES;
                errorMsg = @"磷含量请输入0-100内的整数";
            }
        }
    }
    if (!flag) {
        if (potassium.length != 0) {
            if (![potassium validateTwoPlaceNum]) {
                flag = YES;
                errorMsg = @"钾含量请输入0-100内的整数";
            }
        }
    }
    if (!flag) {
        if (speciUnit1.length == 0) {
            flag = YES;
            errorMsg = @"请选择规格";
        }
    }
    if (!flag) {
        if (speciUnit2.length == 0) {
            flag = YES;
            errorMsg = @"请选择规格";
        }
    }
    if (!flag) {
        if (speciNum.length == 0) {
            flag = YES;
            errorMsg = @"请输入规格数量";
        } else if (![speciNum validateTenThousandAndTwoDecimal]) {
            flag = YES;
            errorMsg = @"规格数量请输入10000内的数,最多支持2位小数";
        }
    }
    if (!flag) {
        if (outputSale.length == 0) {
            flag = YES;
            errorMsg = @"请输入销售单价";
        } else if ([outputSale floatValue] == 0.00) {
            flag = YES;
            errorMsg = @"销售价必填";
        } else if (![outputSale validatePrice]) {
            flag = YES;
            errorMsg = @"销售单价整数最多8位，小数最多2位";
        }
    }
    if (!flag) {
        if (integration.length == 0) {
            flag = YES;
            errorMsg = @"请选择商品积分";
        }
    }
    if (!flag) {
        if (inputSale.length != 0) {
            if (![inputSale validatePrice]) {
                flag = YES;
                errorMsg = @"进货单价整数最多8位，小数最多2位";
            }
        }
    }
    if (!flag) {
        if (stock.length != 0 && stock.length > 9) {
            flag = YES;
            errorMsg = @"库存数最多支持9位整数";
        }
    }
    if (!flag) {
        if (companyName.length != 0) {
            if (companyName.length > 32) {
                flag = YES;
                errorMsg = @"生产企业最多输入32个字";
            }
        }
    }
    if (!flag) {
        if (useIntro.length != 0) {
            if (useIntro.length > 50) {
                flag = YES;
                errorMsg = @"使用说明最多输入50个字";
            }
        }
    }
    if (!flag) {
        if (remark.length != 0) {
            if (remark.length > 50) {
                flag = YES;
                errorMsg = @"备注最多输入50个字";
            }
        }
    }
    return errorMsg;
}
- (BOOL)checkInputPriceGtOutputPrice {
    NSDictionary *requestDic = [self requestParameters];
    // 销售单价
    NSString *outputSale = requestDic[@"outputSale"];
    // 进货单价
    NSString *inputSale = requestDic[@"inputSale"];
    return [outputSale floatValue] < [inputSale floatValue];
}
- (NSString *)requestGoodsParameterStr {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    NSDictionary *originalParameters = [self requestParameters];
    [parameters setValuesForKeysWithDictionary:originalParameters];
    NSArray *defaultZeroValues = @[@"nitrogen",@"phosphorus",@"potassium",@"content"];
    for (NSString *key in defaultZeroValues) {
        NSString *value = [parameters objectForKey:key];
        if (value && value.length == 0) {
            value = @"0";
            [parameters setObject:value forKey:key];
        }
    }
    NSMutableArray *nilValueKeys = @[].mutableCopy;
    for (NSString *key in parameters.allKeys) {
        NSString *value = parameters[key];
        if (value.length == 0) {
            [nilValueKeys addObject:key];
        }
    }
    [parameters removeObjectsForKeys:nilValueKeys];
    // 添加固定参数
    [parameters setObject:@"app" forKey:@"datafrom"];
    [parameters setObject:self.storeId forKey:@"storeId"];
    NSString *online = parameters[@"online"];
    if (!online || [online boolValue]) {
        [parameters setObject:@(YES) forKey:@"online"];
    } else {
        [parameters setObject:@(NO) forKey:@"online"];
    }
    NSMutableString *goodsSpeci = @"".mutableCopy;
    NSString *speciNum = [originalParameters objectForKey:@"speciNum"];
    NSString *speciUnit1 = [originalParameters objectForKey:@"speciUnit1"];
    NSString *speciUnit2 = [originalParameters objectForKey:@"speciUnit2"];
    if (speciNum) {
        [goodsSpeci appendString:speciNum];
    }
    if (speciUnit1) {
        [goodsSpeci appendString:speciUnit1];
    }
    if (speciUnit2) {
        [goodsSpeci appendString:@"/"];
        [goodsSpeci appendString:speciUnit2];
    }
    [parameters setObject:goodsSpeci forKey:@"goodsSpeci"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *parameterStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return parameterStr;
}
- (NSDate *)manufactureDate {
    NSDate *date = nil;
    NSDictionary *parameters = [self requestParameters];
    NSString *dateStr = [parameters objectForKey:@"manufactureDate"];
    if (dateStr.length > 0) {
        date = [NSDate dateWithDateString:dateStr dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
    return date;
}
- (NSDate *)validityTimeDate {
    NSDate *date = nil;
    NSDictionary *parameters = [self requestParameters];
    NSString *dateStr = [parameters objectForKey:@"validityTime"];
    if (dateStr.length > 0) {
        date = [NSDate dateWithDateString:dateStr dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
    return date;
}
- (void)updateCellModelPickerContentModelsWithPickerModels:(NSArray <id <AddGoodsPickerModelProtocol>>*)pickerModels {
    if (pickerModels.count > 0) {
        if (self.cellData.pickerContentModels.count == 1) {
            AddGoodsInputDataModel *inputData = self.cellData.pickerContentModels.firstObject;
            id <AddGoodsPickerModelProtocol>pickerModel = pickerModels.lastObject;
            NSString *valueKey = [pickerModel parameterValueWithKeyPath];
            NSString *showValueKey = [pickerModel pickerShowTextKeyPath];
            inputData.value = [(NSObject *)pickerModel valueForKeyPath:valueKey];
            inputData.showValue = [(NSObject *)pickerModel valueForKeyPath:showValueKey];
        } else if (self.cellData.pickerContentModels.count == 2) {
            [self.cellData.pickerContentModels enumerateObjectsUsingBlock:^(AddGoodsInputDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                id <AddGoodsPickerModelProtocol>pickerModel = pickerModels[idx];
                NSString *valueKey = [pickerModel parameterValueWithKeyPath];
                NSString *showValueKey = [pickerModel pickerShowTextKeyPath];
                obj.value = [(NSObject *)pickerModel valueForKeyPath:valueKey];
                obj.showValue = [(NSObject *)pickerModel valueForKeyPath:showValueKey];
            }];
        }
        self.valuesDic = [self allValues].mutableCopy;
    }
}
- (NSString *)categoryNameWithCategoryId:(NSString *)categoryId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id = %@",categoryId];
    NSArray *preArray = [self.categoryList filteredArrayUsingPredicate:predicate];
    if (preArray && preArray.count > 0) {
        return ((CommodityCategoryModel *)preArray.firstObject).name;
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

- (KKCellModel *)cellModelWithCellClassStr:(NSString *)cellClassStr cellDataBlock:(AddGoodsCellDataModel * (^)(void))cellDataBlock {
    KKCellModel *cellModel = [[KKCellModel alloc]init];
    cellModel.data = cellDataBlock();
    cellModel.cellClass = NSClassFromString(cellClassStr);
    cellModel.height = 50.0f;
    return cellModel;
}
- (NSString *)goodsValueForKey:(NSString *)key {
    NSDictionary *values = [self.valuesDic objectForKey:@"parameters"];
    if (values.allKeys.count > 0) {
        NSString *value = [values objectForKey:key];
        if (!value) {
            value = @"";
        }
        return value;
    }
    return @"";
}
- (NSString *)goodsShowValueForKey:(NSString *)key {
    NSDictionary *values = [self.valuesDic objectForKey:@"showValue"];
    if (values.allKeys.count > 0) {
        return [values objectForKey:key];
    }
    return nil;
}
- (NSString *)categoryPidWithId:(NSString *)Id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id = %@",Id];
    NSArray *preArray = [self.categoryList filteredArrayUsingPredicate:predicate];
    if (preArray && preArray.count > 0) {
        return ((CommodityCategoryModel *)preArray.firstObject).pid;
    }
    return @"";
}
- (NSMutableDictionary *)valuesDic {
    if (!_valuesDic) {
        _valuesDic = [NSMutableDictionary dictionary];
    }
    return _valuesDic;
}
- (NSMutableArray *)pickerSource {
    if (!_pickerSource) {
        _pickerSource = [NSMutableArray array];
    }
    return _pickerSource;
}
- (NSArray *)contentUnits {
    if (!_contentUnits) {
        _contentUnits = @[@"%",@"克/升"];
    }
    return _contentUnits;
}
- (NSArray *)toxicitys {
    if (!_toxicitys) {
        _toxicitys = @[@"微毒",@"低毒",@"中毒",@"高毒",@"剧毒"];
    }
    return _toxicitys;
}
- (NSArray *)formulations {
    if (!_formulations) {
        _formulations = @[@"乳油",@"悬浮剂",@"可湿性粉剂",@"粉剂",@"粒剂",@"水剂",@"毒饵",@"母液",@"母粉"];
    }
    return _formulations;
}
@end
