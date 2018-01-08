//
//  MallOrderReceiverInfoCell.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderReceiverInfoCell.h"

@interface MallOrderReceiverInfoCell ()

@property (nonatomic,weak) UIImageView *addressIcon;
@property (nonatomic,weak) UILabel *receiverNameLabel;
@property (nonatomic,weak) UILabel *receiverMobileLabel;
@property (nonatomic,weak) UILabel *receiverFullAddressLabel;
@property (nonatomic,weak) UIImageView *rightIcon;
@end


@implementation MallOrderReceiverInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.receiverNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(58);
            make.top.offset(20);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        [self.receiverMobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-47);
            make.top.equalTo(self.receiverNameLabel.mas_top);
            make.left.equalTo(self.contentView.mas_centerX);
        }];
        [self.receiverFullAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.receiverMobileLabel.mas_right);
            make.top.equalTo(self.receiverNameLabel.mas_bottom).with.offset(9);
            make.left.equalTo(self.receiverNameLabel.mas_left);
        }];
        [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)reloadData:(MallOrderReceiverInfoCellModel *)model {
    self.receiverNameLabel.text = model.receiverName;
    self.receiverMobileLabel.text = model.receiverMobile;
    self.receiverFullAddressLabel.text = model.receiverFullAddress;
}
#pragma mark - getter
- (UIImageView *)addressIcon {
    if (!_addressIcon) {
        UIImageView *name = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_adress"]];
        [self.contentView addSubview:name];
        _addressIcon = name;
    }
    return _addressIcon;
}
- (UILabel *)receiverNameLabel {
    if (!_receiverNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _receiverNameLabel = name;
    }
    return _receiverNameLabel;
}
- (UILabel *)receiverMobileLabel {
    if (!_receiverMobileLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _receiverMobileLabel = name;
    }
    return _receiverMobileLabel;
}
- (UILabel *)receiverFullAddressLabel {
    if (!_receiverFullAddressLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(15);
        [self.contentView addSubview:name];
        _receiverFullAddressLabel = name;
    }
    return _receiverFullAddressLabel;
}
- (UIImageView *)rightIcon {
    if (!_rightIcon) {
        UIImageView *name = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        [self.contentView addSubview:name];
        _rightIcon = name;
    }
    return _rightIcon;
}
@end


@implementation MallOrderReceiverInfoCellModel

@end
