//
//  SignupViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SignupViewController.h"
#import "VerCodeButton.h"
#import "AppDelegate.h"
#import "JPush.h"
#import "UserBaseInfo.h"


@interface SignupViewController ()<VerCodeButtonDelegate>

@property(nonatomic,strong)UILabel *lab1;
@property(nonatomic,strong)UILabel *lab2;

@property(nonatomic,strong)CMTextField *mobileTextField;
@property(nonatomic,strong)CMTextField *codeTextField;
@property(nonatomic,strong)VerCodeButton *verCodeButton;

@property(nonatomic,strong)UIButton *signupButton;
@property(nonatomic,strong)UILabel *tipsBtn;

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(255, 255, 255, 1);
    self.navView.backgroundColor = ColorWithRGB(255, 255, 255, 1);
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(self.navBarHeight);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(41);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.offset(15);
        make.top.equalTo(self.lab1.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
    }];
    
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.equalTo(self.lab2.mas_top).offset(40);
        make.right.offset(-150);
        make.height.mas_equalTo(45);
        
    }];
    
    [self.verCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.equalTo(self.lab2.mas_top).offset(40);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(120);
    }];
    
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.equalTo(self.verCodeButton.mas_top).offset(50);
        make.right.offset(-15);
        make.height.mas_equalTo(45);
        
    }];
    
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(50);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
    }];
    
    [self.tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.signupButton.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(220);
    }];

}
#pragma mark - onButtonAction
- (void)onSignupButtonAction
{
    NSString *mobile = [self.mobileTextField.text deleteSpace];
    NSString *verifyCode = [self.codeTextField.text deleteSpace];
    
    if (mobile.length==0)
    {
        [[KKToast makeToast:@"手机号码不能为空"] show];
        return;
    }
    
    if (mobile.length != 11)
    {
        [[KKToast makeToast:@"请输入正确的手机号码"] show];
        return;
    }
    
    if (verifyCode.length==0)
    {
        [[KKToast makeToast:@"验证码不能为空"] show];
        return;
    }
    
    if (verifyCode.length != 6) {
        [[KKToast makeToast:@"请输入正确的验证码"] show];
        return;
    }
    
    [self httpRequestRegister:mobile verifyCode:verifyCode];
}

- (void)onProtocolAction
{
    NSString *url = [self pathAppendBaseURL:@"/api/pages/integral_mall/serviceAgreement.html"];
    url = [self urlAppendBaseParam:url];
    [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":url,@"webTitle":@"用户服务协议"}];
}

- (void)onTipsBtnAction
{
    [Mobile telephone:@"4009009078"];
}

- (void)onRightButtonAction
{
    [[CMRouter sharedInstance]showViewController:@"LoginViewController" param:nil];
    [[CMRouter sharedInstance]removeControllersWithRange:NSMakeRange(1, 1)];
}

#pragma mark - VerCodeButtonClick 发送验证码

- (void)verCodeButtonDidSelect:(VerCodeButton*)verCodeButton
{
    NSString *mobile = [self.mobileTextField.text deleteSpace];
    if (mobile.length == 11)
    {
        [self httpRequestSendSms:mobile];
        [self.codeTextField becomeFirstResponder];
    }else
    {
        [[KKToast makeToast:@"请输入正确的手机号码"] show];
    }
}


#pragma mark - httpRequest

- (void)httpRequestSendSms:(NSString*)mobile
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestSendSMS:mobile
                                  success:^(NSDictionary *responseObject) {
                                      
          [KKProgressHUD hideMBProgressForView:self.view];
          [_verCodeButton startTheTime:60];
          [[KKToast makeToast:@"验证码已发送"] show];

        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];

}

- (void)httpRequestRegister:(NSString*)mobile
                 verifyCode:(NSString*)verifyCode
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestRegister:mobile
                                verifyCode:verifyCode
                                   success:^(NSDictionary *responseObject) {
                                       
                                       [KKProgressHUD hideMBProgressForView:self.view];
//                                       [self onRightButtonAction];
                                       
                                       [KeyChain setToken:responseObject[@"token"]];
                                       [KeyChain setMobileNo:mobile];
//                                       [JPush setAlias:mobile];
                                       [JPush uploadRegistrationID];
                                       [self httpRequestQueryUserInfo];
                                       
                                       
                                       
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];
}

- (void)httpRequestQueryUserInfo
{
    NSString *mobile = [KeyChain getMobileNo];
    [[APIService share]httpRequestQueryUserWithMobile:mobile
                                              success:^(NSDictionary *responseObject) {
                                                  
                                                  NSString *userId = responseObject[@"id"];
                                                  [KeyChain setUserId:userId];
                                                  UserBaseInfo *info = [UserBaseInfo share];
                                                  [info modelObjectWithDictionary:responseObject];
                                                  [self showTBC];

                                                  
                                              } failure:^(NSNumber *errorCode,
                                                          NSString *errorMsg,
                                                          NSDictionary *responseObject) {
                                                  
                                                  [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

                                                  
                                              }];
}


#pragma mark - show

- (void)showTBC
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate showTBC];
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.mobileTextField];
    [self.view addSubview:self.verCodeButton];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.signupButton];
    [self.view addSubview:self.tipsBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = APPFONT(17);
    [rightBtn addTarget:self action:@selector(onRightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (UILabel *)lab1
{
    if (!_lab1) {
        
        _lab1 = [[UILabel alloc]init];
        _lab1.text = @"新用户注册";
        _lab1.textColor = ColorWithRGB(51, 51, 51, 1);
        _lab1.font = APPFONT(34);
        
    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        
        _lab2 = [[UILabel alloc]init];
        NSAttributedString *item1 = [CMLinkTextViewItem attributeStringWithText:@"注册即代表阅读并同意" textFont:APPFONT(12) textColor:ColorWithRGB(153, 153, 153, 1)];
        NSAttributedString *item2 = [CMLinkTextViewItem attributeStringWithText:@"《农丁掌柜用户服务协议》" textFont:APPFONT(12) textColor:ColorWithRGB(242, 151, 0, 1)];

        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc]init];
        [mStr appendAttributedString:item1];
        [mStr appendAttributedString:item2];
        _lab2.attributedText = mStr;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onProtocolAction)];
        [_lab2 addGestureRecognizer:tap];
        _lab2.userInteractionEnabled = YES;
        
    }
    
    return _lab2;
}

- (CMTextField *)mobileTextField
{
    if (!_mobileTextField)
    {
        _mobileTextField = [[CMTextField alloc]init];
        _mobileTextField.inputType = CMTextFieldViewInputTypePhoneNO;
        _mobileTextField.hasSpace = NO;
        _mobileTextField.placeholder = @"手机号";
        _mobileTextField.font = APPFONT(17);
        _mobileTextField.textColor = ColorWithRGB(51, 51, 51, 1);
        UIView *line = [self createLine];
        [_mobileTextField addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(1.0/SCREEN_SCALE);
        }];
        
    }
    return _mobileTextField;
}

-(VerCodeButton *)verCodeButton
{
    if (!_verCodeButton) {
        _verCodeButton = [[VerCodeButton alloc]init];
        _verCodeButton.delegate = self;
    }
    
    return _verCodeButton;
}


- (CMTextField *)codeTextField
{
    if (!_codeTextField)
    {
        _codeTextField = [[CMTextField alloc]init];
        _codeTextField.hasSpace = NO;
        _codeTextField.placeholder = @"验证码";
        _codeTextField.font = APPFONT(17);
        _codeTextField.maxLength = 6;
        _codeTextField.keyboardType =  UIKeyboardTypeNumberPad;
        _codeTextField.textColor = ColorWithRGB(51, 51, 51, 1);
        UIView *line = [self createLine];
        [_codeTextField addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(1.0/SCREEN_SCALE);
        }];
        
    }
    return _codeTextField;
}

- (UIButton *)signupButton
{
    if (_signupButton==nil) {
        _signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signupButton addTarget:self action:@selector(onSignupButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_signupButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_signupButton setTitle:@"注册" forState:UIControlStateNormal];
        [_signupButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _signupButton.titleLabel.font = APPFONT(18);
        [_signupButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _signupButton;
}

- (UILabel *)tipsBtn
{
    
    if (!_tipsBtn) {
        
        _tipsBtn = [[UILabel alloc]init];
        NSAttributedString *item1 = [CMLinkTextViewItem attributeStringWithText:@"未收到验证码，请拨打" textFont:APPFONT(12) textColor:ColorWithRGB(153, 153, 153, 1)];
        NSAttributedString *item2 = [CMLinkTextViewItem attributeStringWithText:@"免费热线" textFont:APPFONT(12) textColor:ColorWithRGB(242, 151, 0, 1)];
        NSAttributedString *item3 = [CMLinkTextViewItem attributeStringWithText:@"获取帮助" textFont:APPFONT(12) textColor:ColorWithRGB(153, 153, 153, 1)];

        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc]init];
        [mStr appendAttributedString:item1];
        [mStr appendAttributedString:item2];
        [mStr appendAttributedString:item3];
        _tipsBtn.attributedText = mStr;
        _tipsBtn.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTipsBtnAction)];
        [_tipsBtn addGestureRecognizer:tap];
    }
    return _tipsBtn;
}

- (UIView*)createLine
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    return line;
}

@end
