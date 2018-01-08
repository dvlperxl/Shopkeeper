//
//  NoticeListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NoticeListTableViewCell.h"

@interface NoticeListTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *timeLab;

@end

@implementation NoticeListTableViewCell

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

- (void)reloadData:(NoticeListTableViewCellModel*)model
{
    self.timeLab.text = model.time;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.statusLab.attributedText = model.status;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(20);
        make.right.offset(-85);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.right.offset(-15);
        
    }];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-15);
        make.top.offset(20);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(14);
        make.top.equalTo(self.contentLab.mas_bottom).offset(10);
    }];
}

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.statusLab];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _titleLab.numberOfLines = 0;
        
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithRGB(102, 102, 102, 1);
        _contentLab.font  = APPFONT(15);
        _contentLab.numberOfLines = 0;

    }
    return _contentLab;
}

- (UILabel *)statusLab
{
    if (!_statusLab) {
        _statusLab = [[UILabel alloc]init];
    }
    return _statusLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = APPFONT(12);
        _timeLab.textColor = ColorWithRGB(153, 153, 153, 1);
    }
    return _timeLab;
}

@end

@implementation NoticeListTableViewCellModel

@end
