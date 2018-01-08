//
//  OrderDetailAddressTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailAddressTableViewCell.h"

@interface OrderDetailAddressTableViewCell()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *mobileLab;
@property(nonatomic,strong)UILabel *addressLab;

@end
@implementation OrderDetailAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(OrderDetailAddressTableViewCellModel*)model
{
    self.nameLab.text = model.name;
    self.mobileLab.text = model.mobile;
    self.addressLab.text = model.address;
    [self layoutSubviews];
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
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(28);
        
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(58);
        make.top.offset(21);
        make.height.mas_equalTo(17);
    }];
    
    [self.mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(21);
        make.height.mas_equalTo(17);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.left.offset(58);
        make.top.equalTo(self.nameLab.mas_bottom).offset(9);
        make.bottom.offset(-21);
    }];
}

- (void)initSubviews
{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.mobileLab];
    [self.contentView addSubview:self.addressLab];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = Image(@"ico_adress");
        
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = APPFONT(17);
        _nameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        
    }
    
    return _nameLab;
}

- (UILabel *)mobileLab
{
    if (!_mobileLab) {
        
        _mobileLab = [[UILabel alloc]init];
        _mobileLab.textAlignment = NSTextAlignmentRight;
        _mobileLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _mobileLab.font = APPFONT(17);
    }
    return _mobileLab;
}

- (UILabel *)addressLab
{
    if (!_addressLab) {
        
        _addressLab = [[UILabel alloc]init];
        _addressLab.textColor = ColorWithRGB(153, 153, 153, 1);
        _addressLab.font = APPFONT(15);
        _addressLab.numberOfLines = 0;
    }
    return _addressLab;
}


@end

@implementation OrderDetailAddressTableViewCellModel

@end
