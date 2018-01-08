//
//  GoodsDetailMoreTitleCell.m
//  Shopkeeper
//
//  Created by xl on 2017/12/4.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDetailMoreTitleCell.h"

@interface GoodsDetailMoreTitleCell ()

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UILabel *oneTitleLabel;
@property (nonatomic,weak) UILabel *twoTitleLabel;
@property (nonatomic,weak) UILabel *threeTitleLabel;
@end

@implementation GoodsDetailMoreTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
        }];
        [self.twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneTitleLabel.mas_right).with.offset(0);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.oneTitleLabel);
        }];
        [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoTitleLabel.mas_right).with.offset(0);
            make.right.offset(-10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.oneTitleLabel);
        }];
    }
    return self;
}

- (void)reloadData:(GoodsDetailMoreTitleCellModel *)model {
    self.leftNameLabel.text = model.leftTitle;
    self.oneTitleLabel.text = model.oneTitle;
    self.twoTitleLabel.text = model.twoTitle;
    self.threeTitleLabel.text = model.threeTitle;
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
- (UILabel *)oneTitleLabel {
    if (!_oneTitleLabel) {
        _oneTitleLabel = [self selfSubLabel];
    }
    return _oneTitleLabel;
}
- (UILabel *)twoTitleLabel {
    if (!_twoTitleLabel) {
        _twoTitleLabel = [self selfSubLabel];
    }
    return _twoTitleLabel;
}
- (UILabel *)threeTitleLabel {
    if (!_threeTitleLabel) {
        _threeTitleLabel = [self selfSubLabel];
    }
    return _threeTitleLabel;
}

- (UILabel *)selfSubLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = APPFONT(17);
    [self.contentView addSubview:label];
    return label;
}
@end


@implementation GoodsDetailMoreTitleCellModel

@end
