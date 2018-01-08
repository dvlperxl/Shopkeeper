//
//  AddGoodsPickerAndTextFieldCell.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsPickerAndTextFieldCell.h"
#import "AddGoodsCellDataModel.h"

@interface AddGoodsPickerAndTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UITextField *contentTextField;
@property (nonatomic,weak) UIImageView *rightArrowImage;
@property (nonatomic,weak) UIButton *pickerButton;

@property (nonatomic,weak) AddGoodsCellDataModel *cellModel;
@property (nonatomic,copy) NSString *lastTextFieldText;
@end

@implementation AddGoodsPickerAndTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.pickerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-35);
            make.centerY.equalTo(self.contentView);
            make.width.mas_lessThanOrEqualTo(55);
        }];
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.pickerButton.mas_left).with.offset(0);
        }];
    }
    return self;
}

- (void)reloadData:(AddGoodsCellDataModel *)model {
    self.cellModel = model;
    self.leftNameLabel.text = model.leftTitle;
    self.contentTextField.keyboardType = model.keyboardType;
    self.contentTextField.textAlignment = model.textAlignment;
    self.contentTextField.text = model.textFieldContentModel.showValue;
    self.contentTextField.placeholder = model.textFieldContentModel.placeholder;
    self.lastTextFieldText = model.textFieldContentModel.showValue;
    
    NSMutableString *showValue = @"".mutableCopy;
    UIColor *color = [UIColor colorWithHexString:@"#8F8E94"];
    for (AddGoodsInputDataModel *obj in model.pickerContentModels) {
        if (obj.showValue && obj.showValue.length > 0) {
            [showValue appendString:obj.showValue];
            [showValue appendString:obj.suffix];
            color = [UIColor colorWithHexString:@"#333333"];
        } else {
            [showValue appendString:obj.placeholder];
        }
    }
    [self.pickerButton setTitle:showValue.copy forState:UIControlStateNormal];
    [self.pickerButton setTitleColor:color forState:UIControlStateNormal];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.cellModel.textFieldContentModel.value = textField.text.length > 0 ? textField.text : @"";
    self.cellModel.textFieldContentModel.showValue = textField.text.length > 0 ?textField.text : nil;
}
#pragma mark - event
- (void)onPickerClick:(UIButton *)button {
    if (self.cellModel.modelOperation) {
        self.cellModel.modelOperation();
    }
}
- (void)textFieldDidChange:(UITextField *)textField {
    if (![textField.text validateNumWithPointPreCount:self.cellModel.limitPointPreCount pointLaterCount:self.cellModel.limitPointLaterCount]) {
        textField.text = self.lastTextFieldText;
    } else {
        self.lastTextFieldText = textField.text;
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
- (UITextField *)contentTextField {
    if (!_contentTextField) {
        UITextField *content = [[UITextField alloc]init];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(17);
        [content setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [content setValue:APPFONT(17) forKeyPath:@"_placeholderLabel.font"];
        content.delegate = self;
        [content addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:content];
        _contentTextField = content;
    }
    return _contentTextField;
}
- (UIImageView *)rightArrowImage {
    if (!_rightArrowImage) {
        UIImageView *statusImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        [self.contentView addSubview:statusImage];
        _rightArrowImage = statusImage;
    }
    return _rightArrowImage;
}
- (UIButton *)pickerButton {
    if (!_pickerButton) {
        UIButton *picker = [[UIButton alloc]init];
        picker.titleLabel.font = APPFONT(17);
        picker.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [picker addTarget:self action:@selector(onPickerClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:picker];
        _pickerButton = picker;
    }
    return _pickerButton;
}
@end
