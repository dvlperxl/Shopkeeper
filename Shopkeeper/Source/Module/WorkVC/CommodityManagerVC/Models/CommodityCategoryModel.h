//
//  CommodityCategoryModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddGoodsModel.h"

@interface CommodityCategoryModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pid;
@end

@interface GoodsContentUnitPickerModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *name;
+ (instancetype)pickerModelWithName:(NSString *)name;
@end

@interface GoodsToxicityPickerModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *name;
+ (instancetype)pickerModelWithName:(NSString *)name;
@end


@interface GoodsFormulationPickerModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *name;
+ (instancetype)pickerModelWithName:(NSString *)name;
@end


@interface GoodsSpeciPickerModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *name;
+ (instancetype)pickerModelWithName:(NSString *)name;
@end

@interface GoodsIntegrationPickerModel : NSObject<AddGoodsPickerModelProtocol>

@property (nonatomic,copy) NSString *integrationValue;
@property (nonatomic,copy) NSString *name;
+ (instancetype)pickerModelWithIntegrationValue:(NSString *)integrationValue;
@end
