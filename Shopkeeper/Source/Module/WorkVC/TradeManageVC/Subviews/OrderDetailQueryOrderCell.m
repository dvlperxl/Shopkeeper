//
//  OrderDetailQueryOrderCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/5.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailQueryOrderCell.h"

@interface OrderDetailQueryOrderCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrowImageView;

@end


@implementation OrderDetailQueryOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubviews];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.width.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(77);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
}

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.arrowImageView];
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithImage:Image(@"ico_formerorder")];
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithHex(@"#333333");
        _titleLab.font = APPFONT(18);
        _titleLab.text = @"查看原订单";
        
    }
    return _titleLab;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}


@end
