//
//  GoodsDatePicker.m
//  Dev
//
//  Created by xl on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDatePicker.h"

CGFloat const datePickerH = 216.0f;
CGFloat const dateToolBarH = 40.0f;

@interface GoodsDatePicker ()

@property (nonatomic,strong) UIView *containView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIToolbar *pickerToolBar;
@end

@implementation GoodsDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat pickerW = self.bounds.size.width;
    CGFloat pickerH = datePickerH;
    CGFloat pickerX = 0;
    CGFloat pickerY = dateToolBarH;
    self.datePicker.frame = CGRectMake(pickerX, pickerY, pickerW, pickerH);
    self.pickerToolBar.frame = CGRectMake(pickerX, 0, pickerW, dateToolBarH);
}
- (void)showInController:(UIViewController *)viewController {
    UIView *supView = [UIApplication sharedApplication].keyWindow;
    if (viewController) {
        supView = viewController.view;
    }
    [supView endEditing:YES];
    CGFloat supH = supView.bounds.size.height;
    CGFloat supW = supView.bounds.size.width;
    self.frame = CGRectMake(0, supH, supW, datePickerH + dateToolBarH);
    self.containView.frame = supView.frame;
    [supView addSubview:self.containView];
    [supView addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat pickerY = supH - (datePickerH + dateToolBarH);
        self.frame = CGRectMake(0, pickerY, supW, datePickerH + dateToolBarH);
    } completion:nil];
}

#pragma mark - event
- (void)dismiss {
    [self dismissCompletion:nil];
}
- (void)dismissCompletion:(void(^)(void))completion {
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat supH = self.superview.bounds.size.height;
        CGFloat supW = self.superview.bounds.size.width;
        self.frame = CGRectMake(0, supH, supW, datePickerH + dateToolBarH);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [self removeFromSuperview];
        [self.containView removeFromSuperview];
    }];
}
- (void)doneClick {
    [self dismissCompletion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerView:datePicker:selectedDate:)]) {
            [self.delegate datePickerView:self datePicker:self.datePicker selectedDate:self.datePicker.date];
        }
    }];
}
- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}
- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}
#pragma mark - getter
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        CGFloat pickerW = [UIScreen mainScreen].bounds.size.width;
        CGFloat pickerH = datePickerH;
        CGFloat pickerX = 0;
        CGFloat pickerY = dateToolBarH;
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        _datePicker.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_datePicker];
    }
    return _datePicker;
}
- (UIToolbar *)pickerToolBar {
    if (!_pickerToolBar) {
        _pickerToolBar = [[UIToolbar alloc]init];
        _pickerToolBar.barTintColor = [UIColor whiteColor];
        UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
        lefttem.tintColor = right.tintColor = [UIColor colorWithHexString:@"#F29700"];
        _pickerToolBar.items = @[lefttem,centerSpace,right];
        [self addSubview:_pickerToolBar];
    }
    return _pickerToolBar;
}
- (UIView *)containView {
    if (!_containView) {
        UIView *contain = [[UIView alloc]init];
        contain.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [contain addGestureRecognizer:tap];
        _containView = contain;
    }
    return _containView;
}

@end
