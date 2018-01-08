//
//  RemarkTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RemarkTableViewCell.h"

@interface RemarkTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIView *line;

@end

@implementation RemarkTableViewCell

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

- (void)reloadData:(RemarkTableViewCellModel *)model
{
    self.titleLab.attributedText = model.title;
    self.contentLab.attributedText = model.content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.offset(11);
        make.bottom.offset(-11);
        make.width.mas_equalTo(70);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.top.offset(11);
        make.bottom.offset(-11);
        make.left.offset(100);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.line];
    [self layoutSubviews];
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


- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = APPBOLDFONT(17);//34
        _contentLab.textColor = ColorWithHex(@"#333333");
        _contentLab.textAlignment = NSTextAlignmentRight;
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
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

@implementation RemarkTableViewCellModel

@end
