//
//  AddGoodsCellDataModel.m
//  Shopkeeper
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsCellDataModel.h"

@implementation AddGoodsCellDataModel

- (instancetype)init {
    if (self = [super init]) {
        _limitPointPreCount = 0;
        _limitPointLaterCount = 0;
    }
    return self;
}
+ (instancetype)goodsCellModelWithLeftTitle:(NSString *)leftTitle textFieldContentModel:(AddGoodsInputDataModel *)textFieldContentModel pickerContentModels:(NSArray <AddGoodsInputDataModel *> *)pickerContentModels imageContentModel:(AddGoodsInputDataModel *)imageContentModel rightTitle:(NSString *)rightTitle {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    cellModel.textFieldContentModel = textFieldContentModel;
    cellModel.pickerContentModels = pickerContentModels;
    cellModel.imageContentModel = imageContentModel;
    cellModel.rightTitle = rightTitle;
    return cellModel;
}
+ (instancetype)textFieldContentGoodsCellModelWithTitle:(NSString *)leftTitle textFieldPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue textFieldParameterName:(NSString *)textFieldParameterName textFieldValue:(NSString *)textFieldValue textFieldSuffix:(NSString *)textFieldSuffix {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    AddGoodsInputDataModel *textFieldInput = [AddGoodsInputDataModel inputDataWithPlaceholder:placeholder showValue:showValue parameterName:textFieldParameterName value:textFieldValue suffix:textFieldSuffix];
    cellModel.textFieldContentModel = textFieldInput;
    return cellModel;
}
+ (instancetype)pickerContentGoodsCellModelWithTitle:(NSString *)leftTitle pickerPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue pickerParameterName:(NSString *)parameterName pickerValue:(NSString *)value pickerSuffix:(NSString *)suffix {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    AddGoodsInputDataModel *pickerInput = [AddGoodsInputDataModel inputDataWithPlaceholder:placeholder showValue:showValue parameterName:parameterName value:value suffix:suffix];
    cellModel.pickerContentModels = @[pickerInput];
    return cellModel;
}
+ (instancetype)textFieldAndRightTitleContentGoodsCellModelWithTitle:(NSString *)leftTitle textFieldPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue textFieldParameterName:(NSString *)textFieldParameterName textFieldValue:(NSString *)textFieldValue textFieldSuffix:(NSString *)textFieldSuffix rightTitle:(NSString *)rightTitle {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    cellModel.rightTitle = rightTitle;
    AddGoodsInputDataModel *textFieldInput = [AddGoodsInputDataModel inputDataWithPlaceholder:placeholder showValue:showValue parameterName:textFieldParameterName value:textFieldValue suffix:textFieldSuffix];
    cellModel.textFieldContentModel = textFieldInput;
    return cellModel;
}
+ (instancetype)customContentGoodsCellModelWithTitle:(NSString *)leftTitle customContentModels:(NSArray <AddGoodsInputDataModel *> *)customContentModels {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    cellModel.customContentModels = customContentModels;
    return cellModel;
}
+ (instancetype)imageContentGoodsCellModelWithTitle:(NSString *)leftTitle imageContentModel:(AddGoodsInputDataModel *)imageContentModel {
    AddGoodsCellDataModel *cellModel = [[AddGoodsCellDataModel alloc]init];
    cellModel.leftTitle = leftTitle;
    cellModel.imageContentModel = imageContentModel;
    return cellModel;
}
- (NSDictionary *)requestParameters {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    if (_textFieldContentModel) {
        if (_textFieldContentModel.parameterName) {
            [parameters setObject:_textFieldContentModel.value forKey:_textFieldContentModel.parameterName];
        }
    }
    if (_pickerContentModels) {
        [_pickerContentModels enumerateObjectsUsingBlock:^(AddGoodsInputDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.parameterName) {
                [parameters setObject:obj.value forKey:obj.parameterName];
            }
        }];
    }
    if (_imageContentModel) {
        if (_imageContentModel.parameterName) {
            [parameters setObject:_imageContentModel.value forKey:_imageContentModel.parameterName];
        }
    }
    if (_customContentModels) {
        [_customContentModels enumerateObjectsUsingBlock:^(AddGoodsInputDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.parameterName) {
                [parameters setObject:obj.value forKey:obj.parameterName];
            }
        }];
    }
    return parameters.copy;
}
- (NSDictionary *)showValues {
    NSMutableDictionary *values = @{}.mutableCopy;
    if (_textFieldContentModel) {
        if (_textFieldContentModel.parameterName) {
            [values setObject:_textFieldContentModel.showValue forKey:_textFieldContentModel.parameterName];
        }
    }
    if (_pickerContentModels) {
        [_pickerContentModels enumerateObjectsUsingBlock:^(AddGoodsInputDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.parameterName) {
                [values setObject:obj.showValue forKey:obj.parameterName];
            }
        }];
    }
    if (_imageContentModel) {
        if (_imageContentModel.parameterName) {
            [values setObject:_imageContentModel.showValue forKey:_imageContentModel.parameterName];
        }
    }
    if (_customContentModels) {
        [_customContentModels enumerateObjectsUsingBlock:^(AddGoodsInputDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.parameterName) {
                [values setObject:obj.showValue forKey:obj.parameterName];
            }
        }];
    }
    return values.copy;
}
@end


@implementation AddGoodsInputDataModel

+ (instancetype)inputDataWithPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue parameterName:(NSString *)parameterName value:(NSString *)value suffix:(NSString *)suffix {
    AddGoodsInputDataModel *inputData = [[AddGoodsInputDataModel alloc]init];
    inputData.placeholder = placeholder;
    inputData.showValue = showValue;
    inputData.parameterName = parameterName;
    inputData.value = value;
    inputData.suffix = suffix;
    return inputData;
}
+ (instancetype)inputDataWithTitle:(NSString *)title placeholder:(NSString *)placeholder showValue:(NSString *)showValue parameterName:(NSString *)parameterName value:(NSString *)value suffix:(NSString *)suffix {
    AddGoodsInputDataModel *inputData = [[AddGoodsInputDataModel alloc]init];
    inputData.title = title;
    inputData.placeholder = placeholder;
    inputData.showValue = showValue;
    inputData.parameterName = parameterName;
    inputData.value = value;
    inputData.suffix = suffix;
    return inputData;
}
@end
