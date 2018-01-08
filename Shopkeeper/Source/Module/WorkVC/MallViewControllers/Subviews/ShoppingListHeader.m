//
//  ShoppingListHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShoppingListHeader.h"

@interface ShoppingListHeader ()

@property (nonatomic,weak) UIImageView *headerImage;
@property (nonatomic,weak) UIView *bgView;
@property (nonatomic,weak) UILabel *companyNameLabel;
@end

@implementation ShoppingListHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(40);
            make.right.offset(-15);
            make.height.mas_equalTo(45);
            make.centerY.equalTo(self.contentView);
        }];
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImage.mas_right).with.offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)reloadData:(ShoppingListHeaderModel*)model {
    self.companyNameLabel.text = model.wholesaleName;
}
#pragma mark - getter
- (UIImageView *)headerImage {
    if (!_headerImage) {
        UIImageView *name = [[UIImageView alloc]init];
        name.image = [UIImage imageNamed:@"cart_icon_supplier"];
        [self.contentView addSubview:name];
        _headerImage = name;
    }
    return _headerImage;
}
- (UILabel *)companyNameLabel {
    if (!_companyNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _companyNameLabel = name;
    }
    return _companyNameLabel;
}
- (UIView *)bgView {
    if (!_bgView) {
        UIView *name = [[UIView alloc]init];
        name.layer.cornerRadius = 20.0f;
        name.backgroundColor = [UIColor colorWithHexString:@"#FCF7F0"];
        [self.contentView addSubview:name];
        _bgView = name;
    }
    return _bgView;
}

@end

@implementation ShoppingListHeaderModel

@end
