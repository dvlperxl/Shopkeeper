//
//  MallOrderPayHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderPayHeader.h"

@interface MallOrderPayHeader ()

@property (nonatomic,weak) UILabel *headerTitle;
@end

@implementation MallOrderPayHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)reloadData:(NSString *)model {
    self.headerTitle.text = model;
}
#pragma mark - getter
- (UILabel *)headerTitle {
    if (!_headerTitle) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(12);
        [self.contentView addSubview:name];
        _headerTitle = name;
    }
    return _headerTitle;
}
@end
