//
//  SearchRegistrationGoodsToast.m
//  Shopkeeper
//
//  Created by xl on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SearchRegistrationGoodsToast.h"

NSString *const SearchRegistrationGoodsToastText = @"【查登记证】 输入登记证号即可查询。 例如：PD20121664、 LS20150355等。\n\n【查厂家】 输入厂家简称即可查询相关信息。 例如中华立华、陶氏、巴斯夫等\n\n【查产品】 输入商品名称或登记名称查询。 例如草甘磷、蚍磋醚菌脂等";

@interface SearchRegistrationGoodsToast ()

@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation SearchRegistrationGoodsToast

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-10);
            make.top.offset(70);
        }];
        self.contentLabel.text = SearchRegistrationGoodsToastText;
    }
    return self;
}

+ (instancetype)searchRegistrationToast {
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat navMaxY = rectOfStatusbar.size.height+44;
    SearchRegistrationGoodsToast *toast = [[SearchRegistrationGoodsToast alloc]initWithFrame:CGRectMake(0,navMaxY , SCREEN_WIDTH, SCREEN_HEIGHT-navMaxY)];
    return toast;
}

#pragma mark - getter
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 0;
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(17);
        [self addSubview:name];
        _contentLabel = name;
    }
    return _contentLabel;
}
@end
