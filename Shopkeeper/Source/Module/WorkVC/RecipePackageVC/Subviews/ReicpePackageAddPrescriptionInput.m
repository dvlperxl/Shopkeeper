//
//  ReicpePackageAddPrescriptionInput.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionInput.h"

@interface ReicpePackageAddPrescriptionInput ()

@property (nonatomic,strong) UIView *bottomLine;
@end

@implementation ReicpePackageAddPrescriptionInput

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
    [self.contentTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).with.offset(18);
        make.right.offset(-15);
        make.centerY.equalTo(self);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1);
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
- (UITextField *)contentTxtField {
    if (!_contentTxtField) {
        UITextField *content = [[UITextField alloc]init];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(17);
        [content setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [content setValue:APPFONT(17) forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:content];
        _contentTxtField = content;
    }
    return _contentTxtField;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}
@end
