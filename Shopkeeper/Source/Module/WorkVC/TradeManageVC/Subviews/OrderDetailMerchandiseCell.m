//
//  OrderDetailMerchandiseCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailMerchandiseCell.h"

@interface OrderDetailMerchandiseCell ()

@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *brandLab;
@property(nonatomic,strong)UILabel *countLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIView  *lineView;

@end


@implementation OrderDetailMerchandiseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(OrderDetailMerchandiseCellModel *)model
{
    self.nameLab.text = model.name;
    self.brandLab.text = model.brand;
    self.amountLab.text = model.amount;
    self.descLab.text = model.desc;
    self.countLab.text = model.count;
    self.lineView.hidden = model.hideLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-105);
        make.top.offset(15);
        make.bottom.offset(-40);
        
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(23);
        make.top.offset(16);
    }];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.bottom.offset(-14);
        make.height.mas_equalTo(17);
        
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.offset(-14);
        make.height.mas_equalTo(17);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.bottom.offset(-14);
        make.height.mas_equalTo(17);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.nameLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.descLab];
    [self addSubview:self.brandLab];
    [self addSubview:self.countLab];
    [self addSubview:self.lineView];

}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.numberOfLines = 0;
        _nameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _nameLab.font = APPFONT(17);
        
    }
    return _nameLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _amountLab.font = APPBOLDFONT(17);
    }
    
    return _amountLab;
}

- (UILabel *)brandLab
{
    if (!_brandLab) {
        
        _brandLab = [[UILabel alloc]init];
        _brandLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _brandLab.font = APPFONT(15);
        
    }
    return _brandLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _descLab.font = APPFONT(15);
        
    }
    return _descLab;
}

- (UILabel *)countLab
{
    if (!_countLab) {
        
        _countLab = [[UILabel alloc]init];
        _countLab.textAlignment = NSTextAlignmentRight;
        _countLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _countLab.font = APPFONT(15);
        
    }
    return _countLab;
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

@implementation OrderDetailMerchandiseCellModel
@end
