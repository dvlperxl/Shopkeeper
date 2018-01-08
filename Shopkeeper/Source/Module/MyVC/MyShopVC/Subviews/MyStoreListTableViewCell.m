//
//  MyStoreListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyStoreListTableViewCell.h"

@interface MyStoreListTableViewCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *storeNameLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *iconLab;
@property(nonatomic,strong)UIView *line;


@end


@implementation MyStoreListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
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

- (void)reloadData:(MyStoreListTableViewCellModel*)model
{
    self.storeNameLab.text = model.storeName;
    self.addressLab.text = model.address;
    
    if (model.index<10)
    {
        self.iconImageView.hidden = NO;
        self.iconLab.hidden = YES;
        NSString *imageN = [NSString stringWithFormat:@"ico_no_%@",@(model.index)];
        self.iconImageView.image = Image(imageN);
    }else
    {
        self.iconImageView.hidden = YES;
        self.iconLab.hidden = NO;
        self.iconLab.text = STRINGWITHOBJECT(@(model.index));
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(32);
        
    }];
    
    [self.iconLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.iconImageView.mas_centerX);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(31);
        
    }];
    
    [self.storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(62);
        make.top.offset(17);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(25);
        
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(62);
        make.top.equalTo(self.storeNameLab.mas_bottom).offset(0);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(16);
        
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(62);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.iconLab];
    [self addSubview:self.storeNameLab];
    [self addSubview:self.addressLab];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.line];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
     
        _iconImageView = [[UIImageView alloc]init];
        
    }
    return _iconImageView;
}

- (UILabel*)iconLab
{
    if (!_iconLab) {
        _iconLab = [[UILabel alloc]init];
        _iconLab.textAlignment = NSTextAlignmentCenter;
        _iconLab.textColor = ColorWithRGB(63, 58, 58, 1);
        _iconLab.font = APPFONT(22);
        
    }
    return _iconLab;
}

- (UILabel *)storeNameLab
{
    if (!_storeNameLab) {
        
        _storeNameLab = [[UILabel alloc]init];
        _storeNameLab.font = APPFONT(18);
        _storeNameLab.textColor = ColorWithRGB(51, 51, 51, 1);
    }
    return _storeNameLab;
}

- (UILabel *)addressLab
{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.font = APPFONT(14);
        _addressLab.textColor = ColorWithHex(@"#999999");
    }
    return _addressLab;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
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

@implementation MyStoreListTableViewCellModel

@end

