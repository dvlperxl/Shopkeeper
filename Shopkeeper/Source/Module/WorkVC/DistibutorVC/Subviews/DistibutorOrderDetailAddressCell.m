//
//  DistibutorOrderDetailAddressCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderDetailAddressCell.h"

@interface DistibutorOrderDetailAddressCell()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *mobileLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UIView *line;

@end

@implementation DistibutorOrderDetailAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
//        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(DistibutorOrderDetailAddressCellModel*)model
{
    self.nameLab.text = model.name;
    self.mobileLab.text = model.mobile;
    self.addressLab.text = model.address;
    self.line.hidden = model.hideLine;
    self.iconImageView.image = Image(model.imageName);
    
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
        
        make.left.offset(20);
        make.top.offset(10);
//        make.width.mas_equalTo(63);
        make.height.mas_equalTo(35);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(103);
        make.top.offset(19);
        make.height.mas_equalTo(19);
    }];
    
    [self.mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(19);
        make.height.mas_equalTo(19);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.left.offset(20);
        make.top.offset(52);
        make.bottom.offset(-8);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
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
        
        _iconImageView = [[UIImageView alloc]init];// 63*35
        _iconImageView.image = Image(@"icon_recipient");
        
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

-(UIView *)line
{
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}
@end

@implementation DistibutorOrderDetailAddressCellModel

@end
