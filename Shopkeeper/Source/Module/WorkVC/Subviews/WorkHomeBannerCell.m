//
//  WorkHomeBannerCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeBannerCell.h"


@interface WorkHomeBannerCell ()

@property(nonatomic,strong)UIImageView *bannerImageView;
@property(nonatomic,strong)UIImageView *bannerBGImageView;

@end

@implementation WorkHomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.offset(2);
        make.bottom.offset(-10);
    }];
    
    [self.bannerBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubviews
{
    [self addSubview:self.bannerBGImageView];
    [self addSubview:self.bannerImageView];
}

- (UIImageView *)bannerImageView
{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc]initWithImage:Image(@"work_banner")];
        _bannerImageView.layer.masksToBounds = YES;
        _bannerImageView.layer.cornerRadius = 10;
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerImageView;
}

- (UIImageView *)bannerBGImageView
{
    if (!_bannerBGImageView) {
        _bannerBGImageView = [[UIImageView alloc]initWithImage:Image(@"bk_work_banner")];
        UIImage *image = Image(@"bk_work_banner");
        _bannerBGImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(50, 50, 50, 50) resizingMode:UIImageResizingModeStretch];
    }
    return _bannerBGImageView;
}



@end
