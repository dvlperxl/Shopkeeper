//
//  GoodsDetailImageCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDetailImageCell.h"
#import "UIImageView+KKWebImage.h"

@interface GoodsDetailImageCell ()

@property (nonatomic,weak) UIImageView *oneImageView;
@property (nonatomic,weak) UIImageView *twoImageView;
@property (nonatomic,weak) UIImageView *threeImageView;

@end

@implementation GoodsDetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat imageSpace = 20.0f;
        [self.oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(70);
        }];
        [self.twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneImageView.mas_right).with.offset(imageSpace);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(70);
        }];
        [self.threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoImageView.mas_right).with.offset(imageSpace);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(70);
        }];
    }
    return self;
}

- (void)reloadData:(GoodsDetailImageCellModel *)model {
    if (model.imageArray.count == 0) {
        self.oneImageView.image = [UIImage imageNamed:@"no_pic"];
    } else {
        NSString *oneUrlStr = [model.imageArray objectAtIndex:0];
        NSString *twoUrlStr = [model.imageArray objectAtIndex:1];
        NSString *threeUrlStr = [model.imageArray objectAtIndex:2];
        [self.oneImageView sd_setImageWithURL:[self urlWithStr:oneUrlStr] placeholderImage:nil options:SDWebImageRetryFailed];
        [self.twoImageView sd_setImageWithURL:[self urlWithStr:twoUrlStr] placeholderImage:nil options:SDWebImageRetryFailed];
        [self.threeImageView sd_setImageWithURL:[self urlWithStr:threeUrlStr] placeholderImage:nil options:SDWebImageRetryFailed];
    }
}
- (NSURL *)urlWithStr:(NSString *)urlStr {
    if (urlStr) {
        return [NSURL URLWithString:urlStr];
    }
    return nil;
}
#pragma mark - getter
- (UIImageView *)oneImageView {
    if (!_oneImageView) {
        UIImageView *name = [[UIImageView alloc]init];
        [self.contentView addSubview:name];
        _oneImageView = name;
    }
    return _oneImageView;
}
- (UIImageView *)twoImageView {
    if (!_twoImageView) {
        UIImageView *name = [[UIImageView alloc]init];
        [self.contentView addSubview:name];
        _twoImageView = name;
    }
    return _twoImageView;
}
- (UIImageView *)threeImageView {
    if (!_threeImageView) {
        UIImageView *name = [[UIImageView alloc]init];
        [self.contentView addSubview:name];
        _threeImageView = name;
    }
    return _threeImageView;
}

@end


@implementation GoodsDetailImageCellModel


@end
