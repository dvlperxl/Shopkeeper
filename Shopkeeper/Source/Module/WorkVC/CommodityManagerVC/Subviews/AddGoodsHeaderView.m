//
//  AddGoodsHeaderView.m
//  Shopkeeper
//
//  Created by xl on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsHeaderView.h"

@interface AddGoodsHeaderView ()

@property (nonatomic,weak) UIImageView *arrowImage;
@property (nonatomic,weak) UILabel *leftTitleLabel;

@property (nonatomic,weak) AddGoodsHeaderViewModel *headerData;
@end

@implementation AddGoodsHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(45);
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)reloadData:(AddGoodsHeaderViewModel *)model {
    self.headerData = model;
    self.leftTitleLabel.text = model.headerTitle;
    self.arrowImage.image = model.openStatusImage;
}
#pragma mark - event
- (void)tapClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapHeader:)]) {
        [self.delegate tapHeader:self];
    }
}
#pragma mark - getter
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        UIImageView *statusImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"expand"]];
        [self.contentView addSubview:statusImage];
        _arrowImage = statusImage;
    }
    return _arrowImage;
}
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#F29700"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _leftTitleLabel = name;
    }
    return _leftTitleLabel;
}
@end


@implementation AddGoodsHeaderViewModel

- (UIImage *)openStatusImage {
    return !_open ? [UIImage imageNamed:@"expand"] : [UIImage imageNamed:@"foldup"];
}
@end
