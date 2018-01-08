//
//  CommodityListHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "CommodityListHeader.h"

@interface CommodityListHeader ()

@property (nonatomic,weak) UILabel *leftTitleLabel;
@property (nonatomic,weak) UILabel *rightTitleLabel;
@property (nonatomic,weak) UIImageView *arrowImage;

@end

@implementation CommodityListHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-34);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(self.contentView);
        }];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.right.greaterThanOrEqualTo(self.rightTitleLabel.mas_left).with.offset(-10);
        }];
    }
    return self;
}

- (void)reloadData:(CommodityListHeaderModel *)model {
    self.leftTitleLabel.text = model.leftTitle;
    self.rightTitleLabel.text = model.rightTitle;
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
        UIImageView *statusImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        [self.contentView addSubview:statusImage];
        _arrowImage = statusImage;
    }
    return _arrowImage;
}
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#666666"];
        name.font = APPFONT(15);
        [self.contentView addSubview:name];
        _leftTitleLabel = name;
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        UILabel *status = [[UILabel alloc]init];
        status.textColor = [UIColor colorWithHexString:@"#F29700"];
        status.font = APPFONT(15);
        status.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:status];
        _rightTitleLabel = status;
    }
    return _rightTitleLabel;
}
@end


@interface CommodityListHeaderModel ()

@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,copy) NSString *rightTitle;
@property (nonatomic,copy) NSString *headerId;
@end

@implementation CommodityListHeaderModel

+ (instancetype)headerModelWithLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle headerId:(NSString *)headerId {
    CommodityListHeaderModel *headerModel = [[CommodityListHeaderModel alloc]init];
    headerModel.leftTitle = leftTitle;
    headerModel.rightTitle = rightTitle;
    headerModel.headerId = headerId;
    return headerModel;
}
@end
