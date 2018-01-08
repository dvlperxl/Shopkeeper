//
//  StockManageTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockManageTableViewCell.h"

@interface StockManageTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIButton *payButton;
@property(nonatomic,strong)StockManageTableViewCellModel *model;

@end

@implementation StockManageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(StockManageTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.descLab.text = model.desc;
    self.amountLab.text = model.amount;
    
    self.payButton.hidden = YES;
    
    if (model.status.integerValue == 7) {
        
        self.payButton.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(19);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.amountLab.mas_left).offset(-5);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(42);
        make.height.mas_equalTo(15);
        
    }];
    

    
    if (self.model.status.integerValue == 7)
    {
        [self.amountLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-20);
            make.top.offset(13);
            make.height.mas_equalTo(19);
            make.width.mas_equalTo(150);
        }];
        
    }else
    {
        [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-20);
            make.height.mas_equalTo(19);
            make.width.mas_equalTo(150);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.bottom.offset(-13);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(80);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}

- (void)onPayButtonAction
{
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.payButton];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithHex(@"#333333");
        
    }
    return _titleLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(14);
        _descLab.textColor = ColorWithHex(@"#999999");
    }
    return _descLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPFONT(17);
        _amountLab.textColor = ColorWithHex(@"#f49900");
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.numberOfLines = 0;
    }
    return _amountLab;
}

- (UIButton *)payButton
{
    if (!_payButton) {
        
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState: UIControlStateNormal];
        [_payButton setTitleColor:ColorWithHex(@"#4A90E2") forState:UIControlStateNormal];
        _payButton.titleLabel.font = APPFONT(15);
        [_payButton addTarget:self action:@selector(onPayButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setBackgroundColor:ColorWithHex(@"#F9F8FC")];
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = 14;
        _payButton.layer.rasterizationScale = SCREEN_SCALE;
        _payButton.layer.shouldRasterize = YES;
        _payButton.enabled = NO;
    }
    return _payButton;
}

-(UIView *)line
{
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

@end

@implementation StockManageTableViewCellModel

@end
