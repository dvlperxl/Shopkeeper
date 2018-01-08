//
//  ReicpePackageAddPrescriptionTabFooter.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionTabFooter.h"
#import "ReicpePackageAddPrescriptionInput.h"
#import "ReicpePackageAddPrescriptionPicker.h"

@interface ReicpePackageAddPrescriptionTabFooter ()

/** 销售价格*/
@property (nonatomic,strong) ReicpePackageAddPrescriptionInput *salePriceView;
/** 商品积分*/
@property (nonatomic,strong) ReicpePackageAddPrescriptionPicker *integrationView;
/** 处方说明*/
@property (nonatomic,strong) ReicpePackageAddPrescriptionInput *descriptionView;

@property (nonatomic,copy) NSString *lastTextFieldText;
@end

@implementation ReicpePackageAddPrescriptionTabFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.salePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(10);
            make.height.mas_equalTo(50);
        }];
        [self.integrationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.salePriceView);
            make.top.equalTo(self.salePriceView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        [self.descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.salePriceView);
            make.top.equalTo(self.integrationView.mas_bottom).with.offset(10);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}
- (NSString *)outMoneyIconStrWithText:(NSString *)text {
    if (text.length > 0) {
        if ([text hasPrefix:@"¥"]) {
            return [text substringFromIndex:1];
        }
    }
    return text;
}
#pragma mark - HNReactView
- (void)bindingViewModel:(ReicpePackageAddPrescriptionTabFooterModel *)viewModel {
    self.salePriceView.nameLabel.text = viewModel.salePriceTitle;
    self.salePriceView.contentTxtField.text = viewModel.salePriceContent;
    self.lastTextFieldText = viewModel.salePriceContent;
    self.salePriceView.contentTxtField.placeholder = viewModel.salePricePlaceholder;
    [self.salePriceView.contentTxtField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    self.integrationView.nameLabel.text = viewModel.integrationTitle;
    self.integrationView.contentLabel.text = viewModel.integrationContent;
    self.integrationView.rightPlaceholderLabel.attributedText = viewModel.integrationPlaceholder;
    self.descriptionView.nameLabel.text = viewModel.descriptionTitle;
    self.descriptionView.contentTxtField.text = viewModel.descriptionContent;
    self.descriptionView.contentTxtField.placeholder = viewModel.descriptionPlaceholder;
    [self.descriptionView.contentTxtField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

}
#pragma mark - event
- (void)integrationViewTapClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapIntegrationRowTabFooter:)]) {
        [self.delegate tapIntegrationRowTabFooter:self];
    }
}
- (void)textFieldDidChange:(UITextField *)textField {
    NSString *outMoneyIcon = [self outMoneyIconStrWithText:textField.text];
    if (![outMoneyIcon validateNumWithPointPreCount:8 pointLaterCount:2]) {
        textField.text = self.lastTextFieldText;
    } else {
        self.lastTextFieldText = textField.text;
    }
}
#pragma mark - getter
- (ReicpePackageAddPrescriptionInput *)salePriceView {
    if (!_salePriceView) {
        _salePriceView = [[ReicpePackageAddPrescriptionInput alloc]init];
        _salePriceView.contentTxtField.keyboardType = UIKeyboardTypeDecimalPad;
        [_salePriceView.contentTxtField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_salePriceView];
    }
    return _salePriceView;
}
- (ReicpePackageAddPrescriptionPicker *)integrationView {
    if (!_integrationView) {
        _integrationView = [[ReicpePackageAddPrescriptionPicker alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(integrationViewTapClick)];
        [_integrationView addGestureRecognizer:tap];
        [self addSubview:_integrationView];
    }
    return _integrationView;
}
- (ReicpePackageAddPrescriptionInput *)descriptionView {
    if (!_descriptionView) {
        _descriptionView = [[ReicpePackageAddPrescriptionInput alloc]init];
        [self addSubview:_descriptionView];
    }
    return _descriptionView;
}
@end


@implementation ReicpePackageAddPrescriptionTabFooterModel

@end
