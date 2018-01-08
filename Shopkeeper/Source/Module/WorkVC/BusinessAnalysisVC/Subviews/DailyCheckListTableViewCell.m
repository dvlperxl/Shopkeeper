//
//  DailyCheckListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "DailyCheckListTableViewCell.h"

@interface DailyCheckListTableViewCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *typeLab;

@property(nonatomic,strong)UILabel *titleLab1;
@property(nonatomic,strong)UILabel *titleLab2;

@property(nonatomic,strong)UILabel *contentLab1;
@property(nonatomic,strong)UILabel *contentLab2;

@property(nonatomic,strong)UIView *lineView;

@end

@implementation DailyCheckListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(DailyCheckListTableViewCellModel*)model
{
    self.iconImageView.image = Image(model.iconName);
    self.typeLab.text = model.type;
    self.titleLab1.text = model.title1;
    self.titleLab2.text = model.title2;
    self.contentLab1.attributedText = model.content1;
    self.contentLab2.attributedText = model.content2;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(17);
        make.width.height.mas_equalTo(50);
        
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.iconImageView.mas_centerX).offset(0);
        make.bottom.offset(-6);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(90);
        make.top.offset(16);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(90);
        make.bottom.offset(-15);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    
    [self.contentLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(16);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    [self.contentLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.bottom.offset(-15);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    
    
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(80);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void) initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.typeLab];
    [self addSubview:self.titleLab1];
    [self addSubview:self.titleLab2];
    [self addSubview:self.contentLab1];
    [self addSubview:self.contentLab2];
    [self addSubview:self.lineView];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UILabel *)typeLab
{
    if (!_typeLab) {
        
        _typeLab = [[UILabel alloc]init];
        _typeLab.textAlignment = NSTextAlignmentCenter;
        _typeLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _typeLab.font = APPFONT(12);
        
    }
    return _typeLab;
}

- (UILabel *)titleLab1
{
    if (!_titleLab1) {
        _titleLab1 = [[UILabel alloc]init];
        _titleLab1.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab1.font = APPFONT(18);
        
    }
    return _titleLab1;
}

- (UILabel *)titleLab2
{
    if (!_titleLab2) {
        _titleLab2 = [[UILabel alloc]init];
        _titleLab2.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab2.font = APPFONT(18);
        
    }
    return _titleLab2;
}

- (UILabel *)contentLab1
{
    if (!_contentLab1) {
        
        _contentLab1 = [[UILabel alloc]init];
        _contentLab1.textAlignment = NSTextAlignmentRight;
        _contentLab1.font = APPFONT(18);
        
    }
    return _contentLab1;
}

- (UILabel *)contentLab2
{
    if (!_contentLab2) {
        _contentLab2 = [[UILabel alloc]init];
        _contentLab2.textAlignment = NSTextAlignmentRight;
        _contentLab2.font = APPFONT(18);
    }
    return _contentLab2;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _lineView;
}


@end

@implementation DailyCheckListTableViewCellModel

@end
