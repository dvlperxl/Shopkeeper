//
//  AddStoreTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStoreTableViewCell.h"

@interface AddStoreTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CMTextField *contentTextField;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)AddStoreTableViewCellModel *model;
@property(nonatomic,strong)UILabel *contentLab;

@end

@implementation AddStoreTableViewCell

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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)textfieldTextDidChange:(NSNotification*)notif
{
    if (self.contentTextField.isFirstResponder)
    {
        self.model.content = self.contentTextField.text;
    }
}


- (void)reloadData:(AddStoreTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentTextField.placeholder = model.placeholder;
    if (model.edit) {
        
        self.contentTextField.text = model.content;
        self.contentTextField.enabled = model.edit;
        self.contentLab.text = @"";
        
    }else
    {
        self.contentLab.text = model.content;
        self.contentTextField.enabled = model.edit;
        self.contentTextField.text = @"";
    }
    
    self.contentLab.hidden = model.edit;
    self.contentTextField.hidden = !model.edit;
    
    self.arrowImageView.hidden = !model.choose;
    self.descLab.hidden = !model.choose;
    
    if (model.maxlength>0) {
        self.contentTextField.maxLength = model.maxlength;
    }
    
    if ([model.contentKey isEqualToString:@"mobile"])
    {
        _contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        _contentTextField.maxLength = 11;

    }else
    {
        _contentTextField.keyboardType = UIKeyboardTypeDefault;
        _contentTextField.maxLength = 0;
    }
    
    [self setNeedsLayout];
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
    
    if (self.model.choose) {
        
        [self.contentTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(100);
            make.right.equalTo(self.descLab.mas_left).mas_equalTo(0);
            make.top.offset(15);
            make.bottom.offset(-15);
        }];
        
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(100);
            make.right.equalTo(self.descLab.mas_left).mas_equalTo(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
        
        
    }else
    {
        
     
        [self.contentTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(100);
            make.right.mas_equalTo(-30);
            make.top.offset(15);
            make.bottom.offset(-15);
        }];
        
        [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(100);
            make.right.mas_equalTo(-30);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.arrowImageView.mas_left).offset(-11);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentTextField];
    [self addSubview:self.contentLab];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.line];
    [self addSubview:self.descLab];
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

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithRGB(51, 51, 51, 1);
        _contentLab.font = APPFONT(17);
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithImage:Image(@"arrow_right")];
    }
    return _arrowImageView;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.text = @"请选择";
        _descLab.textAlignment = NSTextAlignmentRight;
        _descLab.font = APPFONT(17);
        _descLab.textColor = ColorWithRGB(143, 142, 148, 1);

    }
    return _descLab;
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

@implementation AddStoreTableViewCellModel

@end
