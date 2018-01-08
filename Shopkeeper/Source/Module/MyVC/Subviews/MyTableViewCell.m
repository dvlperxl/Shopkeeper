//
//  MyTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyTableViewCell.h"


@interface MyTableViewCell ()

@property (strong, nonatomic)  UIImageView *iconImageV;
@property (strong, nonatomic)  UILabel *contentLab;
@property (strong, nonatomic)  UIImageView *arrowImageV;
@property (nonatomic,strong)UIView *line;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
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
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(50);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(77);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(150);
        
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(77);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)reloadData:(MyTableViewCellModel*)model
{
    self.iconImageV.image = Image(model.iconImageName);
    self.contentLab.text = model.content;
}

#pragma mark

- (void)initSubviews
{
    [self addSubview:self.iconImageV];
    [self addSubview:self.contentLab];
    [self addSubview:self.arrowImageV];
    [self addSubview:self.line];
}

- (UIImageView *)iconImageV
{
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc]init];
    }
    return _iconImageV;
}

- (UILabel *)contentLab
{
    if (_contentLab == nil) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = APPFONT(18);
        _contentLab.textColor = ColorWithRGB(51, 51, 51, 1);
    }
    return _contentLab;
}

- (UIImageView *)arrowImageV
{
    if (!_arrowImageV) {
        _arrowImageV = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageV;
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


@implementation MyTableViewCellModel


@end
