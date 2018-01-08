//
//  ReicpePackageAddPrescriptionCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionCell.h"
#import "HNNumberButton.h"

@interface ReicpePackageAddPrescriptionCell ()<UITextFieldDelegate,HNNumberButtonDelegate>

@property (nonatomic,strong) UILabel *goodsBrandLabel;
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *singlePriceLabel;
@property (nonatomic,strong) UILabel *goodsSpeciLabel;
@property (nonatomic,strong) UIView *useSpcSupView;
@property (nonatomic,strong) UILabel *useSpcTitleLabel;
@property (nonatomic,strong) UITextField *useSpcContentTxtField;
@property (nonatomic,strong) UILabel *useSpcUnitLabel;
@property (nonatomic,strong) HNNumberButton *numButton;

@property (nonatomic,copy) NSString *lastTextFieldText;
@end

@implementation ReicpePackageAddPrescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.goodsBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(20.0);
            make.right.offset(-15);
        }];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsBrandLabel.mas_left);
            make.right.equalTo(self.goodsBrandLabel.mas_right);
            make.top.equalTo(self.goodsBrandLabel.mas_bottom).with.offset(4);
        }];
        [self.singlePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsBrandLabel.mas_left);
            make.top.equalTo(self.goodsNameLabel.mas_bottom).with.offset(15);
        }];
        [self.numButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.equalTo(self.singlePriceLabel);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(40);
        }];
        [self.goodsSpeciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.singlePriceLabel.mas_right).with.offset(10);
            make.right.equalTo(self.numButton.mas_left).with.offset(-5);
            make.centerY.equalTo(self.singlePriceLabel);
        }];
        [self.singlePriceLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.useSpcSupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.singlePriceLabel.mas_bottom).with.offset(20);
            make.height.mas_equalTo(50);
        }];
        [self.useSpcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(25);
            make.centerY.equalTo(self.useSpcSupView);
            make.width.mas_equalTo(70);
        }];
        [self.useSpcUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-25);
            make.centerY.equalTo(self.useSpcSupView);
            make.width.mas_equalTo(90);
        }];
        [self.useSpcContentTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.useSpcTitleLabel.mas_right).with.offset(10);
            make.centerY.equalTo(self.useSpcSupView);
            make.right.equalTo(self.useSpcUnitLabel.mas_left).with.offset(-10);
        }];
    }
    return self;
}

- (void)reloadData:(ReicpePackageAddPrescriptionCellModel *)model {
    self.goodsBrandLabel.text = model.goodsBrand;
    self.goodsNameLabel.text = model.goodsName;
    self.singlePriceLabel.text = model.singlePrice;
    self.goodsSpeciLabel.text = model.goodsSpeci;
    self.useSpcTitleLabel.text = model.useSpcTitle;
    self.useSpcContentTxtField.text = model.useSpcContent;
    self.lastTextFieldText = model.useSpcContent;
    self.useSpcUnitLabel.text = model.useSpcUnit;
    self.numButton.currentNumber = model.goodsNumber;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(prescriptionCell:useSpcContent:)]) {
        [self.delegate prescriptionCell:self useSpcContent:textField.text];
    }
}
#pragma mark - event
- (void)textFieldDidChange:(UITextField *)textField {
    if (![textField.text validateNumWithPointPreCount:4 pointLaterCount:2]) {
        textField.text = self.lastTextFieldText;
    } else {
        self.lastTextFieldText = textField.text;
    }
}
#pragma mark - HNNumberButtonDelegate
- (void)numberButton:(HNNumberButton *)numberButton number:(NSInteger)number {
    if (self.delegate && [self.delegate respondsToSelector:@selector(prescriptionCell:number:)]) {
        [self.delegate prescriptionCell:self number:number];
    }
}
#pragma mark - getter
- (UILabel *)goodsBrandLabel {
    if (!_goodsBrandLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#8F9FBF"];
        name.font = APPFONT(13);
        [self.contentView addSubview:name];
        _goodsBrandLabel = name;
    }
    return _goodsBrandLabel;
}
- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _goodsNameLabel = name;
    }
    return _goodsNameLabel;
}
- (UILabel *)singlePriceLabel {
    if (!_singlePriceLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#F29700"];
        name.font = APPFONT(24);
        [self.contentView addSubview:name];
        _singlePriceLabel = name;
    }
    return _singlePriceLabel;
}
- (UILabel *)goodsSpeciLabel {
    if (!_goodsSpeciLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(13);
        [self.contentView addSubview:name];
        _goodsSpeciLabel = name;
    }
    return _goodsSpeciLabel;
}
- (UIView *)useSpcSupView {
    if (!_useSpcSupView) {
        UIView *spcSup = [[UIView alloc]init];
        spcSup.layer.cornerRadius = 4.0f;
        spcSup.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.contentView addSubview:spcSup];
        _useSpcSupView = spcSup;
    }
    return _useSpcSupView;
}
- (UILabel *)useSpcTitleLabel {
    if (!_useSpcTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _useSpcTitleLabel = name;
    }
    return _useSpcTitleLabel;
}
- (UITextField *)useSpcContentTxtField {
    if (!_useSpcContentTxtField) {
        UITextField *content = [[UITextField alloc]init];
        content.delegate = self;
        content.keyboardType = UIKeyboardTypeDecimalPad;
        [content addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(24);
        [content setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [content setValue:APPFONT(24) forKeyPath:@"_placeholderLabel.font"];
        [self.contentView addSubview:content];
        _useSpcContentTxtField = content;
    }
    return _useSpcContentTxtField;
}
- (UILabel *)useSpcUnitLabel {
    if (!_useSpcUnitLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _useSpcUnitLabel = name;
    }
    return _useSpcUnitLabel;
}
- (HNNumberButton *)numButton {
    if (!_numButton) {
        _numButton = [[HNNumberButton alloc]init];
        _numButton.maxValue = 999999999;
        _numButton.delegate = self;
        [self.contentView addSubview:_numButton];
    }
    return _numButton;
}
@end

@implementation ReicpePackageAddPrescriptionCellModel

@end
