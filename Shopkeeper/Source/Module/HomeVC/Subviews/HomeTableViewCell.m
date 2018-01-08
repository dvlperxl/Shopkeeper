//
//  HomeTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *redPointLab;
@property(nonatomic,strong)UIView *lineView;

@end


@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(HomeTableViewCellModel*)model
{
    self.iconImageView.image = Image(model.iconName);
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.timeLab.text = model.dateTime;
    
    if (model.redPointCount&&model.redPointCount.integerValue>0) {
        
        self.redPointLab.hidden = NO;
        NSString *title = STRINGWITHOBJECT(model.redPointCount);
        if (model.redPointCount.integerValue>99) {
            title = @"99+";
        }
        [self.redPointLab setTitle:title forState:UIControlStateNormal];
        
    }else
    {
        self.redPointLab.hidden = YES;

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.width.height.offset(50);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(77);
        make.top.offset(16);
        make.height.offset(25);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(77);
        make.height.offset(17);
        make.top.offset(42);
    }];

    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.height.offset(16);
        make.top.offset(21);
    }];
    
    [self.redPointLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.top.offset(40);
        make.width.mas_greaterThanOrEqualTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(77);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.redPointLab];
    [self addSubview:self.lineView];
}



- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        
    }
    
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab  = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab)
    {
        _contentLab  = [[UILabel alloc]init];
        _contentLab.font = APPFONT(12);
        _contentLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _contentLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab)
    {
        _timeLab  = [[UILabel alloc]init];
        _timeLab.font = APPFONT(12);
        _timeLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _timeLab;
}

- (UIButton *)redPointLab
{
    if (!_redPointLab) {
        _redPointLab = [UIButton buttonWithType:UIButtonTypeCustom];
        _redPointLab.backgroundColor = ColorWithHex(@"#FC6A21");
        [_redPointLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _redPointLab.titleLabel.font = APPFONT(12);
        _redPointLab.layer.masksToBounds = YES;
        _redPointLab.layer.cornerRadius = 10;
        _redPointLab.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return _redPointLab;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _lineView;
}

@end

@implementation HomeTableViewCellModel

@end
