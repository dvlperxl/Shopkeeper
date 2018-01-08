//
//  MallOrderPayCell.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderPayCell.h"

@interface MallOrderPayCell ()

@property (nonatomic,weak) UIImageView *payIcon;
@property (nonatomic,weak) UILabel *payNameLabel;
@property (nonatomic,weak) UIImageView *selectedIcon;
@end

@implementation MallOrderPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.payIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(50);
        }];
        [self.payNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.payIcon.mas_right).with.offset(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-18);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)reloadData:(MallOrderPayCellModel *)model {
    self.payIcon.image = model.payIcon;
    self.payNameLabel.attributedText = model.content;
    self.selectedIcon.image = model.selectedImage;
}
#pragma mark - getter
- (UIImageView *)payIcon {
    if (!_payIcon) {
        UIImageView *name = [[UIImageView alloc]init];
        [self.contentView addSubview:name];
        _payIcon = name;
    }
    return _payIcon;
}
- (UILabel *)payNameLabel {
    if (!_payNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _payNameLabel = name;
    }
    return _payNameLabel;
}
- (UIImageView *)selectedIcon {
    if (!_selectedIcon) {
        UIImageView *name = [[UIImageView alloc]init];
        [self.contentView addSubview:name];
        _selectedIcon = name;
    }
    return _selectedIcon;
}
@end

@implementation MallOrderPayCellModel

@end
