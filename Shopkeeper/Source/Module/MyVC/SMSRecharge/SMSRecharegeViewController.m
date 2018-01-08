//
//  SMSRecharegeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRecharegeViewController.h"
#import "MallPayCompletionModel.h"


@interface SMSRecharegeViewController ()

@property (nonatomic,strong) MallPayCompletionModel *viewModel;
@property (nonatomic,strong) UIImageView *payStatusBg;
@property (nonatomic,strong) UIImageView *payStatusIcon;
@property (nonatomic,strong) UILabel *payStatustLabel;
@property (nonatomic,strong) UILabel *payToastLabel;
@property (nonatomic,strong) UILabel *payContentTitleLabel;
@property (nonatomic,strong) UILabel *payContentInfoLabel;
@property (nonatomic,strong) UILabel *payTypeTitleLabel;
@property (nonatomic,strong) UILabel *payTypeInfoLabel;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;


@end

@implementation SMSRecharegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self reloadUI];
    self.navView.backgroundColor = [UIColor clearColor];
    self.backBtn.hidden = YES;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)setupUI {
    [self.payStatusBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(self.payStatusBg.mas_width).multipliedBy(0.72);
    }];
    [self.payStatusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.centerY.mas_equalTo(self.payStatusBg);
        make.width.height.mas_equalTo(44);
    }];
    [self.payStatustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(76);
        make.centerY.mas_equalTo(self.payStatusIcon);
    }];
    [self.payToastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payStatustLabel.mas_left);
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(self.payStatustLabel.mas_bottom).with.offset(10);
    }];
    [self.payContentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.top.equalTo(self.payStatusBg.mas_bottom).with.offset(30);
    }];
    [self.payContentInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-60);
        make.centerY.mas_equalTo(self.payContentTitleLabel);
    }];
    [self.payTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payContentTitleLabel.mas_left);
        make.top.equalTo(self.payContentTitleLabel.mas_bottom).with.offset(20);
    }];
    [self.payTypeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payContentInfoLabel.mas_right);
        make.centerY.mas_equalTo(self.payTypeTitleLabel);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeTitleLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeTitleLabel.mas_bottom).with.offset(50+60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
    }];
}

- (void)reloadUI {
    
    self.viewModel.payCompletionType = [self.payCompletionType integerValue];
    
    self.payStatusBg.image = self.viewModel.payStatusBg;
    self.payStatusIcon.image = self.viewModel.payStatusIcon;
    self.payStatustLabel.text = self.viewModel.payStatus;
    self.payToastLabel.attributedText = self.viewModel.payToast;
    self.payContentTitleLabel.text = self.viewModel.payContentTitle;
    self.payContentInfoLabel.text = self.content;
    self.payTypeTitleLabel.text = self.viewModel.payTypeTitle;
    self.payTypeInfoLabel.text = self.viewModel.payTypeInfo;
    
    NSString *btnT = @"重新支付";
    
    if (self.payCompletionType.integerValue == 0) {
        btnT = @"返回";
        self.rightBtn.hidden = YES;
    }
    [self.leftBtn setTitle:btnT forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"暂不充值" forState:UIControlStateNormal];

}
// 暂不支付
- (void)notPay {
    
    NSMutableDictionary *callBack = @{}.mutableCopy;
    [callBack setObject:@"repay" forKey:@"actionName"];
    [[CMRouter sharedInstance]backToViewController:@"SMSRechargeViewController" param:@{@"callBack":callBack} animation:NO];
    
}
// 重新支付
- (void)rePay {
    
    [[CMRouter sharedInstance]popViewController];

    
}
// 继续开单
- (void)continueMergeWholesaleRetail
{
    [[CMRouter sharedInstance]popViewController];

}
//// 查看订单
//- (void)lookOrder
//{
//    self.present = NO;
//    NSMutableDictionary *callBack = @{}.mutableCopy;
//    [callBack setObject:@"queryMallOrderList" forKey:@"actionName"];
//    [callBack setObject:@2 forKey:@"orderStatus"];
//    [[CMRouter sharedInstance]backToViewController:@"StockManageViewController" param:@{@"callBack":callBack} animation:YES];
//}
#pragma mark - event
- (void)btnClick:(UIButton *)button {
    MallPayCompletionVCType type = [self.payCompletionType integerValue];
    if (button == self.leftBtn) {
        if (type == MallPayCompletionVCTypeSuccess) {
            [self continueMergeWholesaleRetail];
        } else if (type == MallPayCompletionVCTypeFailure) {
            [self notPay];
        }
    } else if (button == self.rightBtn) {
        if (type == MallPayCompletionVCTypeSuccess) {
//            [self lookOrder];
        } else if (type == MallPayCompletionVCTypeFailure) {
            [self rePay];
        }
    }
}
#pragma mark - getter
- (MallPayCompletionModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MallPayCompletionModel alloc]init];
    }
    return _viewModel;
}
- (UIImageView *)payStatusBg {
    if (!_payStatusBg) {
        _payStatusBg = [[UIImageView alloc]init];
        [self.view addSubview:_payStatusBg];
    }
    return _payStatusBg;
}
- (UIImageView *)payStatusIcon {
    if (!_payStatusIcon) {
        _payStatusIcon = [[UIImageView alloc]init];
        [self.view addSubview:_payStatusIcon];
    }
    return _payStatusIcon;
}
- (UILabel *)payStatustLabel {
    if (!_payStatustLabel) {
        _payStatustLabel = [[UILabel alloc]init];
        _payStatustLabel.textColor = [UIColor colorWithHexString:@"#3F1F0F"];
        _payStatustLabel.font = APPFONT(34);
        [self.view addSubview:_payStatustLabel];
    }
    return _payStatustLabel;
}
- (UILabel *)payToastLabel {
    if (!_payToastLabel) {
        _payToastLabel = [[UILabel alloc]init];
        _payToastLabel.numberOfLines = 3;
        _payToastLabel.textColor = [UIColor colorWithHexString:@"#3F1F0F"];
        _payToastLabel.font = APPFONT(13);
        [self.view addSubview:_payToastLabel];
    }
    return _payToastLabel;
}
- (UILabel *)payContentTitleLabel {
    if (!_payContentTitleLabel) {
        _payContentTitleLabel = [self selfInitLabel];
    }
    return _payContentTitleLabel;
}
- (UILabel *)payContentInfoLabel {
    if (!_payContentInfoLabel) {
        _payContentInfoLabel = [self selfInitLabel];
        _payContentInfoLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payContentInfoLabel;
}
- (UILabel *)payTypeTitleLabel {
    if (!_payTypeTitleLabel) {
        _payTypeTitleLabel = [self selfInitLabel];
    }
    return _payTypeTitleLabel;
}
- (UILabel *)payTypeInfoLabel {
    if (!_payTypeInfoLabel) {
        _payTypeInfoLabel = [self selfInitLabel];
        _payTypeInfoLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payTypeInfoLabel;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [self selfInitButton];
        [_leftBtn setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [self selfInitButton];
        [_rightBtn setTitleColor:ColorWithHex(@"#F39700") forState:UIControlStateNormal];
    }
    return _rightBtn;
}
- (UILabel *)selfInitLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = APPFONT(17);
    [self.view addSubview:label];
    return label;
}
- (UIButton *)selfInitButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#F29700"]] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#EBEBEB"]] forState:UIControlStateDisabled];
//    btn.layer.cornerRadius = 20.0f;
//    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}


@end
