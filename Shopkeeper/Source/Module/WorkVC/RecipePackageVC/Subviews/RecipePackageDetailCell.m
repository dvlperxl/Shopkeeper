//
//  RecipePackageDetailCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailCell.h"

@interface RecipePackageDetailCell ()

@property (nonatomic,strong) UILabel *goodsBrandLabel;
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *singlePriceLabel;
@property (nonatomic,strong) UILabel *goodsSpeciLabel;
@property (nonatomic,strong) UIView *useSpcSupView;
@property (nonatomic,strong) UILabel *useSpcTitleLabel;
@property (nonatomic,strong) UILabel *useSpcContentLabel;
@property (nonatomic,strong) UILabel *useSpcUnitLabel;
@property (nonatomic,strong) UILabel *goodsNumLabel;
@end

@implementation RecipePackageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.goodsBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(20.0);
            make.right.offset(-75);
        }];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsBrandLabel.mas_left);
            make.right.equalTo(self.goodsBrandLabel.mas_right);
            make.top.equalTo(self.goodsBrandLabel.mas_bottom).with.offset(4);
        }];
        [self.singlePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsBrandLabel.mas_left);
            make.top.equalTo(self.goodsNameLabel.mas_bottom).with.offset(15);
        }];
        [self.goodsSpeciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.singlePriceLabel.mas_right).with.offset(10);
            make.right.equalTo(self.goodsBrandLabel.mas_right);
            make.centerY.equalTo(self.singlePriceLabel);
        }];
        [self.singlePriceLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.singlePriceLabel);
            make.width.mas_greaterThanOrEqualTo(50);
        }];
        [self.useSpcSupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(self.singlePriceLabel.mas_bottom).with.offset(20);
            make.height.mas_equalTo(50);
        }];
        [self.useSpcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(25);
            make.centerY.equalTo(self.useSpcSupView);
            make.width.mas_equalTo(70);
        }];
        [self.useSpcUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-25);
            make.centerY.equalTo(self.useSpcSupView);
            make.width.mas_equalTo(84);
        }];
        [self.useSpcContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.useSpcTitleLabel.mas_right).with.offset(10);
            make.centerY.equalTo(self.useSpcSupView);
            make.right.equalTo(self.useSpcUnitLabel.mas_left).with.offset(0);
        }];
    }
    return self;
}

- (void)reloadData:(RecipePackageDetailCellModel *)model {
    self.goodsBrandLabel.text = model.goodsBrand;
    self.goodsNameLabel.text = model.goodsName;
    self.singlePriceLabel.text = model.singlePrice;
    self.goodsSpeciLabel.text = model.goodsSpeci;
    self.useSpcTitleLabel.text = model.useSpcTitle;
    self.useSpcContentLabel.text = model.useSpcContent;
    self.useSpcUnitLabel.text = model.useSpcUnit;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"x%ld",(long)model.goodsNumber];
}
#pragma mark - getter
- (UILabel *)goodsBrandLabel {
    if (!_goodsBrandLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#8F9FBF"];
        name.font = APPFONT(13);
        [self.contentView addSubview:name];
        _goodsBrandLabel = name;
    }
    return _goodsBrandLabel;
}
- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _goodsNameLabel = name;
    }
    return _goodsNameLabel;
}
- (UILabel *)singlePriceLabel {
    if (!_singlePriceLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#F29700"];
        name.font = APPFONT(24);
        [self.contentView addSubview:name];
        _singlePriceLabel = name;
    }
    return _singlePriceLabel;
}
- (UILabel *)goodsSpeciLabel {
    if (!_goodsSpeciLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(13);
        [self.contentView addSubview:name];
        _goodsSpeciLabel = name;
    }
    return _goodsSpeciLabel;
}
- (UIView *)useSpcSupView {
    if (!_useSpcSupView) {
        UIView *spcSup = [[UIView alloc]init];
        spcSup.layer.cornerRadius = 4.0f;
        spcSup.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.contentView addSubview:spcSup];
        _useSpcSupView = spcSup;
    }
    return _useSpcSupView;
}
- (UILabel *)useSpcTitleLabel {
    if (!_useSpcTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _useSpcTitleLabel = name;
    }
    return _useSpcTitleLabel;
}
- (UILabel *)useSpcContentLabel {
    if (!_useSpcContentLabel) {
        UILabel *content = [[UILabel alloc]init];
        content.textAlignment = NSTextAlignmentRight;
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(17);
        [self.contentView addSubview:content];
        _useSpcContentLabel = content;
    }
    return _useSpcContentLabel;
}
- (UILabel *)useSpcUnitLabel {
    if (!_useSpcUnitLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _useSpcUnitLabel = name;
    }
    return _useSpcUnitLabel;
}
- (UILabel *)goodsNumLabel {
    if (!_goodsNumLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _goodsNumLabel = name;
    }
    return _goodsNumLabel;
}

@end


@implementation RecipePackageDetailCellModel


@end
