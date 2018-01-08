//
//  AddStoreQrCodeCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStoreQrCodeCell.h"


@interface AddStoreQrCodeCell ()

@property(nonatomic,strong)UIImageView *qrImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIImageView *arrowImageView;

@end

@implementation AddStoreQrCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.width.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(77);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(170);
        
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.arrowImageView.mas_left).offset(-11);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(170);
    }];
    
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.qrImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    [self addSubview:self.arrowImageView];
}

-(UIImageView *)qrImageView
{
    if (!_qrImageView) {
        
        _qrImageView = [[UIImageView alloc]initWithImage:Image(@"ico_code")];
        
    }
    return _qrImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.text = @"门店二维码";
        
    }
    return _titleLab;
}

- (UILabel *)descLab
{
    if (!_descLab)
    {
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(17);
        _descLab.textColor = ColorWithRGB(143, 142, 148, 1);
        _descLab.text = @"查看";
        _descLab.textAlignment = NSTextAlignmentRight;
    }
    return _descLab;
}


- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}


@end
