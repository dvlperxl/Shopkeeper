//
//  WorkHomeTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeTableHeaderView.h"

@interface WorkHomeTableHeaderView ()

@property(nonatomic,strong)UILabel  *storeNameLab;
@property(nonatomic,strong)UIButton *storeChooseButton;

@end

@implementation WorkHomeTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(66);
        make.height.offset(41);
        make.right.equalTo(self.storeChooseButton.mas_left).offset(-5);
    }];
    
    [self.storeChooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.storeNameLab.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
        make.right.mas_lessThanOrEqualTo(-15);
    }];
    
}

- (void)onStoreChooseButtonAction
{
    if ([self.delegate respondsToSelector:@selector(workHomeTableHeaderViewDidSelectChooseStoreButton)]) {
        
        [self.delegate workHomeTableHeaderViewDidSelectChooseStoreButton];
    }
}

- (void)reloadData:(NSString*)title showChooseButton:(BOOL)show
{
    self.storeNameLab.text = title;
    self.storeChooseButton.hidden = !show;
}

- (void)initSubviews
{
    [self addSubview:self.storeNameLab];
    [self addSubview:self.storeChooseButton];
}

- (UILabel *)storeNameLab
{
    if (!_storeNameLab) {
        
        _storeNameLab = [[UILabel alloc]init];
        _storeNameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _storeNameLab.font = APPFONT(34);
        _storeNameLab.text = @"";
        _storeNameLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onStoreChooseButtonAction)];
        [_storeNameLab addGestureRecognizer:tap];
    }
    return _storeNameLab;
}

- (UIButton *)storeChooseButton
{
    if (!_storeChooseButton) {
        
        _storeChooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_storeChooseButton setImage:Image(@"arrowdown") forState:UIControlStateNormal];
        [_storeChooseButton addTarget:self action:@selector(onStoreChooseButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _storeChooseButton;
}


@end
