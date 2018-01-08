//
//  KKTextField.m
//  kakatrip
//
//  Created by CaiMing on 2017/1/5.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KKTextField.h"

@interface KKTextField ()

@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UILabel *tipsLabel;

@end

@implementation KKTextField

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _autoValid = YES;
        [self initSubviews];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - noti

- (void)notification:(NSNotification*)notification
{
    if ([notification.object isEqual:self.textField])
    {
        self.errorTips = @"";
    }
}

#pragma mark -

- (void)setIconImageName:(NSString *)iconImageName
{
    self.iconImageView.image = [UIImage imageNamed:iconImageName];
}

- (void)setLineColor:(UIColor *)lineColor
{
    self.lineView.backgroundColor = lineColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [_textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setErrorTips:(NSString *)errorTips
{
    _errorTips = errorTips;
    _tipsLabel.text = errorTips;
}

#pragma mark -

- (void)initSubviews
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
    [self addSubview:self.tipsLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(20);
        make.left.offset(0);
        make.top.offset(11);
        
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(27);
        make.right.offset(0);
        make.top.offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(27);
        make.top.offset(34);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(27);
        make.right.offset(0);
        make.top.offset(41);
    }];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (CMTextField *)textField
{
    if (!_textField) {
        
        _textField = [[CMTextField alloc]init];
        _textField.textColor = [UIColor whiteColor];
        _textField.font = APPFONT(18);
        [_textField setValue:ColorWithHex(@"b4c2cf") forKeyPath:@"_placeholderLabel.textColor"];
        _textField.delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return _textField;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.textColor = ColorWithHex(@"ff8585");
        _tipsLabel.font = APPFONT(10);
        _tipsLabel.numberOfLines = 0;
    }
    return _tipsLabel;
}


@end
