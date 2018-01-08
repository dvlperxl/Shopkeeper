//
//  SupplierListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SupplierListTableViewCell.h"

@interface SupplierListTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIView *line;

@end

@implementation SupplierListTableViewCell

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

- (void)reloadData:(SupplierListTableViewCellModel*)model
{
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(18);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(42);
        make.height.mas_equalTo(16);
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
    [self addSubview:self.contentLab];
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

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithHex(@"#999999");
        _contentLab.font = APPFONT(14);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
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

@implementation SupplierListTableViewCellModel

@end
