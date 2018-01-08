//
//  ChooseTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ChooseTableViewCell.h"

@interface ChooseTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)ChooseTableViewCellModel *model;

@end

@implementation ChooseTableViewCell

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

- (void)reloadData:(ChooseTableViewCellModel*)model
{
    self.contentLab.attributedText = nil;
    self.titleLab.text = nil;
    if (model.attriStrcontent) {
        self.contentLab.attributedText = model.attriStrcontent;
    }
    self.model = model;
    self.titleLab.text = model.title;
    if (model.content) {
        self.contentLab.text = model.content;
    }
    self.descLab.attributedText = model.desc;
    self.line.hidden = model.hideLine;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(70);
        
    }];
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(100);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-11);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.arrowImageView.mas_left).offset(-11);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.line];
    [self addSubview:self.descLab];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithRGB(3, 3, 3, 1);
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _contentLab.font = APPFONT(17);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.text = @"请选择";
        _descLab.textAlignment = NSTextAlignmentRight;
        _descLab.font = APPFONT(17);
        _descLab.textColor = ColorWithRGB(143, 142, 148, 1);
    }
    return _descLab;
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

@implementation ChooseTableViewCellModel

@end
