//
//  LoginViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "LoginViewController.h"
#import "VerCodeButton.h"
#import "AppDelegate.h"
#import "JPush.h"
#import "UserBaseInfo.h"


@interface LoginViewController ()<VerCodeButtonDelegate>

@property(nonatomic,strong)UILabel *lab1;
@property(nonatomic,strong)UILabel *lab2;

@property(nonatomic,strong)CMTextField *mobileTextField;
@property(nonatomic,strong)CMTextField *codeTextField;
@property(nonatomic,strong)VerCodeButton *verCodeButton;

@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UILabel *tipsBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWithRGB(255, 255, 255, 1);
    self.navView.backgroundColor = ColorWithRGB(255, 255, 255, 1);

    [self initSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        make.width.mas_equalTo(260);
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
        make.top.equalTo(self.mobileTextField.mas_top).offset(50);
        make.right.offset(-15);
        make.height.mas_equalTo(45);
        
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(50);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
    }];
    
    [self.tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.loginButton.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(220);
    }];
    
}
#pragma mark - onButtonAction
- (void)onloginButtonAction
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
    [self httpRequestLogin:mobile verifyCode:verifyCode];
}

- (void)onTipsBtnAction
{
    [Mobile telephone:@"4009009078"];
}

- (void)onRightButtonAction
{
    [[CMRouter sharedInstance]showViewController:@"SignupViewController" param:nil];
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
        if (mobile.length==0) {
            
            [[KKToast makeToast:@"手机号码不能为空"] show];
        }else
        {
            [[KKToast makeToast:@"请输入正确的手机号码"] show];

        }
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

- (void)httpRequestLogin:(NSString*)mobile
              verifyCode:(NSString*)verifyCode
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestLogin:mobile
                             verifyCode:verifyCode
                                success:^(NSDictionary *responseObject) {
                                    
                                    [KKProgressHUD hideMBProgressForView:self.view];
//                                    [self onRightButtonAction];
                                    [KeyChain setToken:responseObject[@"token"]];
                                    [KeyChain setMobileNo:mobile];
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
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.tipsBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = APPFONT(17);
    [rightBtn addTarget:self action:@selector(onRightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (UILabel *)lab1
{
    if (!_lab1) {
        
        _lab1 = [[UILabel alloc]init];
        _lab1.text = @"登录";
        _lab1.textColor = ColorWithRGB(51, 51, 51, 1);
        _lab1.font = APPFONT(34);
        
    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        
        _lab2 = [[UILabel alloc]init];
        NSAttributedString *item1 = [CMLinkTextViewItem attributeStringWithText:@"欢迎再次打开农丁掌柜" textFont:APPFONT(12) textColor:ColorWithRGB(153, 153, 153, 1)];
        _lab2.attributedText = item1;
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

- (UIButton *)loginButton
{
    if (_loginButton==nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton addTarget:self action:@selector(onloginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _loginButton.titleLabel.font = APPFONT(18);
        [_loginButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _loginButton;
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
