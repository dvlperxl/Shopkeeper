//
//  CommodityCategoryModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "CommodityCategoryModel.h"

@implementation CommodityCategoryModel

- (NSString *)keyPathWithFilterPickerSource {
    return @"pid";
}

- (NSString *)identifierKeyPathWithFilterPickerSource {
    return @"id";
}

- (NSString *)pickerShowTextKeyPath {
    return @"name";
}

- (NSString *)parameterValueWithKeyPath {
    return @"id";
}
@end


@implementation GoodsContentUnitPickerModel

+ (instancetype)pickerModelWithName:(NSString *)name {
    GoodsContentUnitPickerModel *picker = [[GoodsContentUnitPickerModel alloc]init];
    picker.name = name;
    return picker;
}
- (NSString *)pickerShowTextKeyPath {
    return @"name";
}
- (NSString *)parameterValueWithKeyPath {
    return @"name";
}
@end


@implementation GoodsToxicityPickerModel

+ (instancetype)pickerModelWithName:(NSString *)name {
    GoodsToxicityPickerModel *picker = [[GoodsToxicityPickerModel alloc]init];
    picker.name = name;
    return picker;
}
- (NSString *)pickerShowTextKeyPath {
    return @"name";
}
- (NSString *)parameterValueWithKeyPath {
    return @"name";
}
@end


@implementation GoodsFormulationPickerModel

+ (instancetype)pickerModelWithName:(NSString *)name {
    GoodsFormulationPickerModel *picker = [[GoodsFormulationPickerModel alloc]init];
    picker.name = name;
    return picker;
}
- (NSString *)pickerShowTextKeyPath {
    return @"name";
}
- (NSString *)parameterValueWithKeyPath {
    return @"name";
}
@end

@implementation GoodsSpeciPickerModel

+ (instancetype)pickerModelWithName:(NSString *)name {
    GoodsSpeciPickerModel *picker = [[GoodsSpeciPickerModel alloc]init];
    picker.name = name;
    return picker;
}
- (NSString *)pickerShowTextKeyPath {
    return @"name";
}
- (NSString *)parameterValueWithKeyPath {
    return @"name";
}
@end

@implementation GoodsIntegrationPickerModel

+ (instancetype)pickerModelWithIntegrationValue:(NSString *)integrationValue {
    GoodsIntegrationPickerModel *picker = [[GoodsIntegrationPickerModel alloc]init];
    picker.integrationValue = integrationValue;
    if ([integrationValue isEqualToString:@"0"]) {
        picker.name = @"无积分";
    } else {
        picker.name = [NSString stringWithFormat:@"%@元1积分",integrationValue];
    }
    return picker;
}
- (NSString *)pickerShowTextKeyPath {
    return @"name";
}
- (NSString *)parameterValueWithKeyPath {
    return @"integrationValue";
}
@end

