//
//  GoodsChooseAlertView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsChooseAlertView.h"


@interface GoodsChooseInputView : UIView

@property(nonatomic,strong)UILabel *unitLab;
@property(nonatomic,strong)CMTextField *textField;

@end

@implementation GoodsChooseInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(12);
        make.bottom.offset(-12);
        make.right.equalTo(self.unitLab.mas_left);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(12);
        make.bottom.offset(-12);
        make.width.mas_equalTo(20);
    }];
    
    self.backgroundColor = ColorWithHex(@"f5f5f5");
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
}

- (void)initSubviews
{
    [self addSubview:self.unitLab];
    [self addSubview:self.textField];
}

- (CMTextField *)textField
{
    if (!_textField)
    {
        _textField = [[CMTextField alloc]init];
        _textField.font = APPFONT(17);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}


- (UILabel *)unitLab
{
    if (!_unitLab)
    {
        _unitLab = [[UILabel alloc]init];
        _unitLab.textColor = ColorWithHex(@"#333333");
        _unitLab.font = APPFONT(17);
        _unitLab.textAlignment = NSTextAlignmentRight;
    }
    return _unitLab;
}

@end

@interface GoodsChooseAlertView ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)GoodsChooseInputView *priceView;
@property(nonatomic,strong)GoodsChooseInputView *countView;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UILabel *yuanLab;
@property(nonatomic,strong)GoodsChooseAlertViewModel *model;

@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *confirmButton;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UIView *line2;

@end

@implementation GoodsChooseAlertView

+ (instancetype)goodsChooseAlertView:(GoodsChooseAlertViewModel*)model
{
    return [[[GoodsChooseAlertView alloc]init]goodsChooseAlertView:model];
}

- (instancetype)goodsChooseAlertView:(GoodsChooseAlertViewModel*)model
{
    self.model = model;
    [self initSubviews];
    [self bindingViewModel:model];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(30);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.equalTo(@23);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(57);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.equalTo(@19);
    }];
    
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.descLab.mas_bottom).offset(10);
    }];
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.priceView.mas_bottom).offset(10);
    }];
    
    
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(35);
        make.height.mas_equalTo(16);
        make.bottom.offset(-76);
        make.width.mas_equalTo(40);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-54);
        make.height.mas_equalTo(26);
        make.bottom.offset(-72);
        make.left.equalTo(self.totalLab.mas_right).offset(5);
    }];
    
    [self.yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(-32);
        make.height.mas_equalTo(26);
        make.bottom.offset(-72);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
        make.bottom.offset(-48);
        
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(1.0/SCREEN_SCALE);
        make.bottom.offset(0);
        make.height.offset(48);
    }];
    
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.offset(0);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.offset(48);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.offset(0);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.offset(48);
    }];
    
    
}

- (void)onButtonAction:(UIButton*)btn
{
    if (btn.tag == 1)
    {
        if (self.priceView.textField.text.length<1)
        {
            [[KKToast makeToast:[NSString stringWithFormat:@"请输入%@",self.model.pricePlaceholder]]show];
            return ;
        }
        
        if (!(self.priceView.textField.text.floatValue>0))
        {
            
            [[KKToast makeToast:[NSString stringWithFormat:@"%@不能为0",self.model.pricePlaceholder]]show];
            return ;
        }
        
        if (self.countView.textField.text.length<1)
        {
            [[KKToast makeToast:[NSString stringWithFormat:@"请输入%@",self.model.countPlaceholder]]show];
            return ;
        }
        
        if (!(self.countView.textField.text.floatValue>0))
        {
            [[KKToast makeToast:[NSString stringWithFormat:@"%@不能为0",self.model.countPlaceholder]]show];
            return ;
        }
        
    }
//    NSNumber *price = [NSNumber numberWithFloat:self.priceView.textField.text.floatValue];
//    NSNumber *count = [NSNumber numberWithInteger:self.countView.textField.text.floatValue];
//    NSNumber *total = [NSNumber numberWithFloat:self.amountLab.text.floatValue];

    if ([self.delegate respondsToSelector:@selector(goodsChooseAlertViewDidSelectButton:price:count:total:)])
    {
        [self.delegate goodsChooseAlertViewDidSelectButton:btn.tag price:self.priceView.textField.text count:self.countView.textField.text total:self.amountLab.text];
    }
}
- (void)bindingViewModel:(GoodsChooseAlertViewModel *)model {
    self.titleLab.text = model.title;
    self.descLab.text = model.desc;
    self.priceView.textField.enabled = model.priceEnable;
    self.priceView.textField.placeholder = model.pricePlaceholder;
    if (model.price && model.price.floatValue > 0) {
        self.priceView.textField.text = AMOUNTSTRING(model.price);
    }
    self.countView.textField.placeholder = model.countPlaceholder;
    if (model.count && model.count.integerValue > 0) {
        self.countView.textField.text = model.count;
    }
    if (model.count && model.count.integerValue > 0 && model.price)
    {
        NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:self.model.price];
        NSDecimalNumber *count = [NSDecimalNumber decimalNumberWithString:self.model.count];
        NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                          decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                          scale:2
                                          raiseOnExactness:NO
                                          raiseOnOverflow:NO
                                          raiseOnUnderflow:NO
                                          raiseOnDivideByZero:YES];
        NSDecimalNumber *toatl = [price decimalNumberByMultiplyingBy:count withBehavior:roundUp];
        self.amountLab.text = AMOUNTSTRING(toatl.description);
    }
}
#pragma mark - initSubviews

- (void)initSubviews
{
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    [self addSubview:self.titleLab];
    [self addSubview:self.descLab];
    [self addSubview:self.priceView];
    [self addSubview:self.countView];
    [self addSubview:self.totalLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.yuanLab];
    [self addSubview:self.cancelButton];
    [self addSubview:self.confirmButton];
    [self addSubview:self.line1];
    [self addSubview:self.line2];

}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"#333333");
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
        _descLab.font = APPFONT(14);
        _descLab.textColor = ColorWithHex(@"#999999");
        _descLab.textAlignment = NSTextAlignmentCenter;
    }
    return _descLab;
}

- (GoodsChooseInputView *)priceView
{
    if (!_priceView) {
        
        _priceView = [[GoodsChooseInputView alloc]init];
        _priceView.unitLab.text = @"元";
        _priceView.textField.delegate = self;
        _priceView.textField.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    return _priceView;
}

- (GoodsChooseInputView *)countView
{
    if (!_countView) {
        _countView = [[GoodsChooseInputView alloc]init];
        _countView.unitLab.text = self.model.unit;
        _countView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _countView.textField.delegate = self;
    }
    return _countView;
}

- (UILabel *)totalLab
{
    if (!_totalLab) {
        
        _totalLab = [[UILabel alloc]init];
        _totalLab.text = @"小计";
        _totalLab.font = APPFONT(14);
        _totalLab.textColor = ColorWithHex(@"#333333");
    }
    return _totalLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        
        _amountLab = [[UILabel alloc]init];
        _amountLab.text = @"0.00";
        _amountLab.textColor = ColorWithHex(@"333333");
        _amountLab.textAlignment = NSTextAlignmentRight;
        _amountLab.font = APPFONT(22);
 

    }
    return _amountLab;
}

- (UILabel *)yuanLab
{
    if (!_yuanLab) {
        
        _yuanLab = [[UILabel alloc]init];
        _yuanLab.text = @"元";
        _yuanLab.textAlignment = NSTextAlignmentRight;
        _yuanLab.font = APPFONT(17);
        _yuanLab.textColor = ColorWithHex(@"333333");

    }
    return _yuanLab;
}

- (UIView *)line1
{
    if (!_line1) {
        
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = ColorWithRGB(0, 0, 80, 0.05);

    }
    return _line1;
}

- (UIView *)line2
{
    if (!_line2) {
        
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = ColorWithRGB(0, 0, 80, 0.05);
    }
    return _line2;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = APPFONT(18);
        [_cancelButton setTitleColor:ColorWithHex(@"#333333") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.tag = 0;
    }
    return _cancelButton;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确 定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = APPFONT(18);
        [_confirmButton setTitleColor:ColorWithHex(@"#F29700") forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.tag = 1;
    }
    return _confirmButton;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.amountLab.text = @"0.00";
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (aString.length==0) {
        
        self.amountLab.text = @"0.00";
        
        return YES;
    }
    
    if ([textField isEqual:self.priceView.textField])
    {
        
        
        float aFloat;
        NSScanner *scanner = [NSScanner scannerWithString:aString];
        BOOL valid = [scanner scanFloat:&aFloat] && [scanner isAtEnd];
        
        if (valid == NO) {
            
            return NO;
        }
        
        float f = aString.floatValue;
        
        if (f>100000)
        {
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
        
        NSString *countStr = self.countView.textField.text;
        if (countStr==nil||countStr.length<1) {
            countStr = @"0";
        }
        self.amountLab.text = [Calculate amountDisplayCalculate:aString multiplyingBy:countStr];
        return  valid;
        
    }else
    {
        NSInteger aInt;
        NSScanner *scanner = [NSScanner scannerWithString:aString];
        BOOL valid = [scanner scanInteger:&aInt] && [scanner isAtEnd];
        if (valid == NO) {
            
            return NO;
        }
        
        NSInteger integaer = aString.floatValue;
        
        if (integaer>1000000000)
        {
            return NO;
        }
        NSString *priceStr = self.priceView.textField.text;
        if (priceStr==nil||priceStr.length<1) {
            priceStr = @"0";
        }
        
        self.amountLab.text = [Calculate amountDisplayCalculate:priceStr multiplyingBy:aString];
        return valid;
    }
    return YES;
}

@end

@implementation GoodsChooseAlertViewModel


@end
