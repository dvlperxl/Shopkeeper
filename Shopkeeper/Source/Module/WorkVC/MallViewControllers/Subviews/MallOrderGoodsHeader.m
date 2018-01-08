//
//  MallOrderGoodsHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderGoodsHeader.h"

@interface MallOrderGoodsHeader ()

@property (nonatomic,weak) UILabel *headerTitle;
@property (nonatomic,weak) UIButton *backShoppingBtn;
@end

@implementation MallOrderGoodsHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.backShoppingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)reloadData:(MallOrderGoodsHeaderModel *)model {
    self.headerTitle.text = model.headerTitle;
    self.backShoppingBtn.hidden = !model.showShopping;
}
#pragma mark - event
- (void)backShoppingClick:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsHeaderTapBackShopping:)]) {
        [self.delegate goodsHeaderTapBackShopping:self];
    }
}
#pragma mark - getter
- (UILabel *)headerTitle {
    if (!_headerTitle) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(12);
        [self.contentView addSubview:name];
        _headerTitle = name;
    }
    return _headerTitle;
}
- (UIButton *)backShoppingBtn {
    if (!_backShoppingBtn) {
        UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
        [name setImage:[UIImage imageNamed:@"shoppingIcon"] forState:UIControlStateNormal];
        [name setTitle:@"返回购物车" forState:UIControlStateNormal];
        [name setTitleColor:[UIColor colorWithHexString:@"#030303"] forState:UIControlStateNormal];
        name.titleLabel.font = APPFONT(17);
        [name addTarget:self action:@selector(backShoppingClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:name];
        _backShoppingBtn = name;
    }
    return _backShoppingBtn;
}
@end


@implementation MallOrderGoodsHeaderModel

@end
