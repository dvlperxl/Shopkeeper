//
//  RecipePackageListHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/29.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageListHeaderView.h"

@interface RecipePackageListHeaderView ()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *goodsLab;
@property(nonatomic,strong)UILabel *goodsCountLab;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,strong)RecipePackageListHeaderViewModel *model;

@end

@implementation RecipePackageListHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubviews];
    }
    
    return self;
}

- (void)reloadData:(RecipePackageListHeaderViewModel*)model
{
    self.model = model;
    [self.bgImageView kk_setImageWithURLString:model.imageURL];
    self.goodsLab.text = model.goodsName;
    self.goodsCountLab.text = model.goodsCount;
}

- (void)onTapAction
{
    if ([self.delegate respondsToSelector:@selector(recipePackageListHeaderViewDidSelectWithCropId:cropName:)]) {
        
        [self.delegate recipePackageListHeaderViewDidSelectWithCropId:self.model.cropId cropName:self.model.goodsName];
    }
}

- (void)layoutSubviews//110
{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.offset(35);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(10);
        make.right.offset(-15);
        make.height.mas_equalTo(90);
    }];
    
    [self.goodsLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(25);
        make.top.offset(16);
        make.height.mas_equalTo(35);
        make.right.offset(-25);
        
    }];
    
    [self.goodsCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(25);
        make.height.mas_equalTo(17);
        make.right.offset(-25);
        make.top.equalTo(self.goodsLab.mas_bottom).offset(7);
    }];
    
}



- (void)initSubviews
{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.goodsLab];
    [self.bgImageView addSubview:self.goodsCountLab];
    [self addGestureRecognizer:self.tap];
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = ColorWithHex(@"#ffffff");
    }
    return _bgView;
}

-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.layer.cornerRadius = 5;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.shouldRasterize = YES;
        
    }
    return _bgImageView;
}

-(UILabel *)goodsLab
{
    if (!_goodsLab) {
        
        _goodsLab = [[UILabel alloc]init];
        _goodsLab.textColor = ColorWithHex(@"#ffffff");
        _goodsLab.font = APPFONT(34);
    
    }
    return _goodsLab;
}

-(UILabel *)goodsCountLab
{
    if (!_goodsCountLab) {
        
        _goodsCountLab = [[UILabel alloc]init];
        _goodsCountLab.textColor = ColorWithHex(@"ffffff");
        _goodsCountLab.font = APPFONT(15);
    }
    return _goodsCountLab;
}

- (UITapGestureRecognizer *)tap
{
    if(!_tap)
    {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction)];
        
    }
    return _tap;
}

@end

@implementation RecipePackageListHeaderViewModel

@end
