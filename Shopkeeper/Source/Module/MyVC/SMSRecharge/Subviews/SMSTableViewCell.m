//
//  SMSTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSTableViewCell.h"


@interface SMSMenuView : UIView

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;

@end

@implementation SMSMenuView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
        
    }
    return self;
}

- (void)setSelect:(BOOL)select
{
    if (select) {
        
        self.titleLab.textColor = ColorWithHex(@"#ffffff");
        self.descLab.textColor = ColorWithHex(@"#ffffff");
        self.backgroundColor = ColorWithHex(@"#F39700");
        
    }else
    {
        self.titleLab.textColor = ColorWithHex(@"#333333");
        self.descLab.textColor = ColorWithHex(@"#999999");
        self.backgroundColor = ColorWithHex(@"#F9F8FC");
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.offset(18);
        make.height.mas_equalTo(22);
        
    }];
    
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.offset(40);
        make.height.mas_equalTo(22);
        
    }];

}

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = SCREEN_SCALE;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(20);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(14);
        _descLab.textAlignment = NSTextAlignmentCenter;
    }
    return _descLab;
}


@end

@interface SMSTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)NSMutableArray *menus;

@end

@implementation SMSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.offset(15);
        make.height.mas_equalTo(19);

    }];
    
    [self.tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(93);
        make.top.offset(20);
        make.height.mas_equalTo(14);
        
    }];
}

- (void)onTap:(UITapGestureRecognizer*)tap
{
    for (SMSMenuView *menu  in  self.menus) {

        [menu setSelect:[menu isEqual:tap.view]];
    }
    
    if ([self.delegate respondsToSelector:@selector(SMSTableViewCellDidSelectMenuIndex:)]) {
        
        [self.delegate SMSTableViewCellDidSelectMenuIndex: [self.menus indexOfObject:tap.view]];
    }

}

- (void)reloadData:(NSArray*)list
{

    for (NSInteger i = 0; i<3; i++)
    {
        SMSMenuView *menu = self.menus[i];
        if (list[i])
        {
            NSDictionary *dict = list[i];
            menu.titleLab.text = [NSString stringWithFormat:@"%@条",dict[@"smsNumber"]];
            menu.descLab.text = [NSString stringWithFormat:@"%@元",dict[@"smsAmount"]];
        }
    }
}

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.tipsLab];
    self.menus = @[].mutableCopy;
    
    CGFloat width = (SCREEN_WIDTH -15)/3-15;
    
    for (NSInteger i = 0; i<3; i++)
    {
        SMSMenuView *menu = [[SMSMenuView alloc]init];
        
        [menu setSelect:i==0];
        [self addSubview:menu];
        
        [menu mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15+(width+15)*i);
            make.top.offset(55);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(75);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        [menu addGestureRecognizer:tap];
        [self.menus addObject:menu];
    }
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"充值金额";
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"333333");
        
    }
    return _titleLab;
}

- (UILabel *)tipsLab
{
    if (!_tipsLab) {
        
        _tipsLab = [[UILabel alloc]init];
        _tipsLab.text = @"注：购买的短信无使用时间限制";
        _tipsLab.font = APPFONT(12);
        _tipsLab.textColor = ColorWithHex(@"999999");
        
    }
    return _tipsLab;
}



@end
