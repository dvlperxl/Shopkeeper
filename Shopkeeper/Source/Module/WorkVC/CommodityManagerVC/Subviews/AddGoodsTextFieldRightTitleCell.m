//
//  AddGoodsTextFieldRightTitleCell.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsTextFieldRightTitleCell.h"
#import "AddGoodsCellDataModel.h"

@interface AddGoodsTextFieldRightTitleCell ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UITextField *contentTextField;
@property (nonatomic,weak) UILabel *rightNameLabel;
@property (nonatomic,weak) AddGoodsCellDataModel *cellModel;
@property (nonatomic,copy) NSString *lastTextFieldText;
@end

@implementation AddGoodsTextFieldRightTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.rightNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(30);
        }];
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.rightNameLabel.mas_left).with.offset(-10);
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
    self.lastTextFieldText = model.textFieldContentModel.showValue;
    self.contentTextField.placeholder = model.textFieldContentModel.placeholder;
    self.rightNameLabel.text = model.rightTitle;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.cellModel.textFieldContentModel.value = textField.text.length > 0 ? textField.text : @"";
    self.cellModel.textFieldContentModel.showValue = textField.text.length > 0 ?textField.text : nil;
}
#pragma mark - event
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
- (UILabel *)rightNameLabel {
    if (!_rightNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _rightNameLabel = name;
    }
    return _rightNameLabel;
}
@end
