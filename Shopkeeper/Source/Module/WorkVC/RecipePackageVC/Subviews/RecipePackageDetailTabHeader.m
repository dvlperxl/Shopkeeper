//
//  RecipePackageDetailTabHeader.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailTabHeader.h"


@implementation ReicpePackageDetailRowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15).priority(400);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(70).priority(300);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).with.offset(18).priority(400);
            make.right.offset(-15).priority(400);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

#pragma mark - getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#030303"];
        name.font = APPFONT(17);
        [self addSubview:name];
        _nameLabel = name;
    }
    return _nameLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *content = [[UILabel alloc]init];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.font = APPFONT(17);
        [self addSubview:content];
        _contentLabel = content;
    }
    return _contentLabel;
}
@end

@interface RecipePackageDetailTabHeader ()

@property (nonatomic,strong) UILabel *cropTitleLabel;
@property (nonatomic,strong) ReicpePackageDetailRowView *prescriptionNameView;
@property (nonatomic,strong) ReicpePackageDetailRowView *prescriptionSpecView;
@end

@implementation RecipePackageDetailTabHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F8FC"];
        [self.cropTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.mas_equalTo(80);
        }];
        [self.prescriptionNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cropTitleLabel);
            make.top.equalTo(self.cropTitleLabel.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        [self.prescriptionSpecView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.cropTitleLabel);
            make.top.equalTo(self.prescriptionNameView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}
#pragma mark - HNReactView
- (void)bindingViewModel:(RecipePackageDetailTabHeaderModel *)viewModel {
    self.cropTitleLabel.text = viewModel.prescriptionTitle;
    self.prescriptionNameView.nameLabel.text = viewModel.prescriptionNameTitle;
    self.prescriptionNameView.contentLabel.text = viewModel.prescriptionNameContent;
    self.prescriptionSpecView.nameLabel.text = viewModel.prescriptionSpecTitle;
    self.prescriptionSpecView.contentLabel.text = viewModel.prescriptionSpecContent;
}
#pragma mark - getter
- (UILabel *)cropTitleLabel {
    if (!_cropTitleLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textAlignment = NSTextAlignmentCenter;
        name.backgroundColor = [UIColor colorWithHexString:@"#FFF4E1"];
        name.textColor = [UIColor blackColor];
        name.font = APPFONT(34);
        [self addSubview:name];
        _cropTitleLabel = name;
    }
    return _cropTitleLabel;
}
- (ReicpePackageDetailRowView *)prescriptionNameView {
    if (!_prescriptionNameView) {
        _prescriptionNameView = [[ReicpePackageDetailRowView alloc]init];
        [self addSubview:_prescriptionNameView];
    }
    return _prescriptionNameView;
}
- (ReicpePackageDetailRowView *)prescriptionSpecView {
    if (!_prescriptionSpecView) {
        _prescriptionSpecView = [[ReicpePackageDetailRowView alloc]init];
        [self addSubview:_prescriptionSpecView];
    }
    return _prescriptionSpecView;
}
@end


@implementation RecipePackageDetailTabHeaderModel

@end
