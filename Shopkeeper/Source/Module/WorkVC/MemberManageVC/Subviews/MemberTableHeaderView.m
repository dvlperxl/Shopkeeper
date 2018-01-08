//
//  MemberTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberTableHeaderView.h"

@interface MemberTableHeaderView ()

@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *conLab;
@property(nonatomic,strong)UILabel *creditLab;

@end

@implementation MemberTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_offset(18);
    }];
    
    [self.conLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_offset(18);
    }];
    
    [self.creditLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_offset(18);
    }];
    
}

- (void)initSubviews
{
    [self addSubview:self.nameLab];
    [self addSubview:self.conLab];
    [self addSubview:self.creditLab];
    
    
    CGFloat width = SCREEN_WIDTH/3;
    for (NSInteger i = 1; i<3; i++)
    {
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
        line.frame = CGRectMake(width*i, 15, 1.0/SCREEN_SCALE, 20);
        [self addSubview:line];
    }
    
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"姓名";
        _nameLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _nameLab.font = APPFONT(18);
        
    }
    return _nameLab;
}

- (UILabel *)conLab
{
    if (!_conLab) {
        
        _conLab = [[UILabel alloc]init];
        _conLab.text = @"总消费";
        _conLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _conLab.font = APPFONT(18);
        _conLab.textAlignment = NSTextAlignmentCenter;

    }
    return _conLab;
}

- (UILabel *)creditLab
{
    if (!_creditLab) {
        
        _creditLab = [[UILabel alloc]init];
        _creditLab.text = @"总赊欠";
        _creditLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _creditLab.font = APPFONT(18);
        _creditLab.textAlignment = NSTextAlignmentRight;
        
    }
    return _creditLab;
}


@end
