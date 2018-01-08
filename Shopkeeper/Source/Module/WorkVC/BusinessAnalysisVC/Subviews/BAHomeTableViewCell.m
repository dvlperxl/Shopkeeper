//
//  BAHomeTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BAHomeTableViewCell.h"

@interface BAHomeTableViewCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UIView *lineView;

@end


@implementation BAHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(BAHomeTableViewCellModel *)model
{
    self.iconImageView.image = Image(model.iconName);
    self.titleLab.text = model.title;
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
        
        make.left.offset(80);
        make.height.mas_equalTo(19);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(80);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
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
    [self addSubview:self.lineView];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.font = APPFONT(18);
        
    }
    return _titleLab;
}


- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _lineView;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}
@end

@implementation BAHomeTableViewCellModel

@end

