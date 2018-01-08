//
//  MemberImportContactsBottomBar.m
//  Dev
//
//  Created by xl on 2017/11/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberImportContactsBottomBar.h"

@interface MemberImportAllButton : UIButton

@end

@implementation MemberImportAllButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGFloat labelX = CGRectGetMaxX(self.imageView.frame) + 20;
    self.titleLabel.frame = CGRectMake(labelX, self.imageView.frame.origin.y, self.bounds.size.width - labelX, self.imageView.frame.size.height);
}
@end

@interface MemberImportContactsBottomBar ()

@property (nonatomic,strong) MemberImportAllButton *selectedAllBtn;
@property (nonatomic,strong) UIButton *sureBtn;

@end

@implementation MemberImportContactsBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self selectedCount:0];
        [self allSelectedTotal:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.bottom.offset(-8);
        make.right.offset(-15);
        make.left.equalTo(self.mas_centerX).with.offset(15);
    }];
}
- (void)setAllSelectedTotalStatus:(BOOL)status {
    self.selectedAllBtn.selected = status;
}
- (void)allSelectedTotal:(NSInteger)total {
    NSString *title = [NSString stringWithFormat:@"全选(共%@人)",@(total)];
    [self.selectedAllBtn setTitle:title forState:UIControlStateNormal];
}
- (void)selectedCount:(NSInteger)count {
    [self.sureBtn setTitle:[NSString stringWithFormat:@"确认(%@人)",@(count)] forState:UIControlStateNormal];
}
#pragma mark - event
/** 全选事件*/
- (void)selectedAllClick:(MemberImportAllButton *)button {
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:tapSelectedAllStatus:)]) {
        [self.delegate bottomBar:self tapSelectedAllStatus:button.selected];
    }
}
/** 确认事件*/
- (void)sureClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBarTapSureBtn:)]) {
        [self.delegate bottomBarTapSureBtn:self];
    }
}
#pragma mark - getter
- (MemberImportAllButton *)selectedAllBtn {
    if (!_selectedAllBtn) {
        _selectedAllBtn = [MemberImportAllButton buttonWithType:UIButtonTypeCustom];
        [_selectedAllBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_selectedAllBtn setImage:[UIImage imageNamed:@"icon_grey_checkbox"] forState:UIControlStateNormal];
        [_selectedAllBtn setImage:[UIImage imageNamed:@"icon_orange_checkbox"] forState:UIControlStateSelected];
        [_selectedAllBtn addTarget:self action:@selector(selectedAllClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectedAllBtn];
    }
    return _selectedAllBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#F29700"];
        _sureBtn.layer.cornerRadius = 20.0f;
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureBtn];
    }
    return _sureBtn;
}
@end

