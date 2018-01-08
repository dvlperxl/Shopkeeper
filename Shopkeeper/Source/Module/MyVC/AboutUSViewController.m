//
//  AboutUSViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *appNameLab;
@property(nonatomic,strong)UILabel *versionLab;
@property(nonatomic,strong)UILabel *contentLab;

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于我们";
    [self setBackBtnTitle:@"我的"];
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.offset(self.navBarHeight);
        make.width.equalTo(self.view.mas_width);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(108);
        make.top.equalTo(self.bgImageView.mas_bottom).offset(-35);
    }];
    
    [self.appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(25);

    }];
    
    [self.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.appNameLab.mas_bottom).offset(5);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(97);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.versionLab.mas_bottom).offset(15);
        make.left.offset(20);
        make.right.offset(-20);
        
    }];
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.appNameLab];
    [self.view addSubview:self.versionLab];
    [self.view addSubview:self.contentLab];
}


- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc]initWithImage:Image(@"aboutus_bk")];
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

-(UILabel *)appNameLab
{
    if (!_appNameLab) {
        
        _appNameLab = [[UILabel alloc]init];
        _appNameLab.text = @"农丁掌柜";
        _appNameLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _appNameLab.font = APPFONT(18);
        _appNameLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _appNameLab;
}

-(UILabel *)versionLab
{
    if (!_versionLab) {
        
        _versionLab = [[UILabel alloc]init];
        _versionLab.textAlignment = NSTextAlignmentCenter;
        _versionLab.font = APPFONT(12);
        _versionLab.textColor = ColorWithRGB(51, 51, 51, 1);
        
        NSString *buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        if ([[AppConfig share] test])
        {
            _versionLab.text = STRING(@"v", buildVersion);

        }else
        {
            _versionLab.text = STRING(@"v", APP_SHORT_VERSION);
        }

        
        _versionLab.layer.masksToBounds = YES;
        _versionLab.layer.cornerRadius = 12;
        _versionLab.layer.borderWidth = 1;
        _versionLab.layer.borderColor = ColorWithRGB(235, 235, 235, 1).CGColor;
        
    }
    return _versionLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab  = [[UILabel alloc]init];
        _contentLab.numberOfLines = 0;
        
        CMLinkTextViewItem *item = [[CMLinkTextViewItem alloc]init];
        item.textColor = ColorWithRGB(51, 51, 51, 1);
        item.textFont = APPFONT(18);
        item.lineSpacing = 5;
        item.textContent = @"      农丁掌柜由上海合农网络科技有限公司出品，是国内领先的现代农资渠道连锁互联网服务商；农丁掌柜致力于帮助百万农资门店更好地拿到货、更好地卖出货，为农资门店提供POS收银、会员营销管理、金融、农产品、农技等综合服务。";
        _contentLab.attributedText = [item attributeStringNormal];
    }
    
    return _contentLab;
}

@end
