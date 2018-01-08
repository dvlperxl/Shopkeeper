//
//  SMSRechargeCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRechargeCell.h"


@interface SMSRechargeCell ()

@property(nonatomic,strong)UILabel *smsNumLab;
@property(nonatomic,strong)UILabel *smsDesLab;

@end


@implementation SMSRechargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.smsNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(36);
        make.top.offset(19);
    }];
    
    [self.smsDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(20);
        make.top.offset(63);
    }];
    
}

- (void)reloadData:(NSString*)model
{
    self.smsNumLab.text = model;
}

#pragma mark

- (void)initSubviews
{
    [self addSubview:self.smsNumLab];
    [self addSubview:self.smsDesLab];

}


- (UILabel *)smsNumLab
{
    if (_smsNumLab == nil) {
        
        _smsNumLab = [[UILabel alloc]init];
        _smsNumLab.textAlignment = NSTextAlignmentCenter;
        _smsNumLab.font = APPFONT(34);
        _smsNumLab.textColor = ColorWithHex(@"#333333");
    }
    return _smsNumLab;
}

- (UILabel *)smsDesLab
{
    if (_smsDesLab == nil) {
        
        _smsDesLab = [[UILabel alloc]init];
        _smsDesLab.textAlignment = NSTextAlignmentCenter;
        _smsDesLab.font = APPFONT(14);
        _smsDesLab.textColor = ColorWithHex(@"#999999");
        _smsDesLab.text = @"剩余短信(条)";
    }
    return _smsDesLab;
}


@end
