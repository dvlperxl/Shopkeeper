//
//  ReicpePackageAddPrescriptionHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionHeader.h"
#import "ReicpePackageAddPrescriptionPicker.h"

@interface ReicpePackageAddPrescriptionHeader ()

@property (nonatomic,strong) ReicpePackageAddPrescriptionPicker *pickerHeader;
@end

@implementation ReicpePackageAddPrescriptionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.pickerHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

- (void)reloadData:(ReicpePackageAddPrescriptionHeaderModel *)model {
    self.pickerHeader.nameLabel.text = model.headerLeftTitle;
    self.pickerHeader.contentLabel.attributedText = model.headerMiddleTitle;
    self.pickerHeader.rightPlaceholderLabel.attributedText = model.headerRightTitle;
}
#pragma mark - event
- (void)pickerTapClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSectionHeader:)]) {
        [self.delegate tapSectionHeader:self];
    }
}
#pragma mark - getter
- (ReicpePackageAddPrescriptionPicker *)pickerHeader {
    if (!_pickerHeader) {
        _pickerHeader = [[ReicpePackageAddPrescriptionPicker alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerTapClick)];
        [_pickerHeader addGestureRecognizer:tap];
        [self.contentView addSubview:_pickerHeader];
    }
    return _pickerHeader;
}
@end


@implementation ReicpePackageAddPrescriptionHeaderModel

@end
