//
//  SelectGoodsListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SelectGoodsListTableViewCell.h"
#import "StockGoodsListTableViewCell.h"

@interface SelectGoodsListTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *countLab;
@property(nonatomic,strong)UIButton *modifyButton;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)StockGoodsListTableViewCellModel *model;

@end

@implementation SelectGoodsListTableViewCell

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

- (void)reloadData:(StockGoodsListTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.descLab.text = model.desc;
    self.amountLab.attributedText = model.amount;
    self.countLab.text = STRING(@"x", model.count);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(42);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(120);
        make.top.offset(42);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.height.mas_equalTo(23);
        make.bottom.offset(-14);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.modifyButton.mas_centerX);
        make.centerY.equalTo(self.descLab.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(100);
    }];
    
    [self.modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(72);
        make.bottom.offset(-15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

#pragma mark - on button action

- (void)onModifyButtonAction
{
    if ([self.delegate respondsToSelector:@selector(selectGoodsListTableViewCellDidSelectModifyButton:)]) {
        [self.delegate selectGoodsListTableViewCellDidSelectModifyButton:self];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.descLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.countLab];
    [self addSubview:self.modifyButton];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"#333333");
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab)
    {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithHex(@"#999999");
        _contentLab.font = APPFONT(15);
    }
    return _contentLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.textColor =  ColorWithHex(@"#999999");
        _descLab.font = APPFONT(15);
    }
    return _descLab;
}

- (UILabel *)countLab
{
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.textColor =  ColorWithHex(@"#999999");
        _countLab.font = APPFONT(15);
        _countLab.textAlignment = NSTextAlignmentCenter;
    }
    return _countLab;
}

- (UIButton *)modifyButton
{
    if (!_modifyButton) {
        
        _modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        [_modifyButton addTarget:self action:@selector(onModifyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_modifyButton setBackgroundColor:ColorWithHex(@"#F9F8FC")];
        _modifyButton.layer.cornerRadius = 14;
        _modifyButton.layer.masksToBounds = YES;
        [_modifyButton setTitleColor:ColorWithHex(@"#4A90E2") forState:UIControlStateNormal];
        _modifyButton.titleLabel.font = APPFONT(15);
    }
    return _modifyButton;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
    }
    
    return _amountLab;
}

-(UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

@end
