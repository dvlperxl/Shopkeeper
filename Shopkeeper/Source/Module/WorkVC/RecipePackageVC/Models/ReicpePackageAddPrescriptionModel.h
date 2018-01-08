//
//  ReicpePackageAddPrescriptionModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReicpePackageAddPrescriptionTabHeader.h"
#import "ReicpePackageAddPrescriptionTabFooter.h"
#import "ReicpePackageAddPrescriptionCell.h"

typedef NS_ENUM(NSInteger, AddPrescriptionModelPickerType) {
    AddPrescriptionModelPickerTypeSpec = 0,                  // 规格
    AddPrescriptionModelPickerTypeIntegration                // 积分
};
typedef void(^AddPrescriptionToast)(NSString *toast);

@interface ReicpePackageAddPrescriptionModel : NSObject

@property (nonatomic,copy) AddPrescriptionToast toastBlock;
//  picker相关
@property (nonatomic,assign) AddPrescriptionModelPickerType pickerType;
- (NSInteger)pickerComponentsCount;
- (NSInteger)pickerRowsInComponent:(NSInteger)component;
- (NSString *)pickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (BOOL)pickerReplaceObjectInRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)pickerUpdateDataWithSelectedRows:(NSArray *)rows;

// 修改value
- (void)setPrescriptionName:(NSString *)prescriptionName;
- (void)setSalePrice:(NSString *)salePrice;
- (void)setPrescriptionDescription:(NSString *)prescriptionDescription;
- (void)setGoodsUseNumber:(NSString *)useNumber index:(NSInteger)index;
- (void)setGoodsNumber:(NSInteger)goodsNumer index:(NSInteger)index;
- (void)addGoodsList:(NSArray *)goodsList;

// 数据
- (void)inputCrop:(NSDictionary *)corp;
- (void)inputPrescriptionDic:(NSDictionary *)prescription;

// tableview数据源
- (ReicpePackageAddPrescriptionTabHeaderModel *)tabHeaderModel;
- (KKTableViewModel *)tableViewModel;
- (ReicpePackageAddPrescriptionTabFooterModel *)tabFooterModel;

// 其他数据源
- (NSArray *)stockGoodsListVCGoodsList;

// 请求参数相关
- (NSInteger)reqIntegration;
- (NSNumber *)reqStoreCropId;
- (NSString *)reqDescription;
- (NSString *)reqName;
- (NSString *)reqSalePrice;
- (NSString *)reqPrescriptionSpecName;
- (NSArray *)reqGoodsList;
- (NSString *)reqPrescriptionId;
// 验证参数
- (NSString *)checkParamWithErrorMsg;
@end
