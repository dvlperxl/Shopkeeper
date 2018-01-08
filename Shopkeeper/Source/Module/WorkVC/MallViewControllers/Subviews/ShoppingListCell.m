//
//  ShoppingListCell.m
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShoppingListCell.h"
#import "HNNumberButton.h"
#import "UIButton+KKWebCache.h"

@interface ShoppingListCell ()<HNNumberButtonDelegate>

@property (nonatomic,weak) UIImageView *selectedStatusImage;
@property (nonatomic,weak) UIButton *goodsImage;
@property (nonatomic,weak) UILabel *goodsContentLabel;
@property (nonatomic,weak) UIButton *deleteBtn;
@property (nonatomic,weak) UILabel *goodsSpeciLabel;
@property (nonatomic,weak) UILabel *goodsPriceLabel;
@property (nonatomic,weak) HNNumberButton *numberBtn;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)ShoppingListCellModel *model;


@end

@implementation ShoppingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.selectedStatusImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(50);
            make.top.offset(20);
            make.width.height.mas_equalTo(90);
        }];
        [self.goodsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsImage.mas_right).with.offset(10);
            make.top.equalTo(self.goodsImage.mas_top);
            make.right.offset(-54);
        }];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsContentLabel.mas_right);
            make.top.equalTo(self.goodsContentLabel.mas_top);
            make.right.offset(0);
        }];
        [self.goodsSpeciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsContentLabel.mas_left);
            make.top.equalTo(self.goodsContentLabel.mas_bottom).with.offset(18);
        }];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.left.equalTo(self.goodsSpeciLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.goodsSpeciLabel);
        }];
        [self.goodsPriceLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsContentLabel.mas_left);
            make.right.offset(-15);
            make.bottom.offset(-10);
            make.height.mas_equalTo(40);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(50);
            make.right.bottom.offset(0);
            make.height.mas_equalTo(1.0/SCREEN_SCALE);
        }];
        
    }
    return self;
}
- (void)reloadData:(ShoppingListCellModel *)model
{
    self.model = model;
//    self.selectedStatusImage.image = model.selectedImage;
    [self.goodsImage kk_setImageWithURLString:model.goodsImage forState:UIControlStateNormal];
    self.goodsContentLabel.text = model.goodsContent;
    self.goodsSpeciLabel.text = model.goodsSpeci;
    self.goodsPriceLabel.attributedText = model.goodsPrice;
    self.numberBtn.currentNumber = [model.goodsNumber integerValue];
    self.selectedStatusImage.image = model.select ? [UIImage imageNamed:@"icon_orange_checkbox"] : [UIImage imageNamed:@"icon_grey_checkbox"];
}

#pragma mark - HNNumberButtonDelegate
- (void)numberButton:(HNNumberButton *)numberButton number:(NSInteger)number {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCell:number:)]) {
        self.model.goodsNumber = [NSNumber numberWithInteger:number];
        self.numberBtn.currentNumber = [self.model.goodsNumber integerValue];
        [self.delegate shoppingCell:self number:number];
    }
}
- (void)numberButton:(HNNumberButton *)numberButton errorNumber:(NSInteger)errorNumber {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCell:errorNumber:)]) {
        [self.delegate shoppingCell:self errorNumber:errorNumber];
    }
}
#pragma mark - event
- (void)deleteClick:(UIButton *)deleteBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCellDeleteHandle:)]) {
        [self.delegate shoppingCellDeleteHandle:self];
    }
}
#pragma mark - getter
- (UIImageView *)selectedStatusImage {
    if (!_selectedStatusImage) {
        UIImageView *name = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_grey_checkbox"]];
        [self.contentView addSubview:name];
        _selectedStatusImage = name;
    }
    return _selectedStatusImage;
}
- (UIButton *)goodsImage {
    if (!_goodsImage) {
        UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
        name.enabled = NO;
        name.adjustsImageWhenDisabled = NO;
        [self.contentView addSubview:name];
        _goodsImage = name;
    }
    return _goodsImage;
}
- (UILabel *)goodsContentLabel {
    if (!_goodsContentLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.numberOfLines = 2;
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.font = APPFONT(14);
        [self.contentView addSubview:name];
        _goodsContentLabel = name;
    }
    return _goodsContentLabel;
}
- (UILabel *)goodsSpeciLabel {
    if (!_goodsSpeciLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        name.font = APPFONT(12);
        [self.contentView addSubview:name];
        _goodsSpeciLabel = name;
    }
    return _goodsSpeciLabel;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"cart_icon_delete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _deleteBtn = btn;
    }
    return _deleteBtn;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor colorWithHexString:@"#ED8508"];
        name.font = APPFONT(22);
        [self.contentView addSubview:name];
        _goodsPriceLabel = name;
    }
    return _goodsPriceLabel;
}
- (HNNumberButton *)numberBtn {
    if (!_numberBtn) {
        HNNumberButton *numberBtn = [[HNNumberButton alloc]init];
        numberBtn.editing = YES;
        numberBtn.maxValue = 99999999;
        numberBtn.minValue = 1;
        numberBtn.delegate = self;
        [self.contentView addSubview:numberBtn];
        _numberBtn = numberBtn;
    }
    return _numberBtn;
}

-(UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
        [self.contentView addSubview:_line];
    }
    return _line;
}


@end


@implementation ShoppingListCellModel

@end
