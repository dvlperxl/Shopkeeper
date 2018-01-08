//
//  AddGoodsImageCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsImageCell.h"
#import "AddGoodsCellDataModel.h"
#import "UIButton+KKWebCache.h"

@interface AddGoodsImageCell ()

@property (nonatomic,weak) UIButton *oneImageView;
@property (nonatomic,weak) UIButton *oneBadge;
@property (nonatomic,weak) UIButton *twoImageView;
@property (nonatomic,weak) UIButton *twoBadge;
@property (nonatomic,weak) UIButton *threeImageView;
@property (nonatomic,weak) UIButton *threeBadge;
@end

@implementation AddGoodsImageCell

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
        [self.oneBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.oneImageView.mas_right).with.offset(5);
            make.top.equalTo(self.oneImageView.mas_top).with.offset(-5);
        }];
        [self.twoBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.twoImageView.mas_right).with.offset(5);
            make.top.equalTo(self.twoImageView.mas_top).with.offset(-5);
        }];
        [self.threeBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.threeImageView.mas_right).with.offset(5);
            make.top.equalTo(self.threeImageView.mas_top).with.offset(-5);
        }];
    }
    return self;
}

- (void)reloadData:(AddGoodsCellDataModel *)model {
    NSString *imageUrl = model.imageContentModel.showValue;
    NSArray *imageArray = nil;
    if (imageUrl.length > 0) {
        imageArray = [imageUrl componentsSeparatedByString:@","].mutableCopy;
    }
    if (imageArray.count == 0) {
        self.oneImageView.hidden = NO;
        self.twoImageView.hidden = self.threeImageView.hidden = YES;
        self.oneBadge.hidden = self.twoBadge.hidden = self.threeBadge.hidden = YES;
        self.oneImageView.enabled = YES;
        self.twoImageView.enabled = self.threeImageView.enabled = NO;
        [self.oneImageView setBackgroundImage:[UIImage imageNamed:@"add_pic"] forState:UIControlStateNormal];
    } else if (imageArray.count == 1) {
        self.oneImageView.hidden = self.twoImageView.hidden = NO;
        self.threeImageView.hidden = YES;
        self.oneBadge.hidden = NO;
        self.twoBadge.hidden = self.threeBadge.hidden = YES;
        self.oneImageView.enabled = self.threeImageView.enabled = NO;
        self.twoImageView.enabled = YES;
        [self.oneImageView kk_setBackgroundImageWithURL:imageArray[0] forState:UIControlStateNormal];
        [self.twoImageView setBackgroundImage:[UIImage imageNamed:@"add_pic"] forState:UIControlStateNormal];
    } else if (imageArray.count == 2) {
        self.oneImageView.hidden = self.twoImageView.hidden = self.threeImageView.hidden = NO;
        self.oneBadge.hidden = self.twoBadge.hidden = NO;
        self.threeBadge.hidden = YES;
        self.oneImageView.enabled = self.twoImageView.enabled = NO;
        self.threeImageView.enabled = YES;
        [self.oneImageView kk_setBackgroundImageWithURL:imageArray[0] forState:UIControlStateNormal];
        [self.twoImageView kk_setBackgroundImageWithURL:imageArray[1] forState:UIControlStateNormal];
        [self.threeImageView setBackgroundImage:[UIImage imageNamed:@"add_pic"] forState:UIControlStateNormal];
    } else if (imageArray.count == 3) {
        self.oneImageView.hidden = self.twoImageView.hidden = self.threeImageView.hidden = NO;
        self.oneBadge.hidden = self.twoBadge.hidden = self.threeBadge.hidden = NO;
        self.oneImageView.enabled = self.twoImageView.enabled = self.threeImageView.enabled = NO;
        [self.oneImageView kk_setBackgroundImageWithURL:imageArray[0] forState:UIControlStateNormal];
        [self.twoImageView kk_setBackgroundImageWithURL:imageArray[1] forState:UIControlStateNormal];
        [self.threeImageView kk_setBackgroundImageWithURL:imageArray[2] forState:UIControlStateNormal];
    }
}
#pragma mark - event
- (void)buttonClick:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsImageCellTapAddImage:)]) {
        [self.delegate addGoodsImageCellTapAddImage:self];
    }
}
- (void)cancelImageClick:(UIButton *)badge {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsImageCell:deleteImageWithIndex:)]) {
        [self.delegate addGoodsImageCell:self deleteImageWithIndex:[self indexOfBadge:badge]];
    }
}
#pragma mark - getter
- (UIButton *)oneImageView {
    if (!_oneImageView) {
        UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
        name.adjustsImageWhenDisabled = NO;
        [name addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:name];
        UIButton *badge = [UIButton buttonWithType:UIButtonTypeCustom];
        [badge setImage:[UIImage imageNamed:@"icon_deletephoto"] forState:UIControlStateNormal];
        [badge addTarget:self action:@selector(cancelImageClick:) forControlEvents:UIControlEventTouchUpInside];
        badge.hidden = YES;
        [self.contentView addSubview:badge];
        _oneBadge = badge;
        _oneImageView = name;
    }
    return _oneImageView;
}
- (UIButton *)twoImageView {
    if (!_twoImageView) {
        UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
        name.adjustsImageWhenDisabled = NO;
        [name addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:name];
        UIButton *badge = [UIButton buttonWithType:UIButtonTypeCustom];
        [badge setImage:[UIImage imageNamed:@"icon_deletephoto"] forState:UIControlStateNormal];
        [badge addTarget:self action:@selector(cancelImageClick:) forControlEvents:UIControlEventTouchUpInside];
        badge.hidden = YES;
        [self.contentView addSubview:badge];
        _twoBadge = badge;
        _twoImageView = name;
    }
    return _twoImageView;
}
- (UIButton *)threeImageView {
    if (!_threeImageView) {
        UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
        name.adjustsImageWhenDisabled = NO;
        [name addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:name];
        UIButton *badge = [UIButton buttonWithType:UIButtonTypeCustom];
        [badge setImage:[UIImage imageNamed:@"icon_deletephoto"] forState:UIControlStateNormal];
        [badge addTarget:self action:@selector(cancelImageClick:) forControlEvents:UIControlEventTouchUpInside];
        badge.hidden = YES;
        [self.contentView addSubview:badge];
        _threeBadge = badge;
        _threeImageView = name;
    }
    return _threeImageView;
}
- (NSInteger)indexOfBadge:(UIButton *)badge {
    if (self.oneBadge == badge) {
        return 0;
    }
    if (self.twoBadge == badge) {
        return 1;
    }
    if (self.threeBadge == badge) {
        return 2;
    }
    return 4;
}
@end
