//
//  RecipePackageCropListViewCropCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageCropListViewCropCell.h"

@interface RecipePackageCropListViewCropCell ()

@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;

@end

@implementation RecipePackageCropListViewCropCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)onButtonAction:(UIButton*)btn
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.top.offset(0);
        make.height.mas_equalTo(44);
        make.right.equalTo(self.mas_centerX).offset(-9);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-28);
        make.top.offset(0);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.mas_centerX).offset(1);

    }];
}

- (void)initSubviews
{
    self.button1 = [self createButton];
    self.button2 = [self createButton];
    [self addSubview:self.button1];
    [self addSubview:self.button2];
}

- (UIButton*)createButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius  = 22;
    btn.layer.masksToBounds = YES;
    btn.layer.shouldRasterize  = YES;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = ColorWithHex(@"ebebeb").CGColor;
    
    btn.titleLabel.font = APPFONT(17);
    [btn setTitleColor:ColorWithHex(@"#030303") forState:UIControlStateNormal];
    [btn setTitle:@"110" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage createImageWithColor:ColorWithHex(@"#f5f5f5")] forState:UIControlStateHighlighted];
    
    return btn;
}

@end
