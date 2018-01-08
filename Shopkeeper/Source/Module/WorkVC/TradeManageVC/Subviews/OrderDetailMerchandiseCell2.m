//
//  OrderDetailMerchandiseCell2.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailMerchandiseCell2.h"


@interface OrderDetailMerchandiseSubview : UIView

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;

@end

@implementation OrderDetailMerchandiseSubview

- (instancetype)init
{
    if (self = [super init]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.contentLab];
        
    }
    return self;
}

- (void)reloadData:(OrderDetailMerchandiseSubviewModel*)model
{
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-110);
        make.top.offset(0);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLab.mas_right).offset(5);
        make.right.offset(-15);
        make.top.offset(0);
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(15);
        _titleLab.textColor = ColorWithHex(@"333333");
        _titleLab.numberOfLines = 0;
        
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = APPFONT(15);
        _contentLab.textColor = ColorWithHex(@"999999");
        _contentLab.textAlignment = NSTextAlignmentRight;
    }
    return _contentLab;
}

@end


@interface OrderDetailMerchandiseCell2 ()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *preLab;
@property(nonatomic,strong)UIButton *openButton;
@property(nonatomic,strong)UIView *bgLineView;
@property(nonatomic,strong)UIView  *lineView;
@property(nonatomic,strong)NSMutableArray<OrderDetailMerchandiseSubview *> *subViewList;
@property(nonatomic,strong)OrderDetailMerchandiseCell2Model *model;

@end

@implementation OrderDetailMerchandiseCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)createPreViewCount:(NSInteger)count
{
    for (NSInteger i = 0; i<count; i++) {
        
        OrderDetailMerchandiseSubview *view = [[OrderDetailMerchandiseSubview alloc]init];
        
        [self.bgView addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(30);
            make.top.offset(50);
        }];
        [self.subViewList addObject:view];
    }

}

- (void)reloadData:(OrderDetailMerchandiseCell2Model*)model
{
    _model = model;
    
    if (model.preList.count>self.subViewList.count)
    {
        [self createPreViewCount:model.preList.count-self.subViewList.count];
    }
    
    self.bgLineView.hidden = !model.open;
    CGFloat y = 56;
    CGFloat space = 13;
    
    NSString *openButtonTitle = model.open?@"点击收起":@"点击展开";
    [self.openButton setTitle:openButtonTitle forState:UIControlStateNormal];
    
    for (NSInteger i = 0;i<self.subViewList.count ; i++)
    {
        OrderDetailMerchandiseSubview *view = self.subViewList[i];

        if (model.open == NO)
        {
            view.hidden = YES;
            
        }else
        {
            if (i<model.preList.count)
            {
                view.hidden = NO;
                
                OrderDetailMerchandiseSubviewModel *data = model.preList[i];
                
                [view reloadData:data];
                
                [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.offset(0);
                    make.right.offset(0);
                    make.height.offset(data.height);
                    make.top.offset(y);
                }];
                y+=data.height;
                y+=space;
                
            }else
            {
                view.hidden = YES;
            }
        }

    }
}

- (void)onOpenButtonAction
{
    if ([self.delegate respondsToSelector:@selector(orderDetailMerchandiseCell2:didSelectOpenButton: retailId:)])
    {
        [self.delegate orderDetailMerchandiseCell2:self didSelectOpenButton:!_model.open retailId:_model.retailId];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(10);
        make.top.offset(0);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
    
    [self.preLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.height.offset(18);
        make.top.offset(11);

    }];
    
    [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.height.offset(40);
        make.centerY.equalTo(self.preLab.mas_centerY);
        
    }];
    
    [self.bgLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(40);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.preLab];
    [self.bgView addSubview:self.openButton];
    [self.bgView addSubview:self.bgLineView];
    [self addSubview:self.lineView];
}



-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = ColorWithRGB(249, 248, 252, 1);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 4;
    }
    return _bgView;
}

- (UILabel *)preLab
{
    if (!_preLab) {
        
        _preLab = [[UILabel alloc]init];
        _preLab.text = @"处方商品清单";
        _preLab.textColor = ColorWithHex(@"#999999");
        _preLab.font = APPFONT(17);
    }
    return _preLab;
}

- (UIButton *)openButton
{
    if (!_openButton) {
        
        _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openButton setTitle:@"点击展开" forState:UIControlStateNormal];
        [_openButton setTitleColor:ColorWithHex(@"#4A90E2") forState:UIControlStateNormal];
        _openButton.titleLabel.font = APPFONT(15);
        [_openButton addTarget:self action:@selector(onOpenButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _openButton;
}

- (UIView *)bgLineView
{
    if(!_bgLineView)
    {
        _bgLineView = [[UIView alloc]init];
        _bgLineView.backgroundColor = ColorWithHex(@"ebebeb");
    }
    
    return _bgLineView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _lineView;
}

- (NSMutableArray<OrderDetailMerchandiseSubview *> *)subViewList
{
    if (!_subViewList) {
        
        _subViewList = @[].mutableCopy;
    }
    return _subViewList;
}

@end

@implementation OrderDetailMerchandiseCell2Model

@end

@implementation OrderDetailMerchandiseSubviewModel

@end
