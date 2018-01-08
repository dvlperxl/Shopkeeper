//
//  SettlementAmountTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SettlementAmountTableViewCell.h"


@interface SettlementAmountTableViewCell ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CMTextField *amountTextFild;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)SettlementAmountTableViewCellModel *model;

@end

@implementation SettlementAmountTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(SettlementAmountTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.amountTextFild.placeholder = model.placeholder;
    self.amountTextFild.text = model.content;
    self.amountTextFild.keyboardType = model.keyBoardType;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(23);
        
    }];
    
    [self.amountTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.titleLab.mas_right).offset(5);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.model.content = @"";
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (aString.length==0) {
        
        self.model.content = @"";
        return YES;
    }
    
    float aFloat;
    NSScanner *scanner = [NSScanner scannerWithString:aString];
    BOOL valid = [scanner scanFloat:&aFloat] && [scanner isAtEnd];
    if (valid == NO) {
        
        return NO;
    }
    
    if ([aString containsString:@"."])
    {
        NSArray *array = [aString componentsSeparatedByString:@"."];
        NSString *lastObject = array.lastObject;
        if (lastObject.length>2) {
            return NO;
        }
    }
    
    if (_model.inputMaxAmount)
    {
        if (aString.floatValue>_model.inputMaxAmount.floatValue)
        {
            textField.text = _model.inputMaxAmount;
            self.model.content = _model.inputMaxAmount;
            [[KKToast makeToast:@"结账金额有误，请重新输入"] show];
            return NO;
        }
    }
    
    self.model.content = aString;
    return valid;
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.amountTextFild];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(18);
        _titleLab.textColor = ColorWithHex(@"#030303");
    }
    return _titleLab;
}


- (CMTextField *)amountTextFild
{
    if (!_amountTextFild) {
        
        _amountTextFild = [[CMTextField alloc]init];
        _amountTextFild.font = APPFONT(22);//34
        _amountTextFild.textColor = ColorWithHex(@"#333333");
        _amountTextFild.textAlignment = NSTextAlignmentRight;
        _amountTextFild.delegate = self;
        _amountTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _amountTextFild;
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

@implementation SettlementAmountTableViewCellModel

@end
