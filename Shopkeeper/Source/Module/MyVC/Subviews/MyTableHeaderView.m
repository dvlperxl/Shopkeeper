//
//  MyTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyTableHeaderView.h"
#import "UserBaseInfo.h"

@interface MyTableHeaderView ()

@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *nameLab;
//@property(nonatomic,strong)UILabel *mobileLab;
//@property(nonatomic,strong)UIImageView *mobileImageV;
@property(nonatomic,strong)UIButton *logoutBtn;

@end

@implementation MyTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
    }
    return self;
}

- (void)reloadData
{
    if ([UserBaseInfo share].userName.length>0)
    {
        _nameLab.text = [NSString stringWithFormat:@"你好,%@",[UserBaseInfo share].userName];

    }else
    {
        _nameLab.text = @"未完善个人信息";

    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-19);
        make.bottom.offset(-40);
        make.width.height.mas_equalTo(48);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(66);
        make.height.mas_equalTo(41);
        make.right.offset(-70);
        
    }];
    
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(112);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(22);
        
    }];
}

- (void)onLogoutButtonAction
{
    [[UserBaseInfo share]logout];
}

- (void)initSubviews
{
    [self addSubview:self.headerImageView];
    [self addSubview:self.nameLab];
    [self addSubview:self.logoutBtn];
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        
        _headerImageView = [[UIImageView alloc]initWithImage:Image(@"defaultavatar_shopkepper")];
    }
    
    return _headerImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = APPFONT(34);
        _nameLab.textColor = ColorWithRGB(255, 255, 255, 1);
    }
    return _nameLab;
}

//-(UIImageView *)mobileImageV
//{
//    if (!_mobileImageV) {
//
//        _mobileImageV = [[UIImageView alloc]initWithImage:Image(@"ico_phone")];
//
//    }
//    return _mobileImageV;
//}
//
//- (UILabel *)mobileLab
//{
//    if (!_mobileLab) {
//
//        _mobileLab = [[UILabel alloc]init];
//        _mobileLab.text = @"13312345678";
//        _mobileLab.font = APPFONT(12);
//        _mobileLab.textColor = ColorWithRGB(255, 255, 255, 1);
//
//    }
//    return _mobileLab;
//}

- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = APPFONT(12);
        _logoutBtn.layer.masksToBounds = YES;
        _logoutBtn.layer.cornerRadius = 11;
        _logoutBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _logoutBtn.layer.borderWidth = 1.0/SCREEN_SCALE;
        [_logoutBtn addTarget:self action:@selector(onLogoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _logoutBtn;
}


@end


