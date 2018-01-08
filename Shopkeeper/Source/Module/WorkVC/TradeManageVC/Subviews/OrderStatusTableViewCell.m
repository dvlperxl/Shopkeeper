//
//  OrderStatusTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderStatusTableViewCell.h"

@interface OrderStatusTableViewCell()

@property(nonatomic,strong)UILabel *orderStatusLab;
@property(nonatomic,strong)UILabel *orderTimeLab;

@end

@implementation OrderStatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addSubview:self.orderStatusLab];
        [self addSubview:self.orderTimeLab];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = ColorWithRGB(255, 244, 225, 1);
    }
    return self;
}

- (void)reloadData:(OrderStatusTableViewCellModel*)model
{
    self.orderStatusLab.text = model.orderStatus;
    self.orderTimeLab.text = model.orderTime;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(16);
        make.height.mas_equalTo(34);
        
    }];
    
    [self.orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(56);
        make.height.mas_equalTo(15);
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)orderStatusLab
{
    if (!_orderStatusLab) {
        
        _orderStatusLab = [[UILabel alloc]init];
        _orderStatusLab.font = APPFONT(34);
        _orderStatusLab.textColor = ColorWithRGB(0, 0, 0, 1);
    }
    
    return _orderStatusLab;
}

- (UILabel *)orderTimeLab
{
    if (!_orderTimeLab) {
        
        _orderTimeLab = [[UILabel alloc]init];
        _orderTimeLab.font = APPFONT(12);
        _orderTimeLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _orderTimeLab;
}

@end


@implementation OrderStatusTableViewCellModel

@end

