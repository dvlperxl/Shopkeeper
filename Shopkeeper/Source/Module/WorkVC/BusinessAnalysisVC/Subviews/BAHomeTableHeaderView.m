//
//  BAHomeTableHeaderView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BAHomeTableHeaderView.h"
#import "NSDate+DateFormatter.h"
#import "UIButton+Extensions.h"

@interface BAHomeTableHeaderView ()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *dateTimeLab;

@property(nonatomic,strong)UILabel *salesTitleLab;//销售额
@property(nonatomic,strong)UILabel *salesContentLab;

@property(nonatomic,strong)UILabel *creditTitleLab;//赊销额
@property(nonatomic,strong)UILabel *creditContentLab;


@property(nonatomic,strong)UILabel *monthSalesTitleLab;//月销售额
@property(nonatomic,strong)UILabel *monthSalesContentLab;

@property(nonatomic,strong)UILabel *monthProfitTitleLab;//月利润
@property(nonatomic,strong)UILabel *monthProfitContentLab;

@property(nonatomic,strong)UILabel *monthCreditTitleLab;//月赊销
@property(nonatomic,strong)UILabel *monthCreditContentLab;

@property(nonatomic,strong)UIButton *helpButton;


@end


@implementation BAHomeTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(BAHomeTableHeaderViewModel*)model
{
    self.salesContentLab.text = STRING(@"¥", model.todayamount);
    self.creditContentLab.text = STRING(@"¥", model.todayCreditAmount);
    self.monthSalesContentLab.text = STRING(@"¥", model.currMonthFinalAmount);
    self.monthProfitContentLab.text = STRING(@"¥", model.monthProfit);
    self.monthCreditContentLab.text = STRING(@"¥", model.currMonthCreditAmount);
}

- (void)onHelpButtonAction
{
    KKAlertAction *action = [KKAlertAction alertActionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
        
    }];
    
    NSString *title = @"1、快捷订单不计算在内；\n 2、月利润=当月当前为止（所有待送货或已收货订单金额总和-所有待送货或已收货订单商品成本总和-（退货订单金额-该退货订单商品成本总和））；\n3、还款和赊账都不影响当日利润；\n4、如果商品没有进货价，默认为该商品销售价处理。";
    
    [KKAlertView showAlertActionViewWithTitle:title actions:@[action]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
    
    [self.dateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(22);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.salesTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.offset(67);
        make.height.mas_equalTo(28);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);

    }];
    
    [self.salesContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.top.offset(96);
        make.height.mas_equalTo(28);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
    [self.creditTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.top.offset(67);
        make.height.mas_equalTo(28);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
    [self.creditContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.top.offset(96);
        make.height.mas_equalTo(28);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    
    [self.monthSalesTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.bottom.offset(-39);
        make.height.mas_equalTo(17);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3);
    }];
    
    
    [self.monthSalesContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.bottom.offset(-16);
        make.height.mas_equalTo(22);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3);
    }];
    
    [self.monthProfitTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(-39);
        make.height.mas_equalTo(17);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    [self.monthProfitContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(-16);
        make.height.mas_equalTo(22);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3);
        make.centerX.equalTo(self.mas_centerX);

    }];
    
    
    [self.monthCreditTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.bottom.offset(-39);
        make.height.mas_equalTo(17);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3);
        
    }];
    
    
    [self.monthCreditContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.bottom.offset(-16);
        make.height.mas_equalTo(22);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3);
    }];

    
    [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.monthProfitTitleLab.mas_right).offset(5);
        make.centerY.equalTo(self.monthProfitTitleLab.mas_centerY);
        make.width.height.mas_equalTo(12);
        
    }];
}

- (void)initSubviews
{
    [self addSubview:self.bgImageView];
    [self addSubview:self.dateTimeLab];
    [self addSubview:self.salesTitleLab];
    [self addSubview:self.salesContentLab];
    [self addSubview:self.creditTitleLab];
    [self addSubview:self.creditContentLab];
    
    [self addSubview:self.monthSalesTitleLab];
    [self addSubview:self.monthSalesContentLab];
    
    [self addSubview:self.monthProfitTitleLab];
    [self addSubview:self.monthProfitContentLab];
    
    [self addSubview:self.monthCreditTitleLab];
    [self addSubview:self.monthCreditContentLab];
    [self addSubview:self.helpButton];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc]initWithImage:Image(@"analysis_display_bg")];
        _bgImageView.contentMode =  UIViewContentModeScaleAspectFill;
        
    }
    return _bgImageView;
}

- (UILabel *)dateTimeLab
{
    if (!_dateTimeLab)
    {
        _dateTimeLab = [[UILabel alloc]init];
        _dateTimeLab.textAlignment = NSTextAlignmentCenter;
        _dateTimeLab.textColor = [UIColor whiteColor];
        _dateTimeLab.font = APPFONT(12);
        _dateTimeLab.layer.masksToBounds = YES;
        _dateTimeLab.layer.cornerRadius = 11;
        _dateTimeLab.backgroundColor = ColorWithRGB(51, 51, 51, 0.15);
        NSString *date = [[NSDate date]stringWithDateFormatter:TODAY_YYYY_M_D];
        _dateTimeLab.text = [NSString stringWithFormat:@"今天 %@",date];
    }
    
    return _dateTimeLab;
}

- (UILabel *)salesTitleLab
{
    if (!_salesTitleLab) {
        
        _salesTitleLab = [[UILabel alloc]init];
        _salesTitleLab.textAlignment = NSTextAlignmentCenter;
        _salesTitleLab.text = @"销售额";
        _salesTitleLab.font = APPFONT(12);
        _salesTitleLab.textColor = [UIColor whiteColor];
    }
    return _salesTitleLab;
}

- (UILabel *)salesContentLab
{
    if (!_salesContentLab) {
        
        _salesContentLab = [[UILabel alloc]init];
        _salesContentLab.textAlignment = NSTextAlignmentCenter;
        _salesContentLab.text = @"0.00";
        _salesContentLab.font = APPFONT(24);
        _salesContentLab.textColor = [UIColor whiteColor];
    }
    return _salesContentLab;
}

- (UILabel *)creditTitleLab
{
    if (!_creditTitleLab) {
        
        _creditTitleLab = [[UILabel alloc]init];
        _creditTitleLab.textAlignment = NSTextAlignmentCenter;
        _creditTitleLab.text = @"赊销额";
        _creditTitleLab.font = APPFONT(12);
        _creditTitleLab.textColor = [UIColor whiteColor];
    }
    return _creditTitleLab;
}

- (UILabel *)creditContentLab
{
    if (!_creditContentLab) {
        
        _creditContentLab = [[UILabel alloc]init];
        _creditContentLab.textAlignment = NSTextAlignmentCenter;
        _creditContentLab.text = @"0.00";
        _creditContentLab.font = APPFONT(24);
        _creditContentLab.textColor = [UIColor whiteColor];
    }
    return _creditContentLab;
}

- (UILabel *)monthSalesTitleLab
{
    if (!_monthSalesTitleLab) {
        
        _monthSalesTitleLab = [[UILabel alloc]init];
        _monthSalesTitleLab.textAlignment = NSTextAlignmentCenter;
        _monthSalesTitleLab.text = @"月销售额";
        _monthSalesTitleLab.font = APPFONT(12);
        _monthSalesTitleLab.textColor = [UIColor whiteColor];
    }
    return _monthSalesTitleLab;
}

- (UILabel *)monthSalesContentLab
{
    if (!_monthSalesContentLab) {
        
        _monthSalesContentLab = [[UILabel alloc]init];
        _monthSalesContentLab.textAlignment = NSTextAlignmentCenter;
        _monthSalesContentLab.text = @"0.00";
        _monthSalesContentLab.font = APPFONT(18);
        _monthSalesContentLab.textColor = [UIColor whiteColor];
    }
    return _monthSalesContentLab;
}

- (UILabel *)monthProfitTitleLab
{
    if (!_monthProfitTitleLab) {
        
        _monthProfitTitleLab = [[UILabel alloc]init];
        _monthProfitTitleLab.textAlignment = NSTextAlignmentCenter;
        _monthProfitTitleLab.text = @"月利润";
        _monthProfitTitleLab.font = APPFONT(12);
        _monthProfitTitleLab.textColor = [UIColor whiteColor];
    }
    return _monthProfitTitleLab;
}

- (UILabel *)monthProfitContentLab
{
    if (!_monthProfitContentLab) {
        
        _monthProfitContentLab = [[UILabel alloc]init];
        _monthProfitContentLab.textAlignment = NSTextAlignmentCenter;
        _monthProfitContentLab.text = @"0.00";
        _monthProfitContentLab.font = APPFONT(18);
        _monthProfitContentLab.textColor = [UIColor whiteColor];
    }
    return _monthProfitContentLab;
}

- (UILabel *)monthCreditTitleLab
{
    if (!_monthCreditTitleLab) {
        
        _monthCreditTitleLab = [[UILabel alloc]init];
        _monthCreditTitleLab.textAlignment = NSTextAlignmentCenter;
        _monthCreditTitleLab.text = @"月赊销额";
        _monthCreditTitleLab.font = APPFONT(12);
        _monthCreditTitleLab.textColor = [UIColor whiteColor];
    }
    return _monthCreditTitleLab;
}

- (UILabel *)monthCreditContentLab
{
    if (!_monthCreditContentLab) {
        
        _monthCreditContentLab = [[UILabel alloc]init];
        _monthCreditContentLab.textAlignment = NSTextAlignmentCenter;
        _monthCreditContentLab.text = @"0.00";
        _monthCreditContentLab.font = APPFONT(18);
        _monthCreditContentLab.textColor = [UIColor whiteColor];
    }
    return _monthCreditContentLab;
}

- (UIButton*)helpButton
{
    if (!_helpButton) {
        
        _helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_helpButton setImage:Image(@"nav_icon_faq_white") forState:UIControlStateNormal];
        [_helpButton addTarget:self action:@selector(onHelpButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _helpButton.hitTestEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5);
        
    }
    return _helpButton;
}

@end

@implementation BAHomeTableHeaderViewModel

@end
