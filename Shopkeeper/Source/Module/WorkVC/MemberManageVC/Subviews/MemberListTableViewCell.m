//
//  MemberListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberListTableViewCell.h"

@interface MemberListTableViewCell ()

@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *scoreLab;
@property(nonatomic,strong)UILabel *consumptionLab;
@property(nonatomic,strong)UILabel *creditLab;


@end

@implementation MemberListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(MemberListTableViewCellModel*)model
{
    self.nameLab.text = model.name;
    self.scoreLab.text = model.score;
    self.consumptionLab.text = model.con;
    self.creditLab.text = model.credit;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(18);
        make.height.offset(20);
    }];
    
    [self.scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.bottom.offset(-18);
        make.height.offset(14);
    }];

    [self.creditLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.consumptionLab.mas_right).offset(10);
    }];
    
    [self.consumptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(140);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.nameLab];
    [self addSubview:self.scoreLab];
    [self addSubview:self.consumptionLab];
    [self addSubview:self.creditLab];
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = APPFONT(18);
        _nameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        
    }
    return _nameLab;
}

- (UILabel *)scoreLab
{
    if (!_scoreLab) {
        
        _scoreLab = [[UILabel alloc]init];
        _scoreLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _scoreLab.font = APPFONT(12);
    }
    return _scoreLab;
}

- (UILabel *)consumptionLab
{
    if (!_consumptionLab) {
        _consumptionLab = [[UILabel alloc]init];
        _consumptionLab.font = APPFONT(15);
        _consumptionLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _consumptionLab.textAlignment = NSTextAlignmentCenter;
        _consumptionLab.numberOfLines = 0;

    }
    return _consumptionLab;
}

- (UILabel *)creditLab
{
    if (!_creditLab) {
        _creditLab = [[UILabel alloc]init];
        _creditLab.font = APPFONT(15);
        _creditLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _creditLab.textAlignment = NSTextAlignmentRight;
        _creditLab.numberOfLines = 0;
    }
    return _creditLab;
}


@end

@implementation MemberListTableViewCellModel

@end

