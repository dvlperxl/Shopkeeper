//
//  ShoppingListBottomBar.m
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShoppingListBottomBar.h"

@interface ShoppingVerticalButton : UIButton

@end

@implementation ShoppingVerticalButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageX = (self.bounds.size.width - self.imageView.frame.size.width)*0.5;
    self.imageView.frame = CGRectMake(imageX, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGFloat labelY = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.frame = CGRectMake(0, labelY, self.bounds.size.width, self.bounds.size.height - labelY);
}
@end

@interface ShoppingListBottomBar ()

@property (nonatomic,strong) ShoppingVerticalButton *selectedAllBtn;
@property (nonatomic,strong) UILabel *totalTitleLabel;
@property (nonatomic,strong) UILabel *totalPriceLabel;
@property (nonatomic,strong) UIButton *payBtn;
@end

@implementation ShoppingListBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSelectedTotalPrice:@"0.00"];
        [self setSelectedCount:0];
        [self setPayBtnEnabled:NO];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(6);
        make.top.offset(10);
        make.width.mas_equalTo(44);
        make.bottom.offset(-8);
    }];
    [self.totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(11);
        make.right.equalTo(self.payBtn.mas_left).with.offset(-15);
    }];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalTitleLabel.mas_bottom).with.offset(5);
        make.left.offset(50);
        make.right.equalTo(self.payBtn.mas_left).with.offset(-15);
    }];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(8);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(150);
    }];
}
#pragma mark - public
- (void)setAllSelectedTotalStatus:(BOOL)status {
    self.selectedAllBtn.selected = status;
}
- (void)setSelectedTotalPrice:(NSString*)totalPrice {
    self.totalPriceLabel.text = totalPrice;
}
- (void)setSelectedCount:(NSInteger)selectedCount {
    [self.payBtn setTitle:[NSString stringWithFormat:@"去结算(%@)",@(selectedCount)] forState:UIControlStateNormal];
}
- (void)setPayBtnEnabled:(BOOL)enabled {
    self.payBtn.enabled = enabled;
}
- (void)updateAllSelectedTotalStatus:(BOOL)status selectedTotalPrice:(NSString*)totalPrice selectedCount:(NSInteger)selectedCount payBtnEnabled:(BOOL)enabled {
    [self setAllSelectedTotalStatus:status];
    [self setSelectedTotalPrice:totalPrice];
    [self setSelectedCount:selectedCount];
    [self setPayBtnEnabled:enabled];
}
#pragma mark - event
- (void)selectedAllClick:(UIButton *)selectedAllBtn {
    selectedAllBtn.selected = !selectedAllBtn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:tapSelectedAllStatus:)]) {
        [self.delegate bottomBar:self tapSelectedAllStatus:selectedAllBtn.selected];
    }
}
- (void)payClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBarTapPayBtn:)]) {
        [self.delegate bottomBarTapPayBtn:self];
    }
}
#pragma mark - getter
- (ShoppingVerticalButton *)selectedAllBtn {
    if (!_selectedAllBtn) {
        _selectedAllBtn = [ShoppingVerticalButton buttonWithType:UIButtonTypeCustom];
        [_selectedAllBtn setImage:[UIImage imageNamed:@"icon_grey_checkbox"] forState:UIControlStateNormal];
        [_selectedAllBtn setImage:[UIImage imageNamed:@"icon_orange_checkbox"] forState:UIControlStateSelected];
        [_selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        _selectedAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _selectedAllBtn.titleLabel.font = APPFONT(11);
        [_selectedAllBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_selectedAllBtn addTarget:self action:@selector(selectedAllClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectedAllBtn];
    }
    return _selectedAllBtn;
}
- (UILabel *)totalTitleLabel {
    if (!_totalTitleLabel) {
        _totalTitleLabel = [[UILabel alloc]init];
        _totalTitleLabel.font = APPFONT(12);
        _totalTitleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _totalTitleLabel.text = @"合计";
        [self addSubview:_totalTitleLabel];
    }
    return _totalTitleLabel;
}
- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]init];
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        _totalPriceLabel.font = APPFONT(18);
        _totalPriceLabel.textColor = [UIColor colorWithHexString:@"#EF8600"];
        [self addSubview:_totalPriceLabel];
    }
    return _totalPriceLabel;
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F29700"]] forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#EBEBEB"]] forState:UIControlStateDisabled];
        _payBtn.layer.cornerRadius = 20.0f;
        _payBtn.layer.masksToBounds = YES;
        [_payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_payBtn];
    }
    return _payBtn;
}
@end
