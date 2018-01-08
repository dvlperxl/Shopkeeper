//
//  RecipePackageDetailTabFooter.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailTabFooter.h"
#import "RecipePackageDetailTabHeader.h"

@interface RecipePackageDetailTabFooter ()

/** 销售价格*/
@property (nonatomic,strong) ReicpePackageDetailRowView *salePriceView;
/** 商品积分*/
@property (nonatomic,strong) ReicpePackageDetailRowView *integrationView;
/** 处方说明*/
@property (nonatomic,strong) ReicpePackageDetailRowView *descriptionView;
@end

@implementation RecipePackageDetailTabFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.salePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(10);
            make.height.mas_equalTo(50);
        }];
        [self.integrationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.salePriceView);
            make.top.equalTo(self.salePriceView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        [self.descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.salePriceView);
            make.top.equalTo(self.integrationView.mas_bottom).with.offset(10);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}

#pragma mark - HNReactView
- (void)bindingViewModel:(RecipePackageDetailTabFooterModel *)viewModel {
    self.salePriceView.nameLabel.text = viewModel.salePriceTitle;
    self.salePriceView.contentLabel.text = viewModel.salePriceContent;
    self.integrationView.nameLabel.text = viewModel.integrationTitle;
    self.integrationView.contentLabel.text = viewModel.integrationContent;
    self.descriptionView.nameLabel.text = viewModel.descriptionTitle;
    self.descriptionView.contentLabel.text = viewModel.descriptionContent;
}
#pragma mark - getter
- (ReicpePackageDetailRowView *)salePriceView {
    if (!_salePriceView) {
        _salePriceView = [[ReicpePackageDetailRowView alloc]init];
        [self addSubview:_salePriceView];
    }
    return _salePriceView;
}
- (ReicpePackageDetailRowView *)integrationView {
    if (!_integrationView) {
        _integrationView = [[ReicpePackageDetailRowView alloc]init];
        [self addSubview:_integrationView];
    }
    return _integrationView;
}
- (ReicpePackageDetailRowView *)descriptionView {
    if (!_descriptionView) {
        _descriptionView = [[ReicpePackageDetailRowView alloc]init];
        [self addSubview:_descriptionView];
    }
    return _descriptionView;
}
@end

@implementation RecipePackageDetailTabFooterModel

@end
