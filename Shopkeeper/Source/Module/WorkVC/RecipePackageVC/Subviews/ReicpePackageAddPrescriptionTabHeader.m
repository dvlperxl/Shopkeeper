//
//  ReicpePackageAddPrescriptionTabHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionTabHeader.h"
#import "ReicpePackageAddPrescriptionInput.h"
#import "ReicpePackageAddPrescriptionPicker.h"

@interface ReicpePackageAddPrescriptionTabHeader ()

@property (nonatomic,strong) UILabel *cropTitleLabel;
@property (nonatomic,strong) ReicpePackageAddPrescriptionInput *prescriptionNameView;
@property (nonatomic,strong) ReicpePackageAddPrescriptionPicker *prescriptionSpecView;
@end

@implementation ReicpePackageAddPrescriptionTabHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.cropTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.mas_equalTo(80);
        }];
        [self.prescriptionNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cropTitleLabel);
            make.top.equalTo(self.cropTitleLabel.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        [self.prescriptionSpecView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cropTitleLabel);
            make.top.equalTo(self.prescriptionNameView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}
#pragma mark - HNReactView
- (void)bindingViewModel:(ReicpePackageAddPrescriptionTabHeaderModel *)viewModel {
    self.cropTitleLabel.text = viewModel.prescriptionTitle;
    self.prescriptionNameView.nameLabel.text = viewModel.prescriptionNameTitle;
    self.prescriptionNameView.contentTxtField.text = viewModel.prescriptionNameContent;
    self.prescriptionNameView.contentTxtField.placeholder = viewModel.prescriptionNamePlaceholder;
    [self.prescriptionNameView.contentTxtField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    self.prescriptionSpecView.nameLabel.text = viewModel.prescriptionSpecTitle;
    self.prescriptionSpecView.contentLabel.text = viewModel.prescriptionSpecContent;
    self.prescriptionSpecView.rightPlaceholderLabel.attributedText = viewModel.rightPlaceholder;
}
#pragma mark - event
- (void)specViewTapClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSpecRowTabHeader:)]) {
        [self.delegate tapSpecRowTabHeader:self];
    }
}
#pragma mark - getter
- (UILabel *)cropTitleLabel {
    if (!_cropTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentCenter;
        name.backgroundColor = [UIColor colorWithHexString:@"#FFF4E1"];
        name.textColor = [UIColor blackColor];
        name.font = APPFONT(34);
        [self addSubview:name];
        _cropTitleLabel = name;
    }
    return _cropTitleLabel;
}
- (ReicpePackageAddPrescriptionInput *)prescriptionNameView {
    if (!_prescriptionNameView) {
        _prescriptionNameView = [[ReicpePackageAddPrescriptionInput alloc]init];
        [self addSubview:_prescriptionNameView];
    }
    return _prescriptionNameView;
}
- (ReicpePackageAddPrescriptionPicker *)prescriptionSpecView {
    if (!_prescriptionSpecView) {
        _prescriptionSpecView = [[ReicpePackageAddPrescriptionPicker alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(specViewTapClick)];
        [_prescriptionSpecView addGestureRecognizer:tap];
        [self addSubview:_prescriptionSpecView];
    }
    return _prescriptionSpecView;
}
@end


@implementation ReicpePackageAddPrescriptionTabHeaderModel

@end
