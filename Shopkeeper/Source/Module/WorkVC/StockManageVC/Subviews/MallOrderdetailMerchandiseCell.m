//
//  MallOrderdetailMerchandiseCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderdetailMerchandiseCell.h"

@interface MallOrderdetailMerchandiseCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *spcLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *countLab;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UIView *line;

@end

@implementation MallOrderdetailMerchandiseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(MallOrderdetailMerchandiseCellModel*)model
{
    [self.iconImageView kk_setImageWithURLString:model.imageUrl];
    self.titleLab.text = model.title;
    self.spcLab.text = model.spec;
    self.priceLab.text = model.price;
    self.countLab.text = model.count;
    self.totalLab.attributedText = model.total;
    self.line.hidden = model.hideLine;
    
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.width.height.mas_equalTo(60);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.right.offset(-15);
        make.top.offset(12);
    }];
    
    [self.spcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
        make.right.offset(-15);
        
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(self.spcLab.mas_bottom).offset(8);
        make.right.offset(-15);
        
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(self.spcLab.mas_bottom).offset(8);
        make.right.offset(-15);
        
    }];
    
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(self.countLab.mas_bottom).offset(7);
        make.right.offset(-15);
        make.bottom.offset(-11);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.spcLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.countLab];
    [self.contentView addSubview:self.totalLab];
    [self.contentView addSubview:self.line];
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
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"#333333");
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)spcLab
{
    if (!_spcLab) {
        
        _spcLab = [[UILabel alloc]init];
        _spcLab.textColor = ColorWithHex(@"#999999");
        _spcLab.font = APPFONT(14);
        
    }
    return _spcLab;
}

- (UILabel *)priceLab
{
    if (!_priceLab) {
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = ColorWithHex(@"#999999");
        _priceLab.font = APPFONT(14);
        
    }
    return _priceLab;
}


- (UILabel *)countLab
{
    if (!_countLab) {
        
        _countLab = [[UILabel alloc]init];
        _countLab.textColor = ColorWithHex(@"#999999");
        _countLab.font = APPFONT(14);
        _countLab.textAlignment = NSTextAlignmentRight;
    }
    return _countLab;
}

-(UILabel *)totalLab
{
    if (!_totalLab) {
        
        _totalLab = [[UILabel alloc]init];
        
    }
    return _totalLab;
}

-(UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

@end


@implementation MallOrderdetailMerchandiseCellModel

@end
