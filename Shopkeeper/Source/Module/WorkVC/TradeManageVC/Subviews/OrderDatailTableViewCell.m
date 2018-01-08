//
//  OrderDatailTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDatailTableViewCell.h"

@interface OrderDatailTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIView  *lineView;

@end

@implementation OrderDatailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addSubview:self.titleLab];
        [self addSubview:self.contentLab];
        [self addSubview:self.lineView];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(OrderDatailTableViewCellModel*)model
{
    self.titleLab.attributedText = model.title;
    self.contentLab.attributedText = model.content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.offset(0);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.bottom.offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];

    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
    }
    return _contentLab;
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

@implementation OrderDatailTableViewCellModel

@end
