//
//  UserHomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "UserHomeViewController.h"

@interface UserHomeViewController ()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIImageView *sloganImageView;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *signupButton;

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navView.alpha = 0;
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super statusBarStyleLightContent];
}

#pragma mark - action

- (void)onLoginButtonAction
{
    [[CMRouter sharedInstance]showViewController:@"LoginViewController" param:nil];
}

- (void)onSignupButtonAction
{
    [[CMRouter sharedInstance]showViewController:@"SignupViewController" param:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.offset(0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(108);
        make.top.equalTo(self.bgImageView.mas_bottom).offset(-48);
    }];
    
    [self.sloganImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.width.mas_equalTo(156);
        make.height.mas_equalTo(27);
    }];
    
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.sloganImageView.mas_bottom).offset(29);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(314);
        
    }];

    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.signupButton.mas_bottom).offset(18);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(314);
        
    }];
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.sloganImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.signupButton];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc]initWithImage:Image(@"login_bk")];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]initWithImage:Image(@"ico_ndzg")];
    }
    return _iconImageView;
}

- (UIImageView *)sloganImageView
{
    if (!_sloganImageView) {
        
        _sloganImageView = [[UIImageView alloc]initWithImage:Image(@"login_slogon")];
    }
    return _sloganImageView;
}

- (UIButton *)signupButton
{
    if (_signupButton==nil) {
        _signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signupButton addTarget:self action:@selector(onSignupButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_signupButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_signupButton setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_signupButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _signupButton.titleLabel.font = APPFONT(18);
        [_signupButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _signupButton;
}

- (UIButton *)loginButton
{
    if (_loginButton==nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton addTarget:self action:@selector(onLoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundImage:Image(@"login_btn") forState:UIControlStateNormal];
        [_loginButton setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
        [_loginButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _loginButton.titleLabel.font = APPFONT(18);
        [_loginButton setTitleColor:ColorWithRGB(63, 58, 58, 1) forState:UIControlStateNormal];
    }
    return _loginButton;
}


@end
