
//
//  ReicpePackageAddPrescriptionModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionModel.h"
#import "AddGoodsModel.h"
#import "ReicpePackageAddPrescriptionHeader.h"
#import "ReicpePackageAddPrescriptionFooter.h"
#import "CommodityCategoryModel.h"
#import "KaKaCache.h"

@interface NSString (PickerModelProtocol)<AddGoodsPickerModelProtocol>

@end

@implementation  NSString (PickerModelProtocol)
- (NSString *)pickerShowTextKeyPath {
    return self;
}

- (NSString *)parameterValueWithKeyPath {
    return self;
}
@end

@interface ReicpePackageAddPrescriptionModel ()
/** 作物*/
@property (nonatomic,copy) NSDictionary *crop;
/** 处方名称*/
@property (nonatomic,copy) NSString *prescriptionName;
/** 处方规格*/
@property (nonatomic,copy) NSString *prescriptionSpecName;
/** 销售价格*/
@property (nonatomic,copy) NSString *salePrice;
/** 商品积分*/
@property (nonatomic,copy) NSString *integration;
/** 处方说明*/
@property (nonatomic,copy) NSString *prescriptionDescription;
/** 处方商品列表*/
@property (nonatomic,strong) NSMutableArray *goodsList;
/** 套餐id*/
@property (nonatomic,copy) NSString *prescriptionId;
/** 商品总个数*/
@property (nonatomic,assign) NSInteger totalCount;
/** 商品实际总价格*/
@property (nonatomic,assign) CGFloat totalPrice;


@property (nonatomic,strong) NSArray *prescriptionSpecNameList;
@property (nonatomic,strong) NSArray *integralRules;

@property (nonatomic,strong) NSMutableArray *pickerSource;
@end

@implementation ReicpePackageAddPrescriptionModel

- (instancetype)init {
    if (self = [super init]) {
        // 处方规格默认值为‘40斤水’
        _prescriptionSpecName = self.prescriptionSpecNameList.firstObject;
        _salePrice = @"0.00";
        [self getGoodsSpeciInfoSuccess:nil failure:nil];
    }
    return self;
}
- (NSDictionary *)prescriptionDicWithAddGoodsDic:(NSDictionary *)goodsDic {
    if (!goodsDic) {
        return @{};
    }
    NSMutableDictionary *presDic = @{}.mutableCopy;
    for (NSString *key in goodsDic.allKeys) {
        NSString *value = goodsDic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [(NSNumber *)value stringValue];
        }
        NSString *needKey = self.addGoodsDicKeyMapPrescriptionDic[key];
        if (!needKey) {
            needKey = key;
        }
        [presDic setObject:value forKey:needKey];
    }
    // 额外增加的字段
    NSString *goodsSpec = presDic[@"goodsSpec"];
//    NSInteger goodsNumber = [presDic[@"goodsNumber"] integerValue];
    NSString *goodsOutputSale = presDic[@"goodsOutputSale"];
    NSString *speciNum = [goodsSpec numberValue];
    NSString *goodsUseUnit = nil;
    if (speciNum) {
        NSString *speciUnit = [goodsSpec substringFromIndex:speciNum.length];
        goodsUseUnit = [speciUnit componentsSeparatedByString:@"/"].firstObject;
    } else {
        goodsUseUnit = [goodsSpec componentsSeparatedByString:@"/"].firstObject;
    }
//    NSString *goodsUseNumber = [NSString stringWithFormat:@"%.2f",goodsNumber * speciNum];
    [presDic setObject:goodsUseUnit forKey:@"goodsUseUnit"];
    [presDic setObject:self.prescriptionSpecName forKey:@"goodsUseSpc"];
    [presDic setObject:speciNum ? speciNum : @"" forKey:@"goodsUseNumber"];
    [presDic setObject:goodsOutputSale forKey:@"goodsPrice"];
    [presDic setObject:goodsOutputSale forKey:@"singleGoodsPrice"];
    return presDic.copy;
}
- (NSDictionary *)addGoodsDicWithPrescriptionDic:(NSDictionary *)prescriptionDic {
    if (!prescriptionDic) {
        return @{};
    }
    NSMutableDictionary *goodsDic = @{}.mutableCopy;
    for (NSString *key in prescriptionDic.allKeys) {
        NSString *value = prescriptionDic[key];
        NSString *needKey = self.prescriptionDicMapAddGoodsDicKey[key];
        if (!needKey) {
            needKey = key;
        }
        [goodsDic setObject:value forKey:needKey];
    }
    return goodsDic.copy;
}
- (void)getGoodsSpeciInfoSuccess:(void(^)(void))success failure:(void(^)(NSString *errorMsg))failure {
    // 缓存key用请求Server_name
    NSString *key = @"server_getAllWccDictionList";
    NSDictionary *allWccDictionList = (NSDictionary *)[KaKaCache objectForKey:key];
    if (allWccDictionList) {
        // 取出 积分
        self.integralRules = [allWccDictionList objectForKey:@"integral_rules"];
        // 设置默认积分
        if (!self.integration) {
            self.integration = self.integralRules.firstObject;
        }
        if (success) {
            success();
        }
    } else {
        [[APIService share]httpRequestQueryGoodsSpecSuccess:^(NSDictionary *responseObject) {
            [KaKaCache setObject:responseObject forKey:key];
            self.integralRules = [responseObject objectForKey:@"integral_rules"];
            // 设置默认积分
            if (!self.integration) {
                self.integration = self.integralRules.firstObject;
            }
            if (success) {
                success();
            }
        } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
            if (failure) {
                failure(errorMsg);
            }
        }];
    }
}
- (ReicpePackageAddPrescriptionTabHeaderModel *)tabHeaderModel {
    ReicpePackageAddPrescriptionTabHeaderModel *headerModel = [[ReicpePackageAddPrescriptionTabHeaderModel alloc]init];
    headerModel.prescriptionTitle = [self.crop objectForKey:@"cropName"];
    headerModel.prescriptionNameTitle = @"处方名称";
    headerModel.prescriptionNamePlaceholder = @"必填(最多20个字)";
    headerModel.prescriptionNameContent = self.prescriptionName;
    headerModel.prescriptionSpecTitle = @"规格";
    headerModel.prescriptionSpecContent = [NSString stringWithFormat:@"%@/套",self.prescriptionSpecName];
    headerModel.rightPlaceholder = headerModel.prescriptionSpecContent ? [[NSAttributedString alloc]initWithString:@"修改" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#F29700"]}] : [[NSAttributedString alloc]initWithString:@"请选择" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8F8E94"]}];
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
- (ReicpePackageAddPrescriptionTabFooterModel *)tabFooterModel {
    ReicpePackageAddPrescriptionTabFooterModel *footerModel = [[ReicpePackageAddPrescriptionTabFooterModel alloc]init];
    footerModel.salePriceTitle = @"销售价格";
    footerModel.salePriceContent = [[self showSalePrice:self.salePrice] isEqualToString:@"¥0.00"] ? nil :[self showSalePrice:self.salePrice];
    footerModel.salePricePlaceholder = @"¥0.00";
    footerModel.integrationTitle = @"商品积分";
    footerModel.integrationContent = [self integrationNameWithIntegration:self.integration];
    footerModel.integrationPlaceholder = footerModel.integrationContent ? [[NSAttributedString alloc]initWithString:@"修改" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#F29700"]}] : [[NSAttributedString alloc]initWithString:@"请选择" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8F8E94"]}];
    footerModel.descriptionTitle = @"处方说明";
    footerModel.descriptionContent = self.prescriptionDescription;
    footerModel.descriptionPlaceholder = @"最多50个字";
    return footerModel;
}
- (NSArray *)stockGoodsListVCGoodsList {
    if (self.goodsList.count == 0) {
        return @[];
    }
    NSMutableArray *goodsList = @[].mutableCopy;
    for (NSDictionary *prescriptionDic in self.goodsList) {
        NSDictionary *goods = [self addGoodsDicWithPrescriptionDic:prescriptionDic];
        [goodsList addObject:goods];
    }
    return goodsList.copy;
}

- (NSArray <KKCellModel *> *)cellModelList {
    if (self.goodsList.count == 0) {
        return @[];
    }
    NSMutableArray *cellList = @[].mutableCopy;
    for (NSDictionary *goods in self.goodsList) {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.data = [self cellDataWithGoodsDic:goods];
        cellModel.cellClass = NSClassFromString(@"ReicpePackageAddPrescriptionCell");
        cellModel.height = 195.0f;
        [cellList addObject:cellModel];
    }
    return cellList.copy;
}
- (KKCellModel *)sectionHeaderModel {
    KKCellModel *headerModel = [KKCellModel new];
    headerModel.data = [self sectionHeaderData];
    headerModel.cellClass = NSClassFromString(@"ReicpePackageAddPrescriptionHeader");
    headerModel.height = 50.0f;
    return headerModel;
}
- (KKCellModel *)sectionFooterModel {
    KKCellModel *footerModel = [KKCellModel new];
    footerModel.data = [self sectionFooterData];
    footerModel.cellClass = NSClassFromString(@"ReicpePackageAddPrescriptionFooter");
    footerModel.height = 50.0f;
    return footerModel;
}
- (ReicpePackageAddPrescriptionCellModel *)cellDataWithGoodsDic:(NSDictionary *)goodsDic {
    ReicpePackageAddPrescriptionCellModel *data = [ReicpePackageAddPrescriptionCellModel new];
    data.goodsBrand = goodsDic[@"goodsBrand"];
    data.goodsName = goodsDic[@"goodsName"];
    data.singlePrice = [NSString stringWithFormat:@"¥%@",goodsDic[@"goodsOutputSale"]];
    data.goodsSpeci = goodsDic[@"goodsSpec"];
    data.useSpcTitle = @"用量说明";
    data.useSpcContent = goodsDic[@"goodsUseNumber"];
    data.useSpcUnit = [NSString stringWithFormat:@"%@/%@",goodsDic[@"goodsUseUnit"],self.prescriptionSpecName] ;
    data.goodsNumber = [goodsDic[@"goodsNumber"] integerValue];
    return data;
}
- (ReicpePackageAddPrescriptionHeaderModel *)sectionHeaderData {
    ReicpePackageAddPrescriptionHeaderModel *headerData = [ReicpePackageAddPrescriptionHeaderModel new];
    headerData.headerLeftTitle = @"处方商品";
    NSString *middleStr = @"必填";
    NSString *rightStr = @"请选择";
    UIColor *middleColor = [UIColor colorWithHexString:@"#999999"];
    UIColor *rightStrColor = [UIColor colorWithHexString:@"#8F8E94"];
    if (self.goodsList.count > 0) {
        middleStr = @"";
        rightStr = @"添加";
        rightStrColor = [UIColor colorWithHexString:@"#F29700"];
    }
    headerData.headerMiddleTitle = [[NSAttributedString alloc]initWithString:middleStr attributes:@{NSForegroundColorAttributeName:middleColor}];
    headerData.headerRightTitle = [[NSAttributedString alloc]initWithString:rightStr attributes:@{NSForegroundColorAttributeName:rightStrColor}];
    return headerData;
}
- (ReicpePackageAddPrescriptionFooterModel *)sectionFooterData {
    ReicpePackageAddPrescriptionFooterModel *footerData = [ReicpePackageAddPrescriptionFooterModel new];
    footerData.footerLeftTitle = [NSString stringWithFormat:@"共%ld件商品",(long)self.totalCount];
    footerData.footerRightTitle = [NSString stringWithFormat:@"合计：¥%@",AMOUNTSTRING(@(self.totalPrice))];
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
- (void)inputCrop:(NSDictionary *)crop {
    self.crop = crop;
}
- (void)inputPrescriptionDic:(NSDictionary *)prescription {
    if (prescription) {
        self.prescriptionName = prescription[@"prescriptionName"];
        self.prescriptionSpecName = prescription[@"prescriptionSpecName"];
        self.salePrice = prescription[@"salePrice"];
        self.integration = prescription[@"integration"];
        self.prescriptionDescription = prescription[@"description"];
        self.totalPrice = [prescription[@"prescriptionPrice"] floatValue];
        self.prescriptionId = prescription[@"prescriptionId"];
        // 处理商品列表中的数据
        NSInteger total = 0;
        NSArray *detail = prescription[@"detail"];
        for (NSDictionary *goods in detail) {
            NSDictionary *strValueGoods = [self dictionValueStrWithDic:goods];
            // 商品数量
            NSInteger goodsNumber = [goods[@"goodsNumber"] integerValue];
            total += goodsNumber;
            [self.goodsList addObject:strValueGoods];
        }
        self.totalCount = total;
    }
}

- (void)addGoodsList:(NSArray *)goodsList {
    if (goodsList.count > 0) {
        [self.goodsList removeAllObjects];
        NSInteger total = 0;
        CGFloat totalPrice = 0.00f;
        for (NSDictionary *goods in goodsList) {
            NSDictionary *prescription = [self prescriptionDicWithAddGoodsDic:goods];
            // 商品数量
            NSInteger goodsNumber = [prescription[@"goodsNumber"] integerValue];
            // 售价
            CGFloat goodsOutputSaleF = [prescription[@"goodsOutputSale"] floatValue];
            total += goodsNumber;
            totalPrice += goodsOutputSaleF*goodsNumber;
            [self.goodsList addObject:prescription];
        }
        self.totalCount = total;
        self.totalPrice = totalPrice;
        self.salePrice = AMOUNTSTRING(@(totalPrice));
        [self commandTotalCount];
    }
}
- (void)setGoodsUseNumber:(NSString *)useNumber index:(NSInteger)index {
    if (self.goodsList.count > index) {
        NSMutableDictionary *goodsDic = ((NSDictionary *)self.goodsList[index]).mutableCopy;
        [goodsDic setObject:useNumber forKey:@"goodsUseNumber"];
        [self.goodsList replaceObjectAtIndex:index withObject:goodsDic.copy];
    }
}
- (void)setGoodsNumber:(NSInteger)goodsNumer index:(NSInteger)index {
    if (self.goodsList.count > index) {
        if (goodsNumer == 0) {
            [self.goodsList removeObjectAtIndex:index];
        } else {
            NSMutableDictionary *goodsDic = ((NSDictionary *)self.goodsList[index]).mutableCopy;
            [goodsDic setObject:[NSString stringWithFormat:@"%ld",(long)goodsNumer] forKey:@"goodsNumber"];
            // 改变数量同时改变用量
//            CGFloat speciNum = [goodsDic[@"goodsSpec"] floatValue];
//            NSString *goodsUseNumber = [NSString stringWithFormat:@"%.2f",goodsNumer * speciNum];
//            [goodsDic setObject:goodsUseNumber forKey:@"goodsUseNumber"];
            [self.goodsList replaceObjectAtIndex:index withObject:goodsDic.copy];
        }
        
        // 重新计算数据
        [self calculateTotalCountAndPrice];
        self.salePrice = AMOUNTSTRING(@(self.totalPrice));
        [self commandTotalCount];
    }
}
- (void)calculateTotalCountAndPrice {
    NSInteger total = 0;
    CGFloat totalPrice = 0.00f;
    for (NSDictionary *goods in self.goodsList) {
        // 商品数量
        NSInteger goodsNumber = [goods[@"goodsNumber"] integerValue];
        // 售价
        CGFloat goodsOutputSaleF = [goods[@"goodsOutputSale"] floatValue];
        total += goodsNumber;
        totalPrice += goodsOutputSaleF*goodsNumber;
    }
    self.totalCount = total;
    self.totalPrice = totalPrice;
}
// 价格超出最大限制的处理
- (void)commandTotalCount {
    if ([self.salePrice floatValue] > 99999999.99) {  // 超过最大价格限制
        self.salePrice = @"99999999.99";
        if (self.goodsList.count == 1) {
            NSMutableDictionary *goodsDic = ((NSDictionary *)self.goodsList[0]).mutableCopy;
            // 售价
            CGFloat goodsOutputSaleF = [goodsDic[@"goodsOutputSale"] floatValue];
            NSInteger goodsNumber = 99999999.99 / goodsOutputSaleF;
            [goodsDic setObject:[NSString stringWithFormat:@"%ld",(long)goodsNumber] forKey:@"goodsNumber"];
            [self.goodsList replaceObjectAtIndex:0 withObject:goodsDic.copy];
            [self calculateTotalCountAndPrice];
        } else {
            //价格超出限制，请调整商品数量
            if (self.toastBlock) {
                self.toastBlock(@"价格已达到最大限制，请调整商品数量");
            }
        }
    }
}
#pragma mark - picker相关
- (void)setPickerType:(AddPrescriptionModelPickerType)pickerType {
    _pickerType = pickerType;
    [self.pickerSource removeAllObjects];
    if (pickerType == AddPrescriptionModelPickerTypeSpec) {    // 规则
        [self.pickerSource addObject:self.prescriptionSpecNameList];
    } else if (pickerType == AddPrescriptionModelPickerTypeIntegration) {  // 积分
        NSMutableArray *integrationPicks = @[].mutableCopy;
        for (NSString *integration in self.integralRules) {
            GoodsIntegrationPickerModel *toxModel = [GoodsIntegrationPickerModel pickerModelWithIntegrationValue:integration];
            [integrationPicks addObject:toxModel];
        }
        [self.pickerSource addObject:integrationPicks];
    }
}
- (NSInteger)pickerComponentsCount {
    return self.pickerSource.count;
}
- (NSInteger)pickerRowsInComponent:(NSInteger)component {
    return [self.pickerSource[component] count];
}
- (NSString *)pickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id<AddGoodsPickerModelProtocol> model = self.pickerSource[component][row];
    if ([model isKindOfClass:[NSString class]]) {
        return [model pickerShowTextKeyPath];
    }
    NSString *keyPath = [model pickerShowTextKeyPath];
    return [(NSObject *)model valueForKeyPath:keyPath];
}
- (BOOL)pickerReplaceObjectInRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerSource.count > 1) {
        if (component == 0) {
//            id model = self.pickerSource[component][row];
           //  根据model替换对应数组
        }
    }
    return NO;
}
- (void)pickerUpdateDataWithSelectedRows:(NSArray *)rows {
    if (self.pickerSource.count == 1) {
        NSInteger selectedRow = [rows[0] integerValue];
        id <AddGoodsPickerModelProtocol>model = [self.pickerSource[0] objectAtIndex:selectedRow];
        if (model) {
            NSString *value = nil;
            if ([model isKindOfClass:[NSString class]]) {
                value = [model parameterValueWithKeyPath];
            } else {
                NSString *keyPath = [model parameterValueWithKeyPath];
                value = [(NSObject *)model valueForKeyPath:keyPath];
            }
            if (self.pickerType == AddPrescriptionModelPickerTypeSpec) {  // 规格
                self.prescriptionSpecName = value;
            } else if (self.pickerType == AddPrescriptionModelPickerTypeIntegration) {  // 积分
                self.integration = value;
            }
        }
    }
}
#pragma mark - 请求参数相关
- (NSInteger)reqIntegration {
    return [self.integration integerValue];
}
- (NSNumber *)reqStoreCropId {
    return [self.crop objectForKey:@"cropId"];
}
- (NSString *)reqDescription {
    return self.prescriptionDescription;
}
- (NSString *)reqName {
    return self.prescriptionName;
}
- (NSString *)reqSalePrice {
    NSString *price = self.salePrice;
    if ([price hasPrefix:@"¥"]) {
        price = [price substringFromIndex:1];
    }
    return price;
}
- (NSString *)reqPrescriptionSpecName {
    return self.prescriptionSpecName;
}
- (NSArray *)reqGoodsList {
    NSMutableArray *goodsList = [NSMutableArray array];
    for (NSDictionary *goods in self.goodsList) {
        NSMutableDictionary *dic = goods.mutableCopy;
        [dic removeObjectForKey:@"finalAmount"];
        [goodsList addObject:dic.copy];
    }
    return goodsList.copy;
}
- (NSString *)reqPrescriptionId {
    return self.prescriptionId;
}
// 验证参数
- (NSString *)checkParamWithErrorMsg {
    BOOL flag = NO;
    NSString *errorMsg = nil;
    // 处方名称
    if (self.prescriptionName.length == 0) {
        flag = YES;
        errorMsg = @"请输入处方名称";
    } else if (self.prescriptionName.length > 20){
        flag = YES;
        errorMsg = @"处方名称最多20个字";
    } else if ([self.prescriptionName firstLetterLegal]) {
        flag = YES;
        errorMsg = @"首字不能为特殊符号";
    }
    // 规格
    if (!flag) {
        if (self.prescriptionSpecName.length == 0) {
            flag = YES;
            errorMsg = @"请选择规格";
        }
    }
    // 商品
    if (!flag) {
        if (self.goodsList.count == 0) {
            flag = YES;
            errorMsg = @"请选择处方商品";
        } else {
            BOOL check = YES;
            for (NSDictionary *goods in self.goodsList) {
                // 用量
                NSString *goodsUseNumber = goods[@"goodsUseNumber"];
                if (goodsUseNumber.length == 0) {
                    check = NO;
                    break;
                }
            }
            if (!check) {
                flag = YES;
                errorMsg = @"请输入用量说明";
            }
        }
    }
    // 价格
    if (!flag) {
        if (self.reqSalePrice.length == 0) {
            flag = YES;
            errorMsg = @"请输入销售价格";
        }
    }
    // 积分
    if (!flag) {
        if (self.integration.length == 0) {
            flag = YES;
            errorMsg = @"请选择积分";
        }
    }
    // 处方说明
    if (!flag) {
        if (self.prescriptionDescription.length != 0 && self.prescriptionDescription.length > 50) {
            flag = YES;
            errorMsg = @"处方说明最多可输入50个字";
        }
    }
    return errorMsg;
}
#pragma mark - getter
- (NSMutableArray *)pickerSource {
    if (!_pickerSource) {
        _pickerSource = [NSMutableArray array];
    }
    return _pickerSource;
}
- (NSMutableArray *)goodsList {
    if (!_goodsList) {
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
}
- (NSArray *)prescriptionSpecNameList {
    if (!_prescriptionSpecNameList) {
        _prescriptionSpecNameList = @[@"40斤水",@"400斤水"];
    }
    return _prescriptionSpecNameList;
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
/** 添加商品返回的数据与本页面所需数据字段映射表*/
- (NSDictionary *)addGoodsDicKeyMapPrescriptionDic {
    return @{@"content":@"goodsBrand",
             @"desc":@"goodsSpec",
             @"goodsId":@"goodsId",
             @"purchaseNum":@"goodsNumber",
             @"purchasePrice":@"goodsInputSale",
             @"retailAmount":@"goodsOutputSale",
             @"title":@"goodsName"};
}
/** 本页面所需数据字段与添加商品返回的数据映射表*/
- (NSDictionary *)prescriptionDicMapAddGoodsDicKey {
    return @{@"goodsBrand":@"content",
             @"goodsSpec":@"desc",
             @"goodsId":@"goodsId",
             @"goodsNumber":@"purchaseNum",
             @"goodsInputSale":@"purchasePrice",
             @"goodsOutputSale":@"retailAmount",
             @"goodsName":@"title"};
}
@end
