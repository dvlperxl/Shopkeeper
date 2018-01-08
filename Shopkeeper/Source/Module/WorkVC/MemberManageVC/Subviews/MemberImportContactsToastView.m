//
//  MemberImportContactsToastView.m
//  Dev
//
//  Created by xl on 2017/11/13.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberImportContactsToastView.h"

NSString *const MemberContactsToastTitle = @"将通讯录的联系人导入为门店会员";

@interface MemberImportContactsToastView ()

@property (nonatomic,strong) UILabel *toastLabel;
@property (nonatomic,strong) UIButton *closeBtn;
@end

@implementation MemberImportContactsToastView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFF4E1"];
        self.toastLabel.text = MemberContactsToastTitle;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(44);
        make.right.offset(-8);
    }];
    [self.toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(self);
        make.right.greaterThanOrEqualTo(self.closeBtn.mas_left).with.offset(-10);
    }];
}

- (void)setTipsStr:(NSString *)tipsStr
{
    _tipsStr = tipsStr;
    self.toastLabel.text = tipsStr;
}

#pragma mark - event
/** 关闭事件*/
- (void)closeClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(toastViewTapCloseBtn:)]) {
        [self.delegate toastViewTapCloseBtn:self];
    }
}
#pragma mark - getter
- (UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc]init];
        _toastLabel.textColor = [UIColor colorWithHexString:@"#F29700"];
        _toastLabel.font = APPFONT(14);
        _toastLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_toastLabel];
    }
    return _toastLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"combinedShape"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}
@end
