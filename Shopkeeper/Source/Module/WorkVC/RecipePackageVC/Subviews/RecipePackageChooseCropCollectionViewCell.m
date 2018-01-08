//
//  RecipePackageChooseCropCollectionViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageChooseCropCollectionViewCell.h"

@interface RecipePackageChooseCropCollectionViewCell ()

@property(nonatomic,strong)UIButton *titleButton;

@end

@implementation RecipePackageChooseCropCollectionViewCell


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
}

- (void)reloadData:(NSString*)title
{
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}


- (void)onTitleButtonAction
{
    if ([self.delegate respondsToSelector:@selector(recipePackageChooseCropCollectionViewCellDidSelect:)]) {
        [self.delegate recipePackageChooseCropCollectionViewCellDidSelect:self];
    }
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.layer.cornerRadius  = 22;
        _titleButton.layer.masksToBounds = YES;
//        _titleButton.layer.shouldRasterize  = YES;
        _titleButton.layer.borderWidth = 1.0;
        _titleButton.layer.borderColor = ColorWithHex(@"ebebeb").CGColor;
        
        _titleButton.titleLabel.font = APPFONT(17);
        [_titleButton setTitleColor:ColorWithHex(@"#030303") forState:UIControlStateNormal];
        [_titleButton setTitle:@"110" forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(onTitleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setBackgroundImage:[UIImage createImageWithColor:ColorWithHex(@"#f5f5f5")] forState:UIControlStateHighlighted];
        [self addSubview:_titleButton];
    }
    return _titleButton;
}


@end
