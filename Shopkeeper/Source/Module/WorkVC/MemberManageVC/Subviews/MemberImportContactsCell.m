//
//  MemberImportContactsCell.m
//  Dev
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberImportContactsCell.h"

@interface MemberImportContactsCell ()

@property (nonatomic,weak) UIImageView *contactStatusImage;
@property (nonatomic,weak) UILabel *contactNameLabel;
@property (nonatomic,weak) UILabel *contactStatusLabel;
@end

@implementation MemberImportContactsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviewsLayout];
    }
    return self;
}
- (void)setupSubviewsLayout {
    __weak typeof(self) weakSelf = self;
    [self.contactStatusImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    [self.contactStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-4);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(28);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    [self.contactNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.greaterThanOrEqualTo(weakSelf.contactStatusLabel.mas_left).with.offset(10);
    }];
}

- (void)reloadData:(MemberImportContactsCellModel*)model {
    self.userInteractionEnabled = model.enabled;
    self.contactNameLabel.text = model.contactName;
    self.contactStatusImage.image = model.contactStatusImage;
    self.contactStatusLabel.attributedText = model.contactStatusStr;
    self.contactStatusLabel.backgroundColor = model.contactStatusBgColor;
}

#pragma mark - getter
- (UIImageView *)contactStatusImage {
    if (!_contactStatusImage) {
        UIImageView *statusImage = [[UIImageView alloc]init];
        [self.contentView addSubview:statusImage];
        _contactStatusImage = statusImage;
    }
    return _contactStatusImage;
}
- (UILabel *)contactNameLabel {
    if (!_contactNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _contactNameLabel = name;
    }
    return _contactNameLabel;
}
- (UILabel *)contactStatusLabel {
    if (!_contactStatusLabel) {
        UILabel *status = [[UILabel alloc]init];
        status.textColor = [UIColor colorWithHexString:@"#999999"];
        status.font = APPFONT(15);
        status.backgroundColor = [UIColor clearColor];
        status.textAlignment = NSTextAlignmentCenter;
        status.layer.cornerRadius = 12;
        status.layer.masksToBounds = YES;
        [self.contentView addSubview:status];
        _contactStatusLabel = status;
    }
    return _contactStatusLabel;
}

@end


@implementation MemberImportContactsCellModel

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        if (![[self.manager selctedItems] containsObject:self]) {
            [[self.manager selctedItems] addObject:self];
        }
    } else {
        if ([[self.manager selctedItems] containsObject:self]) {
            [[self.manager selctedItems] removeObject:self];
        }
    }
}
- (UIImage *)contactStatusImage {
    UIImage *image = [UIImage imageNamed:@"icon_grey_checkbox_disable"];
    if (_enabled) {
        image = _selected ? [UIImage imageNamed:@"icon_orange_checkbox"] : [UIImage imageNamed:@"icon_grey_checkbox"];
    }
    return image;
}
- (NSAttributedString *)contactStatusStr {
    NSMutableAttributedString *contactStatus = [[NSMutableAttributedString alloc]initWithString:@"已导入" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]}];
    if (_enabled) {
        contactStatus = [[NSMutableAttributedString alloc]initWithString:@"未导入" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4A90E2"]}];
    }
    return contactStatus.copy;
}
- (UIColor *)contactStatusBgColor {
    UIColor *color = [UIColor clearColor];
    if (_enabled) {
        color = [UIColor colorWithHexString:@"#F9F8FC"];
    }
    return color;
}
@end
