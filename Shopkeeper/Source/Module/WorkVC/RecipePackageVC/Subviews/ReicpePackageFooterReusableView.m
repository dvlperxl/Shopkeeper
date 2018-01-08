//
//  ReicpePackageFooterReusableView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageFooterReusableView.h"

@interface ReicpePackageFooterReusableView ()

@property(nonatomic,strong)UIButton *addButton;

@end

@implementation ReicpePackageFooterReusableView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(50);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(113);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(300);
    }];
}

- (void)onAddButtonAction
{
    if ([self.delegate respondsToSelector:@selector(reicpePackageFooterReusableViewDidSelectAddButton)]) {
        [self.delegate reicpePackageFooterReusableViewDidSelectAddButton];
    }
}

- (UIButton *)addButton
{
    if (_addButton==nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton addTarget:self action:@selector(onAddButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_addButton setTitle:@"添加其他作物" forState:UIControlStateNormal];
        [_addButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _addButton.titleLabel.font = APPFONT(18);
        [_addButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
        
        self.backgroundColor = ColorWithHex(@"#f5f5f5");
        [self addSubview:_addButton];
    }
    return _addButton;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(13);
        _descLab.textColor = ColorWithHex(@"#999999");
        _descLab.textAlignment = NSTextAlignmentCenter;
        _descLab.text = @"没有你要选择的作物，点击按钮去添加";
        [self addSubview:self.descLab];
    }
    return _descLab;
}

@end
