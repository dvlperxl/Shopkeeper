//
//  AddGoodsCellDataModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddGoodsCellDataModel,AddGoodsInputDataModel;

typedef void(^AddGoodsCellDataModelOperation)(void);

@interface AddGoodsCellDataModel : NSObject

@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,strong) AddGoodsInputDataModel *textFieldContentModel;
@property (nonatomic,strong) NSArray <AddGoodsInputDataModel *> *pickerContentModels;
@property (nonatomic,strong) AddGoodsInputDataModel *imageContentModel;
@property (nonatomic,copy) NSString *rightTitle;
// 键盘类型
@property (nonatomic,assign) UIKeyboardType keyboardType;
// textField对齐方式
@property (nonatomic,assign) NSTextAlignment textAlignment;
// 整数位限制
@property (nonatomic,assign) NSInteger limitPointPreCount;
// 小数位限制
@property (nonatomic,assign) NSInteger limitPointLaterCount;
@property (nonatomic,strong) NSArray <AddGoodsInputDataModel *> *customContentModels;

/** 可能需要的操作*/
@property (nonatomic,copy) AddGoodsCellDataModelOperation modelOperation;

+ (instancetype)goodsCellModelWithLeftTitle:(NSString *)leftTitle textFieldContentModel:(AddGoodsInputDataModel *)textFieldContentModel pickerContentModels:(NSArray <AddGoodsInputDataModel *> *)pickerContentModels imageContentModel:(AddGoodsInputDataModel *)imageContentModel rightTitle:(NSString *)rightTitle;
+ (instancetype)textFieldContentGoodsCellModelWithTitle:(NSString *)leftTitle textFieldPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue textFieldParameterName:(NSString *)textFieldParameterName textFieldValue:(NSString *)textFieldValue textFieldSuffix:(NSString *)textFieldSuffix;
+ (instancetype)pickerContentGoodsCellModelWithTitle:(NSString *)leftTitle pickerPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue pickerParameterName:(NSString *)parameterName pickerValue:(NSString *)value pickerSuffix:(NSString *)suffix;
+ (instancetype)textFieldAndRightTitleContentGoodsCellModelWithTitle:(NSString *)leftTitle textFieldPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue textFieldParameterName:(NSString *)textFieldParameterName textFieldValue:(NSString *)textFieldValue textFieldSuffix:(NSString *)textFieldSuffix rightTitle:(NSString *)rightTitle;
+ (instancetype)customContentGoodsCellModelWithTitle:(NSString *)leftTitle customContentModels:(NSArray <AddGoodsInputDataModel *> *)customContentModels;
+ (instancetype)imageContentGoodsCellModelWithTitle:(NSString *)leftTitle imageContentModel:(AddGoodsInputDataModel *)imageContentModel;

- (NSDictionary *)requestParameters;
- (NSDictionary *)showValues;
@end

@interface AddGoodsInputDataModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSString *showValue;
@property (nonatomic,copy) NSString *parameterName;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *suffix;

+ (instancetype)inputDataWithPlaceholder:(NSString *)placeholder showValue:(NSString *)showValue parameterName:(NSString *)parameterName value:(NSString *)value suffix:(NSString *)suffix;
+ (instancetype)inputDataWithTitle:(NSString *)title placeholder:(NSString *)placeholder showValue:(NSString *)showValue parameterName:(NSString *)parameterName value:(NSString *)value suffix:(NSString *)suffix;
@end
