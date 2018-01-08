//
//  ChooseMemberTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ChooseMemberTableViewCell.h"

@interface ChooseMemberTableViewCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *amountDescLab;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)ChooseMemberTableViewCellModel *model;

@end


@implementation ChooseMemberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}


- (void)reloadData:(ChooseMemberTableViewCellModel*)model
{
    _model = model;
    self.iconImageView.image = model.select?Image(@"icon_orange_checkbox"):Image(@"icon_grey_checkbox");
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.amountLab.text = model.amount;
    self.amountDescLab.text = model.amountDesc;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.width.height.mas_equalTo(26);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(61);
        make.top.offset(18);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(61);
        make.height.mas_equalTo(16);
        make.bottom.mas_offset(-18);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-17);
        make.top.offset(18);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.titleLab.mas_right).offset(10);

    }];
    
    [self.amountDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-17);
        make.height.mas_equalTo(16);
        make.bottom.mas_offset(-18);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(61);
        make.right.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
        make.bottom.mas_offset(0);
    }];
    
}

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.amountDescLab];
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
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithHex(@"333333");
        
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithHex(@"999999");
        _contentLab.font  = APPFONT(14);
        
    }
    return _contentLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPFONT(17);
        _amountLab.textColor = ColorWithHex(@"#f49900");
        _amountLab.textAlignment = NSTextAlignmentRight;
        
    }
    return _amountLab;
}

- (UILabel *)amountDescLab
{
    if (!_amountDescLab) {
        
        _amountDescLab = [[UILabel alloc]init];
        _amountDescLab.font = APPFONT(13);
        _amountDescLab.textColor = ColorWithHex(@"#999999");
        _amountDescLab.textAlignment = NSTextAlignmentRight;

    }
    return _amountDescLab;
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

@implementation ChooseMemberTableViewCellModel

@end
