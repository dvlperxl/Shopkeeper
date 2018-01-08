//
//  AddGoodsModel.h
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddGoodsCellDataModel.h"

@protocol AddGoodsPickerModelProtocol <NSObject>

- (NSString *)pickerShowTextKeyPath;
- (NSString *)parameterValueWithKeyPath;
@optional;
- (NSString *)keyPathWithFilterPickerSource;
- (NSString *)identifierKeyPathWithFilterPickerSource;
@end

typedef void(^AddGoodsModelRegistrationNum)(void);
typedef void(^AddGoodsModelShowPicker)(void);
typedef void(^AddGoodsModelShowDataPicker)(NSDate *miniDate,NSDate *maxDate);
@interface AddGoodsModel : NSObject

@property (nonatomic,strong) NSArray *categoryList;
@property (nonatomic,copy) AddGoodsModelRegistrationNum registrationNum;
@property (nonatomic,copy) AddGoodsModelShowPicker showPicker;
@property (nonatomic,copy) AddGoodsModelShowDataPicker showDataPicker;
- (instancetype)initWithStoreId:(NSString *)storeId;
- (void)getGoodsSpeciInfoSuccess:(void(^)(void))success failure:(void(^)(NSString *errorMsg))failure;
- (KKTableViewModel *)addGoodsTableViewModel;
- (void)updateDataWithRegistrationGoodsDic:(NSDictionary *)registrationGoods;
- (void)inputExistGoodsDic:(NSDictionary *)existGoods;
- (NSString *)checkRequestParametersErrorMsg;
- (BOOL)checkInputPriceGtOutputPrice;
- (NSDictionary *)requestParameters;
- (NSString *)requestGoodsParameterStr;

- (NSInteger)pickerComponentsCount;
- (NSInteger)pickerRowsInComponent:(NSInteger)component;
- (NSString *)pickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (BOOL)pickerReplaceObjectInRow:(NSInteger)row inComponent:(NSInteger)component;
- (BOOL)pickerUpdateDataWithSelectedRows:(NSArray *)rows;

- (void)updateDateDataWithDate:(NSDate *)date;

- (void)addImageDataWithImageUrl:(NSString *)imageUrl;
- (void)deleteImageDataWithIndex:(NSInteger)index;
- (void)openOrCloseMoreInfo;
@end
