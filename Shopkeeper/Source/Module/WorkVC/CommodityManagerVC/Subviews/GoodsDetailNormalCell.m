//
//  GoodsDetailNormalCell.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDetailNormalCell.h"

@interface GoodsDetailNormalCell ()

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UILabel *goodsContentLabel;

@end

@implementation GoodsDetailNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.goodsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftNameLabel.mas_right).with.offset(18);
            make.centerY.equalTo(self.contentView);
            make.right.offset(-15);
        }];
    }
    return self;
}

- (void)reloadData:(GoodsDetailNormalCellModel *)model {
    self.leftNameLabel.text = model.leftTitle;
    self.goodsContentLabel.text = model.goodsContent;
}

#pragma mark - getter
- (UILabel *)leftNameLabel {
    if (!_leftNameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _leftNameLabel = name;
    }
    return _leftNameLabel;
}
- (UILabel *)goodsContentLabel {
    if (!_goodsContentLabel) {
        UILabel *content = [[UILabel alloc]init];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(17);
        [self.contentView addSubview:content];
        _goodsContentLabel = content;
    }
    return _goodsContentLabel;
}
@end


@implementation GoodsDetailNormalCellModel


@end
