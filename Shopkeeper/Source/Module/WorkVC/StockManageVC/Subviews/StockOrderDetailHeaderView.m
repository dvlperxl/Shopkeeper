//
//  StockOrderDetailHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockOrderDetailHeaderView.h"

@interface StockOrderDetailHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *bgShadowView;
@property(nonatomic,strong)UIView *whiteView;

@property(nonatomic,strong)UILabel *contactLab;
@property(nonatomic,strong)UILabel *orderTimeLab;
@property(nonatomic,strong)UILabel *orderNoLab;
@property(nonatomic,strong)UILabel *contactContentLab;
@property(nonatomic,strong)UILabel *orderTimeContentLab;
@property(nonatomic,strong)UILabel *orderNoContentLab;

@property(nonatomic,strong)UILabel *orderStatusLab;
@property(nonatomic,strong)UILabel *orderStatusContentLab;

@end

@implementation StockOrderDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(StockOrderDetailHeaderViewModel*)model
{
    self.titleLab.text = model.title;
    self.contactContentLab.text = model.mobile;
    self.orderTimeContentLab.text = model.orderTime;
    self.orderNoContentLab.text = model.orderNo;
    self.orderStatusContentLab.text = model.orderStatus;
 
}

- (void)reloadDataMallOrderdetail:(NSDictionary*)orderDetail
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(5);
        make.right.offset(-5);
        make.top.offset(20);
        make.height.mas_equalTo(50);
        
    }];
    
    [self.bgShadowView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.height.equalTo(@120);

    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.height.equalTo(@120);
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.contactLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.top.offset(15);
        make.height.mas_equalTo(16);
    }];
    
    [self.contactContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(95);
        make.top.offset(15);
        make.height.mas_equalTo(16);
    }];
    
    
    [self.orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.top.equalTo(self.contactLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
    [self.orderTimeContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(95);
        make.top.equalTo(self.contactLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
    [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.top.equalTo(self.orderTimeLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
    [self.orderNoContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(95);
        make.top.equalTo(self.orderTimeLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
    [self.orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.top.equalTo(self.orderNoLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
    [self.orderStatusContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(95);
        make.top.equalTo(self.orderNoLab.mas_bottom).offset(9);
        make.height.mas_equalTo(16);
    }];
    
}

- (void)initSubviews
{
    self.backgroundColor = ColorWithHex(@"#FFF4E1");
    [self addSubview:self.titleLab];
    [self addSubview:self.whiteView];
    [self addSubview:self.bgShadowView];
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.contactLab];
    [self.bgView addSubview:self.contactContentLab];
    
    [self.bgView addSubview:self.orderTimeLab];
    [self.bgView addSubview:self.orderTimeContentLab];
    
    [self.bgView addSubview:self.orderNoLab];
    [self.bgView addSubview:self.orderNoContentLab];
    
    [self.bgView addSubview:self.orderStatusLab];
    [self.bgView addSubview:self.orderStatusContentLab];
}

- (UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(34);
        _titleLab.textColor = ColorWithHex(@"#000000");
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}


- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = ColorWithHex(@"#ffffff");
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
//        _bgView.layer.shouldRasterize = YES;
    }
    return _bgView;
}

- (UIView *)bgShadowView
{
    if (!_bgShadowView) {

        _bgShadowView = [[UIView alloc]init];
        CALayer *subLayer=_bgShadowView.layer;
        subLayer.cornerRadius=5;
        subLayer.backgroundColor=[UIColor whiteColor].CGColor;
        subLayer.masksToBounds=NO;
        subLayer.shadowColor=ColorWithRGB(0, 0, 0, 0.12).CGColor;
        subLayer.shadowOffset=CGSizeMake(0,2);
        subLayer.shadowOpacity=1;
        subLayer.shadowRadius=5;
    }
    return _bgShadowView;
}


- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = ColorWithHex(@"#ffffff");
    }
    return _whiteView;
}

- (UILabel *)contactLab
{
    if (!_contactLab) {
        _contactLab = [[UILabel alloc]init];
        _contactLab.text = @"联系方式";
        _contactLab.font = APPFONT(15);
        _contactLab.textColor = ColorWithHex(@"#999999");
    }
    return _contactLab;
}

-(UILabel *)contactContentLab
{
    if (!_contactContentLab) {

        _contactContentLab = [[UILabel alloc]init];
        _contactContentLab.font = APPFONT(15);
        _contactContentLab.textColor = ColorWithHex(@"#333333");
    }
    return _contactContentLab;
}

- (UILabel *)orderTimeLab
{
    if (!_orderTimeLab) {
        _orderTimeLab = [[UILabel alloc]init];
        _orderTimeLab.text = @"下单时间";
        _orderTimeLab.font = APPFONT(15);
        _orderTimeLab.textColor = ColorWithHex(@"#999999");
    }
    return _orderTimeLab;
}

-(UILabel *)orderTimeContentLab
{
    if (!_orderTimeContentLab) {
        _orderTimeContentLab = [[UILabel alloc]init];
        _orderTimeContentLab.font = APPFONT(15);
        _orderTimeContentLab.textColor = ColorWithHex(@"#333333");
    }
    return _orderTimeContentLab;
}

- (UILabel *)orderNoLab
{
    if (!_orderNoLab) {
        _orderNoLab = [[UILabel alloc]init];
        _orderNoLab.text = @"订单号";
        _orderNoLab.font = APPFONT(15);
        _orderNoLab.textColor = ColorWithHex(@"#999999");
    }
    return _orderNoLab;
}

-(UILabel *)orderNoContentLab
{
    if (!_orderNoContentLab) {
        _orderNoContentLab = [[UILabel alloc]init];
        _orderNoContentLab.font = APPFONT(15);
        _orderNoContentLab.textColor = ColorWithHex(@"#333333");
    }
    return _orderNoContentLab;
}

- (UILabel *)orderStatusLab
{
    if (!_orderStatusLab) {
        _orderStatusLab = [[UILabel alloc]init];
        _orderStatusLab.text = @"订单状态";
        _orderStatusLab.font = APPFONT(15);
        _orderStatusLab.textColor = ColorWithHex(@"#999999");
    }
    return _orderStatusLab;
}

-(UILabel *)orderStatusContentLab
{
    if (!_orderStatusContentLab) {
        _orderStatusContentLab = [[UILabel alloc]init];
        _orderStatusContentLab.font = APPFONT(15);
        _orderStatusContentLab.textColor = ColorWithHex(@"#F29700");
    }
    return _orderStatusContentLab;
}


@end

@implementation StockOrderDetailHeaderViewModel

@end
