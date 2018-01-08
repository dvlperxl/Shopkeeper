//
//  SearchRegistrationGoodsCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SearchRegistrationGoodsCell.h"

@interface SearchRegistrationGoodsCell ()

@property (nonatomic,weak) UILabel *snLabel;
@property (nonatomic,weak) UILabel *goodsNameLabel;
@property (nonatomic,weak) UILabel *goodsCompanyLabel;
@end

@implementation SearchRegistrationGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(18);
            make.right.offset(-15);
        }];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.snLabel.mas_left);
            make.top.equalTo(self.snLabel.mas_bottom).with.offset(8);
            make.right.offset(-15);
        }];
        [self.goodsCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.snLabel.mas_left);
            make.top.equalTo(self.goodsNameLabel.mas_bottom).with.offset(8);
            make.right.offset(-15);
        }];
    }
    return self;
}

- (void)reloadData:(SearchRegistrationGoodsCellModel *)model {
    self.snLabel.attributedText = model.attributedSn;
    self.goodsNameLabel.attributedText = model.attributedName;
    self.goodsCompanyLabel.attributedText = model.attributedCompany;
//    self.snLabel.text = model.sn;
//    self.goodsNameLabel.text = model.name;
//    self.goodsCompanyLabel.text = model.company;
}

#pragma mark - getter
- (UILabel *)snLabel {
    if (!_snLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _snLabel = name;
    }
    return _snLabel;
}
- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _goodsNameLabel = name;
    }
    return _goodsNameLabel;
}
- (UILabel *)goodsCompanyLabel {
    if (!_goodsCompanyLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(12);
        [self.contentView addSubview:name];
        _goodsCompanyLabel = name;
    }
    return _goodsCompanyLabel;
}
@end


@implementation SearchRegistrationGoodsCellModel


@end
