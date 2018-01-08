//
//  ReicpePackageAddPrescriptionFooter.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionFooter.h"

@interface ReicpePackageAddPrescriptionFooter ()

@property (nonatomic,strong) UILabel *goodsCountLabel;
@property (nonatomic,strong) UILabel *goodsPriceLabel;
@end

@implementation ReicpePackageAddPrescriptionFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView);
        }];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_centerX);
        }];
    }
    return self;
}

- (void)reloadData:(ReicpePackageAddPrescriptionFooterModel *)model {
    self.goodsCountLabel.text = model.footerLeftTitle;
    self.goodsPriceLabel.text = model.footerRightTitle;
}
#pragma mark - getter
- (UILabel *)goodsCountLabel {
    if (!_goodsCountLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _goodsCountLabel = name;
    }
    return _goodsCountLabel;
}
- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:name];
        _goodsPriceLabel = name;
    }
    return _goodsPriceLabel;
}
@end


@implementation ReicpePackageAddPrescriptionFooterModel

@end
