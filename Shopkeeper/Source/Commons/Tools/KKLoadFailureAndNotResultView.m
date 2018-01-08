//
//  KKLoadFailureAndNotResultView.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/12.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

NSString *const Default_comingsoon = @"default_comingsoon";//敬请期待
NSString *const Default_networkerror = @"default_networkerror";//无网络
NSString *const Default_noassistant = @"default_noassistant";//无门店
NSString *const Default_nocontent = @"default_nocontent";//购物车优惠券奖品无内容
NSString *const Default_nodata = @"default_nodata";// 无数据、公告 会员 订单
NSString *const Default_noproduct = @"default_noproduct";//无商品
NSString *const Default_noresult = @"default_noresult";//搜索无结果
NSString *const Default_notable = @"default_notable";//图标无数据
NSString *const Default_pageerror = @"default_pageerror";//404 default_contactsetting
NSString *const Default_contactsetting = @"default_contactsetting";//通讯录授权

#import "KKLoadFailureAndNotResultView.h"

@interface KKLoadFailureAndNotResultView ()
@property(strong,nonatomic)UIImageView * imageView;
@property(strong,nonatomic)UILabel * titleLab;
@property(strong,nonatomic)UILabel * descLab;

@property(strong,nonatomic)UITapGestureRecognizer* tap;
@property(nonatomic)KKLoadFailureAndNotResultViewTapBloack tapBlock;
@property(nonatomic,strong)UIButton *reloadButton;

@end

@implementation KKLoadFailureAndNotResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat navMaxY = rectOfStatusbar.size.height+44;
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0,navMaxY , SCREEN_WIDTH, SCREEN_HEIGHT-navMaxY);
    if (self) {
        self.backgroundColor=ColorWithHex(@"#ffffff");
        [self initSubview];
    }
    return self;
}


+ (instancetype)noResultViewWithDesc:(NSString*)desc frame:(CGRect)frame
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
    if (frame.size.height>0) {
        aView.frame = frame;
    }
    aView.imageView.image = [UIImage imageNamed:@"default_noassistant"];
    aView.titleLab.text = desc;
    return aView;
}

+(instancetype)noResultViewWithTitle:(NSString *)title desc:(NSString*)desc
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
    aView.imageView.image = [UIImage imageNamed:@"default_noassistant"];
    aView.titleLab.text = title;
    aView.descLab.text = desc;
    return aView;
}

+ (instancetype)noResultViewWithImageName:(NSString *)imageName;
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
    [aView reloadDataWithImageName:imageName];
    return aView;
}

- (void)reloadDataWithImageName:(NSString*)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
    NSDictionary *content = [self contentData:imageName];
    self.titleLab.text = content[@"title"];
    self.descLab.text = content[@"desc"];
}

- (void)reloadDataWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc
{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.titleLab.text = title;
    self.descLab.text = desc;
}

+ (instancetype)loadFailViewWithErrorCode:(NSInteger)errorCode
                                 tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]initWithFrame:CGRectZero];
    if (errorCode == -1009) {
        [aView reloadDataWithImageName:Default_networkerror];
    }else{
        [aView reloadDataWithImageName:Default_pageerror];
    }
    [aView addSubview:aView.reloadButton];
    [aView.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(aView.mas_centerX);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
        make.top.equalTo(aView.titleLab.mas_bottom).offset(38);
    }];
    
    aView.tapBlock = tapBlock;

    return aView;
}

+ (instancetype)loadFailViewWithTapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
    [aView reloadDataWithImageName:Default_networkerror];
    [aView addSubview:aView.reloadButton];
    [aView.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(aView.mas_centerX);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
        make.top.equalTo(aView.titleLab.mas_bottom).offset(60);
    }];
    aView.tapBlock = tapBlock;
    return aView;
}

+(instancetype)loadFailViewWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc btnTitle:(NSString*)btnTitle  tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock
{
    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
//    [aView reloadDataWithImageName:imageName];
    [aView reloadDataWithImageName:imageName title:title desc:desc];
    [aView.reloadButton setTitle:btnTitle forState:UIControlStateNormal];
    [aView addSubview:aView.reloadButton];
    [aView.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(aView.mas_centerX);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(300);
        make.top.equalTo(aView.descLab.mas_bottom).offset(30);
    }];
    
    
    aView.tapBlock = tapBlock;
    return aView;
    
}

+(instancetype)loadFailViewWithFrame:(CGRect)frame
                           errorCode:(NSInteger)errorCode
                            tapBlock:(KKLoadFailureAndNotResultViewTapBloack)tapBlock{

    KKLoadFailureAndNotResultView *aView = [[KKLoadFailureAndNotResultView alloc]init];
    if (frame.size.height>0) {
        aView.frame = frame;
    }
    if (errorCode == -1009) {
        aView.imageView.image = [UIImage imageNamed:@"wifi_error"];
        aView.titleLab.text = @"未连接到网络\n建议您检查网络设置";
    }else{
        aView.imageView.image = [UIImage imageNamed:@"system_error"];
        aView.titleLab.text = @"挂了，系统有点小情绪\n没吐出什么信息";
        
    }
    aView.tapBlock = tapBlock;
    return aView;
}

- (void)onTapAction
{
    if (self.tapBlock) {
        self.tapBlock();
        [self removeFromSuperview];
    }
}

- (void)onReloadButtonAction
{
    if (self.tapBlock) {
        self.tapBlock();
        [self removeFromSuperview];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(50);
        make.width.mas_equalTo(195);
        make.height.mas_equalTo(150);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.centerX.equalTo(self.mas_centerX);
//        make.height.mas_equalTo(42);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
//        make.height.mas_equalTo(28);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
}

-(void)initSubview{
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    
}

-(UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
    }
    return _imageView;
}

-(UITapGestureRecognizer *)tap{
    
    if (!_tap) {
        
        _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction)];
    }
    return _tap;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=APPFONT(18);
        _titleLab.textColor=ColorWithHex(@"#666666");
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

-(UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab=[[UILabel alloc]init];
        _descLab.font=APPFONT(15);
        _descLab.textColor=ColorWithHex(@"#999999");
        _descLab.textAlignment = NSTextAlignmentCenter;
        _descLab.numberOfLines = 0;
    }
    return _descLab;
}

- (UIButton *)reloadButton
{
    if (!_reloadButton) {
        
        _reloadButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadButton addTarget:self action:@selector(onReloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_reloadButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _reloadButton.titleLabel.font = APPFONT(18);
        [_reloadButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _reloadButton;
}

- (NSDictionary*)contentData:(NSString*)imageName
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"imageName = %@",imageName];
    
    NSArray *messageList = @[
                             @{@"title":@"什么都没有",@"desc":@"去其他地方看看吧",@"imageName":Default_nodata},
                             @{@"title":@"没有找到相关内容",@"desc":@"换个关键词试试",@"imageName":Default_noresult},
                             @{@"title":@"糟糕，页面出错了",@"desc":@"",@"imageName":Default_pageerror},
                             @{@"title":@"网络不可用，网络加载失败",@"desc":@"请检查是否连接了WiFi或数据网络",@"imageName":Default_networkerror},
                             @{@"title":@"允许农丁掌柜访问你的\n手机通讯录",@"desc":@"",@"imageName":Default_contactsetting},
                             @{@"title":@"您还没有处方套餐～",@"desc":@"",@"imageName":Default_noproduct},
                             ];
    
    NSArray *result = [messageList filteredArrayUsingPredicate:pred];
    if (result.count>0)
    {
        return result.firstObject;
    }
    
    return messageList.firstObject;
}

@end
