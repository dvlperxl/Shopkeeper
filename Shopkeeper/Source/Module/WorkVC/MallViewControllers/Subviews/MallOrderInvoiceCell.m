//
//  MallOrderInvoiceCell.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderInvoiceCell.h"

@interface MallOrderInvoiceCell ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UITextField *contentTextField;
@property (nonatomic,weak) MallOrderInvoiceCellModel *cellModel;
@end

@implementation MallOrderInvoiceCell

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
- (void)reloadData:(MallOrderInvoiceCellModel *)model {
    self.cellModel = model;
    self.leftNameLabel.text = model.leftTitle;
    self.contentTextField.keyboardType = model.keyboardType;
    self.contentTextField.text = model.content;
    self.contentTextField.placeholder = model.placeholder;
    [self.contentTextField setValue:[UIColor colorWithHexString:@"#CCCCCC"] forKeyPath:@"_placeholderLabel.textColor"];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *text = textField.text.length > 0 ? textField.text : @"";
    self.cellModel.content = text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(invoiceCell:didEndEditingText:)]) {
        [self.delegate invoiceCell:self didEndEditingText:text];
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
        content.delegate = self;
        [self.contentView addSubview:content];
        _contentTextField = content;
    }
    return _contentTextField;
}
@end

@implementation MallOrderInvoiceCellModel

@end
