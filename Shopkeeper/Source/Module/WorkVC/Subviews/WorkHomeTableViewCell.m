//
//  WorkHomeTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeTableViewCell.h"
#import "HNFirstToastView.h"


@interface WorkHomeItemView ()

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *lineV;

@end

@implementation WorkHomeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(13);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(5);
        make.right.offset(-5);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(7);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.lineV];
}

- (void)reloadData:(WorkHomeItemViewModel*)model
{
    self.iconImageView.image = Image(model.iconName);
    self.titleLab.text = model.title;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = APPFONT(14);
    }
    return _titleLab;
}
- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = ColorWithRGB(245, 245, 245, 1);
    }
    return _lineV;
}


@end

@interface WorkHomeTableViewCell ()

@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)NSArray *menus;
@property(nonatomic,strong)NSArray *modelList;
@property(nonatomic,strong)HNFirstToastView *firstToastView;

@end

@implementation WorkHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)onMenuButtonAction:(UITapGestureRecognizer*)tap
{
    NSInteger index = [self.menus indexOfObject:tap.view];
    WorkHomeItemViewModel *model = self.modelList[index];
    if ([self.delegate respondsToSelector:@selector(workHomeTableViewCell:didSelectMenuWithActionName:)]) {
        [self.delegate workHomeTableViewCell:self didSelectMenuWithActionName:model.actionName];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

- (void)reloadData:(NSArray*)modelList
{
    self.firstToastView.hidden = YES;
    _modelList = modelList;
    for (NSInteger i = 0; i<4; i++)
    {
        WorkHomeItemView *menu = self.menus[i];
        if (i<modelList.count)
        {
            menu.hidden = NO;
            
            WorkHomeItemViewModel *model = modelList[i];
            [menu reloadData:model];
            
            if ([model.title isEqualToString:@"采购商城"])
            {
                if (model.showTips) {
                    self.firstToastView.hidden = NO;
                }
            }
            
        }else
        {
            menu.hidden = YES;
        }
        

    }
}


- (void)initSubviews
{
    NSMutableArray *menus = @[].mutableCopy;
    CGFloat width = SCREEN_WIDTH/4;
    for (NSInteger i = 0; i<4; i++)
    {
        WorkHomeItemView *menu = [[WorkHomeItemView alloc]initWithFrame:CGRectMake(i*width, 0, width, 100)];
        [menus addObject:menu];
        menu.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onMenuButtonAction:)];
        [menu addGestureRecognizer:tap];
        
        if (i==3) {
            menu.lineV.hidden = YES;
        }
        [self addSubview:menu];
    }
    _menus = menus.copy;
    [self addSubview:self.lineV];
    [self addSubview:self.firstToastView];
    self.firstToastView.frame = CGRectMake(SCREEN_WIDTH-140, 85, 132, 56);
}

- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = ColorWithRGB(245, 245, 245, 1);
    }
    return _lineV;
}

- (HNFirstToastView *)firstToastView {
    if (!_firstToastView) {
        _firstToastView = [HNFirstToastView new];
        _firstToastView.content = @"采购商城全新上线， 快来体验一下吧！";
        _firstToastView.hidden = YES;
    }
    return _firstToastView;
}

@end

@implementation WorkHomeItemViewModel


@end
