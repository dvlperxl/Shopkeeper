//
//  CMTextField.h
//  UIDemo
//
//  Created by CaiMing on 2016/1/3.
//  Copyright © 2016年 CaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CMTextFieldViewInputType) {
    
    CMTextFieldViewInputTypeNone,
    CMTextFieldViewInputTypePhoneNO,
    CMTextFieldViewInputTypeEmail,
    CMTextFieldViewInputTypeCardNumber,
    CMTextFieldViewInputTypePassword
};

@protocol CMTextFieldDelegate <UITextFieldDelegate>

@optional

- (void)textField:(UITextField *)textField didInputViewButton:(NSInteger)index;

@end

@interface CMTextField : UITextField<UITextFieldDelegate>

@property(nonatomic,assign)BOOL showInputAccessory;//default YES;
@property(nonatomic,assign)CMTextFieldViewInputType inputType;//输入的类型
@property(nonatomic,assign)NSInteger maxLength;//最大输入位数 default 不限制
@property(nonatomic,assign)BOOL hasSpace;//输入的内容是否可以带空格 default YES 可以带空格
@property(nonatomic,strong)NSString *accessoryTitle;//default placeholder;
@property(nonatomic, strong)UIColor *placeholderColor;

@end


@protocol CMInputAccessoryViewDelegate <NSObject>

@optional
- (void)inputAccessoryView:(UIView*)aView didSelectButtonIndex:(NSInteger)index;

@end

@interface CMInputAccessoryView : UIView

@property(weak, nonatomic)id<CMInputAccessoryViewDelegate> cDelegate;
@property(nonatomic,strong)UILabel *titleLab;

@end

