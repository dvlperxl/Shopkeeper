//
//  MallOrderGoodsFooter.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderGoodsFooter.h"

@interface MallOrderGoodsFooter ()

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,weak) UILabel *footerRightTitle;
@end

@implementation MallOrderGoodsFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.mas_equalTo(50.0f);
        }];
        [self.footerRightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.centerY.mas_equalTo(self.topView);
        }];
    }
    return self;
}

- (void)reloadData:(NSString *)model {
    self.footerRightTitle.text = model;
}

#pragma mark - getter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_topView];
    }
    return _topView;
}
- (UILabel *)footerRightTitle {
    if (!_footerRightTitle) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentRight;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(18);
        [self.contentView addSubview:name];
        _footerRightTitle = name;
    }
    return _footerRightTitle;
}
@end
