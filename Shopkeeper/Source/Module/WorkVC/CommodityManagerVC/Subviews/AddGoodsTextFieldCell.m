//
//  AddGoodsTextFieldCell.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsTextFieldCell.h"
#import "AddGoodsCellDataModel.h"

@interface AddGoodsTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UITextField *contentTextField;

@property (nonatomic,weak) AddGoodsCellDataModel *cellModel;
@end

@implementation AddGoodsTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
            make.right.offset(-15);
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
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.cellModel.textFieldContentModel.value = textField.text.length > 0 ? textField.text : @"";
    self.cellModel.textFieldContentModel.showValue = textField.text.length > 0 ?textField.text : nil;
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
        [self.contentView addSubview:content];
        _contentTextField = content;
    }
    return _contentTextField;
}
@end
