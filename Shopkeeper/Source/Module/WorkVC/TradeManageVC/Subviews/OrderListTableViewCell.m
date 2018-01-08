//
//  OrderListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell ()

@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *orderIdLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIView  *lineView;
@property(nonatomic,weak)OrderListTableViewCellModel *model;

@end

@implementation OrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadData:(OrderListTableViewCellModel*)model
{
    self.model = model;
    self.nameLab.text = model.name;
    self.orderIdLab.text = model.order;
    self.amountLab.attributedText = model.amount;
    self.descLab.hidden = !model.isRefunds;
    [self layoutIfNeeded];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(18);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.orderIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.bottom.offset(-18);
        make.height.mas_equalTo(14);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(self.orderIdLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    if (self.model.isRefunds)
    {
        [self.amountLab mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.right.offset(-15);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.nameLab.mas_centerY);
        }];
        
        
    }else
    {
        [self.amountLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-15);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}


- (void)initSubviews
{
    [self addSubview:self.nameLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.orderIdLab];
    [self addSubview:self.descLab];
    [self addSubview:self.lineView];
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.text = @"退款额";
        _descLab.textAlignment = NSTextAlignmentRight;
        _descLab.font = APPFONT(14);
        _descLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _descLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = APPFONT(17);
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.textColor = ColorWithRGB(244, 153, 0, 1);
    }
    return _amountLab;
}

- (UILabel *)orderIdLab
{
    if (!_orderIdLab) {
        
        _orderIdLab = [[UILabel alloc]init];
        _orderIdLab.font = APPFONT(12);
        _orderIdLab.textColor = ColorWithRGB(153, 153, 153, 1);
        
    }
    return _orderIdLab;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = APPFONT(18);
        _nameLab.textColor = ColorWithRGB(51, 51, 51, 1);
    }
    
    return _nameLab;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _lineView;
}

@end

@implementation OrderListTableViewCellModel

@end
