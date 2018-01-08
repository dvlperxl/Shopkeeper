//
//  RecipePackageCropListViewCategoryCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageCropListViewCategoryCell.h"

@interface RecipePackageCropListViewCategoryCell ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation RecipePackageCropListViewCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)reloadData:(RecipePackageCropListViewCategoryCellModel*)model
{
    self.titleLab.text = model.title;
    if (model.selected)
    {
        self.titleLab.backgroundColor = ColorWithHex(@"#f29700");
        self.titleLab.textColor = ColorWithHex(@"#ffffff");
    }else
    {
        self.titleLab.backgroundColor = ColorWithHex(@"#f5f5f5");
        self.titleLab.textColor = ColorWithHex(@"#666666");
    }
}


#pragma mark - init

- (void)initSubviews
{
    [self addSubview:self.titleLab];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithHex(@"#666666");
        _titleLab.font = APPFONT(17);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

@end

@implementation RecipePackageCropListViewCategoryCellModel

@end
