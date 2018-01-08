//
//  ReceivePersonListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReceivePersonListTableViewCell.h"

@interface ReceivePersonListTableViewCell ()

@property(nonatomic,strong)UIImageView *selectImageView;
@property(nonatomic,strong)UIButton *editButton;
@property(nonatomic,strong)UILabel *receivePersonLab;
@property(nonatomic,strong)UILabel *receivePhoneLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)ReceivePersonListTableViewCellModel *model;

@end

@implementation ReceivePersonListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(ReceivePersonListTableViewCellModel*)model
{
    self.model = model;
    self.receivePersonLab.text = model.receiveName;
    self.receivePhoneLab.text = model.receivePhone;
    self.addressLab.text = model.address;
    self.selectImageView.image = model.select?Image(@"icon_orange_checkbox"):Image(@"icon_grey_checkbox");
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(18);
        make.width.height.mas_equalTo(26);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-18);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.receivePersonLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(61);
        make.height.mas_equalTo(19);
        make.top.offset(21);
        make.right.equalTo(self.contentView.mas_centerX).offset(-2);
        
    }];
    
    [self.receivePhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_centerX).offset(2);
        make.height.mas_equalTo(19);
        make.top.offset(21);
        make.right.offset(-18);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(61);
        make.right.offset(-74);
        make.top.equalTo(self.receivePersonLab.mas_bottom).offset(9);
        make.bottom.offset(-21);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}

- (void)onEditButtonAction
{
    [[CMRouter sharedInstance]showViewControllerWithRouterModel:self.model.editRouterModel];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.editButton];
    [self.contentView addSubview:self.receivePhoneLab];
    [self.contentView addSubview:self.receivePersonLab];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.line];
}

- (UIImageView *)selectImageView
{
    if (!_selectImageView)
    {
        _selectImageView = [[UIImageView alloc]initWithImage:Image(@"icon_grey_checkbox")];////icon_orange_checkbox
    }
    return _selectImageView;
}

- (UIButton *)editButton
{
    if (!_editButton) {
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setImage:Image(@"icon_editgoods") forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(onEditButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UILabel *)receivePersonLab
{
    if (!_receivePersonLab) {
        
        _receivePersonLab = [[UILabel alloc]init];
        _receivePersonLab.font = APPFONT(17);
        _receivePersonLab.textColor = ColorWithHex(@"#333333");
    }
    return _receivePersonLab;
}

- (UILabel *)receivePhoneLab
{
    if (!_receivePhoneLab) {
        
        _receivePhoneLab = [[UILabel alloc]init];
        _receivePhoneLab.font = APPBOLDFONT(17);//34
        _receivePhoneLab.textColor = ColorWithHex(@"#333333");
    }
    return _receivePhoneLab;
}

- (UILabel *)addressLab
{
    if (!_addressLab) {
        
        _addressLab = [[UILabel alloc]init];
        _addressLab.font = APPFONT(15);
        _addressLab.textColor = ColorWithHex(@"#999999");
        _addressLab.numberOfLines = 0;
    }
    return _addressLab;
}

-(UIView *)line
{
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

@end

@implementation ReceivePersonListTableViewCellModel

@end
