//
//  MemberDetailAddressCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailAddressCell.h"

@interface MemberDetailAddressCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIImageView *vipImageView;
@property(nonatomic,strong)UILabel *levelLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UIImageView *arrowImageView;

@end

@implementation MemberDetailAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(MemberDetailAddressCellModel*)model
{
    self.nameLab.text = model.name;
    self.addressLab.text = model.address;
    self.levelLab.text = model.level;
    self.levelLab.hidden = !model.showVip;
    self.vipImageView.hidden = !model.showVip;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.width.height.mas_equalTo(65);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(90);
        make.top.offset(19);
        make.height.mas_equalTo(20);
    }];
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLab.mas_right).offset(5);
        make.top.offset(22);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(60);
    }];
    
    [self.levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLab.mas_right).offset(26);
        make.top.offset(22);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(90);
        make.right.offset(-55);
        make.top.offset(45);
        
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
    [self addSubview:self.nameLab];
    [self addSubview:self.vipImageView];
    [self addSubview:self.levelLab];
    [self addSubview:self.addressLab];
    [self addSubview:self.arrowImageView];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]initWithImage:Image(@"menberpic")];
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _nameLab.font = APPFONT(18);
        
    }
    return _nameLab;
}

- (UIImageView *)vipImageView
{
    if (!_vipImageView) {
        
        _vipImageView = [[UIImageView alloc]initWithImage:Image(@"icon_level")];
        
    }
    return _vipImageView;
}

- (UILabel *)levelLab
{
    if (!_levelLab) {
        
        _levelLab = [[UILabel alloc]init];
        _levelLab.font = APPFONT(10);
        _levelLab.textColor = ColorWithRGB(217, 168, 54, 1);
        
    }
    return _levelLab;
}

- (UILabel *)addressLab
{
    if (!_addressLab) {
        
        _addressLab = [[UILabel alloc]init];
        _addressLab.numberOfLines = 0;
        _addressLab.font = APPFONT(12);
        _addressLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _addressLab;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}

@end

@implementation MemberDetailAddressCellModel

@end

