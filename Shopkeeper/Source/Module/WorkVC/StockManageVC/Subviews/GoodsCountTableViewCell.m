//
//  GoodsCountTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsCountTableViewCell.h"

@interface GoodsCountTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UIView *line;

@end

@implementation GoodsCountTableViewCell

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

- (void)reloadData:(GoodsCountTableViewCellModel*)model
{
    self.titleLab.text = model.title;
    self.amountLab.attributedText = model.amount;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.height.mas_equalTo(23);
        make.right.equalTo(self.amountLab.mas_left).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.mas_centerY);
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
    [self addSubview:self.amountLab];
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


- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPBOLDFONT(17);//34
        _amountLab.textColor = ColorWithHex(@"#333333");
        _amountLab.textAlignment = NSTextAlignmentRight;
    }
    return _amountLab;
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

@implementation GoodsCountTableViewCellModel

@end


