//
//  OrderListTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderListTableHeaderView.h"


@interface OrderListTableHeaderView()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *line;

@end


@implementation OrderListTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(OrderListTableHeaderViewModel*)model
{
    self.titleLab.text = model.title;
    self.line.hidden = model.hideLine;
}

-(void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.line];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.height.mas_equalTo(20);
        make.top.offset(19);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(20);
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.text = @"XDA";
    }
    return _titleLab;
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

@implementation OrderListTableHeaderViewModel

@end
