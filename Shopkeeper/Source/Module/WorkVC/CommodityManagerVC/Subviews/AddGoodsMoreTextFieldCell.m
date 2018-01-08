//
//  AddGoodsMoreTextFieldCell.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsMoreTextFieldCell.h"
#import "AddGoodsCellDataModel.h"

@interface AddGoodsMoreTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UILabel *oneTitleLabel;
@property (nonatomic,weak) UITextField *oneContentTextField;
@property (nonatomic,weak) UILabel *twoTitleLabel;
@property (nonatomic,weak) UITextField *twoContentTextField;
@property (nonatomic,weak) UILabel *threeTitleLabel;
@property (nonatomic,weak) UITextField *threeContentTextField;

@property (nonatomic,weak) AddGoodsCellDataModel *cellModel;
@property (nonatomic,copy) NSString *oneTextFieldText;
@property (nonatomic,copy) NSString *twoTextFieldText;
@property (nonatomic,copy) NSString *threeTextFieldText;
@end

@implementation AddGoodsMoreTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        CGFloat titleLabelWidth = 20.0f;
        CGFloat titleToTextFieldSpace = 6.0f;
        CGFloat textFieldWidth = ([UIScreen mainScreen].bounds.size.width - 70 - 18 - 15 - 3*titleLabelWidth - 6*titleToTextFieldSpace)/3.0;
        [self.oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        [self.oneContentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneTitleLabel.mas_right).with.offset(titleToTextFieldSpace);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(textFieldWidth);
        }];
        [self.twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneContentTextField.mas_right).with.offset(titleToTextFieldSpace);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        [self.twoContentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoTitleLabel.mas_right).with.offset(titleToTextFieldSpace);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(textFieldWidth);
        }];
        [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoContentTextField.mas_right).with.offset(titleToTextFieldSpace);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        [self.threeContentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.threeTitleLabel.mas_right).with.offset(titleToTextFieldSpace);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(textFieldWidth);
        }];
    }
    return self;
}
- (void)reloadData:(AddGoodsCellDataModel *)model {
    self.cellModel = model;
    self.leftNameLabel.text = model.leftTitle;
    self.oneContentTextField.keyboardType = self.twoContentTextField.keyboardType = self.threeContentTextField.keyboardType = model.keyboardType;
    self.oneContentTextField.textAlignment = self.twoContentTextField.textAlignment = self.threeContentTextField.textAlignment = model.textAlignment;
    
    self.oneTitleLabel.text = [model.customContentModels objectAtIndex:0].title;
    self.oneContentTextField.text = [model.customContentModels objectAtIndex:0].showValue;
    self.oneTextFieldText = [model.customContentModels objectAtIndex:0].showValue;
    self.oneContentTextField.placeholder = [model.customContentModels objectAtIndex:0].placeholder;
    self.twoTitleLabel.text = [model.customContentModels objectAtIndex:1].title;
    self.twoContentTextField.text = [model.customContentModels objectAtIndex:1].showValue;
    self.twoTextFieldText = [model.customContentModels objectAtIndex:1].showValue;
    self.twoContentTextField.placeholder = [model.customContentModels objectAtIndex:1].placeholder;
    self.threeTitleLabel.text = [model.customContentModels objectAtIndex:2].title;
    self.threeContentTextField.text = [model.customContentModels objectAtIndex:2].showValue;
    self.threeTextFieldText = [model.customContentModels objectAtIndex:2].showValue;
    self.threeContentTextField.placeholder = [model.customContentModels objectAtIndex:2].placeholder;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    AddGoodsInputDataModel *inputModel = [self.cellModel.customContentModels objectAtIndex:[self indexOfTextField:textField]];
    inputModel.value = textField.text.length > 0 ? textField.text : @"";
    inputModel.showValue = textField.text.length > 0 ?textField.text : nil;
}
#pragma mark - event
- (void)textFieldDidChange:(UITextField *)textField {
    if (![textField.text validateNumWithPointPreCount:self.cellModel.limitPointPreCount pointLaterCount:self.cellModel.limitPointLaterCount]) {
        if (textField == self.oneContentTextField) {
            textField.text = self.oneTextFieldText;
        } else if (textField == self.twoContentTextField) {
            textField.text = self.twoTextFieldText;
        } else if (textField == self.threeContentTextField) {
            textField.text = self.threeTextFieldText;
        }
    } else {
        if (textField == self.oneContentTextField) {
            self.oneTextFieldText = textField.text;
        } else if (textField == self.twoContentTextField) {
            self.twoTextFieldText = textField.text;
        } else if (textField == self.threeContentTextField) {
            self.threeTextFieldText = textField.text;
        }
    }
}
#pragma mark - getter
- (UILabel *)leftNameLabel {
    if (!_leftNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _leftNameLabel = name;
    }
    return _leftNameLabel;
}
- (UILabel *)oneTitleLabel {
    if (!_oneTitleLabel) {
        _oneTitleLabel = [self selfSubLabel];
    }
    return _oneTitleLabel;
}
- (UILabel *)twoTitleLabel {
    if (!_twoTitleLabel) {
        _twoTitleLabel = [self selfSubLabel];
    }
    return _twoTitleLabel;
}
- (UILabel *)threeTitleLabel {
    if (!_threeTitleLabel) {
        _threeTitleLabel = [self selfSubLabel];;
    }
    return _threeTitleLabel;
}
- (UITextField *)oneContentTextField {
    if (!_oneContentTextField) {
        _oneContentTextField = [self selfSubTextField];
    }
    return _oneContentTextField;
}
- (UITextField *)twoContentTextField {
    if (!_twoContentTextField) {
        _twoContentTextField = [self selfSubTextField];;
    }
    return _twoContentTextField;
}
- (UITextField *)threeContentTextField {
    if (!_threeContentTextField) {
        _threeContentTextField = [self selfSubTextField];;
    }
    return _threeContentTextField;
}

- (UILabel *)selfSubLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = APPFONT(17);
    [self.contentView addSubview:label];
    return label;
}
- (UITextField *)selfSubTextField {
    UITextField *textField = [[UITextField alloc]init];
    textField.textColor = [UIColor colorWithHexString:@"#333333"];
    textField.font = APPFONT(17);
    [textField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:APPFONT(17) forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    return textField;
}
- (NSInteger)indexOfTextField:(UITextField *)textField {
    if (self.oneContentTextField == textField) {
        return 0;
    }
    if (self.twoContentTextField == textField) {
        return 1;
    }
    if (self.threeContentTextField == textField) {
        return 2;
    }
    return 4;
}
@end
