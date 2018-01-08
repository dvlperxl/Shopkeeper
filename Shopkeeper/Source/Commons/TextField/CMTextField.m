//
//  CMTextField.m
//  UIDemo
//
//  Created by CaiMing on 2016/1/3.
//  Copyright © 2016年 CaiMing. All rights reserved.
//


#import "CMTextField.h"



@interface CMInputAccessoryView ()


@end

@implementation CMInputAccessoryView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
    }
    
    return self;
}



- (void)onBtnAction:(UIButton *)btn
{
    if ([self.cDelegate respondsToSelector:@selector(inputAccessoryView:didSelectButtonIndex:)]) {
        [self.cDelegate inputAccessoryView:self didSelectButtonIndex:btn.tag];
    }
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}

- (void)initSubviews
{
    self.backgroundColor =  ColorWithHex(@"f7f5f3");
    
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame=CGRectMake(SCREEN_WIDTH-40, 0, 40, 44);
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    okBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [okBtn setTitleColor:ColorWithHex(@"666666") forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.titleLabel.font = APPFONT(15.0);
    okBtn.tag = 1;
    [self addSubview:okBtn];
    
    UIView *downline =  [[UIView alloc] initWithFrame:CGRectMake(0,43.5, SCREEN_WIDTH, 0.5)];
    downline.backgroundColor = ColorWithHex(@"d9d9d9");
    [self addSubview:downline];
    
    UIView *upLine =  [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
    upLine.backgroundColor = ColorWithHex(@"a8a6a1");
    [self addSubview:upLine];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-120, 44)];
    titleLab.font = APPFONT(12);
    titleLab.textColor = ColorWithHex(@"8f8f8f");
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    _titleLab = titleLab;
}

@end

@interface CMTextField ()<CMInputAccessoryViewDelegate,UITextFieldDelegate>

@property(nonatomic,weak)id<CMTextFieldDelegate> cDelegate;
@property(nonatomic,strong)CMInputAccessoryView *accessoryView;
@property (nonatomic,copy)NSString *inputText;

@end

@implementation CMTextField

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.showInputAccessory = YES;
        self.hasSpace = YES;
        [self addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
    self.showInputAccessory = YES;
    self.hasSpace = YES;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setShowInputAccessory:(BOOL)showInputAccessory
{
    _showInputAccessory = showInputAccessory;
    self.inputAccessoryView = showInputAccessory?self.accessoryView:nil;
//    if (showInputAccessory) {
//        self.accessoryView.titleLab.text = self.placeholder;
//    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    
//    if (self.showInputAccessory)
//    {
//        NSString *title = placeholder;
//
//        if (![placeholder hasPrefix:@"请输入"]) {
//            title = [NSString stringWithFormat:@"请输入%@",placeholder];
//        }
//        self.accessoryView.titleLab.text = title;
//    }
}

- (void)setInputType:(CMTextFieldViewInputType)inputType
{
    _inputType = inputType;
    
    switch (_inputType) {
        case CMTextFieldViewInputTypeEmail:
            self.keyboardType = UIKeyboardTypeEmailAddress;
            break;
            
        case CMTextFieldViewInputTypePhoneNO:
            self.keyboardType = UIKeyboardTypeNumberPad;
            _hasSpace = NO;
            _maxLength = 11;
            break;
            
        case CMTextFieldViewInputTypeCardNumber:
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case CMTextFieldViewInputTypePassword:
            self.keyboardType = UIKeyboardTypeDefault;
            self.secureTextEntry = YES;
            break;
            
        default:
            break;
    }
}

- (void)setAccessoryTitle:(NSString *)accessoryTitle
{
    _accessoryTitle = accessoryTitle;
    _accessoryView.titleLab.text = _accessoryTitle;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    if (!self.delegate) {
        
        [super setDelegate:delegate];
        
    }else
    {
        self.cDelegate = (id <CMTextFieldDelegate> )delegate;
    }
}

- (CMInputAccessoryView *)accessoryView
{
    if (!_accessoryView) {
        
        _accessoryView = [[CMInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _accessoryView.cDelegate = self;
    }
    return _accessoryView;
}

#pragma mark - CMInputAccessoryViewDelegate 

- (void)inputAccessoryView:(UIView *)aView didSelectButtonIndex:(NSInteger)index
{
    if (index == 1) {
        
        if ([self.cDelegate respondsToSelector:@selector(textField:didInputViewButton:)]) {
            
            [self.cDelegate textField:self didInputViewButton:index];
        }
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       // return NO to disallow editing.
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        
        return [self.cDelegate textFieldShouldBeginEditing:self];
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.cDelegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return  [self.cDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        
        [self.cDelegate respondsToSelector:@selector(textFieldDidEndEditing:)];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0) // if implemented, called in place of textFieldDidEndEditing:
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)])
    {
        [self.cDelegate textFieldDidEndEditing:textField reason:reason];
    }
}

//在输入时，调用下面那个方法来判断输入的字符串是否含有表情
- (void)textFieldDidChanged:(UITextField *)textField
{
    
    if ([textField.text stringContainsEmoji])
    {
        textField.text = self.inputText;

    }else
    {
        self.inputText = textField.text;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    
    if ([string stringContainsEmoji]) {
        
        return NO;
    }
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([text hasPrefix:@" "])
    {
        return NO;
    }
    
    if ([_cDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
      return [_cDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    
    if (self.inputType == CMTextFieldViewInputTypePhoneNO)
    {
        if ([text deleteSpace].length<11)
        {
//            textField.text =[text deleteSpace];
            
            return YES;
            
        }else if ([text deleteSpace].length == 11)
        {
            NSMutableString *mStr = [text deleteSpace].mutableCopy;
            [mStr insertString:@" " atIndex:3];
            [mStr insertString:@" " atIndex:8];
            textField.text =mStr;
        }
        return NO;

        
    }else
    {
        //不允许输入空格
        if (_hasSpace == NO) {
            
            NSString *str = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (text.length != str.length)
            {
                return NO;
            }
        }
        //不允许长度大于 maxLength
        if (self.maxLength>0) {
            
            if (text.length>self.maxLength) {
                
                textField.text = [text substringToIndex:self.maxLength];
                return NO;
            }
        }
    }
    

    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when CMear button pressed. return NO to ignore (no notifications)
{
    if ([_cDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_cDelegate textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    if ([self.cDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        
        return [self.cDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end






