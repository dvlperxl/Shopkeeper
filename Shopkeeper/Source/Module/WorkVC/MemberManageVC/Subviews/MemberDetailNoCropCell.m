//
//  MemberDetailNoCropCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailNoCropCell.h"

@interface MemberDetailNoCropCell ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation MemberDetailNoCropCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(98);
        make.top.offset(0);
        make.height.mas_equalTo(74);
        make.width.mas_equalTo(59);

    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.bottom.offset(-28);
        make.height.mas_equalTo(42);
        make.right.offset(-10);
    }];
    
}

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]initWithImage:Image(@"plantinfo")];
        
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithHex(@"#666666");
        _titleLab.font = APPFONT(17);
        _titleLab.text = @"暂无作物信息";
    }
    return _titleLab;
}


@end
