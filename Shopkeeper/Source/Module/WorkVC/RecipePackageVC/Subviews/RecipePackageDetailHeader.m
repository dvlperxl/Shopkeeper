//
//  RecipePackageDetailHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailHeader.h"

@interface RecipePackageDetailHeader ()

@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation RecipePackageDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)reloadData:(id)model {
    self.nameLabel.text = (NSString *)model;
}
#pragma mark - getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self.contentView addSubview:name];
        _nameLabel = name;
    }
    return _nameLabel;
}
@end
