//
//  GoodsCategoryTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsCategoryTableViewCell.h"

@interface GoodsCategoryTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *selectView;

@end

@implementation GoodsCategoryTableViewCell

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

- (void)reloadData:(GoodsCategoryTableViewCellModel *)model
{
    self.titleLab.text = model.title;
    self.selectView.hidden = !model.select;
    self.contentView.backgroundColor = model.select?[UIColor whiteColor]:ColorWithHex(model.imageBgColor);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.offset(6);
    }];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(5);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.selectView];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"#999999");
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
- (UIView *)selectView
{
    if (!_selectView) {
        
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = ColorWithHex(@"#F29700");
        
    }
    return _selectView;
}
@end

@implementation GoodsCategoryTableViewCellModel

@end
