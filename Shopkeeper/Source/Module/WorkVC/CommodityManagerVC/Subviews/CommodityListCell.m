//
//  CommodityListCell.m
//  Dev
//
//  Created by xl on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "CommodityListCell.h"

@interface CommodityListCell ()

@property (nonatomic,weak) UILabel *commodityNameLabel;
@property (nonatomic,weak) UILabel *commodityContentLabel;
@property (nonatomic,weak) UILabel *commodityPriceLabel;

@end

@implementation CommodityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviewsLayout];
    }
    return self;
}
- (void)setupSubviewsLayout {
    
    [self.commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(90);
    }];
    [self.commodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.lessThanOrEqualTo(self.commodityPriceLabel.mas_left).with.offset(-10);
    }];
    [self.commodityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commodityNameLabel);
        make.top.equalTo(self.commodityNameLabel.mas_bottom).with.offset(6);
        make.right.lessThanOrEqualTo(self.commodityPriceLabel.mas_left).with.offset(-10);
    }];
    
}

- (void)reloadData:(CommodityListCellModel *)model {
    self.commodityNameLabel.text = model.commodityName;
    self.commodityContentLabel.text = model.commodityContent;
    self.commodityPriceLabel.text = model.commodityPrice;
}

#pragma mark - getter
- (UILabel *)commodityNameLabel {
    if (!_commodityNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _commodityNameLabel = name;
    }
    return _commodityNameLabel;
}
- (UILabel *)commodityContentLabel {
    if (!_commodityContentLabel) {
        UILabel *content = [[UILabel alloc]init];
        content.textColor = [UIColor colorWithHexString:@"#999999"];
        content.font = APPFONT(12);
        [self.contentView addSubview:content];
        _commodityContentLabel = content;
    }
    return _commodityContentLabel;
}
- (UILabel *)commodityPriceLabel {
    if (!_commodityPriceLabel) {
        UILabel *price = [[UILabel alloc]init];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        price.font = APPFONT(17);
        price.backgroundColor = [UIColor clearColor];
        price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:price];
        _commodityPriceLabel = price;
    }
    return _commodityPriceLabel;
}
@end


@interface CommodityListCellModel ()

@property (nonatomic,copy) NSString *commodityName;
@property (nonatomic,copy) NSString *commodityContent;
@property (nonatomic,copy) NSString *commodityPrice;
@property (nonatomic,copy) NSString *commodityId;
@end

@implementation CommodityListCellModel

+ (instancetype)cellModelDataWithName:(NSString *)commodityName content:(NSString *)commodityContent price:(NSString *)commodityPrice commodityId:(NSString *)commodityId; {
    CommodityListCellModel *model = [[CommodityListCellModel alloc]init];
    model.commodityName = commodityName;
    model.commodityContent = commodityContent;
    model.commodityPrice = commodityPrice;
    model.commodityId = commodityId;
    return model;
}
@end
