//
//  ReicpePackageAddPrescriptionPicker.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionPicker.h"

@implementation ReicpePackageAddPrescriptionPicker

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(70);
    }];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(self);
    }];
    [self.rightPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-35);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(55);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).with.offset(18);
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightPlaceholderLabel.mas_left).with.offset(-10);
    }];
}
#pragma mark - getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.backgroundColor = [UIColor whiteColor];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self addSubview:name];
        _nameLabel = name;
    }
    return _nameLabel;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        UIImageView *statusImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        [self addSubview:statusImage];
        _arrowImage = statusImage;
    }
    return _arrowImage;
}
- (UILabel *)rightPlaceholderLabel {
    if (!_rightPlaceholderLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#8F8E94"];
        name.font = APPFONT(17);
        [self addSubview:name];
        _rightPlaceholderLabel = name;
    }
    return _rightPlaceholderLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self addSubview:name];
        _contentLabel = name;
    }
    return _contentLabel;
}

@end
