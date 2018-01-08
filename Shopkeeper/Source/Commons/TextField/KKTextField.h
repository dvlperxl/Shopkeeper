//
//  KKTextField.h
//  kakatrip
//
//  Created by CaiMing on 2017/1/5.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTextField.h"

@interface KKTextField : UIView<CMTextFieldDelegate>

@property(nonatomic, strong)CMTextField *textField;
@property(nonatomic, strong)UIColor *placeholderColor;
@property(nonatomic, copy)NSString *iconImageName;
@property(nonatomic, strong)UIColor *lineColor;
@property(nonatomic, assign)BOOL autoValid;

//当输入完成时对用户输入的数据格式校验的正则
@property(nonatomic, strong)NSString *regular;
//数据格式校验不通过的提示
@property(nonatomic, strong)NSString *errorTips;

@end
