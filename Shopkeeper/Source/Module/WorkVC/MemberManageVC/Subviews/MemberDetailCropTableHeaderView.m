//
//  MemberDetailCropTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailCropTableHeaderView.h"

@interface MemberDetailCropTableHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation MemberDetailCropTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(15);
        make.height.mas_equalTo(14);
        
    }];
}


- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"种植作物";
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.font = APPFONT(14);
    }
    return _titleLab;
}

@end
