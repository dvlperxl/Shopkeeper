//
//  WorkHomeSectionHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeSectionHeaderView.h"

@interface WorkHomeSectionHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *lineV;


@end


@implementation WorkHomeSectionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        [self addSubview:self.titleLab];
        [self addSubview:self.lineV];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.bottom.offset(0);
        make.right.offset(-15);
        
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _titleLab.font = APPFONT(12);
        _titleLab.text = @"基础服务";
    }
    return _titleLab;
}

- (UIView *)lineV
{
    if (!_lineV) {
        
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = ColorWithRGB(245, 245, 245, 1);
    }
    return _lineV;
}

@end
