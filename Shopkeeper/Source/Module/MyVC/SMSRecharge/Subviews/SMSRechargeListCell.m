//
//  SMSRechargeListCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRechargeListCell.h"

@interface SMSRechargeListCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *dateLab;
@property(nonatomic,strong)UILabel *amoutLab;
@property(nonatomic,strong)UILabel *payTypeLab;

@end

@implementation SMSRechargeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(19);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(42);
        make.height.mas_equalTo(14);
        
    }];
    
    [self.amoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(19);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(42);
        make.height.mas_equalTo(14);
        
    }];

}

- (void)reloadData:(SMSRechargeListCellModel*)model
{
    self.dateLab.text = model.date;
    self.amoutLab.text = model.amout;
    self.payTypeLab.text = model.payType;
}

#pragma mark

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.dateLab];
    [self addSubview:self.amoutLab];
    [self addSubview:self.payTypeLab];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"短信充值";
        _titleLab.textColor = ColorWithHex(@"333333");
        _titleLab.font = APPFONT(18);
    }
    return _titleLab;
}

- (UILabel *)dateLab
{
    if (!_dateLab) {
        
        _dateLab = [[UILabel alloc]init];
        _dateLab.text = @"短信充值";
        _dateLab.textColor = ColorWithHex(@"999999");
        _dateLab.font = APPFONT(12);
    }
    return _dateLab;
}


- (UILabel *)amoutLab
{
    if (!_amoutLab) {
        
        _amoutLab = [[UILabel alloc]init];
        _amoutLab.textColor = ColorWithHex(@"#F49900");
        _amoutLab.font = APPFONT(17);
        _amoutLab.textAlignment = NSTextAlignmentRight;

    }
    return _amoutLab;
}
- (UILabel *)payTypeLab
{
    if (!_payTypeLab) {
        
        _payTypeLab = [[UILabel alloc]init];
        _payTypeLab.text = @"短信充值";
        _payTypeLab.textColor = ColorWithHex(@"999999");
        _payTypeLab.font = APPFONT(12);
        _payTypeLab.textAlignment = NSTextAlignmentRight;
    }
    return _payTypeLab;
}


@end

@implementation SMSRechargeListCellModel

@end
