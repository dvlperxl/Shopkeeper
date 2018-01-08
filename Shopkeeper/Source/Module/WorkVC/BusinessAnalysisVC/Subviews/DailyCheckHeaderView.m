//
//  DailyCheckHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "DailyCheckHeaderView.h"
#import "UIButton+Extensions.h"

@interface DailyCheckHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *chooseButton;

@end

@implementation DailyCheckHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.chooseButton];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)reloadData:(NSString*)dateTime
{
    self.titleLab.text = dateTime;
}

- (void)onStoreChooseButtonAction
{
    if ([self.delegate respondsToSelector:@selector(dailyCheckHeaderViewDidSelectChooseDateTime)]) {

        [self.delegate dailyCheckHeaderViewDidSelectChooseDateTime];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.width.height.mas_equalTo(16);
        make.left.equalTo(self.titleLab.mas_right).offset(5);
        
    }];
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor =  ColorWithRGB(51, 51, 51, 1);
        _titleLab.font = APPFONT(20);
    }
    return _titleLab;
}

- (UIButton *)chooseButton
{
    if (!_chooseButton) {
        
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseButton setImage:Image(@"arrowdown") forState:UIControlStateNormal];
        [_chooseButton setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -200, -10, -200)];
        [_chooseButton addTarget:self action:@selector(onStoreChooseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

@end
