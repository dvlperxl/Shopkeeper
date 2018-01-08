//
//  MallOrderTabFooter.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderTabFooter.h"

@interface MallOrderTabFooter ()

@property (nonatomic,weak) UILabel *payTitleLabel;
@property (nonatomic,weak) UILabel *payPriceLabel;
@property (nonatomic,weak) UIButton *payBtn;
@end

@implementation MallOrderTabFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(18);
            make.top.offset(10);
        }];
        [self.payPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.payTitleLabel);
            make.top.equalTo(self.payTitleLabel.mas_bottom).with.offset(2);
            make.right.greaterThanOrEqualTo(self.payBtn.mas_left).with.offset(-10);
        }];
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.top.offset(8);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(160);
        }];
        self.payTitleLabel.text = @"订单总金额:";
    }
    return self;
}

#pragma mark - HNReactView
- (void)bindingViewModel:(NSString *)viewModel {
    self.payPriceLabel.text = viewModel;
}
#pragma mark - event
- (void)payClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabFooterDidTapSubmitBtn:)]) {
        [self.delegate tabFooterDidTapSubmitBtn:self];
    }
}

#pragma mark - getter
- (UILabel *)payTitleLabel {
    if (!_payTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(12);
        [self addSubview:name];
        _payTitleLabel = name;
    }
    return _payTitleLabel;
}
- (UILabel *)payPriceLabel {
    if (!_payPriceLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#F29700"];
        name.font = APPFONT(18);
        [self addSubview:name];
        _payPriceLabel = name;
    }
    return _payPriceLabel;
}
- (UIButton *)payBtn {
    if (!_payBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F29700"]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#EBEBEB"]] forState:UIControlStateDisabled];
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 20.0f;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _payBtn = btn;
    }
    return _payBtn;
}
@end
