//
//  InputTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "InputTableViewCell.h"

@interface InputTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CMTextField *contentTextField;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)InputTableViewCellModel *model;

@end

@implementation InputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(textfieldTextDidChange:)
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:nil];
        
        [self initSubviews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)textfieldTextDidChange:(NSNotification*)notif
{
    if (self.contentTextField.isFirstResponder)
    {
        self.model.content = self.contentTextField.text;
    }
}

- (void)reloadData:(InputTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentTextField.placeholder = model.placeholder;
    if (model.maxLength>0)
    {
        self.contentTextField.maxLength = model.maxLength;
    }
    self.contentTextField.text = model.content;
    self.line.hidden = model.hideLine;
    self.contentTextField.keyboardType = model.keyBoardType;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(70);
        
    }];
    
    [self.contentTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(100);
        make.right.mas_equalTo(-15);
        make.top.offset(15);
        make.bottom.offset(-15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];

}




#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentTextField];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithRGB(3, 3, 3, 1);
        
    }
    return _titleLab;
}

- (CMTextField *)contentTextField
{
    if (!_contentTextField) {
        
        _contentTextField = [[CMTextField alloc]init];
        _contentTextField.textColor = ColorWithRGB(51, 51, 51, 1);
        _contentTextField.font = APPFONT(17);
        
    }
    
    return _contentTextField;
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

@implementation InputTableViewCellModel

@end
