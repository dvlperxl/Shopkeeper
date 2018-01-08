//
//  UpdateVersionView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "UpdateVersionView.h"


@interface UpdateVersionView ()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *versionLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIButton *updateButton;
@property(nonatomic,strong)UIButton *notUpdateButton;
@property(nonatomic,strong)UpdateVersionViewModel *model;

@end

@implementation UpdateVersionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = ColorWithRGB(0, 0, 0, 0.5);
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(UpdateVersionViewModel*)model
{
    _model = model;
    
    if (model.force) {
        self.notUpdateButton.hidden = YES;
    }
    self.versionLab.text = model.version;
    self.contentLab.text = model.message;
    [self setNeedsLayout];
}



#pragma mark - on button action

- (void)onUpdateButtonAction
{
    NSURL *url = [NSURL URLWithString:self.model.url];
    [[UIApplication sharedApplication]openURL:url];
    
    if (self.model.force == NO)
    {
        [self onNotUpdateButtonAction];
    }
}

- (void)onNotUpdateButtonAction
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(updateVersionViewDidDisAppear)]) {
        [self.delegate updateVersionViewDidDisAppear];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(421);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.top.offset(143);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.top.offset(180);
        make.right.offset(-20);
        make.height.mas_equalTo(120);
    }];
    
    [self.notUpdateButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    if (self.model.force) {
        
        [self.updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.offset(-10);
            make.height.mas_equalTo(57);
            make.width.mas_equalTo(300);
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(20);
            make.top.offset(180);
            make.right.offset(-20);
            make.height.mas_equalTo(150);
        }];
        
    }else
    {
        [self.updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.offset(-60);
            make.height.mas_equalTo(57);
            make.width.mas_equalTo(300);
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(20);
            make.top.offset(180);
            make.right.offset(-20);
            make.height.mas_equalTo(120);
        }];
        
    }

}


- (void)initSubviews
{
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.versionLab];
    [self.bgImageView addSubview:self.contentLab];
    [self.bgImageView addSubview:self.notUpdateButton];
    [self.bgImageView addSubview:self.updateButton];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        UIImage *image = Image(@"update_bk");
        _bgImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(210, 0, 210, 0) resizingMode:UIImageResizingModeStretch];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UILabel *)versionLab
{
    if (!_versionLab)
    {
        _versionLab = [[UILabel alloc]init];
        _versionLab.font = APPFONT(12);
        _versionLab.textColor = ColorWithHex(@"ffffff");
        _versionLab.textAlignment = NSTextAlignmentCenter;

    }
    return _versionLab;
}

- (UILabel*)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = APPFONT(18);
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = ColorWithHex(@"333333");
        
    }
    return _contentLab;
}

- (UIButton *)notUpdateButton
{
    if (!_notUpdateButton)
    {
        _notUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notUpdateButton setTitle:@"暂不更新" forState:UIControlStateNormal];
        [_notUpdateButton setTitleColor:ColorWithRGB(51, 51, 51, 1) forState:UIControlStateNormal];
        _notUpdateButton.titleLabel.font = APPFONT(18);
        [_notUpdateButton addTarget:self action:@selector(onNotUpdateButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _notUpdateButton;
}

- (UIButton *)updateButton
{
    if (!_updateButton) {
        
        _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateButton addTarget:self action:@selector(onUpdateButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_updateButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
        [_updateButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _updateButton.titleLabel.font = APPFONT(18);
        [_updateButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _updateButton;
}


@end

@implementation UpdateVersionViewModel

@end
