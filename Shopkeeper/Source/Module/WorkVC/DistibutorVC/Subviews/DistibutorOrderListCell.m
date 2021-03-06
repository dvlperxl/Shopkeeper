//
//  DistibutorOrderListCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderListCell.h"


@interface DistibutorOrderListCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UIView *line;

@end

@implementation DistibutorOrderListCell

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

- (void)reloadData:(DistibutorOrderListCellModel*)model
{
    self.titleLab.text = model.title;
    self.descLab.text = model.desc;
    self.amountLab.text = model.amount;
    self.imageV.image = Image(model.imageName);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(19);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.amountLab.mas_left).offset(-5);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(42);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.amountLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-20);
        make.top.offset(19);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-17);
        make.height.mas_equalTo(20);
        make.top.offset(39);
        
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
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.imageV];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithHex(@"#333333");
        
    }
    return _titleLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(14);
        _descLab.textColor = ColorWithHex(@"#999999");
    }
    return _descLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPFONT(17);
        _amountLab.textColor = ColorWithHex(@"#f49900");
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.numberOfLines = 0;
    }
    return _amountLab;
}

- (UIImageView *)imageV
{
    if(!_imageV)
    {
        _imageV = [[UIImageView alloc]init];
    }
    return _imageV;
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

@implementation DistibutorOrderListCellModel

@end
