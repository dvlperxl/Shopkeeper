//
//  HNNumberButton.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNNumberButton.h"

@interface HNNumberButton ()<UITextFieldDelegate>

/** 加号按钮*/
@property (nonatomic,strong) UIButton *increaseBtn;
/** 减号按钮*/
@property (nonatomic,strong) UIButton *decreaseBtn;
/** 数字展示*/
@property (nonatomic,strong) UILabel *numLabel;
/** 输入框*/
@property (nonatomic, strong) UITextField *textField;
@end

@implementation HNNumberButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        // 默认大小
        if (CGRectIsEmpty(frame)){
            self.frame = CGRectMake(0, 0, 100, 40);
        };
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupUI];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)setupUI {
    _minValue = 0;
    _maxValue = NSIntegerMax;
    
    self.currentNumber = _minValue;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 20.f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithHexString:@"#EBEBEB"].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.editing = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)notification:(NSNotification*)notification
{
    if (self.textField.isFirstResponder) {
        
        self.numLabel.text = self.textField.text;
        [self checkNumLabelWithUpdate];
        if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:number:)]) {
            [self.delegate numberButton:self number:self.textField.text.integerValue];
        }
    }

}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width =  self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat btnHeight = height;
    CGFloat btnWidth = btnHeight;
    self.decreaseBtn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    self.textField.frame = CGRectMake(btnWidth, 0, width-2*btnWidth, height);
    self.numLabel.frame = CGRectMake(btnWidth, 0, width-2*btnWidth, height);
    self.increaseBtn.frame = CGRectMake(width-btnWidth, 0, btnWidth, btnHeight);
    
}
- (UIButton *)creatButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)checkNumLabelWithUpdate {
    NSString *minValueString = [NSString stringWithFormat:@"%ld",(long)_minValue];
//    NSString *maxValueString = [NSString stringWithFormat:@"%ld",(long)_maxValue];
    
    if ([self isNotBlankWithStr:self.numLabel.text] == NO || self.numLabel.text.integerValue < _minValue) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:errorNumber:)]) {
            [self.delegate numberButton:self errorNumber:[self.numLabel.text integerValue]];
//            商品数量不能小于1
            [[KKToast makeToast:[NSString stringWithFormat:@"商品数量不能小于%ld",(long)_minValue]] show];

        }
        self.numLabel.text = minValueString;
    }
//    if (self.numLabel.text.integerValue > _maxValue) {
//
//    }
    
    if (self.numLabel.text.length>8) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:errorNumber:)]) {
            [self.delegate numberButton:self errorNumber:[self.numLabel.text integerValue]];
            [[KKToast makeToast:[NSString stringWithFormat:@"商品数量不能大于8位数"]] show];
        }
        self.numLabel.text = [self.numLabel.text substringToIndex:8];
    }
    
    if ([self isNotBlankWithStr:self.textField.text] == NO || self.textField.text.integerValue < _minValue) {
        self.textField.text = minValueString;
    }
    self.textField.text =  self.numLabel.text;

}
- (BOOL)isNotBlankWithStr:(NSString *)str {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < str.length; ++i) {
        unichar c = [str characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}
- (NSInteger)currentNumber {
    return self.numLabel.text.integerValue;
}

- (void)setCurrentNumber:(NSInteger)currentNumber {
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)currentNumber];
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)currentNumber];
    [self checkNumLabelWithUpdate];
}
- (void)setEditing:(BOOL)editing {
    _editing = editing;
    if (editing) {
        [self sendSubviewToBack:self.numLabel];
    } else {
        [self sendSubviewToBack:self.textField];
    }
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.numLabel.text = textField.text;
    [self checkNumLabelWithUpdate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:number:)]) {
        [self.delegate numberButton:self number:self.textField.text.integerValue];
    }
}
#pragma mark - event
- (void)touchClick:(UIButton *)btn {
    [self checkNumLabelWithUpdate];
    NSInteger number = 0;
    if (btn == self.increaseBtn) {   // 加操作
        number = self.numLabel.text.integerValue + 1;
        if (number > _maxValue) {
            NSLog(@"超过最大值");
            if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:errorNumber:)]) {
                [self.delegate numberButton:self errorNumber:number];
                [[KKToast makeToast:[NSString stringWithFormat:@"商品数量不能大于%ld",(long)_maxValue]] show];

            }
            return;
        }
    } else if (btn == self.decreaseBtn) {   // 减操作
        number = self.numLabel.text.integerValue - 1;
        if (number < _minValue) {
            NSLog(@"小于最小值");
            if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:errorNumber:)]) {
                [self.delegate numberButton:self errorNumber:number];
                [[KKToast makeToast:[NSString stringWithFormat:@"商品数量不能小于%ld",(long)_minValue]] show];

            }
            return;
        }
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
    self.textField.text = [NSString stringWithFormat:@"%ld", (long)number];
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberButton:number:)]) {
        [self.delegate numberButton:self number:self.numLabel.text.integerValue];
    }
}
#pragma mark - getter
- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.backgroundColor = [UIColor whiteColor];
        _numLabel.userInteractionEnabled = YES;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.numberOfLines = 2;
        _numLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _numLabel.font = APPFONT(15);
        [self addSubview:_numLabel];
    }
    return _numLabel;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.font = APPFONT(15);
        _textField.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_textField];
    }
    return _textField;
}
- (UIButton *)increaseBtn {
    if (!_increaseBtn) {
        _increaseBtn = [self creatButton];
        [_increaseBtn setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];;
        [self addSubview:_increaseBtn];
    }
    return _increaseBtn;
}
- (UIButton *)decreaseBtn {
    if (!_decreaseBtn) {
        _decreaseBtn = [self creatButton];
        [_decreaseBtn setImage:[UIImage imageNamed:@"icon_minus"] forState:UIControlStateNormal];
        [self addSubview:_decreaseBtn];
    }
    return _decreaseBtn;
}

@end
