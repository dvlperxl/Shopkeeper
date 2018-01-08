//
//  RecipePackageListCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageListCell.h"

@interface RecipePackageListCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *specLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIButton *goodsCountLab;

@end

@implementation RecipePackageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(15);
        make.height.mas_equalTo(27);
        make.right.offset(-74);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(2);
        make.bottom.equalTo(self.amountLab.mas_top).offset(-12);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.mas_equalTo(25);
        make.bottom.offset(-15);
    }];
    
    [self.specLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.amountLab.mas_right).offset(5);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(self.amountLab.mas_centerY);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
    [self.goodsCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.height.mas_equalTo(20);
        make.top.offset(19);
        
    }];
}

- (void)reloadData:(RecipePackageListCellModel*)model
{
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.amountLab.text = model.amount;
    self.specLab.text = model.spec;
    [self.goodsCountLab setTitle:model.goodsCount forState:UIControlStateNormal];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.amountLab];
    [self.contentView addSubview:self.specLab];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.goodsCountLab];
    [self layoutSubviews];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithHex(@"#030303");
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = APPFONT(13);
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = ColorWithHex(@"#666666");
    }
    return _contentLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPFONT_Regular(24);
        _amountLab.textColor = ColorWithHex(@"#f29700");
    }
    return _amountLab;
}

- (UILabel *)specLab
{
    if (!_specLab) {
        _specLab = [[UILabel alloc]init];
        _specLab.textColor = ColorWithHex(@"#999999");
        _specLab.font = APPFONT(13);
    }
    return _specLab;
}

-(UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

- (UIButton *)goodsCountLab
{
    if (!_goodsCountLab) {
        
        _goodsCountLab = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodsCountLab.layer.masksToBounds = YES;
//        _goodsCountLab.layer.shouldRasterize = YES;
        _goodsCountLab.layer.cornerRadius = 10;
        _goodsCountLab.layer.borderColor = ColorWithHex(@"8f9fbf").CGColor;
        _goodsCountLab.layer.borderWidth = 1.0/SCREEN_SCALE;
        _goodsCountLab.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        _goodsCountLab.titleLabel.font = APPFONT(13);
        [_goodsCountLab setTitleColor:ColorWithHex(@"8f9fbf") forState:UIControlStateNormal];
    }
    return _goodsCountLab;
}

@end

@implementation RecipePackageListCellModel

@end
