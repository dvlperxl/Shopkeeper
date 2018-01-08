//
//  AddGoodsPickerCell.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsPickerCell.h"
#import "AddGoodsCellDataModel.h"

@interface AddGoodsPickerCell ()

@property (nonatomic,weak) UILabel *leftNameLabel;
@property (nonatomic,weak) UIImageView *rightArrowImage;
@property (nonatomic,weak) UIButton *pickerButton;

@property (nonatomic,weak) AddGoodsCellDataModel *cellModel;
@end

@implementation AddGoodsPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        [self.rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.pickerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-35);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)reloadData:(AddGoodsCellDataModel *)model {
    self.cellModel = model;
    self.leftNameLabel.text = model.leftTitle;
    AddGoodsInputDataModel *inputModel = [model.pickerContentModels objectAtIndex:0];
    if (inputModel) {
        if (inputModel.showValue) {
            [self.pickerButton setTitle:inputModel.showValue forState:UIControlStateNormal];
            [self.pickerButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        } else {
            [self.pickerButton setTitle:inputModel.placeholder forState:UIControlStateNormal];
            [self.pickerButton setTitleColor:[UIColor colorWithHexString:@"#8F8E94"] forState:UIControlStateNormal];
        }
    }
}
#pragma mark - event
- (void)onPickerClick:(UIButton *)button {
    if (self.cellModel.modelOperation) {
        self.cellModel.modelOperation();
    }
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
- (UIImageView *)rightArrowImage {
    if (!_rightArrowImage) {
        UIImageView *statusImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        [self.contentView addSubview:statusImage];
        _rightArrowImage = statusImage;
    }
    return _rightArrowImage;
}
- (UIButton *)pickerButton {
    if (!_pickerButton) {
        UIButton *picker = [[UIButton alloc]init];
        picker.titleLabel.font = APPFONT(17);
        [picker addTarget:self action:@selector(onPickerClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:picker];
        _pickerButton = picker;
    }
    return _pickerButton;
}
@end
